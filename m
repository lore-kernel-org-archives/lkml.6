Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E341BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8E520870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548865038;
	bh=t/Lo9JW0kJYF+Ne95D0x3dxBalUwtjI+m/as/FArlTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p04IlQ1zSa38vgaeggktBlPpRGngxU8gKTf9WBtJWPO1xkHZWrb1aD7nHVYaHM0v2
	 etBYxgyoh5qH9z2WJORaQ7lv46EdUDcGq1Cj+0PlIfZ9Nk+dChhZI67qlw1v5Is2Lo
	 GwCJ1kEf0e3tlxW70N2Y3MtA5feeo8aBn2gMKqiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbfA3QRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:17:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40219 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfA3QRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:17:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so66166oth.7;
        Wed, 30 Jan 2019 08:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RnNH3KefH9BKp5fCeCTBb5Miw1UaixFZo+DJArm4Kjo=;
        b=pqTM4n5dLjlDTMYh98GpXaQbJME6c94VjkksO4hq2kCoM5UF/zWt83723hx5o0nGMu
         Seh9mYnvS1lPTGf+sI1EhTrEt3k5nZem6P9C3jkyIbumxVCYaP/9m+wHresMK3al+vGO
         Q/Tm2naFHrEbK0ArtQ8K4bexJo296nwLHx164xYdjPdkj0ajjShGQldGABwBd4LwH0E8
         sJMQV3nn0gYMN2onFJ+CzC/0dSlb6Fy7AQGZW6NeO58cp6+0iJWM9GzuVdWEO00hpCbX
         62ahn527h2lVwUBM56l1Glttl4CBeU9gIgMisoJfoQ0fgaIBxefHdNiocZofWHyvMNKR
         lniw==
X-Gm-Message-State: AJcUukeRnZwCykoLeG3+qURHE7U3G4sCUM+2ZV3UfLGHTJI9boZ8mG54
        Ur1738XInKGRKlgzjrktpA==
X-Google-Smtp-Source: ALg8bN484VE6nWCwePk0+gWegZBn0TUV98A4Dyxy5m/m6I8IP9iDXIkdvt0xipxDiFfuN/wc8GP6YQ==
X-Received: by 2002:a9d:3464:: with SMTP id v91mr24557950otb.102.1548865035425;
        Wed, 30 Jan 2019 08:17:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u136sm804401oie.38.2019.01.30.08.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:17:14 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:17:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Erin Lo <erin.lo@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
        mars.cheng@mediatek.com, eddie.huang@mediatek.com,
        linux-clk@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: Re: [PATCH v6 5/6] dt-bindings: pinctrl: mt8183: add binding document
Message-ID: <20190130161714.GA24352@bogus>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-6-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548317240-44682-6-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:07:19PM +0800, Erin Lo wrote:
> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> 
> The commit adds mt8183 compatible node in binding document.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> new file mode 100644
> index 0000000..364e673
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> @@ -0,0 +1,115 @@
> +* Mediatek MT8183 Pin Controller
> +
> +The Mediatek's Pin controller is used to control SoC pins.
> +
> +Required properties:
> +- compatible: value should be one of the following.
> +	"mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> +- gpio-controller : Marks the device node as a gpio controller.
> +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> +  binding is used, the amount of cells must be specified as 2. See the below
> +  mentioned gpio binding representation for description of particular cells.
> +- gpio-ranges : gpio valid number range.
> +- reg: physicall address base for gpio base registers. There are nine
> +  physicall address base in mt8183. They are 0x10005000, 0x11F20000,

Still have a typo in 'physicall'

> +  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
> +  0x11F30000.

You don't need to list the address values. Only how many and what each 
one is.

> +
> +	Eg: <&pio 6 0>
> +	<[phandle of the gpio controller node]
> +	[line number within the gpio controller]
> +	[flags]>
> +
> +	Values for gpio specifier:
> +	- Line number: is a value between 0 to 202.
> +	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> +            Only the following flags are supported:
> +            0 - GPIO_ACTIVE_HIGH
> +            1 - GPIO_ACTIVE_LOW
> +
> +Optional properties:
> +- reg-names: gpio base register names. There are nine gpio base register
> +  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
> +  "iocfg5", "iocfg6", "iocfg7", "iocfg8".

As I said before, these names aren't useful. There's already 
inheritently an index with 'reg'.

Unless some are optional and can be sparsely populated.

> +- interrupt-controller: Marks the device node as an interrupt controller
> +- #interrupt-cells: Should be two.
> +- interrupts : The interrupt outputs from the controller.
> +
> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices.
> +
> +Subnode format
> +A pinctrl node should contain at least one subnodes representing the
> +pinctrl groups available on the machine. Each subnode will list the
> +pins it needs, and how they should be configured, with regard to muxer
> +configuration, pullups, drive strength, input enable/disable and input schmitt.
> +
> +    node {
> +	pinmux = <PIN_NUMBER_PINMUX>;
> +	GENERIC_PINCONFIG;
> +    };
> +
> +Required properties:
> +- pinmux: integer array, represents gpio pin number and mux setting.
> +    Supported pin number and mux varies for different SoCs, and are defined
> +    as macros in boot/dts/<soc>-pinfunc.h directly.
> +
> +Optional properties:
> +- GENERIC_PINCONFIG: is the generic pinconfig options to use, bias-disable,
> +    bias-pull-down, bias-pull-up, input-enable, input-disable, output-low, output-high,
> +    input-schmitt-enable, input-schmitt-disable and drive-strength are valid.
> +
> +    Some special pins have extra pull up strength, there are R0 and R1 pull-up
> +    resistors available, but for user, it's only need to set R1R0 as 00, 01, 10 or 11.
> +    So when config mediatek,pull-up-adv or mediatek,pull-down-adv,
> +    it support arguments for those special pins.
> +
> +    When config drive-strength, it can support some arguments, such as
> +    MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See dt-bindings/pinctrl/mt65xx.h.
> +
> +Examples:
> +
> +#include "mt8183-pinfunc.h"
> +
> +...
> +{
> +	pio: pinctrl@10005000 {
> +		compatible = "mediatek,mt8183-pinctrl";
> +		reg = <0 0x10005000 0 0x1000>,
> +		      <0 0x11F20000 0 0x1000>,
> +		      <0 0x11E80000 0 0x1000>,
> +		      <0 0x11E70000 0 0x1000>,
> +		      <0 0x11E90000 0 0x1000>,
> +		      <0 0x11D30000 0 0x1000>,
> +		      <0 0x11D20000 0 0x1000>,
> +		      <0 0x11C50000 0 0x1000>,
> +		      <0 0x11F30000 0 0x1000>;

Use lowercase hex.

> +		reg-names = "iocfg0", "iocfg1", "iocfg2",
> +			    "iocfg3", "iocfg4", "iocfg5",
> +			    "iocfg6", "iocfg7", "iocfg8";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-ranges = <&pio 0 0 192>;
> +		interrupt-controller;
> +		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-parent = <&gic>;
> +		#interrupt-cells = <2>;
> +
> +		i2c0_pins_a: i2c0 {
> +			pins1 {
> +				pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
> +					 <PINMUX_GPIO49__FUNC_SDA5>;
> +				mediatek,pull-up-adv = <11>;
> +			};
> +		};
> +
> +		i2c1_pins_a: i2c1 {
> +			pins {
> +				pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
> +					 <PINMUX_GPIO51__FUNC_SDA3>;
> +				mediatek,pull-down-adv = <10>;
> +			};
> +		};
> +		...
> +	};
> +};
> -- 
> 1.9.1
> 
