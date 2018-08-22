Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D519C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBEC206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrWAxKM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBEC206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeHVMHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:07:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46390 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeHVMHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:07:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so814477ljj.13;
        Wed, 22 Aug 2018 01:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PXRTCQi9U3dk+/UxmKwXG7JzkynVMNCekHHEPRpYzyg=;
        b=XrWAxKM9I2mG/BJ+anLfLjCEOU0UXH3Uo1UIKHuR2O1X6CikDLNC9FEnfrKw8gBvhQ
         SLcS2dhm1Cf0QfwXkz/sbCtvlaWpf2nBcSdjjD1WV92rocMVg8UMr4tQaYN2JC6AZcHA
         9DMDbBTYvnMnRSbFTzmSFvvpXkaaZ0zVayr/8ShH+DSFGDId9j3CSepJaLN3V5SqKKOe
         T1Bnz//hpM2wd4C4i71PL46E+RIQ4zh6LiL7elsmQHU737cJkYCBUQg9q2PFwIyBJHes
         W/LjadFHyq1E0OYM9aPXQ08fB43TSHwzrxfxFsGjePXn4rwdJR3y8jSL3JtpIjkKmXLd
         Yn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXRTCQi9U3dk+/UxmKwXG7JzkynVMNCekHHEPRpYzyg=;
        b=U1adIR4IuMk/qz8Mnka7K3prbSc+ACWgwFRrd+HA+tHQ401YL8BTXAPqYkwRFTlpck
         /8i2ml9fN8XLU7FrX+/1I26VUbEB2UypMgPb/82NPvB51KwgACDGqnbnNnMD4p6b4ovb
         jE1jNHAE3d9jJ69fE2vAk9VjOE0PF+UBIi9fxUcu8yX7jqti0Fr37gngrdWO0VkfUvQ/
         nbLjjk0hliC5NUmsvUi2rAW1MWvrHBYw47NxPmB8WhIIl5QZCnOrStx49cUajK3zaaKe
         6NtsrTQodyAecatrFutzIV4PC5FYrkQXcfSmAde2QKd4X6jFA09rCYT3EfarPYmk2xTJ
         JwhA==
X-Gm-Message-State: AOUpUlGnAXUbtubrvPi98CWT19zyuO6TFnh5LwkFw5LReDNuKosAUHF3
        5fWJXx+lIu8G/413zcd5QEE=
X-Google-Smtp-Source: AA+uWPx0ilGVKDDET/2Q28OEuY07N1RhV1xfbV4PkMX89nWSRUkHwBQ/t0acDpC+mq35TbpO0T79Tg==
X-Received: by 2002:a2e:1781:: with SMTP id 1-v6mr35694193ljx.76.1534927399232;
        Wed, 22 Aug 2018 01:43:19 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u2-v6sm182185ljg.55.2018.08.22.01.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 01:43:18 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fsOjW-00081W-Pe; Wed, 22 Aug 2018 10:43:18 +0200
Date:   Wed, 22 Aug 2018 10:43:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "J, KEERTHY" <j-keerthy@ti.com>
Cc:     Johan Hovold <johan@kernel.org>, tony@atomide.com,
        d-gerlach@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
        ssantosh@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which
 it is functional
Message-ID: <20180822084318.GN14967@localhost>
References: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
 <20180822073409.GK14967@localhost>
 <20180822073719.GL14967@localhost>
 <ae71d45f-9260-3547-5ff2-355c084fcf8e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae71d45f-9260-3547-5ff2-355c084fcf8e@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 01:50:29PM +0530, J, KEERTHY wrote:
