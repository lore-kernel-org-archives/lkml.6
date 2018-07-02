Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8A2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DC123C68
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKPUZSM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DC123C68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbeGBNUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:20:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42836 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeGBNUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:20:45 -0400
Received: by mail-pl0-f65.google.com with SMTP id y15-v6so6087177pll.9;
        Mon, 02 Jul 2018 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ir3ChEr0HqTxoel/nevm50n8yWXff+Sn6IeCX3ujf1I=;
        b=vKPUZSM0lahoTUWYepkJZxlGyKNBtPLnYW3r5z/0keQv5U4ADzj7Cl/ZI5mDdxO/oa
         AZYYvFNHPhIvbuDITVR1q6klp5dH2Y/bPushK4lKnNOPkIWY9HEu3nYeVl7wrwZeKhCi
         5css5MHYf25Npj0s8qxuTfFV+n/GtViWphk1deEvPUTBbTNBE70PkbynoOIIzuQ5YoZ4
         POO8aPZ9oHbK3RTI+ajx/GyuGZ95KhLrlcDufw/tximqRgfZUEFYW2tQyTXVXO2b+2Zt
         +/spbPy9AcL3sIIsglhAmXbtZ6M7F++BPQNslZL3lZtSs7R4dF11wOguQAn+Lg4B4q97
         QpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ir3ChEr0HqTxoel/nevm50n8yWXff+Sn6IeCX3ujf1I=;
        b=UzeuVaO2Op0o4SBDcCjGc9lIydKKDUKGb+/BXvTqe2blI5AfJHqhw5w//ikXcxFi9l
         gC884Uf7I9W55btDvQFD+W1Dx5Lnt5xUwK4smwMVQrBYLayDML1lZqRFyRgL5RCjFjbA
         E6kD6eQmC2pVDvwJ+FfXzZkTsxrDtRbK3opgygXLV5pi7ef42Mc/iZIEQvH0w+wAtm67
         IvQ9KYCR7M/bQk7WeMPnAUhxregkSS5zTkMqDhmQxDkaGmas1N8YjOV4TPuj/8A6SWdC
         q/UzyquPEq4b5kXH9vU8npWYoQWR3GSgbAd6Pw2A6szuDpoxOvcpxaGBGlT737Q8il9Z
         VorA==
X-Gm-Message-State: APt69E15/lGQBWOLVoHrDGPrUIIZiO8GHPr5bgjSVsKLpzGxTD7BH9YW
        fSyO/Ld8TOCSgcD4m66q8OaQGA==
X-Google-Smtp-Source: ADUXVKIiOxo+/DwXHlAGBs2GGSw2naRJ5jixQiwU0fgI4pVqfox4SDBO3+l5sdzOF0he8puEuZrZAQ==
X-Received: by 2002:a17:902:780e:: with SMTP id p14-v6mr25677239pll.239.1530537644992;
        Mon, 02 Jul 2018 06:20:44 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j133-v6sm32946655pgc.75.2018.07.02.06.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 06:20:44 -0700 (PDT)
Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
To:     "Tian, Baofeng" <baofeng.tian@intel.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0038B620BAC72941BCBF48AEB892976C02CADE1E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <140371d6-4bbb-6377-a570-5253c5f98e0e@roeck-us.net>
Date:   Mon, 2 Jul 2018 06:20:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 12:30 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
> 
> Setting "force_no_reboot" parameter to true (y/Y/1) will have
> the effect to prevent to reset the NO_REBOOT flag thus
> preventing the iTCO to reboot the platform, if not set
> or set to false, then system will reboot after about 30s.
> 
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>

Your e-mail address is messed up.

> ---
>   drivers/watchdog/iTCO_wdt.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 347f038..255318b 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -131,6 +131,11 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);
>   MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
>        "Turn off SMI clearing watchdog (depends on TCO-version)(default=1)");
> 
> +static bool force_no_reboot;
> +module_param(force_no_reboot, bool, 0);
> +MODULE_PARM_DESC(force_no_reboot,
> +           "Prevents the watchdog rebooting the platform (default=0)");
> +
>   /*
>    * Some TCO specific functions
>    */
> @@ -243,6 +248,10 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>        struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
>        unsigned int val;
> 
> +     /* force_no_reboot will prevent to unset NO_REBOOT bit */
> +     if (force_no_reboot)
> +           return -EIO;
> +
It seems to me that this flag prevents the watchdog from being started,
and on top it would return an unreasonable error (-EIO).

I don't see the point of this patch, sorry.

Guenter

>        spin_lock(&p->io_lock);
> 
>        iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
> @@ -250,7 +259,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>        /* disable chipset's NO_REBOOT bit */
>        if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
>              spin_unlock(&p->io_lock);
> -           pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
> +           pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS/rc_cmd\n");
>              return -EIO;
>        }
> 
> -- 
> 2.7.4
> 

