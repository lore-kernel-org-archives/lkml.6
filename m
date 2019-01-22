Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7BFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A75D218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfAVJgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:36:23 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:22898 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727332AbfAVJgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:36:21 -0500
X-UUID: 77f2512ae73b451db95e1ea4fdd29c38-20190122
X-UUID: 77f2512ae73b451db95e1ea4fdd29c38-20190122
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 271746080; Tue, 22 Jan 2019 17:36:15 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 17:36:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 17:36:13 +0800
Message-ID: <1548149773.4433.284.camel@mhfsdcap03>
Subject: Re: [PATCH v4 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From:   Min Guo <min.guo@mediatek.com>
To:     Rob Herring <robh@kernel.org>, Bin Liu <b-liu@ti.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <hdegoede@redhat.com>, <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 22 Jan 2019 17:36:13 +0800
In-Reply-To: <20190121151417.GA19238@bogus>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
         <1548073351-13739-2-git-send-email-min.guo@mediatek.com>
         <20190121151417.GA19238@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

Sorry to bother you again, I encounter a problem about the extcon
property.

I don't find a common driver describing the usb-connector. Is
there any driver that I can refer to, specially the way to switch MUSB
controller between host and device mode? 
If it needs to implement by myself, is it possible to emulate an
usb-connector driver by extcon-usb-gpio, and also use the notifier
mechanism or can you give me some advices?


Hi Rob,

On Mon, 2019-01-21 at 09:14 -0600, Rob Herring wrote:
> On Mon, Jan 21, 2019 at 08:22:26PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode.
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> > changes in v4:
> > suggested by Sergei:
> > 1. String alignment
> > 
> > changes in v3:
> > 1. no changes
> > 
> > changes in v2:
> > suggested by Bin:
> > 1. Modify DRC to DRD
> > suggested by Rob:
> > 2. Drop the "<soc-model>-musb" in compatible
> 
> This is not what I said. I gave you the exact text to put.

Sorry to misunderstood your meaning last time,  I will modify it in next
patch.
	compatible: should be one of "mediatek,mt2701-musb"...,followed by
"mediatek,mtk-musb"

> > 3. Remove phy-names
> > 4. Add space after comma in clock-names
> > ---
> >  .../devicetree/bindings/usb/mediatek,musb.txt      | 43 ++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > new file mode 100644
> > index 0000000..4305770
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > @@ -0,0 +1,43 @@
> > +MediaTek musb DRD/OTG controller
> > +-------------------------------------------
> > +
> > +Required properties:
> > + - compatible      : should be "mediatek,mtk-musb"
> > + - reg             : specifies physical base address and size of
> > +                     the registers
> > + - interrupts      : interrupt used by musb controller
> > + - interrupt-names : must be "mc"
> > + - phys            : PHY specifier for the OTG phy
> > + - dr_mode         : should be one of "host", "peripheral" or "otg",
> > +                     refer to usb/generic.txt
> > + - clocks          : a list of phandle + clock-specifier pairs, one for
> > +                     each entry in clock-names
> > + - clock-names     : must contain "main", "mcu", "univpll"
> > +                     for clocks of controller
> > +
> > +Optional properties:
> > + - extcon          : external connector for VBUS and ID pin changes detection,
> > +                     needed when supports dual-role mode
> 
> Again, do not use extcon in new bindings.

Thanks, ok.

> > + - vbus-supply     : reference to the VBUS regulator, needed when supports
> > +                     dual-role mode
> > + - power-domains   : a phandle to USB power domain node to control USB's
> > +                     MTCMOS
> > +
> > +Example:
> > +
> > +usb2: usb@11200000 {
> > +	compatible = "mediatek,mt2701-musb",
> > +		     "mediatek,mtk-musb";
> > +	reg = <0 0x11200000 0 0x1000>;
> > +	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> > +	interrupt-names = "mc";
> > +	phys = <&u2port2 PHY_TYPE_USB2>;
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
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Regards,
Min.

