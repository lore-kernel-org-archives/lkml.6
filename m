Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25D8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C45420862
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C45420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbeGPWnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:43:55 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41754 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbeGPWny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:43:54 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so77807694oiw.8;
        Mon, 16 Jul 2018 15:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WE2K9/ylPD7r0K64VJCVas/ZQVDESs09E/6ptrDzumc=;
        b=TeM9Ad+/xzXB52ayIgddE/do7jcvA2Rs4t9RgNzHFTfg9FYCMlosg5369jNOuEFLC9
         M+xJuF/RyUycPjrdMkG3UqeEb3vkXtF9TPRPziClrPOXWtiCeRgOHW6yv25XAIgKBRGG
         ZhnVIQT8nE2Y2P63uYpu2n8dyg7MNSSgZFL1dcyIYkTOPZMGCLtkrmcqwTVk6sMHgH6a
         0G9IHpt3XSt2D/aCVUDYbIWTGBy2c98jyKu46HMEWYpkTLxTnTl3jPYhCkEAy5BKHLB7
         5F2/eQtn18u0QPXC5gZK7OQK43AFvA5cMoX0l7oVPhdK5+kIE84nxLPcFq/n6O9l3ah9
         /dKA==
X-Gm-Message-State: AOUpUlGi345l7r1tflkkD0sDy0QThFmhSUt9MD9T9S15oOGxAY/9Uoym
        /bRWTRTkGU6dkCVhMMbwCg==
X-Google-Smtp-Source: AAOMgpehma0GSpPoMG0V05kbwDtpHC7Qlr8ghyJrAHmB93UY2aatPgza6QuM4wEYho6lKVYYb9uRRg==
X-Received: by 2002:aca:df55:: with SMTP id w82-v6mr1109996oig.355.1531779269277;
        Mon, 16 Jul 2018 15:14:29 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id t131-v6sm18646198oie.34.2018.07.16.15.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 15:14:28 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:14:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 1/8] dt-bindings: mfd: document stpmu1 pmic
Message-ID: <20180716221427.GA25139@rob-hp-laptop>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
 <1530803657-17684-2-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530803657-17684-2-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 03:14:22PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> stpmu1 is a pmic from STMicroelectronics. The stpmu1 integrates 10
> regulators and 3 switches with various capabilities.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>  .../devicetree/bindings/mfd/st,stpmu1.txt          | 138 +++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmu1.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmu1.txt b/Documentation/devicetree/bindings/mfd/st,stpmu1.txt
> new file mode 100644
> index 0000000..53bdab4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stpmu1.txt
> @@ -0,0 +1,138 @@
> +* STMicroelectronics STPMU1 Power Management IC
> +
> +Required parent device properties:
> +- compatible: "st,stpmu1"
> +- reg: the I2C slave address for the stpmu1 chip
> +- interrupts-extended: interrupt lines to use: second irq is for wakeup.
> +- #interrupt-cells: should be 2.
> +- interrupt-controller: describes the STPMU1 as an interrupt
> +  controller (has its own domain). interrupt number are the following:
> +	/* Interrupt Register 1 (0x50 for latch) */
> +	IT_SWOUT_R=0
> +	IT_SWOUT_F=1
> +	IT_VBUS_OTG_R=2
> +	IT_VBUS_OTG_F=3
> +	IT_WAKEUP_R=4
> +	IT_WAKEUP_F=5
> +	IT_PONKEY_R=6
> +	IT_PONKEY_F=7
> +	/* Interrupt Register 2 (0x51 for latch) */
> +	IT_OVP_BOOST=8
> +	IT_OCP_BOOST=9
> +	IT_OCP_SWOUT=10
> +	IT_OCP_OTG=11
> +	IT_CURLIM_BUCK4=12
> +	IT_CURLIM_BUCK3=13
> +	IT_CURLIM_BUCK2=14
> +	IT_CURLIM_BUCK1=15
> +	/* Interrupt Register 3 (0x52 for latch) */
> +	IT_SHORT_SWOUT=16
> +	IT_SHORT_SWOTG=17
> +	IT_CURLIM_LDO6=18
> +	IT_CURLIM_LDO5=19
> +	IT_CURLIM_LDO4=20
> +	IT_CURLIM_LDO3=21
> +	IT_CURLIM_LDO2=22
> +	IT_CURLIM_LDO1=23
> +	/* Interrupt Register 3 (0x52 for latch) */
> +	IT_SWIN_R=24
> +	IT_SWIN_F=25
> +	IT_RESERVED_1=26
> +	IT_RESERVED_2=27
> +	IT_VINLOW_R=28
> +	IT_VINLOW_F=29
> +	IT_TWARN_R=30
> +	IT_TWARN_F=31
> +
> +Optional parent device properties:
> +- st,main_control_register:

