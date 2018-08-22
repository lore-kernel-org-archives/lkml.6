Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00426C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB3D21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szPIPT4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB3D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeHVK5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:57:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33838 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeHVK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:57:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so717373ljk.1;
        Wed, 22 Aug 2018 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ClZGx4MeigKRPfILqQ+DFDAkm4s+VI2rV6E9tisjjUA=;
        b=szPIPT4SwIFAhr2V/tU4CVLeWXLTUZjXUyT1or8j4nHjKezwO4fCcupr1MoCR1L6dJ
         /N1O923rK/8x1PtWubkpj+AIrBQMvsbzUsvPrGmV9flwg4/C1WupkXoaz9P+Hz8MFfd+
         6S1bQ5U8UnJAp0LksVOiEpRnDv+ikw0rXDd5X/z3axgqyHGBMBHgRO/f4XVAGElhWhfx
         3loRXhLGhv9iqkISyd1nEY/cj9v6wIWzz+FcSrUTLsSU1ar5EMekpv7sBkKGxW78pn0O
         h0OFpfYFDVsBv61KUzOhw68c5hv2TKIYshrykmJZGi8tAsZR1neh4ASCd1hd2do/rYsz
         dbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ClZGx4MeigKRPfILqQ+DFDAkm4s+VI2rV6E9tisjjUA=;
        b=gpLZM0rKo/xHJ694Hl7h6ECSUkTYjUViOHNA3KMm3jbNJZer+3XA34AEftHVMjDvrA
         0QU3mxogVNjRihivof3AbcKbnkXXcYa6bHRPgbp4GmxthwX2B8J9xua2jZy9kOGCVEW2
         Ycw7olEylZt4Ozjj1PQ4lsYud3/s/tGDAVJoHQvseaO+xClUi+yYV2GCiomVNAIVrdhe
         7anqqD30O8g2lBbqMddNuogpknoqD+TQHm4M1PzyGktBuMsSHoqUsg3lWSSRGrE2ZiHW
         4dvbT7WohuqLLv1+B/2i2pN3OPQFSbVMOfDWmn3frkmvzkhoQncF8BFjnjYlMshO+96x
         k+5Q==
X-Gm-Message-State: AOUpUlH23OSHTPrvn9YPXCh6aJXOcuku0t5BcKd31NJadLocgDntk1dP
        C9IUouGB+cS1BXmOLMn2j5LUa2Xs
X-Google-Smtp-Source: AA+uWPxpdcQYwxhCPhvQyGIbia3ov2pvreGfyVWABFFoWS8RgB7E0mKX3NIKgOonhz5CXNqXrTT4Ew==
X-Received: by 2002:a2e:2282:: with SMTP id i124-v6mr38055290lji.11.1534923248891;
        Wed, 22 Aug 2018 00:34:08 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id s202-v6sm175127lfs.28.2018.08.22.00.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 00:34:08 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fsNeb-0007pa-Hj; Wed, 22 Aug 2018 09:34:09 +0200
Date:   Wed, 22 Aug 2018 09:34:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     tony@atomide.com, d-gerlach@ti.com, linux-kernel@vger.kernel.org,
        t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which
 it is functional
Message-ID: <20180822073409.GK14967@localhost>
References: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:02:31AM +0530, Keerthy wrote:
> Enable DS0 for only those platforms on which it is functional
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/mach-omap2/pm33xx-core.c    | 5 +++++
>  drivers/soc/ti/pm33xx.c              | 9 +++++++++
>  include/linux/platform_data/pm33xx.h | 2 ++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
> index f4971e4..f0f6e8e 100644
> --- a/arch/arm/mach-omap2/pm33xx-core.c
> +++ b/arch/arm/mach-omap2/pm33xx-core.c
> @@ -135,6 +135,11 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
>  {
>  	int ret = 0;
>  
> +	if (!(args & WFI_FLAG_DEEP_SLEEP0)) {
> +		pr_err("DS0 mode not supported\n");
> +		return -ENOTSUPP;
> +	}
> +
>  	amx3_pre_suspend_common();
>  	scu_power_mode(scu_base, SCU_PM_POWEROFF);
>  	ret = cpu_suspend(args, fn);
> diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
> index d0dab32..53238d7 100644
> --- a/drivers/soc/ti/pm33xx.c
> +++ b/drivers/soc/ti/pm33xx.c
> @@ -324,6 +324,15 @@ static int am33xx_pm_probe(struct platform_device *pdev)
>  	suspend_wfi_flags |= WFI_FLAG_SAVE_EMIF;
>  	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
>  
> +	/*
> +	 * Deep Sleep0 mode is currently functional only on am437x-gp-evm,
> +	 * am33xx-evm and boneblack family. Hence set the DS0 flag
> +	 */
> +	if (of_machine_is_compatible("ti,am437x-gp-evm") ||
> +	    of_machine_is_compatible("ti,am335x-bone-black") ||
> +	    of_machine_is_compatible("ti,am335x-evm"))
> +		suspend_wfi_flags |= WFI_FLAG_DEEP_SLEEP0;

What about other (out-of-tree) machines which supports DS0 and which
this change would break?

I think this needs to be a blacklist if anything.

Please also expand in the commit message why you think this is needed.

Last, what tree is this against? There's no am43xx_suspend() in
linux-next (and you add compatibles above for am33xx too).

Thanks,
Johan
