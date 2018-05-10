Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeEJUwJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:52:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54010 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeEJUwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:52:07 -0400
X-Google-Smtp-Source: AB8JxZp/RHsKs3QlKzcl460ffNCTg9xF4LjVHYouMk8V+0IWYMId5OVpXaxKVpa6q56it97ZeULGoA==
Subject: Re: [PATCH v5 1/2] dt: bindings: lm3601x: Introduce the lm3601x
 driver
To: Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, mark.rutland@arm.com,
        pavel@ucw.cz, afd@ti.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180510174717.26540-1-dmurphy@ti.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <868fe3bf-b12d-581b-18f9-1eac734e6239@gmail.com>
Date: Thu, 10 May 2018 22:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510174717.26540-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 07:47 PM, Dan Murphy wrote:
> Introduce the device tree bindings for the lm3601x
> family of LED torch, flash and IR drivers.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v5 - No changes - https://patchwork.kernel.org/patch/10391743/
> 
> v4 - Added " " around "=", changed strobe to flash on label, removed "support and
> register" comment and change ir lable to ir:torch - See v2 patchworks for comments
> v3 - Removed wildcard compatible - https://patchwork.kernel.org/patch/10386241/
> v2 - No changes - https://patchwork.kernel.org/patch/10384587/
> 
>   .../devicetree/bindings/leds/leds-lm3601x.txt | 50 +++++++++++++++++++
>   1 file changed, 50 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> new file mode 100644
> index 000000000000..697e5e3a1d4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> @@ -0,0 +1,50 @@
> +* Texas Instruments - lm3601x Single-LED Flash Driver
> +
> +The LM3601X are ultra-small LED flash drivers that
> +provide a high level of adjustability.
> +
> +Required properties:
> +	- compatible : Can be one of the following
> +		"ti,lm36010"
> +		"ti,lm36011"
> +	- reg : I2C slave address
> +	- #address-cells : 1
> +	- #size-cells : 0
> +
> +Required child properties:
> +	- reg : 0 - Indicates a torch interface
> +		1 - Indicates a flash interface
> +		2 - Indicates an infrared interface

You need here also:

- flash-max-microamp : see Documentation/devicetree/bindin
/leds/common.txt
- flash-max-timeout-us : see 
Documentation/devicetree/bindings/leds/common.txt


> +
> +Optional child properties:
> +	- label : see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example:
> +led-controller@64 {
> +	compatible = "ti,lm36010";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	reg = <0x64>;
> +
> +	led@0 {
> +		reg = <0>;
> +		label = "white:torch";
> +		led-max-microamp = <10000>;
> +	};
> +
> +	led@1 {
> +		reg = <1>;
> +		label = "white:flash";
> +		flash-max-microamp = <10000>;
> +		flash-max-timeout-us = <800>;
> +	};
> +
> +	led@2 {
> +		reg = <2>;
> +		label = "ir:torch";
> +	};
> +}
> +
> +For more product information please see the links below:
> +http://www.ti.com/product/LM36010
> +http://www.ti.com/product/LM36011
> 

-- 
Best regards,
Jacek Anaszewski
