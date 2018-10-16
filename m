Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD0020869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tDIpe99h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD0020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeJPUiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:38:21 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39106 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPUiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:38:20 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E527D1A81;
        Tue, 16 Oct 2018 14:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539694078;
        bh=aEIPrakCnv2UTrKcqWXhTpaOJHN/WJ22S4WP4KK1JWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDIpe99hktM5tnIvDBnyceSx4tIhQvn8X8ipMQ90beMskGk0THZPzBuCwOSAMMrvq
         0QeO+MAsRmwVhWmlE2lbvT77vY6Jy3YoJ6vOwkmtnk6ImbHhnVdT7Ah5Yo6A+1972b
         jG2NcX8aXL4wvhEBI3WJOPbKxNGDYUnr1J4nb27E=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: pinctrl: ds90ux9xx: add description of TI DS90Ux9xx pinmux
Date:   Tue, 16 Oct 2018 15:48:06 +0300
Message-ID: <2595665.eknevzee7a@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <9bd129b4-ce18-b036-9376-2cb1cb76aaf2@mentor.com>
References: <20181008211205.2900-1-vz@mleia.com> <8675619.KiXOS7fxCj@avalon> <9bd129b4-ce18-b036-9376-2cb1cb76aaf2@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Saturday, 13 October 2018 16:47:48 EEST Vladimir Zapolskiy wrote:
> On 10/12/2018 03:01 PM, Laurent Pinchart wrote:
> > On Tuesday, 9 October 2018 00:12:01 EEST Vladimir Zapolskiy wrote:
> >> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> 
> >> TI DS90Ux9xx de-/serializers have a capability to multiplex pin
> >> functions, in particular a pin may have selectable functions of GPIO,
> >> GPIO line transmitter, one of I2S lines, one of RGB24 video signal lines
> >> and so on.
> >> 
> >> The change adds a description of DS90Ux9xx pin multiplexers and GPIO
> >> controllers.
> >> 
> >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> ---
> >> 
> >>  .../bindings/pinctrl/ti,ds90ux9xx-pinctrl.txt | 83 +++++++++++++++++++
> >>  1 file changed, 83 insertions(+)
> >>  create mode 100644
> >> 
> >> Documentation/devicetree/bindings/pinctrl/ti,ds90ux9xx-pinctrl.txt
> >> 
> >> diff --git
> >> a/Documentation/devicetree/bindings/pinctrl/ti,ds90ux9xx-pinctrl.txt
> >> b/Documentation/devicetree/bindings/pinctrl/ti,ds90ux9xx-pinctrl.txt new
> >> file mode 100644
> >> index 000000000000..fbfa1a3cdf9f
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pinctrl/ti,ds90ux9xx-pinctrl.txt
> >> @@ -0,0 +1,83 @@
> >> +TI DS90Ux9xx de-/serializer pinmux and GPIO subcontroller
> >> +
> >> +Required properties:
> >> +- compatible: Must contain a generic "ti,ds90ux9xx-pinctrl" value and
> >> +	may contain one more specific value from the list:
> >> +	"ti,ds90ux925-pinctrl",
> >> +	"ti,ds90ux926-pinctrl",
> >> +	"ti,ds90ux927-pinctrl",
> >> +	"ti,ds90ux928-pinctrl",
> >> +	"ti,ds90ux940-pinctrl".
> > 
> > No need for a subnode, you can mark the main DT node with gpio-controller
> > directly.
> 
> If the IC is seen as an MFD, and you guess I highly prefer it and I object
> the "overkill" argument, then the subnode is requred.
> 
> Also the more complicated part of the subcontroller and its device driver
> is to provide pinmuxing function to consumers rather than to allow GPIO
> line configuration.
> 
> The pinctrl/GPIO driver can not be alloyed with the base driver's code
> to sustain maintainability, so it will reside in drivers/pinctrl as
> a separate cell driver, and by the way that is the reason why it earns
> its own very non-trivial DT binding description documentation.
> 
> >> +- gpio-controller: Marks the device node as a GPIO controller.
> >> +
> >> +- #gpio-cells: Must be set to 2,
> >> +	- the first cell is the GPIO offset number within the controller,
> >> +	- the second cell is used to specify the GPIO line polarity.
> >> +
> >> +- gpio-ranges: Mapping to pin controller pins (as described in
> >> +	Documentation/devicetree/bindings/gpio/gpio.txt)
> >> +
> >> +Optional properties:
> >> +- ti,video-depth-18bit: Sets video bridge pins to RGB 18-bit mode.
> > 
> > Please use standard properties to configure bus width. There is one
> > defined in Documentation/devicetree/bindings/media/video-interfaces.txt.
> 
> Here it is not a bus width description or property, but rather it is a
> custom pinmux control.
> 
> It could make sense to reduce the scope of the property to "parallel" pin
> function only though, like in
> 
> 	ds90ux927_0_pins: pinmux {
> 		parallel {
> 			groups = "parallel";
> 			function = "parallel";
> 			ti,video-depth-18bit;
> 		};
> 	};
> 
> Alternatively the removal of the property would be almost loseless, it is
> needed just in one very specific case, please reference to the driver code
> for details, there you'll find a comment in ds90ux9xx_parse_dt_properties()
> function.

