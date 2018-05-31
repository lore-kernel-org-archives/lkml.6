Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeEaDEm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:04:42 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34101 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932643AbeEaDEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:04:39 -0400
X-Google-Smtp-Source: ADUXVKKd2ZcsyNLCU+iGqnkCu7PV/90pCxPF99sbMjQmGWOTClQ+wJ+JwPKOBBADHD05koCPm2i2HQ==
Date: Wed, 30 May 2018 22:04:36 -0500
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 3/6] regulator: bd71837: Devicetree bindings for
 BD71837 regulators
Message-ID: <20180531030436.GB16122@rob-hp-laptop>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <318229ca7ffcceb090fc8d0c43f887decc3082f0.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <318229ca7ffcceb090fc8d0c43f887decc3082f0.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:42:32AM +0300, Matti Vaittinen wrote:
> Document devicetree bindings for ROHM BD71837 PMIC regulators.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../bindings/regulator/rohm,bd71837-regulator.txt  | 126 +++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> new file mode 100644
> index 000000000000..4edf3137d9f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> @@ -0,0 +1,126 @@
> +ROHM BD71837 Power Management Integrated Circuit (PMIC) regulator bindings
> +
> +BD71837MWV is a programmable Power Management
> +IC (PMIC) for powering single-core, dual-core, and
> +quad-core SoC’s such as NXP-i.MX 8M. It is optimized
> +for low BOM cost and compact solution footprint. It
> +integrates 8 Buck regulators and 7 LDO’s to provide all
> +the power rails required by the SoC and the commonly
> +used peripherals.

Why duplicate this from the core binding?

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>


> +
> +Required properties:
> + - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7"
> +
> +List of regulators provided by this controller. BD71837 regulators node
> +should be sub node of the BD71837 MFD node. See BD71837 MFD bindings at
> +Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> +Regulator nodes should be named to BUCK_<number> and LDO_<number>. The
> +definition for each of these nodes is defined using the standard
> +binding for regulators at
> +Documentation/devicetree/bindings/regulator/regulator.txt.
> +Note that if BD71837 starts at RUN state you probably want to use
> +regulator-boot-on at least for BUCK6 and BUCK7 so that those are not
> +disabled by driver at startup. LDO5 and LDO6 are supplied by those and
> +if they are disabled at startup the voltage monitoring for LDO5/LDO6 will
> +cause PMIC to reset.
> +
> +The valid names for regulator nodes are:
> +BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, BUCK7, BUCK8
> +LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7
> +
> +Optional properties:
> +- Any optional property defined in bindings/regulator/regulator.txt
> +
> +Example:
> +regulators {
> +	buck1: BUCK1 {
> +		regulator-name = "buck1";
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1300000>;
> +		regulator-boot-on;
> +		regulator-ramp-delay = <1250>;
> +	};
> +	buck2: BUCK2 {
> +		regulator-name = "buck2";
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-ramp-delay = <1250>;
> +	};
> +	buck3: BUCK3 {
> +		regulator-name = "buck3";
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1300000>;
> +		regulator-boot-on;
> +	};
> +	buck4: BUCK4 {
> +		regulator-name = "buck4";
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1300000>;
> +		regulator-boot-on;
> +	};
> +	buck5: BUCK5 {
> +		regulator-name = "buck5";
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1350000>;
> +		regulator-boot-on;
> +	};
> +	buck6: BUCK6 {
> +		regulator-name = "buck6";
> +		regulator-min-microvolt = <3000000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +	};
> +	buck7: BUCK7 {
> +		regulator-name = "buck7";
> +		regulator-min-microvolt = <1605000>;
> +		regulator-max-microvolt = <1995000>;
> +		regulator-boot-on;
> +	};
> +	buck8: BUCK8 {
> +		regulator-name = "buck8";
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1400000>;
> +	};
> +
> +	ldo1: LDO1 {
> +		regulator-name = "ldo1";
> +		regulator-min-microvolt = <3000000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +	};
> +	ldo2: LDO2 {
> +		regulator-name = "ldo2";
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		regulator-boot-on;
> +	};
> +	ldo3: LDO3 {
> +		regulator-name = "ldo3";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +	ldo4: LDO4 {
> +		regulator-name = "ldo4";
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +	ldo5: LDO5 {
> +		regulator-name = "ldo5";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +	ldo6: LDO6 {
> +		regulator-name = "ldo6";
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +	ldo7_reg: LDO7 {
> +		regulator-name = "ldo7";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +};
> +
> +
> -- 
> 2.14.3
> 
