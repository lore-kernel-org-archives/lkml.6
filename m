Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB1C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7758E2150C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rfzIKClG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7758E2150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJJWZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:25:06 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:46188 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJJWZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:25:06 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9AF2MrR023279;
        Thu, 11 Oct 2018 00:02:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9AF2MrR023279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539183743;
        bh=3f7GhQWA/IdQP1onQzFkHP8p0yWYF8OnrpHwZ3yxo5Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rfzIKClGiziRw80e5yJTflf3z7tsFPVremz/yIpbesyojdaHchwwWudxnotINzY38
         UnTKnAPoZ8tNg9bjsnPP7pxQtvkNxXBKeloBPjtwm9twaB4zXOrqdEaMx+2lYHdqIN
         lbX81jZk0AYvtfR3pqEa0MCXd0BPQeeOygk583ZK3v7v3IJtuF5x4PUCxEk96mSZl4
         ZzIDocXrySWeOSyioobFCfgISrAHtU/96pnw7nGHNnpkmki5qTik2FFodM98D+NYai
         WNV+hh6ltn1hi7Zc3htxQwZLpsFhzDIYvIIM7Tz6IqzLA5FzR5iC1ioSbxQ8QhjT4e
         q9pVDEXX0lR7Q==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id r83so5341757vsc.4;
        Wed, 10 Oct 2018 08:02:22 -0700 (PDT)
X-Gm-Message-State: ABuFfogwvrmEGS5Y9k4gp5NJUCv8/bK7QTbXO3tOGwzjzTc2tDxAy/6v
        ibOiKHIacekBydKTrfDf4woD9Io9ugg0E6efokU=
X-Google-Smtp-Source: ACcGV63JT4r4heEopgPXV2z+PZ/EUjN0Z1meVp9BqoafdaqeF7ZPDnzJtwlLmfgiqm2X59yJztKqSI2PxU2+omNKIws=
X-Received: by 2002:a67:61c1:: with SMTP id v184mr8507047vsb.179.1539183741474;
 Wed, 10 Oct 2018 08:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
 <20181010120751.GP30658@n2100.armlinux.org.uk>
In-Reply-To: <20181010120751.GP30658@n2100.armlinux.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Oct 2018 00:01:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASEEJw6Yp9HzSoEOwM4iKC=EEjTefE=VLv-wdNstsMriw@mail.gmail.com>
Message-ID: <CAK7LNASEEJw6Yp9HzSoEOwM4iKC=EEjTefE=VLv-wdNstsMriw@mail.gmail.com>
Subject: Re: [Question] directory for SoC-related DT binding
To:     Russell King <linux@armlinux.org.uk>
Cc:     DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 9:09 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Wed, Oct 10, 2018 at 08:07:52PM +0900, Masahiro Yamada wrote:
> > Hi,
> >
> >
> > I see a bunch of vendor (or SoC) names in
> > Documentation/device/bindings/arm/
> >
> > ./Documentation/devicetree/bindings/arm/altera
> > ./Documentation/devicetree/bindings/arm/amlogic
> > ./Documentation/devicetree/bindings/arm/apm
> > ./Documentation/devicetree/bindings/arm/bcm
> > ./Documentation/devicetree/bindings/arm/calxeda
> > ./Documentation/devicetree/bindings/arm/freescale
> > ./Documentation/devicetree/bindings/arm/hisilicon
> > ./Documentation/devicetree/bindings/arm/keystone
> > ./Documentation/devicetree/bindings/arm/marvell
> > ./Documentation/devicetree/bindings/arm/mediatek
> > ./Documentation/devicetree/bindings/arm/mrvl
> > ./Documentation/devicetree/bindings/arm/msm
> > ./Documentation/devicetree/bindings/arm/npcm
> > ./Documentation/devicetree/bindings/arm/nxp
> > ./Documentation/devicetree/bindings/arm/omap
> > ./Documentation/devicetree/bindings/arm/rockchip
> > ./Documentation/devicetree/bindings/arm/samsung
> > ./Documentation/devicetree/bindings/arm/stm32
> > ./Documentation/devicetree/bindings/arm/sunxi
> > ./Documentation/devicetree/bindings/arm/tegra
> > ./Documentation/devicetree/bindings/arm/ti
> > ./Documentation/devicetree/bindings/arm/uniphier
> > ./Documentation/devicetree/bindings/arm/ux500
> > ./Documentation/devicetree/bindings/arm/vt8500
>
> These are for arch/arm/mach-* and are the DT root descriptions for the
> various boards and SoCs.
>
> > I also see some vendor names in
> > Documentation/device/bindings/soc/
> >
> > ./Documentation/devicetree/bindings/soc/bcm
> > ./Documentation/devicetree/bindings/soc/dove
> > ./Documentation/devicetree/bindings/soc/fsl
> > ./Documentation/devicetree/bindings/soc/mediatek
> > ./Documentation/devicetree/bindings/soc/qcom
> > ./Documentation/devicetree/bindings/soc/rockchip
> > ./Documentation/devicetree/bindings/soc/ti
> > ./Documentation/devicetree/bindings/soc/xilinx
> > ./Documentation/devicetree/bindings/soc/zte
>
> These are for individual drivers in drivers/soc/

I see.

Thanks for helpful info!


-- 
Best Regards
Masahiro Yamada