> 
> 
> On 8/22/2018 1:07 PM, Johan Hovold wrote:
> > On Wed, Aug 22, 2018 at 09:34:09AM +0200, Johan Hovold wrote:
> >> On Wed, Aug 22, 2018 at 11:02:31AM +0530, Keerthy wrote:
> >>> Enable DS0 for only those platforms on which it is functional
> >>>
> >>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >>> ---
> >>>   arch/arm/mach-omap2/pm33xx-core.c    | 5 +++++
> >>>   drivers/soc/ti/pm33xx.c              | 9 +++++++++
> >>>   include/linux/platform_data/pm33xx.h | 2 ++
> >>>   3 files changed, 16 insertions(+)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
> >>> index f4971e4..f0f6e8e 100644
> >>> --- a/arch/arm/mach-omap2/pm33xx-core.c
> >>> +++ b/arch/arm/mach-omap2/pm33xx-core.c
> >>> @@ -135,6 +135,11 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
> >>>   {
> >>>   	int ret = 0;
> >>>   
> >>> +	if (!(args & WFI_FLAG_DEEP_SLEEP0)) {
> >>> +		pr_err("DS0 mode not supported\n");
> >>> +		return -ENOTSUPP;
> >>> +	}
> >>> +
> >>>   	amx3_pre_suspend_common();
> >>>   	scu_power_mode(scu_base, SCU_PM_POWEROFF);
> >>>   	ret = cpu_suspend(args, fn);
> >>> diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
> >>> index d0dab32..53238d7 100644
> >>> --- a/drivers/soc/ti/pm33xx.c
> >>> +++ b/drivers/soc/ti/pm33xx.c
> >>> @@ -324,6 +324,15 @@ static int am33xx_pm_probe(struct platform_device *pdev)
> >>>   	suspend_wfi_flags |= WFI_FLAG_SAVE_EMIF;
> >>>   	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
> >>>   
> >>> +	/*
> >>> +	 * Deep Sleep0 mode is currently functional only on am437x-gp-evm,
> >>> +	 * am33xx-evm and boneblack family. Hence set the DS0 flag
> >>> +	 */
> >>> +	if (of_machine_is_compatible("ti,am437x-gp-evm") ||
> >>> +	    of_machine_is_compatible("ti,am335x-bone-black") ||
> >>> +	    of_machine_is_compatible("ti,am335x-evm"))
> >>> +		suspend_wfi_flags |= WFI_FLAG_DEEP_SLEEP0;
> >>
> >> What about other (out-of-tree) machines which supports DS0 and which
> >> this change would break?
> >>
> >> I think this needs to be a blacklist if anything.
> >>
> >> Please also expand in the commit message why you think this is needed.
> 
> Currently when one does echo mem > /sys/power/state on unsuppored 
> machines there can be a crash or a hang. So bail out with a message.

Yes, but why is this unsupported on some machines? Which machines, and
why? Your commit messages should be self-contained and hold the
information needed to determine whether your patch makes sense in the
first place.

> >> Last, what tree is this against? There's no am43xx_suspend() in
> >> linux-next (and you add compatibles above for am33xx too).
> > 
> > Sorry, there is indeed an am43xx_suspend(), but you are adding
> > compatibles for am33xx which use am33xx_suspend().
> 
> am33xx_pm_probe is a common probe function for both am33 and am43.

Yes, but you add a check for your new flag only to am43xx_suspend(), not
to am33xx_suspend() which is used by the am33xx compatibles you add.

> AFAIK for am33 family am335x-evm and am335x-bone-black support Deep 
> Sleep mode. For am43 family am43tx-gp-evm alone supports at the moment.

But these are development boards (EVKs), not SOC families (or
chip revisions). What about all the products that customers to TI who
have bought these SoCs have built?

> Can you let me know of other am33 machines that support DS0 mode?

I have a customer who use DS0, whose DTS is not yet in mainline, and
whose setup this patch would break for example.

> I could have simply used ti,am33xx compatible which covers entire am33 
> family but then am33xx-bone (bone white) does not support this mode.

Yes, and a blacklist would make much more sense for something like this
if where talking about specific boards.

Also note that your patch doesn't even handle bone-white as you didn't
add a check to am33xx_suspend() as I pointed out above.

Johan
