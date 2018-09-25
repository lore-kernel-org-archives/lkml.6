Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3659CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA5320896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA5320896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeIZDaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:30:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38959 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeIZDaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:30:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id y81-v6so2753572oia.6;
        Tue, 25 Sep 2018 14:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWhHYF8aBctzfo/9JxYnoX+0+jYVCX5mvwfHFk88czA=;
        b=esSXmyAhJlzymxxcSIFG+0yLy/UTLS3NHn6LX7bltIy1zzTTxFEWdkh+5XwxbGySXr
         Ci5ax9LElor3Q6vKHSTFPwN2XyeULVyjs8DDOQKyuSatVcNzLREX2werX0GRXM1eL8wK
         BgLH2Aty4je1hI5hyq5eJfPaHQOmreqZjy+6FMX70B31HbjSHAhXIN0Y/tpiMHZoFAyq
         oQcI6WCppYtphcC83wLZNui43/9D4l67g1FjuBhn8L8bTCcNf4bx4Fg6STSAwpz/HpRP
         bHm1pAdittjkLYo2sBB0P8Apm/cXwLbBC7ckNLTNo99B41ZpYdPgsl1cfpP3l3KqXkCO
         ZGNg==
X-Gm-Message-State: ABuFfohGsChy8ZlYuwevBH443EQWs26xafOPNrmnewmv6fLm2z2vwPZo
        PpVMyodGhVW/gsUEyL/NtQ==
X-Google-Smtp-Source: ACcGV63Utt2tTVZRB3rkqmsCSbua6oEMql6IIO0gvEXITFq6uJEHnIGmH5hHr1XUqpXW9DM4z3swrQ==
X-Received: by 2002:aca:b885:: with SMTP id i127-v6mr27855oif.180.1537910481043;
        Tue, 25 Sep 2018 14:21:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i9-v6sm1301815ota.12.2018.09.25.14.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:21:20 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:21:19 -0500
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
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH V2 1/8] dt-bindings: mfd: document stpmic1
Message-ID: <20180925212119.GA12776@bogus>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-2-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536325173-16617-2-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:59:43PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> stpmic1 is a pmic from STMicroelectronics. The stpmic1 integrates 10
> regulators and 3 switches with various capabilities.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v2:
> * the hardware component has been renamed from stpmu1 to stpmic1 !
> * replace _ with - in properties name
> * fix node names in example
> * remove regulator compatibles in example
> * add st,stpmic1.h to the patch
> 
> Rob, I did not change the usage of the properties because it would lead to a lot
> of st properties; for example st,main-control-register would be replaced by:
>   st,power_cycling_on_turn_off
>   st,pwrctrl_enabled
>   st,pwrctrl_active_high
> should I go this way ?

I guess it is fine as-is.

> Rob, I did not found the standard property for st,onkey-press-seconds = <10>;

From input/keys.txt:

Optional properties for Keys:
- power-off-time-sec: Duration in seconds which the key should be kept
        pressed for device to power off automatically. Device with key 
pressed
        shutdown feature can specify this property.

> 
>  .../devicetree/bindings/mfd/st,stpmic1.txt         | 137 +++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmic1.h               |  46 +++++++
>  2 files changed, 183 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
>  create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.txt b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
> new file mode 100644
> index 0000000..9f2c516
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
> @@ -0,0 +1,137 @@
> +* STMicroelectronics STPMIC1 Power Management IC
> +
> +Required parent device properties:
> +- compatible: "st,stpmic1"
> +- reg: the I2C slave address for the stpmic1 chip
> +- interrupts-extended: interrupt lines to use: second irq is for wakeup.

Just use 'interrupts' here. Support for interrupts-extended is implied.

