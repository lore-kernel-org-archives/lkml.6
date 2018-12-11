Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA39EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA0120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA0120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeLKOtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:49:05 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:20928 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLKOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:49:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="24079869"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 07:49:04 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Tue, 11 Dec 2018
 07:49:03 -0700
Date:   Tue, 11 Dec 2018 15:48:58 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     <Tudor.Ambarus@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Cyrille.Pitchen@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Message-ID: <20181211144858.dnbj5iozgk74wzdm@M43218.corp.atmel.com>
Mail-Followup-To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Tudor.Ambarus@microchip.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Cyrille.Pitchen@microchip.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        broonie@kernel.org, linux-spi@vger.kernel.org
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
 <20181211154033.076506aa@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181211154033.076506aa@bbrezillon>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:40:33PM +0100, Boris Brezillon wrote:
> On Mon, 10 Dec 2018 17:15:29 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
> > From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> > 
> > This patch configures the QSPI0 controller pin muxing and declares
> > a jedec,spi-nor memory.
> > 
> > sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
> > memory which advertises a maximum frequency of 80MHz for Quad IO
> > Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
> > the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.
> > 
> > Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> > [tudor.ambarus@microchip.com:
> > - drop partitions,
> > - add spi-rx/tx-bus-width
> > - change spi-max-frequency to match the 80MHz limit advertised by
> >   MX25L25673G for Quad IO Fast Read,
> > - reword commit message and subject.]
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > ---
> >  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > index 518e2b095ccf..171bc82cfbbf 100644
> > --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > @@ -108,6 +108,21 @@
> >  		};
> >  
> >  		apb {
> > +			qspi0: spi@f0020000 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&pinctrl_qspi0_default>;
> > +				/* status = "okay"; */ /* conflict with sdmmc1 */
> > +
> > +				flash@0 {
> > +					compatible = "jedec,spi-nor";
> > +					reg = <0>;
> > +					spi-max-frequency = <80000000>;
> > +					spi-tx-bus-width = <4>;
> > +					spi-rx-bus-width = <4>;
> > +					m25p,fast-read;
> > +				};
> 
> I'm a bit lost. What's the point of defining this if the QSPI
> controller is not enabled?

It's a way to avoid customer struggling with the device tree. If he
doesn't care about sdmmc1, he can easily enable the qpsi controller and
get access to the memory.

Regards

Ludovic

