Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED14C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044952082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044952082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeJZIrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:47:00 -0400
Received: from mx.socionext.com ([202.248.49.38]:39659 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbeJZIrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:47:00 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Oct 2018 09:12:14 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 21D09180B67;
        Fri, 26 Oct 2018 09:12:14 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 26 Oct 2018 09:12:14 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 813C14039B;
        Fri, 26 Oct 2018 09:12:13 +0900 (JST)
Received: from DESKTOP0FARE34 (unknown [10.213.134.218])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 464E7120144;
        Fri, 26 Oct 2018 09:12:13 +0900 (JST)
From:   "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <broonie@kernel.org>, <mark.rutland@arm.com>,
        =?iso-2022-jp?B?WWFtYWRhLCBNYXNhaGlyby8bJEI7M0VEGyhCIBskQj8/OTAbKEI=?= 
        <yamada.masahiro@socionext.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <stable@vger.kernel.org>,
        <masami.hiramatsu@linaro.org>, <jaswinder.singh@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <1540373669-18969-1-git-send-email-hayashibara.keiji@socionext.com> <20181025195906.GA22391@bogus>
In-Reply-To: <20181025195906.GA22391@bogus>
Subject: RE: [PATCH] spi: uniphier: fix incorrect property items
Date:   Fri, 26 Oct 2018 09:12:09 +0900
Message-ID: <000c01d46cc0$89d0a520$9d71ef60$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUa3zQjPaUCHLcmU2HooycfrEHL6UvzIaAgADOrbA=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Friday, October 26, 2018 4:59 AM
> To: Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
> Cc: broonie@kernel.org; mark.rutland@arm.com; Yamada, Masahiro/山田 真弘 <yamada.masahiro@socionext.com>;
> linux-spi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> stable@vger.kernel.org; masami.hiramatsu@linaro.org; jaswinder.singh@linaro.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] spi: uniphier: fix incorrect property items
> 
> On Wed, Oct 24, 2018 at 06:34:29PM +0900, Keiji Hayashibara wrote:
> > This commit fixes incorrect property because it was different from the
> > actual.
> > The parameters of '#address-cells' and '#size-cells' were removed, and
> > 'interrupts', 'pinctrl-names' and 'pinctrl-0' were added.
> >
> > Fixes: 4dcd5c2781f3 ("spi: add DT bindings for UniPhier SPI
> > controller")
> > Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-uniphier.txt | 14
> > ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt
> > b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
> > index 504a4ec..b04e66a 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-uniphier.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
> > @@ -5,18 +5,20 @@ UniPhier SoCs have SCSSI which supports SPI single channel.
> >  Required properties:
> >   - compatible: should be "socionext,uniphier-scssi"
> >   - reg: address and length of the spi master registers
> > - - #address-cells: must be <1>, see spi-bus.txt
> > - - #size-cells: must be <0>, see spi-bus.txt
> 
> How is removing these correct? They are needed if you have any child devices.

They are necessary when the child device is connected.
I removed it because it was specified in spi-bus.txt,
but I will leave them in next patch.

> 
> > - - clocks: A phandle to the clock for the device.
> > - - resets: A phandle to the reset control for the device.
> > + - interrupts: a single interrupt specifier
> > + - pinctrl-names: should be "default"
> > + - pinctrl-0: pin control state for the default mode
> > + - clocks: a phandle to the clock for the device
> > + - resets: a phandle to the reset control for the device
> >
> >  Example:
> >
> >  spi0: spi@54006000 {
> >  	compatible = "socionext,uniphier-scssi";
> >  	reg = <0x54006000 0x100>;
> > -	#address-cells = <1>;
> > -	#size-cells = <0>;
> > +	interrupts = <0 39 4>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_spi0>;
> >  	clocks = <&peri_clk 11>;
> >  	resets = <&peri_rst 11>;
> >  };
> > --
> > 2.7.4
> >

Thank you.

---
Best Regards,
Keiji Hayashibara


