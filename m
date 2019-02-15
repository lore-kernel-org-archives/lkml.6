Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ABBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A843222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392510AbfBOQMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:12:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59257 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392446AbfBOQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:12:06 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gug5n-0006VR-TY; Fri, 15 Feb 2019 17:11:59 +0100
Message-ID: <1550247118.2546.56.camel@pengutronix.de>
Subject: Re: [PATCH v1 1/3] ARM: dts: stm32: Add Vivante GPU support on
 STM32MP157c
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     devicetree@vger.kernel.org, Philippe Cornu <philippe.cornu@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 15 Feb 2019 17:11:58 +0100
In-Reply-To: <1550246316-9747-2-git-send-email-pierre-yves.mordret@st.com>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
         <1550246316-9747-2-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Yves,

Am Freitag, den 15.02.2019, 16:58 +0100 schrieb Pierre-Yves MORDRET:
> Append Vivante GPU DT configuration.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  arch/arm/boot/dts/stm32mp157c.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index f8bbfff..29540bc 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -1106,6 +1106,16 @@
> >  			status = "disabled";
> >  		};
>  
> +		gpu: gpu@59000000 {
> +			compatible = "vivante,gc";
> +			reg = <0x59000000 0x800>;
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&rcc GPU>, <&rcc GPU_K>;
> +			clock-names = "bus" ,"core";

Is this a 2D only core? If it is also 3D capable the binding says you
need to specify the shader clock (may be the same clock feeding the
core).

Regards,
Lucas

> +			resets = <&rcc GPU_R>;
> +			status = "disabled";
> +		};
> +
>  		dsi: dsi@5a000000 {
>  			compatible = "st,stm32-dsi";
>  			reg = <0x5a000000 0x800>;
