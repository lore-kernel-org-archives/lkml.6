Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1D5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FAB20652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAjl+Koz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FAB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeGRRVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:21:55 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37608 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbeGRRVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:21:55 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so2295170plc.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aoOTwWScpJ1WR8TQi6tBQQulegZaGXufU4nLG4sjHK4=;
        b=SAjl+KozG1WjMRzZ3lXpzmmvljMbEvb25KuC4Bu2JNGFkXdjOAfx8xDO5jiLpB1OTF
         S3DfCpth6M63qLmSbmplmW8jTlvKsdgJlHPoP81qkkUkDJjPflpba8SfcudcLv9kFTXU
         /eqpXoPShYfA2zpdvpKlt1uiz8h69P8bMLKXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aoOTwWScpJ1WR8TQi6tBQQulegZaGXufU4nLG4sjHK4=;
        b=DuVZzaTmptb/YvBlzyFlpQdyvx4QD87iq9q0AOpL381s2zROOINLXPPREnZ8nIhdIC
         qvi8NE4fg0bA/QSE6nFsJTFquGenlCtrRd/Czv3W4ybYFwxGIQDGcrsgDKQCJR/p625U
         dZtxulMyfKgbmXImMHon9o2prQ6Rt2HMeDA4IZ2KsBA1REtmE50/q0u/n++rVZcjky3Y
         X5pyLeHkSgxB0aNI97eCTrkgOQrrxrjfBVp9s/OALZSUJGl0hCGwf2qIrRccNp1ymH1t
         hB+o9raxMziPYYUYAR/QhGCcRbysxxI2Ar8K7USb7NWlvDFXZbUEraxSYW/AEQlMEcua
         na4A==
X-Gm-Message-State: AOUpUlGRVOjS0j6EGmH8Qul2PUu5S5gsmZ3j/bzWlOJk97LUQAYThbr8
        xViZ+pX+DWjBQObWSPFU9hhk
X-Google-Smtp-Source: AAOMgpdyViucPVaSWiEel9Eip+16up0v63+8haMmcLWGHpt+I5rKHlwS+BjLmbA8PcatTEytPpBUiQ==
X-Received: by 2002:a17:902:8:: with SMTP id 8-v6mr6723669pla.287.1531932191051;
        Wed, 18 Jul 2018 09:43:11 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:628d:5c0b:c41c:3ac6:8e56:5127])
        by smtp.gmail.com with ESMTPSA id 14-v6sm8264846pft.93.2018.07.18.09.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 09:43:10 -0700 (PDT)
Date:   Wed, 18 Jul 2018 22:13:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com
Subject: Re: [PATCH v2 2/2] arm64: dts: Add Mediatek X20 Development Board
 support
Message-ID: <20180718164304.GA4902@Mani-XPS-13-9360>
References: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
 <20180605163442.4812-3-manivannan.sadhasivam@linaro.org>
 <d88504b4-409c-c42b-f816-bedefce2a819@gmail.com>
 <20180717140453.GA19076@mani>
 <a48b0735-ff75-6228-22ba-c8e868240f0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a48b0735-ff75-6228-22ba-c8e868240f0c@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Wed, Jul 18, 2018 at 05:07:38PM +0200, Matthias Brugger wrote:
> 
> 
> On 17/07/18 16:04, Manivannan Sadhasivam wrote:
> > Hi Matthias,
> > 
> > On Mon, Jul 16, 2018 at 03:24:44PM +0200, Matthias Brugger wrote:
> >> Hi Manivanna,
> >>
> >> On 05/06/18 18:34, Manivannan Sadhasivam wrote:
> >>> Add initial device tree support for Mediatek X20 Development Board
> >>> based on MT6797 Deca core SoC. This board is one of the 96Boards
> >>> Consumer Edition platform.
> >>>
> >>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>> ---
> >>>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
> >>>  .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
> >>>  2 files changed, 34 insertions(+)
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> >>> index ac17f60f998c..5b7fd6ad96e4 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/Makefile
> >>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> >>> @@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> >>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> >>> new file mode 100644
> >>> index 000000000000..2c09ca95d9e2
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> >>> @@ -0,0 +1,33 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Device Tree Source for MediaTek X20 Development Board
> >>> + *
> >>> + * Copyright (C) 2018, Linaro Ltd.
> >>> + *
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +
> >>> +#include "mt6797.dtsi"
> >>> +
> >>> +/ {
> >>> +	model = "Mediatek X20 Development Board";
> >>> +	compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
> >>> +
> >>> +	aliases {
> >>> +		serial0 = &uart1;
> >>> +	};
> >>
> >> Sorry for the late answer.
> >> Why did you use uart1 instead of uart0?
> >> I know that uart0 is used by the bootloader, but because of their exotic flash
> >> procedure I find it quite useful to see this messages in my serial connection.
> >> Of course you can only use 921600 baudrate then.
> >>
> > 
> > The reason is, most of the Mezzanine boards use USB to UART bridge on the
> > UART1 port available on the Low Speed Expansion header. Additionally, the
> > convention followed by most of the Consumer Edition 96Boards is to use UART1
> > as the debug serial port. That's why eventhough the bootloader is using UART0,
> > I forced the kernel to use UART1.
> > 
> 
> Sounds reasonable, I don't have this 96 boards adapter and I forgot about it.
> 

That's fine :)

> >>> +
> >>> +	memory@40000000 {
> >>> +		device_type = "memory";
> >>> +		reg = <0 0x40000000 0 0x1e605000>;
> >>
> >> How comes this strange number for the memory size?
> >>
> > 
> > Actually, the memory size is extracted from the downstream kernel [1].
> > 
> 
> Hm, Archermind "Helio X20 Development Board Hardware Manual" talks about 2GB
> LPDDR3-SDRAM. Would you mind to check if that is actually true?
> 

Yes, it is 2GB. Shall I change the size to 0x80000000?

Thanks,
Mani

> >> BTW do you know the differences between the EVB board and the x20 one?
> >> I used the evb dts for booting up to now.
> >>
> > 
> > Sorry, I don't know the difference between both boards!
> 
> Sure, no problem :)
> 
> Regards,
> Matthias
> 
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://github.com/helio-x20/linux/blob/helio-x20/arch/arm64/boot/dts/amt6797_64_open.dts#L8
> > 
> >> Best regards,
> >> Matthias
> >>
> >>> +	};
> >>> +
> >>> +	chosen {
> >>> +		stdout-path = "serial0:115200n8";
> >>> +	};
> >>> +};
> >>> +
> >>> +&uart1 {
> >>> +	status = "okay";
> >>> +};
> >>>
