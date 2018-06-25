Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C1CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFC025EDC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFC025EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934147AbeFYROW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:14:22 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:42141 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933724AbeFYROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:14:21 -0400
Received: by mail-yb0-f193.google.com with SMTP id i3-v6so2299519ybl.9;
        Mon, 25 Jun 2018 10:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fvxTVPkzNMJwYAatf+uyjoCL6mvNftGw4nTrPI9R1Sc=;
        b=gnS0wutkf3bcsjLnnuRcWeWEasipnAAX+xeU9deeXQV8tDh7vM9RGV2NBgNQr4Nlif
         8C90vPubIaW6o7PMMaOlSGa/RNxNC/mOU8UcYV4IHH6FTEmD1cJ6WmgwtSOgxJEBJwD5
         tFFu+9lSRX/UD61DOtDHQSJUAUTnmHEo0JWgVC356g1RNgFo8Zjdm/eaxaIjF8oejyK8
         SNT8CE9S7wnJhvMnhsKwL+x2dEOWb+uuY673xSKfsBBb1jtsO0Z37+Au5Bav6Vz9bADt
         7uQVzqtK3ze/sXRlHe4irC53cY96Gdp1O778l6AQM65Q4xLjEgYwlPqhBSvLcB2bor8G
         So7w==
X-Gm-Message-State: APt69E1VgjG0NO5C20uLd5Nu6fUd7yXHCLK6iNCIU2C51whI5LxqrKjY
        qPAI3d6sPmTEPn6KVnYKTA==
X-Google-Smtp-Source: ADUXVKL9AfvCtzVbfrfnRec9LOc8yFD3ObKckalXicUodEYlVYCUjv4RUjPHVRkkG1qG6Wq4UZUhVw==
X-Received: by 2002:a25:408c:: with SMTP id n134-v6mr6908002yba.304.1529946860077;
        Mon, 25 Jun 2018 10:14:20 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 137-v6sm5272104yws.24.2018.06.25.10.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:14:19 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:14:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     mark.rutland@arm.com, jdelvare@suse.com, linux@roeck-us.net,
        avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] dt-binding: hwmon: Add NPCM7xx PWM and Fan
 controller documentation
Message-ID: <20180625171417.GA16379@rob-hp-laptop>
References: <20180624124155.82412-1-tmaimon77@gmail.com>
 <20180624124155.82412-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624124155.82412-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 03:41:54PM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM7xx Pulse Width Modulation (PWM)  and Fan tach controller.
> The PWM controller can support upto 8 PWM output ports.
> The Fan tach controller can support upto 16 tachometer inputs.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/npcm750-pwm-fan.txt  | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
> new file mode 100644
> index 000000000000..a9eacda34f92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
> @@ -0,0 +1,84 @@
> +Nuvoton NPCM7xx PWM and Fan Tacho controller device driver

Bindings are for h/w, not drivers.

> +
> +The NPCM7xx has two identical Pulse-width modulation (PWM) controller modules,
> +Each PWM module has four PWM controller outputs, Totally 8 PWM controller outputs.
> +
> +The NPCM7xx has eight identical Fan tachometer controller modules,
> +Each Fan module has two Fan controller inputs, Totally 16 Fan controller inputs.

Have you looked at other fan ctrlr bindings?f This looks like similar 
h/w to ASpeed. Really, I'd like to see a common doc that describes the 
structure and common properties.

> +
> +Required properties for pwm-fan node:
> +- compatible	: "nuvoton,npcm750-pwm-fan" for Poleg NPCM7XX.
> +- reg 			: specifies physical base address and size of the registers.
> +- reg-names 	: must contain:
> +					* "pwm-base" for the PWM registers.
> + 					* "fan-base" for the Fan registers.

'-base' is redundant. And your example doesn't match.

> +- clocks		: phandle of reference clocks.
> +- clock-names	: must contain
> +					* "clk_apb3" for clock of PWM controller.
> + 					* "clk_apb4" for clock of Fan controller.
> +- interrupts	: contain the Fan interrupts with flags for falling edge.
> +- pinctrl-names	: a pinctrl state named "default" must be defined.
> +- pinctrl-0 	: phandle referencing pin configuration of the PWM and Fan
> +					controller ports.
> +
> +pwm subnode format:
> +===================
> +Under pwm subnode can be upto 8 child nodes, each child node representing a PWM channel.
> +Each pwm subnode must have one PWM channel and atleast one Fan tach channel.
> +
> +For PWM channel can be configured cooling-levels to create cooling device.
> +Cooling device could be bound to a thermal zone for the thermal control.
> +
> +Required properties for each child node:
> +- pwm-ch : specify the PWM output channel.
> +			integer value in the range 0 through 7, that represent
> +			the PWM channel number that used.
> +
> +- fan-ch : specify the Fan input channel.
> +			integer value in the range 0 through 15, that represent
> +			the Fan channel number that used.

This is really the tach channel.


> +
> +			At least one Fan tach input channel is required
> +
> +Optional property for each child node:
> +- cooling-levels: PWM duty cycle values in a range from 0 to 255
> +                  which correspond to thermal cooling states.
> +
> +Examples:
> +
> +pwm_fan:pwm_fan_controller@103000 {

fan-controller@...

> +	compatible = "nuvoton,npcm750-pwm-fan";
> +	reg = <0x103000 0x2000>,
> +		<0x180000 0x8000>;
> +	reg-names = "pwm_base", "fan_base";
> +	clocks = <&clk NPCM7XX_CLK_APB3>,
> +		<&clk NPCM7XX_CLK_APB4>;
> +	clock-names = "clk_apb3","clk_apb4";
> +	interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm0_pins &pwm1_pins &pwm2_pins
> +			&fanin0_pins &fanin1_pins &fanin2_pins
> +			&fanin3_pins &fanin4_pins>;
> +
> +			pwm@0 {

The sub-nodes should be "fan" nodes.

A unit-address without reg property is not valid.

> +				pwm-ch = /bits/ 8 <0x00>;

Use 'reg' like ASpeed binding. 

> +				fan-ch = /bits/ 8 <0x00 0x01>;
> +				cooling-levels = <127 255>;
> +				};
> +			pwm@1 {
> +				pwm-ch = /bits/ 8 <0x01>;
> +				fan-ch = /bits/ 8 <0x02 0x03>;
> +				};
> +			pwm@2 {
> +				pwm-ch = /bits/ 8 <0x02>;
> +				fan-ch = /bits/ 8 <0x04>;
> +				};
> +
> +};
> \ No newline at end of file

^^^

> -- 
> 2.14.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
