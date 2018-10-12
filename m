Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797F9C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4047B20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4047B20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbeJLXBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:01:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33293 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbeJLXBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:01:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id q50so12766729otd.0;
        Fri, 12 Oct 2018 08:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8/oXfm4U4O5Q4D7SMrlhdRCPvXW5k29rhKFyDiIDFco=;
        b=dzYVflrYUzhevzOfVhdylnQiTrxCOYQ7/rVjo60ae9kwF1y7phAQnfcNQUd3lGMOLv
         S44j5IzNtJ4aoQejepWst3NEU+G9gmVKD4WWmUdSzfL8/XcrDAJoGmJ91u/LbkBbltoF
         FxeZffJFkhU4xjCkPup+32OPNbSDXG6iyRjmuNEUWNot/y3qHDimfhR/ZoNudl786c4k
         xXzig2mSS4H+Gwhsdik2Sldj0eeJmbrzeSiHMSIg0N6YrXvNrepWoHUjdCScHxW35j3Z
         HyD5C7clJWV5fqOIQG6DmDn7BAa08xMvX4T7S20imd7r12w5cCuwyMZM+baHSUV+MS+T
         cy+Q==
X-Gm-Message-State: ABuFfojJE16uUJWFYtxep54GzYY1IQFdeLGklGlosnsbV+1HGRO7sCXv
        bZ/6QhEO/ctB7ZfIljteNA==
X-Google-Smtp-Source: ACcGV62B8ZBDqfk2mw04ZqpUL7J248DmBkBU1rSRxLmee0bzJ9WYxyccYN9YAOYwc1fAgtRf9IpTtg==
X-Received: by 2002:a9d:60d8:: with SMTP id b24mr3809256otk.157.1539358130189;
        Fri, 12 Oct 2018 08:28:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j83-v6sm388736oih.18.2018.10.12.08.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 08:28:49 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:28:48 -0500
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
Subject: Re: [PATCH v3 1/8] dt-bindings: mfd: document stpmic1
Message-ID: <20181012152848.GA13024@bogus>
References: <1539016176-4072-1-git-send-email-p.paillet@st.com>
 <1539016176-4072-2-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539016176-4072-2-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:29:39PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
> regulators ,3 switches, a watchdog and an input for a power on key.

regulators, 3 switches, ...

> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v3:
> * Replace st,onkey-long-press-seconds by power-off-time-sec.
> * Replace interrupts-extended by  interrupts.
> * Remove wakeup interrupt.
> * Cosmetics.
> 
>  .../devicetree/bindings/mfd/st,stpmic1.txt         | 133 +++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmic1.h               |  46 +++++++
>  2 files changed, 179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
>  create mode 100644 include/dt-bindings/mfd/st,stpmic1.h

A few nits, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.txt b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
> new file mode 100644
> index 0000000..989bd58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
> @@ -0,0 +1,133 @@
> +* STMicroelectronics STPMIC1 Power Management IC
> +
> +Required parent device properties:
> +- compatible: 		"st,stpmic1"
> +- reg: 			The I2C slave address for the STPMIC1 chip.

space before tabs

> +- interrupt-parent	Phandle to the parent interrupt controller.

Drop this. It could be in the parent.

> +- interrupts: 		The interrupt line the device is connected to.
> +- #interrupt-cells: 	Should be 1.

more space before tabs.

> +- interrupt-controller: Describes the STPMIC1 as an interrupt
> +  controller (has its own domain). Interrupt number are the following:
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
> +STPMIC1 consists in a varied group of sub-devices.
> +Each sub-device binding is be described in own documentation file.
> +
> +Device			 Description
> +------			------------
> +st,stpmic1-onkey	: Power on key, see ../input/st,stpmic1-onkey.txt
> +st,stpmic1-regulators	: Regulators, see ../regulator/st,stpmic1-regulator.txt
> +st,stpmic1-wdt		: Watchdog, see ../watchdog/st,stpmic1-wdt.txt
> +
> +Example:
> +
> +pmic: pmic1@33 {

pmic@33

> +	compatible = "st,stpmic1";
> +	reg = <0x33>;
> +	interrupt-parent = <&gpioa>;
> +	interrupts = <0 2>;
> +	st,main-control-register=<0x0c>;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +
> +	onkey {
> +		compatible = "st,stpmic1-onkey";
> +		interrupt-parent = <&pmic>;

Not needed because the parent is the interrupt controller.

> +		interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
> +		interrupt-names = "onkey-falling", "onkey-rising";
> +		power-off-time-sec = <10>;
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
> index 0000000..b2d6c83
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
> +#define IT_PONKEY_F	0
> +#define IT_PONKEY_R	1
> +#define IT_WAKEUP_F	2
> +#define IT_WAKEUP_R	3
> +#define IT_VBUS_OTG_F	4
> +#define IT_VBUS_OTG_R	5
> +#define IT_SWOUT_F	6
> +#define IT_SWOUT_R	7
> +
> +#define IT_CURLIM_BUCK1	8
> +#define IT_CURLIM_BUCK2	9
> +#define IT_CURLIM_BUCK3	10
> +#define IT_CURLIM_BUCK4	11
> +#define IT_OCP_OTG	12
> +#define IT_OCP_SWOUT	13
> +#define IT_OCP_BOOST	14
> +#define IT_OVP_BOOST	15
> +
> +#define IT_CURLIM_LDO1	16
> +#define IT_CURLIM_LDO2	17
> +#define IT_CURLIM_LDO3	18
> +#define IT_CURLIM_LDO4	19
> +#define IT_CURLIM_LDO5	20
> +#define IT_CURLIM_LDO6	21
> +#define IT_SHORT_SWOTG	22
> +#define IT_SHORT_SWOUT	23
> +
> +#define IT_TWARN_F	24
> +#define IT_TWARN_R	25
> +#define IT_VINLOW_F	26
> +#define IT_VINLOW_R	27
> +#define IT_SWIN_F	30
> +#define IT_SWIN_R	31
> +
> +#endif /* __DT_BINDINGS_STPMIC1_H__ */
> -- 
> 1.9.1
