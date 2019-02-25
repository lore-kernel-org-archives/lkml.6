Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B681C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090A421019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfBYBgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 20:36:51 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:47330 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726461AbfBYBgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 20:36:51 -0500
X-UUID: 7fd205b0ed164c14b72a003a086299a1-20190225
X-UUID: 7fd205b0ed164c14b72a003a086299a1-20190225
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1631350980; Mon, 25 Feb 2019 09:36:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 25 Feb
 2019 09:36:44 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Feb 2019 09:36:44 +0800
Message-ID: <1551058604.12020.34.camel@mhfsdcap03>
Subject: Re: [PATCH v5 1/6] dt-bindings: usb: musb: Add support for MediaTek
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
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>
Date:   Mon, 25 Feb 2019 09:36:44 +0800
In-Reply-To: <20190222164923.GA26413@bogus>
References: <1550561795-31132-1-git-send-email-min.guo@mediatek.com>
         <1550561795-31132-2-git-send-email-min.guo@mediatek.com>
         <20190222164923.GA26413@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
On Fri, 2019-02-22 at 10:49 -0600, Rob Herring wrote:
> On Tue, Feb 19, 2019 at 03:36:30PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode.
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> > changes in v5:
> > suggested by Rob:
> > 1. Modify compatible as 
> > - compatible : should be one of:
> >                "mediatek,mt-2701"
> >                ...
> >                followed by "mediatek,mtk-musb"
> > 2. Add usb connector child node
> > 
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
> > 3. Remove phy-names
> > 4. Add space after comma in clock-names
> > ---
> >  .../devicetree/bindings/usb/mediatek,musb.txt      | 54 ++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > new file mode 100644
> > index 0000000..0632e6e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > @@ -0,0 +1,54 @@
> > +MediaTek musb DRD/OTG controller
> > +-------------------------------------------
> > +
> > +Required properties:
> > + - compatible      : should be one of:
> > +                     "mediatek,mt-2701"
> 
> That looks like a top-level SoC compatible and doesn't match the 
> example.
"mediatek,mt-2701" is an example, just to describe a specific SOC.
May I modify compatibel like:
compatible : should be "mediatek,mtk-musb"

> > +                     ...
> > +                     followed by "mediatek,mtk-musb"
> > + - reg             : specifies physical base address and size of
> > +                     the registers
> > + - interrupts      : interrupt used by musb controller
> > + - interrupt-names : must be "mc"
> 
> Not much point in a name when there is only 1.
The MUSB core driver has two interrupts, one is for MAC, another for
DMA, but on MTK platform, there is only a MAC interrupt, musb core
driver uses platform_get_irq_byname(pdev, "mc") to get this interrupt
number.

> > + - phys            : PHY specifier for the OTG phy
> > + - dr_mode         : should be one of "host", "peripheral" or "otg",
> > +                     refer to usb/generic.txt
> > + - clocks          : a list of phandle + clock-specifier pairs, one for
> > +                     each entry in clock-names
> > + - clock-names     : must contain "main", "mcu", "univpll"
> > +                     for clocks of controller
> > +
> > +Optional properties:
> > + - power-domains   : a phandle to USB power domain node to control USB's
> > +                     MTCMOS
> > +
> > +Required child nodes:
> > + usb connector node as defined in bindings/connector/usb-connector.txt
> > + - extcon          : for VBUS and ID pin changes detection, needed when
> > +                     supports dual-role mode
> > + - vbus-supply     : reference to the VBUS regulator, needed when supports
> > +                     dual-role mode
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
> > +	dr_mode = "otg";
> > +	clocks = <&pericfg CLK_PERI_USB0>,
> > +		 <&pericfg CLK_PERI_USB0_MCU>,
> > +		 <&pericfg CLK_PERI_USB_SLV>;
> > +	clock-names = "main","mcu","univpll";
> > +	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> > +	usb_con: connector{
> > +		compatible = "usb-b-connector";
> > +		label = "micro-USB";
> > +		type = "micro";
> > +		extcon = <&extcon_usb>;
> 
> The connector node should replace 'extcon'. Add what you need here 
> directly (e.g. id-gpios). What you add needs to be defined in 
> usb-connector.txt.
OK.

> > +		vbus-supply = <&usb_vbus>;
> > +	};
> > +};
> > -- 
> > 1.9.1
> > 

Regards,
Min.



