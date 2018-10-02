Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A09EC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3004C206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dqb0CBbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3004C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeJCCvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:51:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49138 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCCvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:51:46 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E7B2B7F;
        Tue,  2 Oct 2018 22:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538510801;
        bh=JqVegfD7cJSpYnTK6WX2rQKLdNLsrMy7T47yWVe7yjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqb0CBbBht7JaLMFWbsvkXJ0e1FML0JHahk1mWsqJx3HtgrYAzUp3btBebreA6/WB
         CGZLhnhPzCkYF1XkT5LhS/bAvAe/DbO8CZCm7Am/s9cu0pjXeSCRCYkA2U6WFeNR08
         OrUiXPECIwYowt7egqqzyvn1xRIwudRJ1pg9hNxQ=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org, phdm@macq.eu, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] [media] imx214: device tree binding
Date:   Tue, 02 Oct 2018 23:06:57 +0300
Message-ID: <4555006.y1GbRfQLCO@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181002140515.16299-1-ricardo.ribalda@gmail.com>
References: <20181002140515.16299-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tuesday, 2 October 2018 17:05:15 EEST Ricardo Ribalda Delgado wrote:
> Document bindings for imx214 camera sensor
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> Changelog from v3:
> 
> Sakari Ailus:
> -s/should/shall/
> -remove clock-lanes
> 
> Philippe De Muyter:
> -s/imx274/imx214/
> 
> Laurent Pinchart:
> -s/to to/to/
> -Better description of lanes
> -clock-names: Shall be "xclk"
> -Drop clock-freq
> 
>  .../devicetree/bindings/media/i2c/imx214.txt  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt
> b/Documentation/devicetree/bindings/media/i2c/imx214.txt new file mode
> 100644
> index 000000000000..421a019ab7f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
> @@ -0,0 +1,53 @@
> +* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
> +
> +The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor
> with +an active array size of 4224H x 3200V. It is programmable through an
> I2C +interface. The I2C address can be configured to 0x1a or 0x10,
> depending on +how the hardware is wired.
> +Image data is sent through MIPI CSI-2, through 2 or 4 lanes at a maximum
> +throughput of 1.2Gbps/lane.
> +
> +
> +Required Properties:
> +- compatible: value should be "sony,imx214" for imx214 sensor
> +- reg: I2C bus address of the device
> +- enable-gpios: GPIO descriptor for the enable pin.
> +- vdddo-supply: Chip digital IO regulator (1.8V).
> +- vdda-supply: Chip analog regulator (2.7V).
> +- vddd-supply: Chip digital core regulator (1.12V).
> +- clocks: Reference to the xclk clock.
> +- clock-names:  Shall be "xclk".
> +
> +Optional Properties:
> +- flash-leds: See ../video-interfaces.txt
> +- lens-focus: See ../video-interfaces.txt
> +
> +The imx214 device node shall contain one 'port' child node with
> +an 'endpoint' subnode. For further reading on port node refer to
> +Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +Required Properties on endpoint:
> +- data-lanes: check ../video-interfaces.txt

As I suppose you got access to the datasheet which doesn't appear to be 
public, I'll take this as an opportunity to fish for information :-) Does the 
sensor support remapping data lanes ? Could you please document that here ?

You should also state that only the 2 lanes and 4 lanes options are valid, and 
what lanes can be used in those cases. I assume that would be <1 2> and <1 2 3 
4>, but if other options are possible, it would be useful to document that.

With this updated,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +- link-frequencies: check ../video-interfaces.txt
> +- remote-endpoint: check ../video-interfaces.txt
> +
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
> +		port {
> +			imx214_ep: endpoint {
> +				data-lanes = <1 2 3 4>;
> +				link-frequencies = /bits/ 64 <480000000>;
> +				remote-endpoint = <&csiphy0_ep>;
> +			};
> +		};
> +	};


-- 
Regards,

Laurent Pinchart



