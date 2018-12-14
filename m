Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC52C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9F62080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="K/aCcjO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9F62080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeLNIIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:08:25 -0500
Received: from plaes.org ([188.166.43.21]:44280 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeLNIIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:08:25 -0500
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id D2D804075E;
        Fri, 14 Dec 2018 08:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1544774901; bh=xYiQpmb73TltdiGYN4gbmub6f1BA2IVHlcJOUl413ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/aCcjO1cx6lx7rg9+2vgzyI8N1K/gwY7g4a9AOv4M1Rb2u5eHGH6EFYDci5Q8vmq
         P+ZThOwCStWzNsoxFBF1qnnT0zNSmdZaLofJboIF7JgvzjWW9jqnMBw5DfGC89g67u
         Jk79lYTF7Wm6ii6RzUy6ZAGH64kXi8OQ1IrPt822qQYFs2x/Qe+epl8krwssISBInA
         tPxrZQ77MTVn8gmkhbEXNejYh/83ms3lkin2z2R7cMDkmkKYp+HVMmb/TCuIeOBMKG
         qq2rsBMaA9QrUIxvf+vYm9nMfQk64OWixJtsR+7HgzrQdDN/pfAlKwF1iGXEDEq+yH
         FiSWTrjTPo+sg==
Date:   Fri, 14 Dec 2018 08:08:20 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Olliver Schinagl <oliver@schinagl.nl>, linux-kernel@vger.kernel.org
Subject: Re: Applied "regulator: axp20x: add support for set_ramp_delay for
 AXP209" to the regulator tree
Message-ID: <20181214080820.mkukiqdcr5rk32y3@plaes.org>
References: <20181213181142.A5F3911254D1@debutante.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213181142.A5F3911254D1@debutante.sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 06:11:42PM +0000, Mark Brown wrote:
> The patch
> 

Heya, Mark!

Unfortunately, one error crept in, please see below:

[...]
> 
> From d29f54df8b167be6174881f265b12453a558e48a Mon Sep 17 00:00:00 2001
> From: Olliver Schinagl <oliver@schinagl.nl>
> Date: Tue, 11 Dec 2018 17:17:06 +0200
> Subject: [PATCH] regulator: axp20x: add support for set_ramp_delay for AXP209
> 
> The AXP209 supports ramping up voltages on several regulators such as
> DCDC2 and LDO3.
> 
> This patch adds preliminary support for the regulator-ramp-delay property
> for these 2 regulators. Note that the voltage ramp only works when
> regulator is already enabled. E.g. when going from say 0.7 V to 3.6 V.
> 
> When turning on the regulator, no voltage ramp is performed in hardware.
> 
> What this means, is that if the bootloader brings up the voltage at 0.7 V,
> the ramp delay property is properly applied. If however, the bootloader
> leaves the power off, no ramp delay is applied when the power is
> enabled by the regulator framework.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/axp20x-regulator.c | 85 ++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
[...]
>  
> +static const int axp209_dcdc2_ldo3_slew_rates[] = {
> +	1600,
> +	 800,
> +};
> +
> +static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
> +{
> +	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
> +	const struct regulator_desc *desc = rdev->desc;
> +	u8 reg, mask, enable, cfg = 0xff;
> +	const int *slew_rates;
> +	int rate_count = 0;
> +
> +	if (!rdev)
> +		return -EINVAL;
> +
> +	switch (axp20x->variant) {
> +	case AXP209_ID:
> +		if (desc->id == AXP20X_DCDC2) {

	slew_rates = axp209_dcdc2_ldo3_slew_rates;

> +			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
> +			reg = AXP20X_DCDC2_LDO3_V_RAMP;
> +			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
> +			       AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
> +			enable = (ramp > 0) ?
> +				 AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN :
> +				 !AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN;
> +			break;
> +		}
> +
> +		if (desc->id == AXP20X_LDO3) {
> +			slew_rates = axp209_dcdc2_ldo3_slew_rates;
> +			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
> +			reg = AXP20X_DCDC2_LDO3_V_RAMP;
> +			mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
> +			       AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
> +			enable = (ramp > 0) ?
> +				 AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN :
> +				 !AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN;
> +			break;
> +		}
> +
> +		if (rate_count > 0)
> +			break;
> +
> +		/* fall through */
> +	default:
> +		/* Not supported for this regulator */
> +		return -ENOTSUPP;
> +	}
> +
> +	if (ramp == 0) {
> +		cfg = enable;
> +	} else {
> +		int i;
> +
> +		for (i = 0; i < rate_count; i++) {
> +			if (ramp <= slew_rates[i])
> +				cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
> +			else
> +				break;
> +		}
> +
> +		if (cfg == 0xff) {
> +			dev_err(axp20x->dev, "unsupported ramp value %d", ramp);
> +			return -EINVAL;
> +		}
> +
> +		cfg |= enable;
> +	}
> +
> +	return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
> +}
> +
>  static const struct regulator_ops axp20x_ops_fixed = {
>  	.list_voltage		= regulator_list_voltage_linear,
>  };
> @@ -366,6 +450,7 @@ static const struct regulator_ops axp20x_ops = {
>  	.enable			= regulator_enable_regmap,
>  	.disable		= regulator_disable_regmap,
>  	.is_enabled		= regulator_is_enabled_regmap,
> +	.set_ramp_delay		= axp20x_set_ramp_delay,
>  };
>  
>  static const struct regulator_ops axp20x_ops_sw = {
> -- 
> 2.19.0.rc2
> 
