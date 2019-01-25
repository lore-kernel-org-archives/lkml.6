Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AEBC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B62E21855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfAYJie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:38:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50643 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfAYJie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:38:34 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gmxwS-00025Q-0K; Fri, 25 Jan 2019 10:38:28 +0100
Message-ID: <1548409107.28802.36.camel@pengutronix.de>
Subject: Re: [PATCH v4 5/5] imx8mq.dtsi: add the sdma nodes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 25 Jan 2019 10:38:27 +0100
In-Reply-To: <20190125025528.15645-6-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
         <20190125025528.15645-1-angus@akkea.ca>
         <20190125025528.15645-6-angus@akkea.ca>
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

Am Donnerstag, den 24.01.2019, 19:55 -0700 schrieb Angus Ainslie (Purism):
> Add the sdma nodes to the base devicetree for the imx8mq
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

One nit below, with that fixed:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

You might need to split this patch out from the series and send it to
Shawn separately after the dmaengine changes have been accepted.

regards,
Lucas

> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 28 +++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index c0402375e7c1..f0cd3675ead0 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -336,6 +336,17 @@
> >  				clocks = <&clk IMX8MQ_CLK_WDOG3_ROOT>;
> >  				status = "disabled";
> >  			};
> +
> > > +			sdma2: sdma@302c0000 {
> > +				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
> > +				reg = <0x302c0000 0x10000>;
> > +				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
> +					<&clk IMX8MQ_CLK_SDMA2_ROOT>;

Some spaces to align the second clock reference as in the rest of this
file, please.

> +				clock-names = "ipg", "ahb";
> > +				#dma-cells = <3>;
> > +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
> > +			};
> >  		};
>  
> >  		bus@30400000 { /* AIPS2 */
> @@ -370,6 +381,8 @@
> >  				clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
> >  				         <&clk IMX8MQ_CLK_UART3_ROOT>;
> >  				clock-names = "ipg", "per";
> > +				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> > +				dma-names = "rx", "tx";
> >  				status = "disabled";
> >  			};
>  
> @@ -381,6 +394,8 @@
> >  				clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
> >  				         <&clk IMX8MQ_CLK_UART2_ROOT>;
> >  				clock-names = "ipg", "per";
> > +				dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
> > +				dma-names = "rx", "tx";
> >  				status = "disabled";
> >  			};
>  
> @@ -432,6 +447,8 @@
> >  				clocks = <&clk IMX8MQ_CLK_UART4_ROOT>,
> >  				         <&clk IMX8MQ_CLK_UART4_ROOT>;
> >  				clock-names = "ipg", "per";
> > +				dmas = <&sdma1 28 4 0>, <&sdma1 29 4 0>;
> > +				dma-names = "rx", "tx";
> >  				status = "disabled";
> >  			};
>  
> @@ -465,6 +482,17 @@
> >  				status = "disabled";
> >  			};
>  
> > > +			sdma1: sdma@30bd0000 {
> > +				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
> > +				reg = <0x30bd0000 0x10000>;
> > +				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
> > +					<&clk IMX8MQ_CLK_AHB>;
> > +				clock-names = "ipg", "ahb";
> > +				#dma-cells = <3>;
> > +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
> > +			};
> +
> > >  			fec1: ethernet@30be0000 {
> >  				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
> >  				reg = <0x30be0000 0x10000>;
