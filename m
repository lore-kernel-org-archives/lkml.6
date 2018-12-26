Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB785C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CB42087F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0/qcCoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeLZUIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:08:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45003 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeLZUIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:08:42 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so7867378plt.11;
        Wed, 26 Dec 2018 12:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ReCVJ1zQ8c9EFHFxeKDeCRqZGEpqTR4lXQL9T1B4KBA=;
        b=B0/qcCoiu2oaxijFv5eKqevfQdyy0QilRzAONiGLS/vo+YSKn9ORVz6QQ7MbfQrECr
         sB9BpbOdw/cQplav+1GzI+hKvcy1ghzNr2upYeSvREyN4sUyK9vRCFR3jZOqJ5QNUiol
         7Duoji5y4yCpLHVNe0LZ13/3DhRYXKmzYWBo8b0ogsjn5EL6FHt8cZW3Zhl8a/z6iHVF
         M9GVYJ1O9hmmHFduw5w6Fa69v9S4pv/EfIr8yDfQd/gWxl4tWgphoeoO9zbeVVD5FptO
         W4PKN8Qc9ik5mDHpjIC6pqdGr62L6bDE3TO1TG2YzS1vPJ9BloeTLfqmLuV25+IJN12I
         yJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReCVJ1zQ8c9EFHFxeKDeCRqZGEpqTR4lXQL9T1B4KBA=;
        b=PrEnGJiKiJMpT+ExjiqR5jsRMqoHTVxGXYWNjI8cPkQD9RQrOllIlLOJUm9qI4+Tj9
         g1FS5DjtmPMbcAzFI3AsI31Cji9EIr4oTy6kRGogiwe2gDwehtWo+QXvZo/xcFoJ9zHv
         2LFzcNq9BZ9zAY52DB2AFeEBHcv/fEqCnTDmSLV9Io1NuB+Kca3JyEjHRyJynjcuEni1
         2CLTpNgtYwtKivs98L8XO2YNeXBVFEZyzqJjURgYXiwYtNwoVSGxwWtVXLM1YsM3Pu8j
         08CnyhxrWhw7K0F7NQEj5UgoMWn7UjiRcrsSwARFzRnbZM3OC7M8Gqark5ROfRp7IGgB
         NuxQ==
X-Gm-Message-State: AJcUukedxWIk2QIOho2ke4lUQRO0NovJFX98onaKvGn6Veh+udZrnKsq
        9rTYmzxYGAiuogIj9oWEzRc=
X-Google-Smtp-Source: ALg8bN40ZDt8yXMM8goPwGo+g11zk1VaeXkr9l0L9+QsuUApXjUT5pxw4khE41yf9zAt8EqN6mlwrg==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr21482241plb.17.1545854921005;
        Wed, 26 Dec 2018 12:08:41 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e128sm50181529pfe.67.2018.12.26.12.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 12:08:40 -0800 (PST)
Date:   Wed, 26 Dec 2018 12:08:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Michael Hennerich <michael.hennerich@analog.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/touchscreen: Fix a missing check on
 regmap_bulk_read
Message-ID: <20181226200838.GC5999@dtor-ws>
References: <20181224183719.22211-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224183719.22211-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 24, 2018 at 12:37:19PM -0600, Aditya Pakki wrote:
> regmap_bulk_read() can return a non zero value on failure. The fix
> checks if the function call succeeded before calling mod_timer.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/input/touchscreen/ad7879.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 6bad23ee47a1..735cb4c0d913 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -247,11 +247,12 @@ static void ad7879_timer(struct timer_list *t)
>  static irqreturn_t ad7879_irq(int irq, void *handle)
>  {
>  	struct ad7879 *ts = handle;
> +	int ret;
>  
> -	regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
> -			 ts->conversion_data, AD7879_NR_SENSE);
> +	ret = regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
> +				ts->conversion_data, AD7879_NR_SENSE);

I'd probably say:

	error = regmap_bulk_read(...);
	if (error)
		dev_err_ratelimited(...);
	else if (!ad7879_report(ts))
		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);

Were the failures observed in real life or it is some kind of class
project?

>  
> -	if (!ad7879_report(ts))
> +	if (!ret && !ad7879_report(ts))
>  		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
>  
>  	return IRQ_HANDLED;
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
