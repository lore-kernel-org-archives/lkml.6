Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F175C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68DF2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CZRRtm65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68DF2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJLT0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:26:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45544 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJLT0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:26:20 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 964BD1258;
        Fri, 12 Oct 2018 13:54:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539345252;
        bh=rxur9K3s5b3j3jm+9kAMkg7isbcotSDtUm7h3gvEvQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZRRtm65CtstOc9GBsnNmG06tTnUhQLvrjF75Ef2dnHFZRMQsnEmjAgF8xxrjnDnr
         zlZlqcoSaGENwDVuPBaCEN/GHXOOjDfrm/JOtrqlLhQstsBt62HuOUbbcPjSQZZtmz
         LEpz+ma6V2ROulZReWrb+I0WgNe4c9pECoHhaFmw=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH 2/7] dt-bindings: mfd: ds90ux9xx: add description of TI DS90Ux9xx I2C bridge
Date:   Fri, 12 Oct 2018 14:54:16 +0300
Message-ID: <1728543.TWj8z2etku@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181008211205.2900-3-vz@mleia.com>
References: <20181008211205.2900-1-vz@mleia.com> <20181008211205.2900-3-vz@mleia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

Thank you for the patch.

On Tuesday, 9 October 2018 00:12:00 EEST Vladimir Zapolskiy wrote:
> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> 
> TI DS90Ux9xx de-/serializers are capable to route I2C messages to
> I2C slave devices connected to a remote de-/serializer in a pair,
> the change adds description of device tree bindings of the subcontroller
> to configure and enable this functionality.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  .../bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt
> b/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt new
> file mode 100644
> index 000000000000..4169e382073a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt
> @@ -0,0 +1,61 @@
> +TI DS90Ux9xx de-/serializer I2C bridge subcontroller
> +
> +Required properties:
> +- compatible: Must contain a generic "ti,ds90ux9xx-i2c-bridge" value and
> +	may contain one more specific value from the list:
> +	"ti,ds90ux925-i2c-bridge",
> +	"ti,ds90ux926-i2c-bridge",
> +	"ti,ds90ux927-i2c-bridge",
> +	"ti,ds90ux928-i2c-bridge",
> +	"ti,ds90ux940-i2c-bridge".

I still don't think the I2C bridge should be modeled with a separate 
compatible string, as explained in my comments to the cover letter and patch 
1/7.

> +Required properties of a de-/serializer device connected to a local I2C
> bus:
> +- ti,i2c-bridges: List of phandles to remote de-/serializer devices with
> +	two arguments: id of a local de-/serializer FPD link and an assigned
> +	I2C address of a remote de-/serializer to be accessed on a local
> +	I2C bus.

Please don't. Just make the deserializer a child of the serializer. This is 
how DT works, devices are organized in a tree based on the main control bus. 
When the deserializer is controlled from the serializer through the FPD link, 
it should be a child of the serializer.

> +Optional properties of a de-/serializer device connected to a local I2C
> bus:
> +- ti,i2c-bridge-maps: List of 3-cell values:
> +	- the first argument is id of a local de-/serializer FPD link,
> +	- the second argument is an I2C address of a device connected to
> +	  a remote de-/serializer IC,
> +	- the third argument is an I2C address of the remote I2C device
> +	  for access on a local I2C bus.
> +- ti,i2c-bridge-auto-ack: Enables AUTO ACK mode.

From my experience with GMSL this isn't something you can just enable or 
disable unconditionally, it needs to be handled at runtime, and doesn't belong 
to DT anyway.

> +- ti,i2c-bridge-pass-all: Enables PASS ALL mode, remote I2C slave devices
> +	are accessible on a local (host) I2C bus without I2C address
> +	remappings.

This property also doesn't seem like a hardware description. Please try to 
focus on what DT describes, not what the effect of the properties are. 
Bindings need to describe the model of the device, and that description then 
leads to effects. It shouldn't be the other way around.

> +Remote de-/serializer device may contain a list of device nodes, each
> +one represents an I2C device connected to that remote de-/serializer IC.
> +
> +Example (remote device is a deserializer with Atmel MXT touchscreen):
> +
> +serializer: serializer@c {
> +	compatible = "ti,ds90ub927q", "ti,ds90ux9xx";
> +	reg = <0xc>;
> +
> +	i2c-bridge {
> +		compatible = "ti,ds90ux927-i2c-bridge",
> +			     "ti,ds90ux9xx-i2c-bridge";
> +		ti,i2c-bridges = <&deserializer 0 0x3b>;
> +		ti,i2c-bridge-maps = <0 0x4b 0x64>;
> +	};
> +};
> +
> +deserializer: deserializer {
> +	compatible = "ti,ds90ub928q", "ti,ds90ux9xx";
> +
> +	i2c-bridge {
> +		compatible = "ti,ds90ux928-i2c-bridge",
> +			     "ti,ds90ux9xx-i2c-bridge";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		touchscreen@4b {
> +			compatible = "atmel,maxtouch";
> +			reg = <0x4b>;
> +		};
> +	};
> +};

-- 
Regards,

Laurent Pinchart



