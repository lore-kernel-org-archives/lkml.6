Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeCXRX5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752502AbeCXRX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:23:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A072177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 17:23:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/8] dt-bindings: counter: Document stm32 quadrature
 encoder
Message-ID: <20180324172350.18e826f4@archlinux>
In-Reply-To: <7f160c33e6e37c13974054f3dcfea4a02f1250fb.1520614431.git.vilhelm.gray@gmail.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
        <7f160c33e6e37c13974054f3dcfea4a02f1250fb.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 13:43:32 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> From: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Add bindings for STM32 Timer quadrature encoder.
> It is a sub-node of STM32 Timer which implement the
> counter part of the hardware.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
You are missing the device tree list and maintainers +CC

looks fine to me.

Jonathan

> ---
>  .../bindings/counter/stm32-timer-cnt.txt           | 26 ++++++++++++++++++++++
>  .../devicetree/bindings/mfd/stm32-timers.txt       |  7 ++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
> 
> diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
> new file mode 100644
> index 000000000000..377728128bef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
> @@ -0,0 +1,26 @@
> +STMicroelectronics STM32 Timer quadrature encoder
> +
> +STM32 Timer provides quadrature encoder counter mode to detect
> +angular position and direction of rotary elements,
> +from IN1 and IN2 input signals.
> +
> +Must be a sub-node of an STM32 Timer device tree node.
> +See ../mfd/stm32-timers.txt for details about the parent node.
> +
> +Required properties:
> +- compatible:		Must be "st,stm32-timer-counter".
> +- pinctrl-names: 	Set to "default".
> +- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
> +			to set IN1/IN2 pins in mode of operation for Low-Power
> +			Timer input on external pin.
> +
> +Example:
> +	timers@40010000  {
> +		compatible = "st,stm32-timers";
> +		...
> +		counter {
> +			compatible = "st,stm32-timer-counter";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&tim1_in_pins>;
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> index 1db6e0057a63..ff9c14ada30b 100644
> --- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> @@ -23,6 +23,7 @@ Optional parameters:
>  Optional subnodes:
>  - pwm:			See ../pwm/pwm-stm32.txt
>  - timer:		See ../iio/timer/stm32-timer-trigger.txt
> +- counter:		See ../counter/stm32-timer-cnt.txt
>  
>  Example:
>  	timers@40010000 {
> @@ -43,4 +44,10 @@ Example:
>  			compatible = "st,stm32-timer-trigger";
>  			reg = <0>;
>  		};
> +
> +		counter {
> +			compatible = "st,stm32-timer-counter";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&tim1_in_pins>;
> +		};
>  	};
