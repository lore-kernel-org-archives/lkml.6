Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeA3KGj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:06:39 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:36173 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbeA3KGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:06:34 -0500
Date: Tue, 30 Jan 2018 11:06:21 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com, kernel@pengutronix.de,
        Denis.Osterland@diehl.com
Subject: Re: [PATCH 2/4] rtc: isl1208: Add device tree binding documentation
Message-ID: <20180130100621.GC2809@piout.net>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-3-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180123121801.4214-3-m.grzeschik@pengutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/01/2018 at 13:17:59 +0100, Michael Grzeschik wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> Wrote documentation for ISL1208, ISL1218 device tree
> binding with short examples.
> 

This binding is already in
Documentation/devicetree/bindings/trivial-devices.txt, no need to
duplicate.

> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  .../devicetree/bindings/rtc/intersil,isl1208.txt   | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt b/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> new file mode 100644
> index 0000000000000..a54e99feae1ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> @@ -0,0 +1,35 @@
> +Intersil ISL1208, ISL1218 I2C RTC/Alarm chip
> +
> +ISL1208 is a trivial I2C device (it has simple device tree bindings,
> +consisting of a compatible field, an address and possibly an interrupt
> +line).
> +
> +Required properties supported by the device:
> +
> + - "compatible": must be one of
> +	"isil,isl1208"
> +	"isil,isl1218"
> + - "reg": I2C bus address of the device
> +
> +Optional properties:
> +
> + - "interrupt-parent", "interrupts", "interrupts-extended":
> +   for passing the interrupt line of the SoC connected to #IRQ pin
> +   of the RTC chip.
> +
> +
> +Example isl1208 node without #IRQ pin connected:
> +
> +	isl1208: isl1208@68 {
> +		compatible = "isil,isl1208";
> +		reg = <0x68>;
> +	};
> +
> +Example isl1208 node with #IRQ pin connected to SoC gpio1 pin 12:
> +
> +	isl1208: isl1208@68 {
> +		compatible = "isil,isl1208";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
> +	};
> -- 
> 2.11.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
