Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A65C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346FF208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346FF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeJFFDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:03:04 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:53080 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725772AbeJFFDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:03:04 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id C231F634C8B;
        Sat,  6 Oct 2018 01:02:21 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1g8YAv-0000js-J9; Sat, 06 Oct 2018 01:02:21 +0300
Date:   Sat, 6 Oct 2018 01:02:21 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 1/3] [media] imx214: device tree binding
Message-ID: <20181005220221.luriq43w3yvstmw3@valkosipuli.retiisi.org.uk>
References: <20181005215750.6047-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005215750.6047-1-ricardo.ribalda@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Fri, Oct 05, 2018 at 11:57:50PM +0200, Ricardo Ribalda Delgado wrote:
> Document bindings for imx214 camera sensor
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> Changelog from v8:
> 
> Rob Herring:
> -rename file
> -Move address to reg
> -rename name on example
> -Patch author
> 
> Sakari Ailus:
> -should->shall
> 
>  .../bindings/media/i2c/sony,imx214.txt        | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt b/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
> new file mode 100644
> index 000000000000..2744773070c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
> @@ -0,0 +1,53 @@
> +* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
> +
> +The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
> +an active array size of 4224H x 3200V. It is programmable through an I2C
> +interface.
> +Image data is sent through MIPI CSI-2, through 2 or 4 lanes at a maximum
> +throughput of 1.2Gbps/lane.
> +
> +
> +Required Properties:
> +- compatible: Shall be "sony,imx214".
> +- reg: I2C bus address of the device. Depending on how the sensor is wired,
> +       it shall be <0x10> or <0x1a>;
> +- enable-gpios: GPIO descriptor for the enable pin.
> +- vdddo-supply: Chip digital IO regulator (1.8V).
> +- vdda-supply: Chip analog regulator (2.7V).
> +- vddd-supply: Chip digital core regulator (1.12V).
> +- clocks: Reference to the xclk clock.
> +- clock-names:  Shall be "xclk".

It could be that this was already discussed earlier but I missed that ---
clock frequency. Apologies for that. How does the driver know what to ask?
If you expect assigned-clock-rate or such, then I think it should be
explicitly said here.

You also have a single clock, so do you need clock-names?

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
> +- link-frequencies: check ../video-interfaces.txt
> +- remote-endpoint: check ../video-interfaces.txt
> +
> +Example:
> +
> +	camera-sensor@1a {
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
> -- 
> 2.19.0
> 

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
