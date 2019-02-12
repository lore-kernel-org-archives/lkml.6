Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5243FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6A320838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549980407;
	bh=PsD4ccfcvf4DcvplmHl/tmoOUzqlSaJJFXl7QsApKYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cIKvGkuJiHq6UtjCv5f/hfxWKbThnW4jw3f5hoKg7MPoolnmxLJV31T4BZh+wJQTw
	 SiUP7zyrqbU5mqtHgd2tjc3VjlMy6fPGqogNqjgugIgeND0COfm95p35rhsqajkKjx
	 CVBoSlvuqacBb8s8MzSZ0ybVKyupIcKy1cpT5Rsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfBLOGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:06:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfBLOGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:06:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5341820838;
        Tue, 12 Feb 2019 14:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549980403;
        bh=PsD4ccfcvf4DcvplmHl/tmoOUzqlSaJJFXl7QsApKYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prl/oekjJam4Z4sLk80DFZhx8k3/iQoXzNwYUfO94dfeGAc6/9ZP7TblC5IVVQkww
         yarF+4dDfiBb/K39Mavinzpz2rCda7PToXhMUJ7+Zl1FRRPtPvssI1RcPmgHmslJpZ
         hNYdWrn+8FspyGels9QuSOr/lHimFW7DNoO4sEq8=
Date:   Tue, 12 Feb 2019 15:05:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: For 5.1 merge window
Message-ID: <20190212140518.GA32233@kroah.com>
References: <20190212131319.30398-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212131319.30398-1-kishon@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:43:19PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.1 merge window below.
> 
> It adds two new Armada PHY drivers to support COMPHY and UTMI PHY and a
> PHY driver to support Cadence D-PHY. It also extends existing omap-usb2 PHY
> driver, qcom-qmp PHY driver and qcom-qusb2 PHY driver to support PHYs in
> newer platforms. It also includes minor fixes and cleanups.
> 
> For the complete list of changes, please see the tag message below.
> 
> Let me know If I have to make any modifications to this pull request.
> 
> This pull request will conflict with -net pull request since one of the
> Armada PHY drivers is merged via -net tree. The final resolution should
> be like below
> 
> diff --cc drivers/phy/marvell/Kconfig
> index 224ea4e6a46d,b8e9dd38ad0d..000000000000
> --- a/drivers/phy/marvell/Kconfig
> +++ b/drivers/phy/marvell/Kconfig
> @@@ -21,16 -21,27 +21,37 @@@ config PHY_BERLIN_US
>   	help
>   	  Enable this to support the USB PHY on Marvell Berlin SoCs.
>   
> + config PHY_MVEBU_A3700_COMPHY
> + 	tristate "Marvell A3700 comphy driver"
> + 	depends on ARCH_MVEBU || COMPILE_TEST
> + 	depends on OF
> + 	depends on HAVE_ARM_SMCCC
> + 	default y
> + 	select GENERIC_PHY
> + 	help
> + 	  This driver allows to control the comphy, a hardware block providing
> + 	  shared serdes PHYs on Marvell Armada 3700. Its serdes lanes can be
> + 	  used by various controllers: Ethernet, SATA, USB3, PCIe.
> + 
> + config PHY_MVEBU_A3700_UTMI
> + 	tristate "Marvell A3700 UTMI driver"
> + 	depends on ARCH_MVEBU || COMPILE_TEST
> + 	depends on OF
> + 	default y
> + 	select GENERIC_PHY
> + 	help
> + 	  Enable this to support Marvell A3700 UTMI PHY driver.
> + 
>  +config PHY_MVEBU_A38X_COMPHY
>  +	tristate "Marvell Armada 38x comphy driver"
>  +	depends on ARCH_MVEBU || COMPILE_TEST
>  +	depends on OF
>  +	select GENERIC_PHY
>  +	help
>  +	  This driver allows to control the comphy, an hardware block providing
>  +	  shared serdes PHYs on Marvell Armada 38x. Its serdes lanes can be
>  +	  used by various controllers (Ethernet, sata, usb, PCIe...).
>  +
>   config PHY_MVEBU_CP110_COMPHY
>   	tristate "Marvell CP110 comphy driver"
>   	depends on ARCH_MVEBU || COMPILE_TEST
> diff --cc drivers/phy/marvell/Makefile
> index 59b6c03ef756,82f291cf59ee..000000000000
> --- a/drivers/phy/marvell/Makefile
> +++ b/drivers/phy/marvell/Makefile
> @@@ -2,7 -2,8 +2,9 @@@
>   obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
>   obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
>   obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
> + obj-$(CONFIG_PHY_MVEBU_A3700_COMPHY)	+= phy-mvebu-a3700-comphy.o
> + obj-$(CONFIG_PHY_MVEBU_A3700_UTMI)	+= phy-mvebu-a3700-utmi.o
>  +obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+= phy-armada38x-comphy.o
>   obj-$(CONFIG_PHY_MVEBU_CP110_COMPHY)	+= phy-mvebu-cp110-comphy.o
>   obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
>   obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
> 
> Thanks
> Kishon
> 
> The following changes since commit 827cb0323928952c0db9515aba9d534fb1285b3f:
> 
>   phy: ath79-usb: Fix the main reset name to match the DT binding (2019-01-16 18:00:57 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.1

Pulled and pushed out, thanks.

greg k-h
