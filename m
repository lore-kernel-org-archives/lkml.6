Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD768C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAD82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfAUJk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:40:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54182 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfAUJk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:40:59 -0500
Received: from broadband.bt.com (unknown [IPv6:2a00:23c5:58d:db00:68bb:47d:d5ca:9abd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: martyn)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 05A25263BFA;
        Mon, 21 Jan 2019 09:40:56 +0000 (GMT)
Message-ID: <8746aab308f76b4d8f33a20fea3f54da323832b3.camel@collabora.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx6: Add support for Phytec phyBOARD
 i.MX6UL Segin
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Stefan =?ISO-8859-1?Q?Riedm=FCller?= <s.riedmueller@phytec.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Christian Hemp <c.hemp@phytec.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 21 Jan 2019 09:40:54 +0000
In-Reply-To: <CAOMZO5ASTUDfKkghXq5FftM8-XNztXCYpmdOU9CVfyX3pgKxxA@mail.gmail.com>
References: <20190118194812.3319-1-martyn.welch@collabora.com>
         <20190118194812.3319-2-martyn.welch@collabora.com>
         <CAOMZO5ASTUDfKkghXq5FftM8-XNztXCYpmdOU9CVfyX3pgKxxA@mail.gmail.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Fri, 2019-01-18 at 19:18 -0200, Fabio Estevam wrote:
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-
> > full.dts b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> > new file mode 100644
> > index 000000000000..83cdf4fa10c0
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> > @@ -0,0 +1,96 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> > + * Author: Christian Hemp <c.hemp@phytec.de>
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx6ul-phytec-pcl063.dtsi"
> > +#include "imx6ul-phytec-phyboard-segin.dtsi"
> > +#include "imx6ul-phytec-peb-eval-01.dtsi"
> > +
> > +/ {
> > +       model = "Phytec phyBOARD-Segin i.MX6 UltraLite Full
> > Featured";
> > +       compatible = "phytec,imx6ul-pbacd10", "phytec,imx6ul-
> > pcl063",
> > +                    "fsl,imx6ul";
> 
> Better keep it in a single line?
> 

It makes it longer than 80 chars, but I'm not adverse to that.

> > +&ecspi3 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_ecspi3>;
> > +       cs-gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
> > +       status = "okay";
> > +
> > +       spidev@0 {
> > +               compatible = "spidev";
> 
> Doesn't the kernel complain about spidev dts nodes?
> 

Oh, yes, it does when spidev is loaded...

Removing.

Martyn

