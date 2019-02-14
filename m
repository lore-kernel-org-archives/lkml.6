Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C92C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1C1222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="wP5jmQEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392276AbfBNO6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:58:36 -0500
Received: from node.akkea.ca ([192.155.83.177]:54422 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfBNO6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:58:36 -0500
Received: by node.akkea.ca (Postfix, from userid 33)
        id 2DD314E204B; Thu, 14 Feb 2019 14:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1550156315; bh=lWkxbbLD3ALNJoMMzjDuWcjI06MQbG+Pg48J1Mker34=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=wP5jmQECSOQu8qyhJyo/Go5fivB4ciiHsasPLTjB0QWnyBe2/CtPWEuXS6ptnKBdE
         35jvLtP+k4cXN7ZBhIuekUSm+NSxH3fcUr/RRv+wTfiWxirDksUok48X+2052zmppQ
         AsedioKR391VKmbP9tKhtXmLK7gSh5sABidgfaqo=
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v3 1/3] devicetree: bindings: bd718x7: document HW state  related ROHM specific properties
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Feb 2019 06:58:35 -0800
From:   Angus Ainslie <angus@akkea.ca>
Cc:     mazzisaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        linux-kernel-owner@vger.kernel.org
In-Reply-To: <6ed4238fb083f52de0f5f013647b2334bad8ebe4.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
 <6ed4238fb083f52de0f5f013647b2334bad8ebe4.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <b5d87fef13b16e8b5da8bd88958c6d74@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-14 01:34, Matti Vaittinen wrote:
> Add ROHM BD71837 / BD71847 specific device tree bindings for
> controlling the PMIC shutdown/reset states and voltages for
> different HW states. The PMIC was designed to be used with NXP
> i.MX8 SoC and it supports SNVS low power state which seems to
> be typical for NXP i.MX SoCs. However, when SNVS is used we must
> not allow SW to control enabling/disabling those regulators which
> are crucial for system to boot as there is a HW limitation which
> causes SW controlled regulators to be kept shut down after SNVS
> reset.
> 
> Allow setting the SNVS to be used as reset target state and allow
> marking those regulators which are critical for boot.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

One small nit below

Tested-by: Angus Ainslie <angus@akkea.ca>
Reviewed-by: Angus Ainslie <angus@akkea.ca>

> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 17 ++++++++++
>  .../bindings/regulator/rohm,bd71837-regulator.txt  | 38 
> ++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> index a4b056761eaa..d5f68ac78d15 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> @@ -23,6 +23,20 @@ Required properties:
> 
>  Optional properties:
>  - clock-output-names	: Should contain name for output clock.
> +- rohm,reset-snvs-powered : Transfer BD718x7 to SNVS state at reset.
> +
> +The BD718x7 supports two different HW states as reset target states. 
> States
> +are called as SNVS and READY. At READY state all the PMIC power 
> outputs go
> +down and OTP is reload. At the SNVS state all other logic and external
> +devices apart from the SNVS power domain are shut off. Please refer to 
> NXP
> +i.MX8 documentation for further information regarding SNVS state. When 
> a
> +reset is done via SNVS state the PMIC OTP data is not reload. This 
> causes

Typo s/reload/reloaded/

> +power outputs that have been under SW control to stay down when reset 
> has
> +switched power state to SNVS. If reset is done via READY state the 
> power
> +outputs will be returned to HW control by OTP loading. Thus the reset
> +target state is set to READY by default. If SNVS state is used the 
> boot
> +crucial regulators must have the regulator-always-on and 
> regulator-boot-on
> +properties set in regulator node.
> 
>  Example:
> 
> @@ -43,6 +57,7 @@ Example:
>  		#clock-cells = <0>;
>  		clocks = <&osc 0>;
>  		clock-output-names = "bd71837-32k-out";
> +		rohm,reset-snvs-powered;
> 
>  		regulators {
>  			buck1: BUCK1 {
> @@ -50,8 +65,10 @@ Example:
>  				regulator-min-microvolt = <700000>;
>  				regulator-max-microvolt = <1300000>;
>  				regulator-boot-on;
> +				regulator-always-on;
>  				regulator-ramp-delay = <1250>;
>  			};
> +			// [...]
>  		};
>  	};
> 
> diff --git
> a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> index 4b98ca26e61a..cbce62c22b60 100644
> --- 
> a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> +++ 
> b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> @@ -27,8 +27,38 @@ BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6
>  LDO1, LDO2, LDO3, LDO4, LDO5, LDO6
> 
>  Optional properties:
> +- rohm,dvs-run-voltage		: PMIC default "RUN" state voltage in uV.
> +				  See below table for bucks which support this.
> +- rohm,dvs-idle-voltage		: PMIC default "IDLE" state voltage in uV.
> +				  See below table for bucks which support this.
> +- rohm,dvs-suspend-voltage	: PMIC default "SUSPEND" state voltage in 
> uV.
> +				  See below table for bucks which support this.
>  - Any optional property defined in bindings/regulator/regulator.txt
> 
> +Supported default DVS states:
> +
> +BD71837:
> +buck	| dvs-run-voltage	| dvs-idle-voltage	| dvs-suspend-voltage
> +-----------------------------------------------------------------------------
> +1	| supported		| supported		| supported
> +----------------------------------------------------------------------------
> +2	| supported		| supported		| not supported
> +----------------------------------------------------------------------------
> +3	| supported		| not supported		| not supported
> +----------------------------------------------------------------------------
> +4	| supported		| not supported		| not supported
> +----------------------------------------------------------------------------
> +rest	| not supported		| not supported		| not supported
> +
> +BD71847:
> +buck	| dvs-run-voltage	| dvs-idle-voltage	| dvs-suspend-voltage
> +-----------------------------------------------------------------------------
> +1	| supported		| supported		| supported
> +----------------------------------------------------------------------------
> +2	| supported		| supported		| not supported
> +----------------------------------------------------------------------------
> +rest	| not supported		| not supported		| not supported
> +
>  Example:
>  regulators {
>  	buck1: BUCK1 {
> @@ -36,7 +66,11 @@ regulators {
>  		regulator-min-microvolt = <700000>;
>  		regulator-max-microvolt = <1300000>;
>  		regulator-boot-on;
> +		regulator-always-on;
>  		regulator-ramp-delay = <1250>;
> +		rohm,dvs-run-voltage = <900000>;
> +		rohm,dvs-idle-voltage = <850000>;
> +		rohm,dvs-suspend-voltage = <800000>;
>  	};
>  	buck2: BUCK2 {
>  		regulator-name = "buck2";
> @@ -45,18 +79,22 @@ regulators {
>  		regulator-boot-on;
>  		regulator-always-on;
>  		regulator-ramp-delay = <1250>;
> +		rohm,dvs-run-voltage = <1000000>;
> +		rohm,dvs-idle-voltage = <900000>;
>  	};
>  	buck3: BUCK3 {
>  		regulator-name = "buck3";
>  		regulator-min-microvolt = <700000>;
>  		regulator-max-microvolt = <1300000>;
>  		regulator-boot-on;
> +		rohm,dvs-run-voltage = <1000000>;
>  	};
>  	buck4: BUCK4 {
>  		regulator-name = "buck4";
>  		regulator-min-microvolt = <700000>;
>  		regulator-max-microvolt = <1300000>;
>  		regulator-boot-on;
> +		rohm,dvs-run-voltage = <1000000>;
>  	};
>  	buck5: BUCK5 {
>  		regulator-name = "buck5";
> --
> 2.14.3

