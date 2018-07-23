Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97214ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B72520854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DquTFBjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B72520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbeGWXhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:37:13 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45952 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbeGWXhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:37:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so755677pll.12;
        Mon, 23 Jul 2018 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FZJdR1jkBDSmLkiRFzG2HkeNLbztrmwmCUGYLBVOrlY=;
        b=DquTFBjxa2inNKwIOx7C3LoDZoEIpj55WqE/7Slfq/N4KvK7Z5DlQARwWjmMUKQh9V
         HoMn6Zb/RGII3+BIki5YotJm1EMhF4CjDVWCy2zSx7eLA3/Hw3s96PAVpdQlB7oqNxfz
         Ms9d8S7Ols40EwGfzTkGcsly6aDWamD04GAMbNtgvZ4+DsocdApt22mFrmBQ5Oq/0oak
         YrXZcrtA3hrzSWBGIANrH62kZqSfmrG+++e5bsy/yXIQKsn8n2cLHXyZzDzQZqtb9G2Q
         dAxVOyOulQAEGVqDqxAqfh3NDtF4Hz7KjLfZaX3cxO2X4+/Tt6KoqiyD7LKJ63fE4pyC
         zE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FZJdR1jkBDSmLkiRFzG2HkeNLbztrmwmCUGYLBVOrlY=;
        b=qVkADgeZiQXEg2gtxLlOZGOid4pVxe9qPLzfh1QwNztxKot9Bc2jbjIYuBMoyFsPqt
         ZJf9+ySDxwRpFcyB9fKfXQIezPFxdnm38gccDvdI9+Qw48dvBi6mEAls8yGMkagSg21h
         /vDOVU13Wi3KoBfF4cNL64sR4pC3uAX1nAVd75bcNQSaBUWNZSvheWe3/e7r1AZvnjJT
         lbD4sHwHu/142lblv3RTzvwCAQbvzJCLyy/lVdV9ga1D7RAvNCpFSy5O4ZAG7/YeCVCb
         hOEr0yfhULoYlAbdirR0D2RGsVHjtrV1Qm2DYt8AqJw8RPRGDaSocZFRdQRSK6EckyhX
         HNyA==
X-Gm-Message-State: AOUpUlHC1RZBxnvcAfNNlH4aVHpo1pWBYl+qaRmyYlymF/U1ata07ZMs
        aQEOtNuyfUo56w2AKkiLgp1ZiWum
X-Google-Smtp-Source: AAOMgpdAB3a5Gw1oqtWwb1yfDSJX+01IbTudZ2ynEHXwWYQxLpxD418b8Jm+5TCKk8ULbwE1NOp13w==
X-Received: by 2002:a17:902:6e09:: with SMTP id u9-v6mr14172235plk.13.1532385230130;
        Mon, 23 Jul 2018 15:33:50 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id c1-v6sm13640226pfi.142.2018.07.23.15.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:33:49 -0700 (PDT)
Date:   Mon, 23 Jul 2018 15:33:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nick Dyer <nick@shmanahar.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH v1 09/10] Input: atmel_mxt_ts - tool type is ignored when
 slot is closed
Message-ID: <20180723223347.GJ100814@dtor-ws>
References: <20180720215122.23558-1-nick@shmanahar.org>
 <20180720215122.23558-9-nick@shmanahar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720215122.23558-9-nick@shmanahar.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:51:21PM +0100, Nick Dyer wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> input_mt_report_slot_state() ignores the tool when the slot is closed.
> Remove the tool type from these function calls, which has caused a bit of
> confusion.

Hmm, maybe we could introduce MT_TOOL_NONE or MT_TOOL_INACTIVE and get
rid of the 3rd parameter? It will require a bit of macro trickery for a
release or 2...

> 
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index d7023d261458..c31af790ef84 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -838,8 +838,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
>  		 * have happened.
>  		 */
>  		if (status & MXT_T9_RELEASE) {
> -			input_mt_report_slot_state(input_dev,
> -						   MT_TOOL_FINGER, 0);
> +			input_mt_report_slot_state(input_dev, 0, 0);
>  			mxt_input_sync(data);
>  		}
>  
> @@ -855,7 +854,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
>  		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, area);
>  	} else {
>  		/* Touch no longer active, close out slot */
> -		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, 0);
> +		input_mt_report_slot_state(input_dev, 0, 0);
>  	}
>  
>  	data->update_input = true;
> -- 
> 2.17.1
> 

-- 
Dmitry
