Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBAF20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBAF20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbeGQL1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:27:37 -0400
Received: from mx.socionext.com ([202.248.49.38]:9760 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbeGQL1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:27:37 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 17 Jul 2018 19:55:33 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 6294D1800E5;
        Tue, 17 Jul 2018 19:55:33 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 17 Jul 2018 19:55:33 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 27E7140375;
        Tue, 17 Jul 2018 19:55:33 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id EAF7C120448;
        Tue, 17 Jul 2018 19:55:32 +0900 (JST)
Date:   Tue, 17 Jul 2018 19:55:32 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: phy: add DT bindings for UniPhier USB3 PHY driver
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20180716205049.GA3663@rob-hp-laptop>
References: <1530261541-23104-2-git-send-email-hayashi.kunihiko@socionext.com> <20180716205049.GA3663@rob-hp-laptop>
Message-Id: <20180717195531.8587.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Thank you for your comments.

On Mon, 16 Jul 2018 14:50:49 -0600 <robh@kernel.org> wrote:

> On Fri, Jun 29, 2018 at 05:38:58PM +0900, Kunihiko Hayashi wrote:
> > Add DT bindings for PHY interface built into USB3 controller
> > implemented in UniPhier SoCs.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../devicetree/bindings/phy/uniphier-usb3-phy.txt  | 118 +++++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
> > new file mode 100644
> > index 0000000..3df4a486
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
> > @@ -0,0 +1,118 @@
> > +Socionext UniPhier USB3 PHY
> > +
> > +This describes the devicetree bindings for PHY interfaces built into
> > +USB3 controller implemented on Socionext UniPhier SoCs.
> > +The controller includes High-Speed PHY and Super-Speed PHY.
> > +
> > +USB3 High-Speed (HS) PHY
> > +------------------------
> > +
> > +Required properties:
> > +- compatible: Should contain one of the following:
> > +    "socionext,uniphier-pro4-usb3-hsphy" - for Pro4 SoC
> > +    "socionext,uniphier-pxs2-usb3-hsphy" - for PXs2 SoC
> > +    "socionext,uniphier-ld20-usb3-hsphy" - for LD20 SoC
> > +    "socionext,uniphier-pxs3-usb3-hsphy" - for PXs3 SoC
> > +- reg: Specifies offset and length of the register set for the device.
> > +- #phy-cells: Should be 0.
> > +- clocks: A list of phandles to the clock gate for USB3 glue layer.
> > +	According to the clock-names, appropriate clocks are required.
> > +- clock-names: Should contain the following:
> > +    "gio", "link" - for Pro4 SoC
> > +    "link", "phy", "phy-ext" - for PXs3 SoC, "phy-ext" is optional.
> > +    "link", "phy" - for others
> 
> Can't you make 'link' always first.

I see. I'll change the order.

> > +- resets: A list of phandles to the reset control for USB3 glue layer.
> > +	According to the reset-names, appropriate resets are required.
> > +- reset-names: Should contain the following:
> > +    "gio", "link" - for Pro4 SoC
> > +    "link", "phy" - for others
> > +
> > +Optional properties:
> > +- phy-supply: A phandle to the regulator for USB VBUS.
> 
> The phy actually needs Vbus or you just want to control Vbus from the 
> phy driver?

To enable each USB port correspond with phy, we must enable Vbus for each port.
However, the host driver doesn't have the way to control regulators directly,
then I think it is reasonable to control Vbus by using phy regulator.


> > +- nvmem-cells: Phandles to nvmem cell that contains the trimming data.
> > +	Available only for HS-PHY implemented on LD20 and PXs3, and
> > +	if unspecified, default value is used.
> > +- nvmem-cell-names: Should be the following names, which correspond to
> > +	each nvmem-cells.
> > +	All of the 3 parameters associated with the following names are
> > +	required for each port, if any one is omitted, the trimming data
> > +	of the port will not be set at all.
> > +    "rterm", "sel_t", "hs_i" - Each cell name for phy parameters
> > +
> > +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> > +
> > +Example:
> > +
> > +	usb-glue@65b00000 {
> > +		compatible = "socionext,uniphier-ld20-dwc3-glue",
> > +			     "simple-mfd";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0x65b00000 0x400>;
> > +
> > +		usb_hsphy0: hs-phy@200 {
> > +			compatible = "socionext,uniphier-ld20-usb3-hsphy";
> > +			reg = <0x200 0x10>;
> > +			#phy-cells = <0>;
> > +			clock-names = "link", "phy";
> > +			clocks = <&sys_clk 14>, <&sys_clk 16>;
> > +			reset-names = "link", "phy";
> > +			resets = <&sys_rst 14>, <&sys_rst 16>;
> > +			phy-supply = <&usb_vbus0>;
> > +			nvmem-cell-names = "rterm", "sel_t", "hs_i";
> > +			nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>,
> > +				      <&usb_hs_i0>;
> > +		};
> > +	};
> > +
> > +
> > +USB3 Super-Speed (SS) PHY
> > +-------------------------
> 
> Nothing seems to be shared here. Make this 2 docs.

I see. I'll split it.

> 
> > +
> > +Required properties:
> > +- compatible: Should contain one of the following:
> > +    "socionext,uniphier-pro4-usb3-ssphy" - for Pro4 SoC
> > +    "socionext,uniphier-pxs2-usb3-ssphy" - for PXs2 SoC
> > +    "socionext,uniphier-ld20-usb3-ssphy" - for LD20 SoC
> > +    "socionext,uniphier-pxs3-usb3-ssphy" - for PXs3 SoC
> > +- reg: Specifies offset and length of the register set for the device.
> > +- #phy-cells: Should be 0.
> > +- clocks: A list of phandles to the clock gate for USB3 glue layer.
> > +	According to the clock-names, appropriate clocks are required.
> > +- clock-names:
> > +    "gio", "link" - for Pro4 SoC
> > +    "link", "phy", "phy-ext" - for PXs3 SoC, "phy-ext" is optional.
> > +    "link", "phy" - for others
> 
> Can't you make 'link' always first.

ditto.

> > +- resets: A list of phandles to the reset control for USB3 glue layer.
> > +	According to the reset-names, appropriate resets are required.
> > +- reset-names:
> > +    "gio", "link" - for Pro4 SoC
> > +    "link", "phy" - for others
> 
> And here.
> 
> > +
> > +Optional properties:
> > +- phy-supply: A phandle to the regulator for USB VBUS.
> > +
> > +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> > +
> > +Example:
> > +
> > +	usb-glue@65b00000 {
> > +		compatible = "socionext,uniphier-ld20-dwc3-glue",
> > +			     "simple-mfd";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0x65b00000 0x400>;
> > +
> > +		usb_ssphy0: ss-phy@300 {
> > +			compatible = "socionext,uniphier-ld20-usb3-ssphy";
> > +			reg = <0x300 0x10>;
> > +			#phy-cells = <0>;
> > +			clock-names = "link", "phy";
> > +			clocks = <&sys_clk 14>, <&sys_clk 16>;
> > +			reset-names = "link", "phy";
> > +			resets = <&sys_rst 14>, <&sys_rst 16>;
> > +			phy-supply = <&usb_vbus0>;
> > +		};
> > +
> > +		other nodes ...
> > +	};
> > -- 
> > 2.7.4
> > 

Thank you,

---
Best Regards,
Kunihiko Hayashi


