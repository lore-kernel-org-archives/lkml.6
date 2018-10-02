Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E51C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2466C2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jtgCKjDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2466C2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbeJBUbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:31:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45634 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731662AbeJBUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:31:07 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6E0CFB7F;
        Tue,  2 Oct 2018 15:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538488058;
        bh=EqsUwa7y/VKRDVHOHxRaW5f00pP03XJBujZedw/an4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtgCKjDblqNYKHE5uCBYjVGiemuoKQsZDNB9vDeCan5J6bRb1dc6iOI7SNaxHKk4M
         lIg1xkFq0xbVM+rCHJcQGF54nSym1KjdA9beBazYtUg2p7RVzqW5sKuM0yZ9jKZMId
         LYmTPymHeJaslKK8dJxtlacvKGYKpLBdlv8TBT9w=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] [media] imx214: device tree binding
Date:   Tue, 02 Oct 2018 16:47:55 +0300
Message-ID: <3927913.3GBmOnKHNx@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181002133058.12942-1-ricardo.ribalda@gmail.com>
References: <20181002133058.12942-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tuesday, 2 October 2018 16:30:57 EEST Ricardo Ribalda Delgado wrote:
> Document bindings for imx214 camera sensor
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> Changelog v2:
> Laurent Pinchart:
> 
> -Spell checks
> -Remove frequency
> -Identation
> -Data lanes order
> 
> Thanks!
> 
>  .../devicetree/bindings/media/i2c/imx214.txt  | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt
> b/Documentation/devicetree/bindings/media/i2c/imx214.txt new file mode
> 100644
> index 000000000000..bf3cac731eca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
> @@ -0,0 +1,52 @@
> +* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
> +
> +The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor
> with +an active array size of 4224H x 3200V. It is programmable through an
> I2C +interface. The I2C address can be configured to to 0x1a or 0x10,

s/to to/to/

> depending on +how the hardware is wired.
> +Image data is sent through MIPI CSI-2, which is configured as 4 lanes
> +at 1440 Mbps.

I suppose this is the maxium, with the actual frequency and number of lanes 
being configurable ? I would state it so explicitly then.

> +Required Properties:
> +- compatible: value should be "sony,imx214" for imx214 sensor
> +- reg: I2C bus address of the device
> +- enable-gpios: GPIO descriptor for the enable pin.
> +- vdddo-supply: Chip digital IO regulator (1.8V).
> +- vdda-supply: Chip analog regulator (2.7V).
> +- vddd-supply: Chip digital core regulator (1.12V).
> +- clocks = Reference to the xclk clock.

s/ = /: /

Same below.

> +- clock-names = Clock name, e.g. "xclk".

As the name "xclk" is mandatory I wouldn't call it an example. You can just 
say

- clock-names: Shall be "xclk".

> +- clock-frequency = Frequency of the xclk clock. (Currently the
> +	driver only supports <24000000>).

Please don't mention drivers in DT bindings. I would drop the reference to the 
24 MHz limitation.

I would actually drop the property completely :-) I don't see why you need it, 
and you don't make use of it in the driver.

> +Optional Properties:
> +- flash-leds: See ../video-interfaces.txt
> +- lens-focus: See ../video-interfaces.txt
> +
> +The imx274 device node should contain one 'port' child node with
> +an 'endpoint' subnode. For further reading on port node refer to
> +Documentation/devicetree/bindings/media/video-interfaces.txt.

Please also document the properties of the endpoint node. You can just list 
the ones that are required and the ones that are optional, and reference the 
same document for their definition.

> +Example:
> +
> +	camera_rear@1a {
> +		compatible = "sony,imx214";
> +		reg = <0x1a>;
> +		vdddo-supply = <&pm8994_lvs1>;
> +		vddd-supply = <&camera_vddd_1v12>;
> +		vdda-supply = <&pm8994_l17>;
> +		lens-focus = <&ad5820>;
> +		enable-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
> +		clocks = <&mmcc CAMSS_MCLK0_CLK>;
> +		clock-names = "xclk";
> +		clock-frequency = <24000000>;
> +		port {
> +			imx214_ep: endpoint {
> +				clock-lanes = <0>;
> +				data-lanes = <1 2 3 4>;
> +				link-frequencies = /bits/ 64 <480000000>;
> +				remote-endpoint = <&csiphy0_ep>;
> +			};
> +		};
> +	};

-- 
Regards,

Laurent Pinchart



