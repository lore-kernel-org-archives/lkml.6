Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2FDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BE0224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soaD/QrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BE0224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeKMFTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:19:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42262 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:19:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so301824pfr.9;
        Mon, 12 Nov 2018 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c3lbfkq5R3gtV88MdFuRbU+/1ZML3Ob3cTJlHcQi3Iw=;
        b=soaD/QrKad4Oyi/mcjHmJ3xSBjwyWgCnPplfzyCtCNIuJeWCjsVNT5env3+jv8Alx7
         7W9RKKT5KMxRgS6TYmZO5+A5f3cLQ2Vz/OAkRDJqrOMKDIN0cYBUN4L3KLo7XupS7wNz
         z9UaZd3uEhinb5K6UsjowtJcIQ3Q+m6s12c/aDGdoZRoa/vbgm39OXPNqg4kcndBJfLf
         p+Oz8PVqNbvTJFLNuZ9+G6A6mXdE48eP17+Y29AWztT+Ugr/lQ482DOzgZgPf8P7ywXk
         jiJKdlEThwDF+q5Ea5/m78VWgZEWnWEPLZee2VLdwqfNnRMaF46i2f67iTfFdl0JLCys
         1HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c3lbfkq5R3gtV88MdFuRbU+/1ZML3Ob3cTJlHcQi3Iw=;
        b=aMhSQzA1eyqHMQfkKYd4owQ3VgZNPPIxt1nlUQIYNhELcrn3Os3vU+Se/SX1IvnFp9
         kvCsTNfTfxgIrFYD4MjfqU9UuCu1g3qRCuy//PCoWDrjfO98g9grMT89Yr6t0usS02ZM
         CQn+7mvTPwKQq9qk+g8i5aZ47X6oCft1+lLJE3mz76GCMWctnOcxki4w9Swj2rZ9iLJS
         swsAsnVBhs38gBWeO7jzogig8tYLsGfjW//dISKu1O6GJRInLCGc1WmiGr+Auqlc7bsk
         4FR3dxOy8/HJTTlsiZ0VFW7JVjCZO4usmT9ViR4vYPD8vRFLXDngy+ZAy2TQq0cUuLCk
         LVnA==
X-Gm-Message-State: AGRZ1gLaKnqri9pPTQ9yWSvD+K/05uCwqQDVX0/gfZcws9KGjytcXaAP
        ktp00AkOdCxBvsmNmjKR+54=
X-Google-Smtp-Source: AJdET5exR8ibf6Qg2G8heoGELoRuVlXB9ZF8Wvwi3g7S66ebLwVs92piB2yQJtOVyPpkjvXMS8V1zg==
X-Received: by 2002:aa7:8603:: with SMTP id p3-v6mr2058067pfn.247.1542050663563;
        Mon, 12 Nov 2018 11:24:23 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y88-v6sm22756603pfd.104.2018.11.12.11.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 11:24:22 -0800 (PST)
Date:   Mon, 12 Nov 2018 11:24:20 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.co.uk>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] input: cros_ec_keyb: fix button/switch capability reports
Message-ID: <20181112192420.GC192687@dtor-ws>
References: <20181107223813.178462-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107223813.178462-1-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 02:38:13PM -0800, Brian Norris wrote:
> The cros_ec_keyb_bs array lists buttons and switches together, expecting
> that its users will match the appropriate type and bit fields. But
> cros_ec_keyb_register_bs() only checks the 'bit' field, which causes
> misreported input capabilities in some cases. For example, tablets
> (e.g., Scarlet -- a.k.a. Acer Chromebook Tab 10) were reporting a SW_LID
> capability, because EC_MKBP_POWER_BUTTON and EC_MKBP_LID_OPEN happen to
> share the same bit.
> 
> (This has comedic effect on a tablet, in which a power-management daemon
> then thinks this "lid" is closed, and so puts the system to sleep as
> soon as it boots!)
> 
> To fix this, check both the 'ev_type' and 'bit' fields before reporting
> the capability.
> 
> Tested with a lid (Kevin / Samsung Chromebook Plus) and without a lid
> (Scarlet / Acer Chromebook Tab 10).
> 
> This error got introduced when porting the feature from the downstream
> Chromium OS kernel to be upstreamed.
> 
> Fixes: cdd7950e7aa4 ("input: cros_ec_keyb: Add non-matrix buttons and switches")
> Cc: <stable@vger.kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 81be6f781f0b..d56001181598 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -493,7 +493,8 @@ static int cros_ec_keyb_register_bs(struct cros_ec_keyb *ckdev)
>  	for (i = 0; i < ARRAY_SIZE(cros_ec_keyb_bs); i++) {
>  		const struct cros_ec_bs_map *map = &cros_ec_keyb_bs[i];
>  
> -		if (buttons & BIT(map->bit))
> +		if ((map->ev_type == EV_KEY && (buttons & BIT(map->bit))) ||
> +		    (map->ev_type == EV_SW && (switches & BIT(map->bit))))
>  			input_set_capability(idev, map->ev_type, map->code);
>  	}
>  
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 

-- 
Dmitry