s/_/-/

And elsewhere...

> +	-bit 1: Power cycling will be performed on turn OFF condition
> +	-bit 2: PWRCTRL is functional
> +	-bit 3: PWRCTRL active high
> +- st,pads_pull_register:
> +	-bit 1: WAKEUP pull down is not active
> +	-bit 2: PWRCTRL pull up is active
> +	-bit 3: PWRCTRL pull down is active
> +	-bit 4: WAKEUP detector is disabled
> +- st,vin_control_register:
> +	-bit 0: VINLOW monitoring is enabled
> +	-bit [1...3]: VINLOW rising threshold
> +		000 VINOK_f + 50mV
> +		001 VINOK_f + 100mV
> +		010 VINOK_f + 150mV
> +		011 VINOK_f + 200mV
> +		100 VINOK_f + 250mV
> +		101 VINOK_f + 300mV
> +		110 VINOK_f + 350mV
> +		111 VINOK_f + 400mV
> +	-bit [4...5]: VINLOW hyst
> +		00 100mV
> +		01 200mV
> +		10 300mV
> +		11 400mV
> +	-bit 6: SW_OUT detector is disabled
> +	-bit 7: SW_IN detector is enabled.
> +- st,usb_control_register:
> +	-bit 3: SW_OUT current limit
> +		0: 600mA
> +		1: 1.1A
> +	-bit 4: VBUS_OTG discharge is enabled
> +	-bit 5: SW_OUT discharge is enabled
> +	-bit 6: VBUS_OTG detection is enabled
> +	-bit 7: BOOST_OVP is disabled

Just dumping register values into DT is not the greatest design.

> +
> +
> +stpmu1 consists is a varied group of sub-devices:
> +
> +Device			 Description
> +------			------------
> +stpmu1-onkey		: On key
> +stpmu1-regulators	: Regulators
> +stpmu1-wdt		: Watchdog

These should match the node name below.

> +
> +each sub-device bindings is be described in associated driver
> +documentation section.
> +
> +Example:
> +
> +pmic: stpmu1@33 {
> +	compatible = "st,stpmu1";
> +	reg = <0x33>;
> +	interrupts = <0 2>;
> +	interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_NONE>,
> +			      <&exti 55 1>;
> +	st,version_status = <0x10>;
> +	st,main_control_register=<0x0c>;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	onkey {
> +		compatible = "st,stpmu1-onkey";
> +		interrupt-parent = <&pmic>;
> +		interrupts = <7 0>,<6 1>;

> +		st,onkey-pwroff-enabled;
> +		st,onkey-press-seconds = <10>;

IIRC, we have some standard properties for these.

> +	};
> +
> +	watchdog {
> +		compatible = "st,stpmu1-wdt";
> +	};
> +
> +	regulators {
> +		compatible = "st,stpmu1-regulators";
> +
> +		vdd_core: regulator@0 {

unit-address without reg is not valid. regulator-buck1, etc. instead.

> +			regulator-compatible = "buck1";
> +			regulator-name = "vdd_core";
> +			regulator-boot-on;
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +		vdd: regulator@1 {
> +			regulator-compatible = "buck3";
> +			regulator-name = "vdd";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +			regulator-pull-down;
> +		};
> +	};
> -- 
> 1.9.1
