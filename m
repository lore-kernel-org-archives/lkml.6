Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642E3C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1BC21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZwjSvGcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1BC21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeJDQJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:09:07 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34620 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDQJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tUzpy7auqqbnHtm7e8Zyc5Taz6ORwsCIXflLliKE4Xs=; b=ZwjSvGcQfYWuWZocZzmxqKi4T
        8S/fvK4dOFCEWGzC1kuY0mmH4yumPQtab1Bflqc2udAot25noVK+hoven2I7Hh/rb9Ld8kuoOh/s0
        d7vjoSbwCuO/AjbHxsE29XAd0jIjs8yIM4uJ7w10tZEuY1bW89ooydLa6Ht/23Zgeg/pM=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:57011)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g7zkO-0005nZ-2R; Thu, 04 Oct 2018 10:16:40 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g7zkJ-0001bX-9A; Thu, 04 Oct 2018 10:16:35 +0100
Date:   Thu, 4 Oct 2018 10:16:32 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: socfpga: Turn on ARM errata for L2 cache
Message-ID: <20181004091632.GA30658@n2100.armlinux.org.uk>
References: <20181004085415.12925-1-peron.clem@gmail.com>
 <20181004085415.12925-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181004085415.12925-3-peron.clem@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 10:54:15AM +0200, Clément Péron wrote:
> From: Dinh Nguyen <dinguyen@kernel.org>
> 
> Turn on these ARM and PL310 errata for SoCFPGA:
> 
> ARM_ERRATA_754322
> ARM_ERRATA_764369
> ARM_ERRATA_775420
> 
> PL310_ERRATA_588369
> PL310_ERRATA_727915
> PL310_ERRATA_753970
> PL310_ERRATA_769419
> 
> Fixes: 387798b37c8d ("ARM: initial multiplatform support")

What was broken in the referred to commit that caused this regression?
If it's not a regression, why does it have a Fixes: line?

> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  arch/arm/mach-socfpga/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index 4adb901dd5eb..a04660918d71 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -11,6 +11,13 @@ menuconfig ARCH_SOCFPGA
>  	select HAVE_ARM_TWD if SMP
>  	select MFD_SYSCON
>  	select PCI_DOMAINS if PCI
> +	select ARM_ERRATA_754322
> +	select ARM_ERRATA_764369 if SMP
> +	select ARM_ERRATA_775420
> +	select PL310_ERRATA_588369
> +	select PL310_ERRATA_727915
> +	select PL310_ERRATA_753970 if PL310
> +	select PL310_ERRATA_769419
>  
>  if ARCH_SOCFPGA
>  config SOCFPGA_SUSPEND
> -- 
> 2.17.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
