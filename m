Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6CFECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D870D20844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAn/7cQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D870D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbeGPMuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:50:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45064 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbeGPMuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:50:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id c4-v6so19023128wrs.12;
        Mon, 16 Jul 2018 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Edt9q76ZvTaPrkwSIJip50f/fOrP7yIrNXeBemqdLFc=;
        b=KAn/7cQZYAbg85t6UUNIJphqNP7hixgiwVa0S9nSJlnOBjJWKZ25Od6If36ZFNxPAO
         zRU83/3iHhMfIYL34sbT0qvwfxq2r5ezjSiJNJBHwkwLyWTDDKkYKDv1XFnNkv7BJdSg
         /vuxmYDMbf97BtkLHx5caHEh5aXsN5v16GExiXo3fTRsNbYIOblbYXD2HCRHdBqnPoMB
         +ZLWnsDreCXNs8yM40PeuzTMkS7JbAt83+YIBXoYN8AsuU12HYPUd/Ru27BLsecAhEab
         g+/CqvjKsjcva6uP3ybk5d370Gh+oF32glLHbAAf+mzgssIlkbUTB0hAMLVyG6eISzkE
         PzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Edt9q76ZvTaPrkwSIJip50f/fOrP7yIrNXeBemqdLFc=;
        b=izepn7qaxGfyZg3qUXw8IWC/VtC9FdiJRPpZZoptXP1cff9KrWBYHVu/Zt+KVvu2nb
         OzhbS7prc6osgxGmwx5TovH0y6dRmgutQDCgrlTU5l+1B+ORt0qitTOVLh1cdLPKYag/
         P8OOv15KDLuM2FJr670mvWLRMVzlEY1CDvYvr9pvYPLqSHu0QypiF9949gBWOSqLed9r
         1dW7fYGonT9JKFbKYDnGXJ/a6NpMSIH6iRP2OCntsstBmU9CLcLCOCDMWRFa0+CQt0Qw
         xxFPgwAdGb8CH2CUbzRBjOIXtNpUaoO3zxWqJmE/ZVNgwMMIvhJ2ir9pqg4q18phaJ0O
         augg==
X-Gm-Message-State: AOUpUlHHpjv6//SKfGcD9q9qWO7VzFyYTve+tnyyP4tuMTYlCEWJ8CcY
        1eNzA4G/Dxt3MQHt7ZD8N/4=
X-Google-Smtp-Source: AAOMgpcMVXIdb3kjdqfee0EZqEz8GryyPhpiQJ1+OmWX6QO3M0PWCMev6Fk7qAbehAVT4Bw9dw/Bvg==
X-Received: by 2002:adf:88e3:: with SMTP id g32-v6mr11074582wrg.62.1531743790382;
        Mon, 16 Jul 2018 05:23:10 -0700 (PDT)
Received: from localhost (ohdikc.static.otenet.gr. [80.107.51.104])
        by smtp.gmail.com with ESMTPSA id r8-v6sm3621174wmh.37.2018.07.16.05.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 05:23:09 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:20:05 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     KT Liao <kt.liao@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ulrik.debie-os@e2big.org, anantshende@gmail.com
Subject: Re: [PATCH] Input: elan_i2c - Add antoher ACPI ID for Lenovo Ideapad
 330-15AST
Message-ID: <20180716122005.5c5p3sitbfilt4hs@penguin>
References: <1531740389-4040-1-git-send-email-kt.liao@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531740389-4040-1-git-send-email-kt.liao@emc.com.tw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:26:29PM +0800, KT Liao wrote:
> Add ELAN0622 in ACPI mapping table to support Ideapad 330-15AST ELAN touchpad
> 
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> Reported-by: Anant Shende <anantshende@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 2690a4b..f7e75f0 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1344,6 +1344,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN060B", 0 },
>  	{ "ELAN060C", 0 },
>  	{ "ELAN0611", 0 },
> +	{ "ELAN0622", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
>  };
> -- 
> 2.7.4
> 

-- 
Dmitry
