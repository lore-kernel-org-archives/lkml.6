Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5587FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0186C205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzQWlNEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0186C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbeG0URd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:17:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42548 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389006AbeG0URc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:17:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so3727416pgp.9;
        Fri, 27 Jul 2018 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HAOb9QPYQOdzxO7JPZjJxces3g/2uWoQp39Gm4Jkvzk=;
        b=GzQWlNEa4gwcl7oWetoyhD/0FuTuUeJLIbbE0iL87060ZGbBqtnS3E+vdfJT2DxoG3
         Y6m7JADw3iqxjquZkYvv6WwCbRX2Z8BBKuesDV5x7Ui0PWyi/mWgIXUKHtj7VltQ0KX9
         8vA3d1bGvlg5R3YtuWfA28VpGGCbI3qO720Fbk3/njFf82B5hNThTVVhO0ytSMYPamgs
         +s6AT3BnaDDRinhfcY/9xY4Zq0ltFPtHHgNFl/e0Vjsgu6xLD6plnuxV26Ak535xkMaF
         g8FiQHG+6PXKswtu4rCl7GagisBV7by2O4isOj8drSZGnRTiVJOSvTcXMYnNk4RJqZ/h
         bYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HAOb9QPYQOdzxO7JPZjJxces3g/2uWoQp39Gm4Jkvzk=;
        b=fS3NFG1AP7/kR06ceG5MYX+OZX8dnvxSFfk5DuKMSNzc0HeunR9JS+xKAnBvi2KZef
         podyOu4L/6ZQfle7iq3eyXKa82LZhaEb7PE8KNFy+9PN8TD1vPSs6o9+KSl+Vvi1xKMy
         9eJDupwsFNf2gmTxrl6UFIVXd+1p5FWfJwAz5l6HoKSTciOBY0uB8L+rleGTLzSHHN8W
         H5Nmr7obfP0MdDIWPY2JKZJbHnhyRhZpTQHTRgcTqR9PIhsBKH131EVvxouUOnKxxY/l
         zGSoeIel0LFSTCAjAUUO71h/3u062428MdTbUZ34BroCb0foORDU+PDLCTJq11qAy2qR
         Hk0g==
X-Gm-Message-State: AOUpUlHj9bfAaiM5imKlMUq762K2pzeaNuAzCE3eKb2VmIJv0cdI9ssB
        43SsxZREVuZ6/X5NT+xB0vg=
X-Google-Smtp-Source: AAOMgpcJrCMchiYw19hnvy4x67rpVpKaxg1y0m3jPlN0wz6hFJQOpziyGtIg72gZ0jhfxR/hDTjbFA==
X-Received: by 2002:a63:2106:: with SMTP id h6-v6mr7175006pgh.161.1532717661182;
        Fri, 27 Jul 2018 11:54:21 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id g5-v6sm5509528pgn.73.2018.07.27.11.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 11:54:19 -0700 (PDT)
Date:   Fri, 27 Jul 2018 11:54:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nick Dyer <nick@shmanahar.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH v1 01/10] Input: atmel_mxt_ts - only use first T9 instance
Message-ID: <20180727185418.GG72640@dtor-ws>
References: <20180720215122.23558-1-nick@shmanahar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:51:13PM +0100, Nick Dyer wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> The driver only registers one input device, which uses the screen
> parameters from the first T9 instance. The first T63 instance also uses
> those parameters.
> 
> It is incorrect to send input reports from the second instances of these
> objects if they are enabled: the input scaling will be wrong and the
> positions will be mashed together.
> 
> This also causes problems on Android if the number of slots exceeds 32.
> 
> In the future, this could be handled by looking for enabled touch object
> instances and creating an input device for each one.
> 
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> Acked-by: Benson Leung <bleung@chromium.org>
> Acked-by: Yufeng Shen <miletus@chromium.org>
> ---

OK, I adjusted patch #7 to use kmemdup_nul() as we discussed, and
skipped #9, applied the rest.

Thanks!

>  drivers/input/touchscreen/atmel_mxt_ts.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 54fe190fd4bc..48c5ccab00a0 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1658,10 +1658,11 @@ static int mxt_parse_object_table(struct mxt_data *data,
>  			break;
>  		case MXT_TOUCH_MULTI_T9:
>  			data->multitouch = MXT_TOUCH_MULTI_T9;
> +			/* Only handle messages from first T9 instance */
>  			data->T9_reportid_min = min_id;
> -			data->T9_reportid_max = max_id;
> -			data->num_touchids = object->num_report_ids
> -						* mxt_obj_instances(object);
> +			data->T9_reportid_max = min_id +
> +						object->num_report_ids - 1;
> +			data->num_touchids = object->num_report_ids;
>  			break;
>  		case MXT_SPT_MESSAGECOUNT_T44:
>  			data->T44_address = object->start_address;
> -- 
> 2.17.1
> 

-- 
Dmitry