Based on the information I gathered from the DS90UH92[567] datasheets, the 
restriction on GPIO usage related to 18-bit mode is due to the signals being 
multiplexed on the same pins on DS90UH925. It could also be that the FPD-Link 
protocol itself can't carry both GPIO and the extra 6 colour bits.

In any case, I don't think the property belongs here. The bus width should be 
specified in the DT bindings for the video ports, and the drivers should then 
use that information to configure other parameters, possibly GPIO-specific, if 
needed.

> >> +Available pins, groups and functions (reference to device datasheets):
> >> +
> >> +function: "gpio" ("gpio4" is on DS90Ux925 and DS90Ux926 only,
> >> +		  "gpio9" is on DS90Ux940 only)
> >> + - pins: "gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6",
> >> +	 "gpio7", "gpio8", "gpio9"
> >> +
> >> +function: "gpio-remote"
> >> + - pins: "gpio0", "gpio1", "gpio2", "gpio3"
> >> +
> >> +function: "pass" (DS90Ux940 specific only)
> >> + - pins: "gpio0", "gpio3"
> > 
> > What do those functions mean ?
> 
> "gpio" function should be already familiar to you.

I assume this function is only available for the local device, not the remote 
one ?

> "gpio-remote" function is the pin function for a GPIO line bridging.
> 
> "pass" function sets a pin to a status pin function for detecting
> display timing issues, namely DE or Vsync length value mismatch.

All this is not clear at all from the proposed DT bindings, it should be 
properly documented.

> >> +function: "i2s-1"
> >> + - group: "i2s-1"
> >> +
> >> +function: "i2s-2"
> >> + - group: "i2s-2"
> >> +
> >> +function: "i2s-3" (DS90Ux927, DS90Ux928 and DS90Ux940 specific only)
> >> + - group: "i2s-3"
> >> +
> >> +function: "i2s-4" (DS90Ux927, DS90Ux928 and DS90Ux940 specific only)
> >> + - group: "i2s-4"
> >> +
> >> +function: "i2s-m" (DS90Ux928 and DS90Ux940 specific only)
> >> + - group: "i2s-m"
> > 
> > Do we really need all this ? I think a better model would be to describe
> > the audio interfaces explicitly, and configure pinmuxing automatically
> > based on which audio interfaces are in use.
> 
> Yes, all the pin functions are needed, because they are transparent pinmux
> controls.
> 
> I really don't want to copy a part of gpio and pinctrl frameworks to
> the driver to hunt out why a user configured audio bridging and a GPIO
> line, and then something goes funny due to a pin conflict. To forget
> about such very possible pin and pin function conflicts I'm happy to
> shift the task to the neat Linus' frameworks.

And I still believe this is overkill and confusing, and disagrees that this is 
an MFD device.

> >> +function: "parallel" (DS90Ux925 and DS90Ux926 specific only)
> >> + - group: "parallel"
> >> +
> >> +Example (deserializer with pins GPIO[3:0] set to bridged output
> >> +	 function and pin GPIO4 in standard hogged GPIO function):
> >> +
> >> +deserializer {
> >> +	compatible = "ti,ds90ub928q", "ti,ds90ux9xx";
> >> +
> >> +	ds90ux928_pctrl: pin-controller {
> >> +		compatible = "ti,ds90ux928-pinctrl", "ti,ds90ux9xx-pinctrl";
> >> +		gpio-controller;
> >> +		#gpio-cells = <2>;
> >> +		gpio-ranges = <&ds90ux928_pctrl 0 0 8>;
> >> +
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&ds90ux928_pins>;
> >> +
> >> +		ds90ux928_pins: pinmux {
> >> +			gpio-remote {
> >> +				pins = "gpio0", "gpio1", "gpio2", "gpio3";
> >> +				function = "gpio-remote";
> >> +			};
> >> +		};
> >> +
> >> +		rst {
> >> +			gpio-hog;
> >> +			gpios = <4 GPIO_ACTIVE_HIGH>;
> >> +			output-high;
> >> +		};
> >> +	};
> >> +};

-- 
Regards,

Laurent Pinchart



