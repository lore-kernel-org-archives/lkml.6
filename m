Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753557AbeBVK7m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:59:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:35549 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753411AbeBVK7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:59:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="32705440"
Date: Thu, 22 Feb 2018 12:59:32 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ryan Harkin <ryan.harkin@linaro.org>,
        Rui Miguel Silva <rui.silva@linaro.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] media: ov2680: dt: Add bindings for OV2680
Message-ID: <20180222105932.t4j7ranj2qp4jhj6@paasikivi.fi.intel.com>
References: <20180222102338.28896-1-rui.silva@linaro.org>
 <20180222102338.28896-2-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222102338.28896-2-rui.silva@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

Thanks for the patchset.

Could you use "dt: bindings: " prefix in the subject?

On Thu, Feb 22, 2018 at 10:23:37AM +0000, Rui Miguel Silva wrote:
> Add device tree binding documentation for the OV5640 camera sensor.
> 
> CC: devicetree@vger.kernel.org
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  .../devicetree/bindings/media/i2c/ov2680.txt       | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ov2680.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov2680.txt b/Documentation/devicetree/bindings/media/i2c/ov2680.txt
> new file mode 100644
> index 000000000000..f9dc63ce5044
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ov2680.txt
> @@ -0,0 +1,34 @@
> +* Omnivision OV2680 MIPI CSI-2 sensor
> +
> +Required Properties:
> +- compatible: should be "ovti,ov2680"
> +- clocks: reference to the xvclk input clock.
> +- clock-names: should be "xvclk".
> +
> +Optional Properties:
> +- powerdown-gpios: reference to the GPIO connected to the powerdown pin,
> +		     if any. This is an active high signal to the OV2680.
> +
> +The device node must contain one 'port' child node for its digital output

Please add that the port contains a single endpoint as well.

> +video port, in accordance with the video interface bindings defined in
> +Documentation/devicetree/bindings/media/video-interfaces.txt.

Please list required and optional endpoint properties as well.

> +
> +Example:
> +
> +&i2c2 {
> +	ov2680: camera-sensor@36 {
> +		compatible = "ovti,ov2680";
> +		reg = <0x36>;
> +		clocks = <&osc>;
> +		clock-names = "xvclk";
> +		powerdown-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			ov2680_mipi_ep: endpoint {
> +				remote-endpoint = <&mipi_sensor_ep>;
> +				clock-lanes = <0>;
> +				data-lanes = <1>;
> +			};
> +		};
> +	};
> +};

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
