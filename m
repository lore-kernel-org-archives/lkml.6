Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1680FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7012145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7DkD5B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7012145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJIDdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeJIDdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:33:09 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6917620C0A;
        Mon,  8 Oct 2018 20:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539029978;
        bh=jdaFC+XMm8RRUIw4lcVuSJboAWKZ2pawuSgM9hePSFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o7DkD5B/TWHYQufLGDreorxDV+5bqteRNEhhU45lVHn6HIOABaTrtFdLgt4n6KiNG
         zen/9+7bQv5GytBxnrwB9WTcdeDGKmFjRI8Ex5D6A/H8Z1UOlBGBctkkhzzdiH9Y+e
         MXq8ZShj6af8Vgk8Ez8dKv1bPfgcy3bgT+DaciqU=
Date:   Mon, 8 Oct 2018 21:19:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: add compatibles for AXP803 AC and
 battery power supplies
Message-ID: <20181008211932.16a51643@archlinux>
In-Reply-To: <20181004193410.7265-2-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
        <20181004193410.7265-2-oskari@lemmela.net>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Oct 2018 22:34:07 +0300
Oskari Lemmela <oskari@lemmela.net> wrote:

> AXP803 PMIC is register compatible with AXP813.
> 
> AXP803/AXP813 are capable to limit input current and supply voltage.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Hi Oskari,

It would be better to split this up as different aspects are going
to ideally be applied through different kernel trees.

I know that already got commented on for the later patch but just wanted
to point out it applies here as well.

One comment inline about avoiding wildcards given the propensity of
hardware manufacturers to confuse us on their naming schemes.

Jonathan

> ---
>  Documentation/devicetree/bindings/gpio/gpio-axp209.txt        | 3 ++-
>  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt      | 3 ++-
>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt      | 4 ++++
>  .../devicetree/bindings/power/supply/axp20x_battery.txt       | 1 +
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> index fc42b2caa06d..da3c0efb5e76 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> @@ -11,6 +11,7 @@ This driver employs the per-pin muxing pattern.
>  Required properties:
>  - compatible: Should be one of:
>  	- "x-powers,axp209-gpio"
> +	- "x-powers,axp803-gpio"
>  	- "x-powers,axp813-gpio"
>  - #gpio-cells: Should be two. The first cell is the pin number and the
>    second is the GPIO flags.
> @@ -67,7 +68,7 @@ GPIO0	|	gpio_in, gpio_out, ldo, adc
>  GPIO1	|	gpio_in, gpio_out, ldo, adc
>  GPIO2	|	gpio_in, gpio_out
>  
> -axp813
> +axp8x3
Avoid wild cards like this.   It if far too common to have a hardware
manufacturer not keep to what seems like an established naming convention
and introduce something entirely different in the middle of an existing
series of names.

>  ------
>  GPIO	|	Functions
>  ------------------------
> diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> index 7a6313913923..247616099171 100644
> --- a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> @@ -4,6 +4,7 @@ Required properties:
>    - compatible: should be one of:
>      - "x-powers,axp209-adc",
>      - "x-powers,axp221-adc",
> +    - "x-powers,axp803-adc",
>      - "x-powers,axp813-adc",
>    - #io-channel-cells: should be 1,
>  
> @@ -39,7 +40,7 @@ AXP22x
>   2 | batt_chrg_i
>   3 | batt_dischrg_i
>  
> -AXP813
> +AXP8x3
>  ------
>   0 | pmic_temp
>   1 | gpio0_v
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> index 826e8a879121..97276a71e961 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> @@ -4,6 +4,8 @@ Required Properties:
>   - compatible: One of:
>  			"x-powers,axp202-ac-power-supply"
>  			"x-powers,axp221-ac-power-supply"
> +			"x-powers,axp803-ac-power-supply"
> +			"x-powers,axp813-ac-power-supply"
>  
>  This node is a subnode of the axp20x PMIC.
>  
> @@ -13,6 +15,8 @@ reading ADC channels from the AXP20X ADC.
>  The AXP22X is only able to tell if an AC power supply is present and
>  usable.
>  
> +The AXP8X3 is able to limit current and supply voltage
> +
>  Example:
>  
>  &axp209 {
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> index 41916f69902c..780ebd7e3b84 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -4,6 +4,7 @@ Required Properties:
>   - compatible, one of:
>  			"x-powers,axp209-battery-power-supply"
>  			"x-powers,axp221-battery-power-supply"
> +			"x-powers,axp803-battery-power-supply"
>  			"x-powers,axp813-battery-power-supply"
>  
>  This node is a subnode of its respective PMIC DT node.

