Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeBWO4q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:56:46 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45758 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeBWO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:56:44 -0500
X-Google-Smtp-Source: AH8x227NkMbXmpQ5L/1mNZqnFyXiM4b6A5CZtVOC20ho4Rz0NjxFu4uKdONr16WSdt2TDneTM7WLKA==
References: <20180222102338.28896-1-rui.silva@linaro.org> <20180222102338.28896-2-rui.silva@linaro.org> <20180222105932.t4j7ranj2qp4jhj6@paasikivi.fi.intel.com>
User-agent: mu4e 1.0; emacs 27.0.50
From: Rui Miguel Silva <rui.silva@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ryan Harkin <ryan.harkin@linaro.org>,
        Rui Miguel Silva <rui.silva@linaro.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] media: ov2680: dt: Add bindings for OV2680
In-reply-to: <20180222105932.t4j7ranj2qp4jhj6@paasikivi.fi.intel.com>
Date: Fri, 23 Feb 2018 14:56:41 +0000
Message-ID: <m3k1v3kb4m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,
Thanks for the review.

On Thu 22 Feb 2018 at 10:59, Sakari Ailus wrote:
> Hi Rui,
>
> Thanks for the patchset.
>
> Could you use "dt: bindings: " prefix in the subject?

Sure, no problem.

>
> On Thu, Feb 22, 2018 at 10:23:37AM +0000, Rui Miguel Silva 
> wrote:
>> Add device tree binding documentation for the OV5640 camera 
>> sensor.
>> 
>> CC: devicetree@vger.kernel.org
>> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
>> ---
>>  .../devicetree/bindings/media/i2c/ov2680.txt       | 34 
>>  ++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>  create mode 100644 
>>  Documentation/devicetree/bindings/media/i2c/ov2680.txt
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/media/i2c/ov2680.txt 
>> b/Documentation/devicetree/bindings/media/i2c/ov2680.txt
>> new file mode 100644
>> index 000000000000..f9dc63ce5044
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/ov2680.txt
>> @@ -0,0 +1,34 @@
>> +* Omnivision OV2680 MIPI CSI-2 sensor
>> +
>> +Required Properties:
>> +- compatible: should be "ovti,ov2680"
>> +- clocks: reference to the xvclk input clock.
>> +- clock-names: should be "xvclk".
>> +
>> +Optional Properties:
>> +- powerdown-gpios: reference to the GPIO connected to the 
>> powerdown pin,
>> +		     if any. This is an active high signal to the 
>> OV2680.
>> +
>> +The device node must contain one 'port' child node for its 
>> digital output
>
> Please add that the port contains a single endpoint as well.

Ack.

>
>> +video port, in accordance with the video interface bindings 
>> defined in
>> +Documentation/devicetree/bindings/media/video-interfaces.txt.
>
> Please list required and optional endpoint properties as well.

OK.

---
Cheers,
	Rui

>
>> +
>> +Example:
>> +
>> +&i2c2 {
>> +	ov2680: camera-sensor@36 {
>> +		compatible = "ovti,ov2680";
>> +		reg = <0x36>;
>> +		clocks = <&osc>;
>> +		clock-names = "xvclk";
>> +		powerdown-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
>> +
>> +		port {
>> +			ov2680_mipi_ep: endpoint {
>> +				remote-endpoint = 
>> <&mipi_sensor_ep>;
>> +				clock-lanes = <0>;
>> +				data-lanes = <1>;
>> +			};
>> +		};
>> +	};
>> +};
