Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4D6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A2C2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QqRqpIq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A2C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeJJTa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:30:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47622 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJJTa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WvBPMxNIuL8Fov3ZIkfuO8ade+/nlk3Rfc6d9Ne/lZ4=; b=QqRqpIq0ANZL1VUfv2H5ZLmKw
        VtlpJlEd1eDPg1iMM+UiosC55v4PoWa3J8HbDA1LFG5CTbyOVFb5IlITt8USDBAGGccHebt+RmbK7
        CabGbatk8Mvkmf7p9E3+u6xMzv2UUDNJ0ONYJnw0WalmZYkRgqH2i729Qw9ra9vtFXDo4=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:41183)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gADHQ-0006Zk-KO; Wed, 10 Oct 2018 13:07:56 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gADHM-0001d8-Hi; Wed, 10 Oct 2018 13:07:52 +0100
Date:   Wed, 10 Oct 2018 13:07:51 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] directory for SoC-related DT binding
Message-ID: <20181010120751.GP30658@n2100.armlinux.org.uk>
References: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 08:07:52PM +0900, Masahiro Yamada wrote:
> Hi,
> 
> 
> I see a bunch of vendor (or SoC) names in
> Documentation/device/bindings/arm/
> 
> ./Documentation/devicetree/bindings/arm/altera
> ./Documentation/devicetree/bindings/arm/amlogic
> ./Documentation/devicetree/bindings/arm/apm
> ./Documentation/devicetree/bindings/arm/bcm
> ./Documentation/devicetree/bindings/arm/calxeda
> ./Documentation/devicetree/bindings/arm/freescale
> ./Documentation/devicetree/bindings/arm/hisilicon
> ./Documentation/devicetree/bindings/arm/keystone
> ./Documentation/devicetree/bindings/arm/marvell
> ./Documentation/devicetree/bindings/arm/mediatek
> ./Documentation/devicetree/bindings/arm/mrvl
> ./Documentation/devicetree/bindings/arm/msm
> ./Documentation/devicetree/bindings/arm/npcm
> ./Documentation/devicetree/bindings/arm/nxp
> ./Documentation/devicetree/bindings/arm/omap
> ./Documentation/devicetree/bindings/arm/rockchip
> ./Documentation/devicetree/bindings/arm/samsung
> ./Documentation/devicetree/bindings/arm/stm32
> ./Documentation/devicetree/bindings/arm/sunxi
> ./Documentation/devicetree/bindings/arm/tegra
> ./Documentation/devicetree/bindings/arm/ti
> ./Documentation/devicetree/bindings/arm/uniphier
> ./Documentation/devicetree/bindings/arm/ux500
> ./Documentation/devicetree/bindings/arm/vt8500

These are for arch/arm/mach-* and are the DT root descriptions for the
various boards and SoCs.

> I also see some vendor names in
> Documentation/device/bindings/soc/
> 
> ./Documentation/devicetree/bindings/soc/bcm
> ./Documentation/devicetree/bindings/soc/dove
> ./Documentation/devicetree/bindings/soc/fsl
> ./Documentation/devicetree/bindings/soc/mediatek
> ./Documentation/devicetree/bindings/soc/qcom
> ./Documentation/devicetree/bindings/soc/rockchip
> ./Documentation/devicetree/bindings/soc/ti
> ./Documentation/devicetree/bindings/soc/xilinx
> ./Documentation/devicetree/bindings/soc/zte

These are for individual drivers in drivers/soc/

> Confusingly, I see bcm, mediatek, rockchip
> in both locations.

Correct, because one is for the SoC and board as a whole, the other is
for some subset of the SoC handled via drivers/soc - for example, with
Broadcom, there's a Raspberry PI power domain driver in drivers/soc,
which is described by

 Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt

whereas

 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt

describes the bindings for the root DT node BCM2835 as used on the
Raspberry Pi amongst other boards.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
