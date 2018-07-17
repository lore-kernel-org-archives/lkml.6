Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFCAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5051520C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRD/OMGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5051520C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbeGQOhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:37:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43828 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeGQOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:37:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id v13-v6so487000pgr.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jL/X9m+bnOfsRA7FTfnIuNgDUtwpFOSvFGvO4iQWk2Q=;
        b=BRD/OMGOlm+76cL4A6OF/YoSIa69t8qLKYml1501blU5K2bnKrAqwemKKPWBTHwLen
         K1xjtrtnWRCovDkKv2E0MHFgkeG5Ec8klzvp3hiwp9MnhqmRgHnWBS/qGSWIDUa8ltNd
         v4ie0/JUCFSxtjel8RHSFTSoviJJwfpeEDyxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jL/X9m+bnOfsRA7FTfnIuNgDUtwpFOSvFGvO4iQWk2Q=;
        b=RAPXZhthLPsjuik/eZsm6hsajaEk7y3QEyYAl+tHAv96S5yx9/pKB49cEYsuCc60mW
         3brphtGvRE2Y27kNNjW/ipISa8I8K8KMlCo47+OnpLTLD5NU+39NWoKO/QxYpQpkUqup
         SfdhId/cJ3ErZw1CDIWjLF7XVwAMGaXECtnp4VQjtguQEDOE49BnHHd6mO5F/6nqfD7U
         UmyVrRo/47mRndiV2Q9pwRcEIgXS9CrQ2NK/ranIeIbLWmYfWz0B1BLw+Fcaqi0bMNHj
         ZRxpXUpISSKDXkuKiREYQ5RO+N1Gi6QMVok2wawaA1IjKK4yZhj0BWBngc90LLUpp2ss
         TNpQ==
X-Gm-Message-State: AOUpUlEWRKTdTAYeXYwc3KmPHdNEys6rsMAJ0PVgMiG/+k71BZUcRzh6
        tCqemMBqspIumDQstnqGrJM+
X-Google-Smtp-Source: AAOMgpfj3+83blEfnRaJJtHP/667Vml68ph6kIOyLasZoKL5YzBtKxX9FhylRmQgLjakEYtJsYN8Cg==
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr847953pfo.160.1531836302247;
        Tue, 17 Jul 2018 07:05:02 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id b192-v6sm9272230pga.2.2018.07.17.07.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 07:05:01 -0700 (PDT)
Date:   Tue, 17 Jul 2018 19:34:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com
Subject: Re: [PATCH v2 2/2] arm64: dts: Add Mediatek X20 Development Board
 support
Message-ID: <20180717140453.GA19076@mani>
References: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
 <20180605163442.4812-3-manivannan.sadhasivam@linaro.org>
 <d88504b4-409c-c42b-f816-bedefce2a819@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d88504b4-409c-c42b-f816-bedefce2a819@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Mon, Jul 16, 2018 at 03:24:44PM +0200, Matthias Brugger wrote:
> Hi Manivanna,
> 
> On 05/06/18 18:34, Manivannan Sadhasivam wrote:
> > Add initial device tree support for Mediatek X20 Development Board
> > based on MT6797 Deca core SoC. This board is one of the 96Boards
> > Consumer Edition platform.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
> >  .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> > index ac17f60f998c..5b7fd6ad96e4 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> > diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> > new file mode 100644
> > index 000000000000..2c09ca95d9e2
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> > @@ -0,0 +1,33 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device Tree Source for MediaTek X20 Development Board
> > + *
> > + * Copyright (C) 2018, Linaro Ltd.
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "mt6797.dtsi"
> > +
> > +/ {
> > +	model = "Mediatek X20 Development Board";
> > +	compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
> > +
> > +	aliases {
> > +		serial0 = &uart1;
> > +	};
> 
> Sorry for the late answer.
> Why did you use uart1 instead of uart0?
> I know that uart0 is used by the bootloader, but because of their exotic flash
> procedure I find it quite useful to see this messages in my serial connection.
> Of course you can only use 921600 baudrate then.
> 

The reason is, most of the Mezzanine boards use USB to UART bridge on the
UART1 port available on the Low Speed Expansion header. Additionally, the
convention followed by most of the Consumer Edition 96Boards is to use UART1
as the debug serial port. That's why eventhough the bootloader is using UART0,
I forced the kernel to use UART1.

> > +
> > +	memory@40000000 {
> > +		device_type = "memory";
> > +		reg = <0 0x40000000 0 0x1e605000>;
> 
> How comes this strange number for the memory size?
> 

Actually, the memory size is extracted from the downstream kernel [1].

> BTW do you know the differences between the EVB board and the x20 one?
> I used the evb dts for booting up to now.
> 

Sorry, I don't know the difference between both boards!

Thanks,
Mani

[1] https://github.com/helio-x20/linux/blob/helio-x20/arch/arm64/boot/dts/amt6797_64_open.dts#L8

> Best regards,
> Matthias
> 
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +};
> > +
> > +&uart1 {
> > +	status = "okay";
> > +};
> > 
