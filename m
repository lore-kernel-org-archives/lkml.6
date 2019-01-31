Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA69C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B900E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfAaIad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:30:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:34386 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbfAaIac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:30:32 -0500
X-UUID: 4065f1a1996e4b90a3a905abd93e9050-20190131
X-UUID: 4065f1a1996e4b90a3a905abd93e9050-20190131
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1817860604; Thu, 31 Jan 2019 16:30:26 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 16:30:24 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 16:30:22 +0800
Message-ID: <1548923422.4739.10.camel@mhfsdcap03>
Subject: Re: [PATCH v6 5/6] dt-bindings: pinctrl: mt8183: add binding
 document
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Erin Lo <erin.lo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <mars.cheng@mediatek.com>,
        <eddie.huang@mediatek.com>, <linux-clk@vger.kernel.org>
Date:   Thu, 31 Jan 2019 16:30:22 +0800
In-Reply-To: <20190130161714.GA24352@bogus>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
         <1548317240-44682-6-git-send-email-erin.lo@mediatek.com>
         <20190130161714.GA24352@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0EB05CC0D78A45BC48B2B633DF2DCCA6FA80D1672525544E6236E08BF9CC55232000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 10:17 -0600, Rob Herring wrote:
> On Thu, Jan 24, 2019 at 04:07:19PM +0800, Erin Lo wrote:
> > From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > 
> > The commit adds mt8183 compatible node in binding document.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> >  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > new file mode 100644
> > index 0000000..364e673
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > @@ -0,0 +1,115 @@
> > +* Mediatek MT8183 Pin Controller
> > +
> > +The Mediatek's Pin controller is used to control SoC pins.
> > +
> > +Required properties:
> > +- compatible: value should be one of the following.
> > +	"mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> > +- gpio-controller : Marks the device node as a gpio controller.
> > +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> > +  binding is used, the amount of cells must be specified as 2. See the below
> > +  mentioned gpio binding representation for description of particular cells.
> > +- gpio-ranges : gpio valid number range.
> > +- reg: physicall address base for gpio base registers. There are nine
> > +  physicall address base in mt8183. They are 0x10005000, 0x11F20000,
> 
> Still have a typo in 'physicall'

==>sorry, we will change it in next version.
> 
> > +  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
> > +  0x11F30000.
> 
> You don't need to list the address values. Only how many and what each 
> one is.
==>ok, because every base address don't have the detailed name. We will
remove the address values list and change it like this:
- reg: physical address base for gpio base registers. There are nine
  physical address base in mt8183.
> 
> > +
> > +	Eg: <&pio 6 0>
> > +	<[phandle of the gpio controller node]
> > +	[line number within the gpio controller]
> > +	[flags]>
> > +
> > +	Values for gpio specifier:
> > +	- Line number: is a value between 0 to 202.
> > +	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> > +            Only the following flags are supported:
> > +            0 - GPIO_ACTIVE_HIGH
> > +            1 - GPIO_ACTIVE_LOW
> > +
> > +Optional properties:
> > +- reg-names: gpio base register names. There are nine gpio base register
> > +  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
> > +  "iocfg5", "iocfg6", "iocfg7", "iocfg8".
> 
> As I said before, these names aren't useful. There's already 
> inheritently an index with 'reg'.
> 
> Unless some are optional and can be sparsely populated.

==> Do you mean that we can remove Optional properties the reg-names
description?
> 
> > +- interrupt-controller: Marks the device node as an interrupt controller
> > +- #interrupt-cells: Should be two.
> > +- interrupts : The interrupt outputs from the controller.
> > +
> > +Please refer to pinctrl-bindings.txt in this directory for details of the
> > +common pinctrl bindings used by client devices.
> > +
> > +Subnode format
> > +A pinctrl node should contain at least one subnodes representing the
> > +pinctrl groups available on the machine. Each subnode will list the
> > +pins it needs, and how they should be configured, with regard to muxer
> > +configuration, pullups, drive strength, input enable/disable and input schmitt.
> > +
> > +    node {
> > +	pinmux = <PIN_NUMBER_PINMUX>;
> > +	GENERIC_PINCONFIG;
> > +    };
> > +
> > +Required properties:
> > +- pinmux: integer array, represents gpio pin number and mux setting.
> > +    Supported pin number and mux varies for different SoCs, and are defined
> > +    as macros in boot/dts/<soc>-pinfunc.h directly.
> > +
> > +Optional properties:
> > +- GENERIC_PINCONFIG: is the generic pinconfig options to use, bias-disable,
> > +    bias-pull-down, bias-pull-up, input-enable, input-disable, output-low, output-high,
> > +    input-schmitt-enable, input-schmitt-disable and drive-strength are valid.
> > +
> > +    Some special pins have extra pull up strength, there are R0 and R1 pull-up
> > +    resistors available, but for user, it's only need to set R1R0 as 00, 01, 10 or 11.
> > +    So when config mediatek,pull-up-adv or mediatek,pull-down-adv,
> > +    it support arguments for those special pins.
> > +
> > +    When config drive-strength, it can support some arguments, such as
> > +    MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See dt-bindings/pinctrl/mt65xx.h.
> > +
> > +Examples:
> > +
> > +#include "mt8183-pinfunc.h"
> > +
> > +...
> > +{
> > +	pio: pinctrl@10005000 {
> > +		compatible = "mediatek,mt8183-pinctrl";
> > +		reg = <0 0x10005000 0 0x1000>,
> > +		      <0 0x11F20000 0 0x1000>,
> > +		      <0 0x11E80000 0 0x1000>,
> > +		      <0 0x11E70000 0 0x1000>,
> > +		      <0 0x11E90000 0 0x1000>,
> > +		      <0 0x11D30000 0 0x1000>,
> > +		      <0 0x11D20000 0 0x1000>,
> > +		      <0 0x11C50000 0 0x1000>,
> > +		      <0 0x11F30000 0 0x1000>;
> 
> Use lowercase hex.

==> we will change it in the next version.
> 
> > +		reg-names = "iocfg0", "iocfg1", "iocfg2",
> > +			    "iocfg3", "iocfg4", "iocfg5",
> > +			    "iocfg6", "iocfg7", "iocfg8";
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		gpio-ranges = <&pio 0 0 192>;
> > +		interrupt-controller;
> > +		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-parent = <&gic>;
> > +		#interrupt-cells = <2>;
> > +
> > +		i2c0_pins_a: i2c0 {
> > +			pins1 {
> > +				pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
> > +					 <PINMUX_GPIO49__FUNC_SDA5>;
> > +				mediatek,pull-up-adv = <11>;
> > +			};
> > +		};
> > +
> > +		i2c1_pins_a: i2c1 {
> > +			pins {
> > +				pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
> > +					 <PINMUX_GPIO51__FUNC_SDA3>;
> > +				mediatek,pull-down-adv = <10>;
> > +			};
> > +		};
> > +		...
> > +	};
> > +};
> > -- 
> > 1.9.1
> > 


