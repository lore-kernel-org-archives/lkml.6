Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C92C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4142184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfADDAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 22:00:21 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:2405 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726418AbfADDAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 22:00:20 -0500
X-UUID: 2861622142994ba8a73c956defbc61bf-20190104
X-UUID: 2861622142994ba8a73c956defbc61bf-20190104
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1293402557; Fri, 04 Jan 2019 11:00:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 11:00:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 4 Jan 2019 11:00:07 +0800
Message-ID: <1546570807.585.31.camel@mhfsdcap03>
Subject: Re: [PATCH 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From:   Min Guo <min.guo@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 4 Jan 2019 11:00:07 +0800
In-Reply-To: <20190103221414.GA14639@bogus>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
         <1545896066-897-2-git-send-email-min.guo@mediatek.com>
         <20190103221414.GA14639@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 16:14 -0600, Rob Herring wrote:
> On Thu, Dec 27, 2018 at 03:34:23PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> >  .../devicetree/bindings/usb/mediatek,musb.txt      | 49 ++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > new file mode 100644
> > index 0000000..e899c9b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > @@ -0,0 +1,49 @@
> > +MediaTek musb DRC/OTG controller
> > +-------------------------------------------
> > +
> > +Required properties:
> > + - compatible      : should be "mediatek,<soc-model>-musb",
> > +   "mediatek,mtk-musb", soc-model is the name of SoC, such as
> > +   mt2701, when using "mediatek,mtk-musb" compatible string, you
> > +   need SoC specific ones in addition, one of:
> > +   - "mediatek,mt2701-musb"
> 
> This isn't very clear. Just drop the <soc-model and enumerate the SoCs:
> 
> compatible: should be one of:
>     "mediatek,mt2701-musb"
>     ...
>   followed by "mediatek,mtk-musb"
I will modify it in the next patch.

> > + - reg             : specifies physical base address and size of
> > +   the registers
> > + - interrupts      : interrupt used by musb controller
> > + - interrupt-names : must be "mc"
> 
> -names is pointless when there is only one.
The MUSB core driver has two interrupts, one is for MAC, another for DMA,
but on MTK platform, there is only a MAC interrupt, here following the binding
of MUSB core driver.

> > + - phys            : PHY specifier for the OTG phy
> > + - phy-names       : should be "usb2-phy"
> 
> Same here.
I will modify it in the next patch.

> > + - dr_mode         : should be one of "host", "peripheral" or "otg",
> > +   refer to usb/generic.txt
> > + - clocks          : a list of phandle + clock-specifier pairs, one for
> > +   each entry in clock-names
> > + - clock-names     : must contain "main","mcu","univpll"
> 
> space needed after each comma.
I will modify it in the next patch.

> > +   for clocks of controller
> > +
> > +Optional properties:
> > + - extcon : external connector for VBUS and IDPIN changes detection,
> > +   needed when supports dual-role mode.
> 
> Don't use extcon for new bindings. The usb-connector binding should be 
> used instead.
This is used to detect the changes of the IDPIN and VBUS, the change
events are provided by other drivers, such as extcon-usb-gpio.c, and
then switch MUSB controller to host or device mode, but the
usb-connector can't detect these changes.

> > + - vbus-supply : reference to the VBUS regulator, needed when supports
> > +   dual-role mode.
> 
> The controller is powered from Vbus? Probably not. This belongs in the 
> connector or maybe the phy (if the phy is powered from Vbus).
The Vbus is used to provide 5V voltage to the connected device when the
controller works as host mode.

> > + - power-domains   : a phandle to USB power domain node to control USB's
> > +   MTCMOS
> > +
> > +Example:
> > +
> > +usb2: usb@11200000 {
> > +	compatible = "mediatek,mt2701-musb";
> > +		"mediatek,mtk-musb";
> > +	reg = <0 0x11200000 0 0x1000>;
> > +	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> > +	interrupt-names = "mc";
> > +	phys = <&u2port2 PHY_TYPE_USB2>;
> > +	phy-names = "usb2-phy";
> > +	vbus-supply = <&usb_vbus>;
> > +	extcon = <&extcon_usb>;
> > +	dr_mode = "otg";
> > +	clocks = <&pericfg CLK_PERI_USB0>,
> > +		 <&pericfg CLK_PERI_USB0_MCU>,
> > +		 <&pericfg CLK_PERI_USB_SLV>;
> > +	clock-names = "main","mcu","univpll";
> > +	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> > +};
> > -- 
> > 1.9.1
> > 


