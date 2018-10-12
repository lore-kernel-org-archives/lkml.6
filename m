Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35211C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83182087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qFpdrdrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83182087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeJLTQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:16:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45378 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJLTQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:16:25 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A0EB61258;
        Fri, 12 Oct 2018 13:44:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539344659;
        bh=0F2F90DlDyJ2gnJB6mkdXith5iNHf3tBPG5qjyZRi84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFpdrdrzHx/nO9DQCkU58AGiJeay+vm6XIcQovW8HFxhcCWHeDdsh5xUXEZnDZXM+
         wFvzp1xNLMIome7xtwgL4ctVsKmQzXQ/ixpG7u3qINd9xoTRl9lG3nIReMZ8ZniXsm
         cbiPCoBMHzKXzkXt171t0+/fupUttcQZ9TwJ7rOg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sandeep Jain <Sandeep_Jain@mentor.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH 1/7] dt-bindings: mfd: ds90ux9xx: add description of TI DS90Ux9xx ICs
Date:   Fri, 12 Oct 2018 14:44:23 +0300
Message-ID: <1884479.fINZhmP2Mi@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181008211205.2900-2-vz@mleia.com>
References: <20181008211205.2900-1-vz@mleia.com> <20181008211205.2900-2-vz@mleia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

Thank you for the patch.

On Tuesday, 9 October 2018 00:11:59 EEST Vladimir Zapolskiy wrote:
> From: Sandeep Jain <Sandeep_Jain@mentor.com>
> 
> The change adds device tree binding description of TI DS90Ux9xx
> series of serializer and deserializer controllers which support video,
> audio and control data transmission over FPD-III Link connection.
> 
> Signed-off-by: Sandeep Jain <Sandeep_Jain@mentor.com>
> [vzapolskiy: various updates and corrections of secondary importance]
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  .../devicetree/bindings/mfd/ti,ds90ux9xx.txt  | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt
> b/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt new file mode
> 100644
> index 000000000000..0733da88f7ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt
> @@ -0,0 +1,66 @@
> +Texas Instruments DS90Ux9xx de-/serializer controllers
> +
> +Required properties:
> +- compatible: Must contain a generic "ti,ds90ux9xx" value and
> +	may contain one more specific value from the list:

If it "may" contain one more specific value, when should that value be 
present, and when can it be absent ?

> +	"ti,ds90ub925q",
> +	"ti,ds90uh925q",
> +	"ti,ds90ub927q",
> +	"ti,ds90uh927q",
> +	"ti,ds90ub926q",
> +	"ti,ds90uh926q",
> +	"ti,ds90ub928q",
> +	"ti,ds90uh928q",
> +	"ti,ds90ub940q",
> +	"ti,ds90uh940q".
> +
> +Optional properties:
> +- reg : Specifies the I2C slave address of a local de-/serializer.

You should explain when the reg property is required and when it isn't. This 
will in my opinion require a more detailed explanation of the DT model for 
this device.

> +- power-gpios : GPIO line to control supplied power to the device.

As Marek mentioned, a regulator would be better. I would make it a mandatory 
property, as the device always needs to be powered.

> +- ti,backward-compatible-mode : Overrides backward compatibility mode.
> +	Possible values are "<1>" or "<0>".
> +	If "ti,backward-compatible-mode" is not mentioned, the backward
> +	compatibility mode is not touched and given by hardware pin strapping.

This doesn't seem to be a device description to me, it's a software 
configuration. You should handle it in drivers.

> +- ti,low-frequency-mode : Overrides low frequency mode.
> +	Possible values are "<1>" or "<0>".
> +	If "ti,low-frequency-mode" is not mentioned, the low frequency mode
> +	is not touched and given by hardware pin strapping.

This sounds the same. How about giving a real life example of a case where you 
need to set these two properties to override the pin strapping, for the 
purpose of discussing the DT bindings ?

> +- ti,video-map-select-msb: Sets video bridge pins to MSB mode, if it is set
> +	MAPSEL pin value is ignored.
> +- ti,video-map-select-lsb: Sets video bridge pins to LSB mode, if it is set
> +	MAPSEL pin value is ignored.

I assume those two are mutually exclusive, this should be documented, or you 
could merge the two properties into one. Same comment as above though, why do 
you need an override in DT ?

> +- ti,pixel-clock-edge : Selects Pixel Clock Edge.
> +	Possible values are "<1>" or "<0>".
> +	If "ti,pixel-clock-edge" is High <1>, output data is strobed on the
> +	Rising edge of the PCLK. If ti,pixel-clock-edge is Low <0>, data is
> +	strobed on the Falling edge of the PCLK.
> +	If "ti,pixel-clock-edge" is not mentioned, the pixel clock edge
> +	value is not touched and given by hardware pin strapping.

We have a standard property in Documentation/devicetree/bindings/media/video-
interfaces.txt for this, please use it.

> +- ti,spread-spectrum-clock-generation : Spread Sprectrum Clock Generation.
> +	Possible values are from "<0>" to "<7>". The same value will be
> +	written to SSC register. If "ti,spread-spectrum-clock-gen" is not
> +	found, then SSCG will be disabled.

This makes sense in DT in my opinion, as EMC is a system property. I wonder 
however if exposing the hardware register directly is the best option. Could 
you elaborate on how a system designer will select which value to use, in 
order to find the best DT description ?

> +TI DS90Ux9xx serializers and deserializer device nodes may contain a number
> +of children device nodes to describe and enable particular subcomponents
> +found on ICs.

As mentioned in my review of the cover letter I don't think this is necessary. 
You can make the serializer and deserializer I2C controllers without subnodes. 
Same goes for GPIO control.

> +Example:
> +
> +serializer: serializer@c {
> +	compatible = "ti,ds90ub927q", "ti,ds90ux9xx";
> +	reg = <0xc>;
> +	power-gpios = <&gpio5 12 GPIO_ACTIVE_HIGH>;
> +	ti,backward-compatible-mode = <0>;
> +	ti,low-frequency-mode = <0>;
> +	ti,pixel-clock-edge = <0>;
> +	...
> +}
> +
> +deserializer: deserializer@3c {
> +	compatible = "ti,ds90ub940q", "ti,ds90ux9xx";
> +	reg = <0x3c>;
> +	power-gpios = <&gpio6 31 GPIO_ACTIVE_HIGH>;
> +	...
> +}
> +

Extra blank line ?

-- 
Regards,

Laurent Pinchart