> +- #interrupt-cells: should be 2.
> +- interrupt-controller: describes the STPMIC1 as an interrupt
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
> +- st,main-control-register:
> +	-bit 1: Power cycling will be performed on turn OFF condition
> +	-bit 2: PWRCTRL is functional
> +	-bit 3: PWRCTRL active high
> +- st,pads-pull-register:
> +	-bit 1: WAKEUP pull down is not active
> +	-bit 2: PWRCTRL pull up is active
> +	-bit 3: PWRCTRL pull down is active
> +	-bit 4: WAKEUP detector is disabled
> +- st,vin-control-register:
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
> +- st,usb-control-register:
> +	-bit 3: SW_OUT current limit
> +		0: 600mA
> +		1: 1.1A
> +	-bit 4: VBUS_OTG discharge is enabled
> +	-bit 5: SW_OUT discharge is enabled
> +	-bit 6: VBUS_OTG detection is enabled
> +	-bit 7: BOOST_OVP is disabled
> +
> +
> +stpmic1 consists is a varied group of sub-devices:
> +
> +Device			 Description
> +------			------------
> +st,stpmic1-onkey		: On key
> +st,stpmic1-regulators	: Regulators
> +st,stpmic1-wdt		: Watchdog
> +
> +each sub-device bindings is be described in associated driver
> +documentation section.
> +
> +Example:
> +
> +pmic: stpmic1@33 {

pmic@33

> +	compatible = "st,stpmic1";
> +	reg = <0x33>;
> +	interrupts = <0 2>;
> +	interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_NONE>,
> +			      <&exti 55 1>;
> +	st,version_status = <0x10>;
> +	st,main-control-register=<0x0c>;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	onkey {
> +		compatible = "st,stpmic1-onkey";
> +		interrupt-parent = <&pmic>;
> +		interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
> +		interrupt-names = "onkey-falling", "onkey-rising";
> +		st,onkey-pwroff-enabled;
> +		st,onkey-long-press-seconds = <10>;
> +	};
> +
> +	watchdog {
> +		compatible = "st,stpmic1-wdt";
> +	};
> +
> +	regulators {
> +		compatible = "st,stpmic1-regulators";
> +
> +		vdd_core: buck1 {
> +			regulator-name = "vdd_core";
> +			regulator-boot-on;
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +		vdd: buck3 {
> +			regulator-name = "vdd";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +			regulator-pull-down;
> +		};
> +	};
> diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindings/mfd/st,stpmic1.h
> new file mode 100644
> index 0000000..e32ac8f
> --- /dev/null
> +++ b/include/dt-bindings/mfd/st,stpmic1.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
> + * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> + * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
> + */
> +
> +#ifndef __DT_BINDINGS_STPMIC1_H__
> +#define __DT_BINDINGS_STPMIC1_H__
> +
> +/* IRQ definitions */
> +#define IT_PONKEY_F 0
> +#define IT_PONKEY_R 1
> +#define IT_WAKEUP_F 2
> +#define IT_WAKEUP_R 3
> +#define IT_VBUS_OTG_F 4
> +#define IT_VBUS_OTG_R 5
> +#define IT_SWOUT_F 6
> +#define IT_SWOUT_R 7
> +
> +#define IT_CURLIM_BUCK1 8
> +#define IT_CURLIM_BUCK2 9
> +#define IT_CURLIM_BUCK3 10
> +#define IT_CURLIM_BUCK4 11
> +#define IT_OCP_OTG 12
> +#define IT_OCP_SWOUT 13
> +#define IT_OCP_BOOST 14
> +#define IT_OVP_BOOST 15
> +
> +#define IT_CURLIM_LDO1 16
> +#define IT_CURLIM_LDO2 17
> +#define IT_CURLIM_LDO3 18
> +#define IT_CURLIM_LDO4 19
> +#define IT_CURLIM_LDO5 20
> +#define IT_CURLIM_LDO6 21
> +#define IT_SHORT_SWOTG 22
> +#define IT_SHORT_SWOUT 23
> +
> +#define IT_TWARN_F 24
> +#define IT_TWARN_R 25
> +#define IT_VINLOW_F 26
> +#define IT_VINLOW_R 27
> +#define IT_SWIN_F 30
> +#define IT_SWIN_R 31
> +
> +#endif /* __DT_BINDINGS_STPMIC1_H__ */
> -- 
> 1.9.1
