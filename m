Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 83834C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FA7208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxKjahEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FA7208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965476AbeFOIqw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:46:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55715 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934701AbeFOIqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:46:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so2243087wmh.5;
        Fri, 15 Jun 2018 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6BPP4zcGntDxG9+syTp3LzOQnM40MGtq+V0dAFMWzMM=;
        b=FxKjahEuSdJx+6prK1+TqLMRc7GyjNIb9RiKl3LpLTXTR6qirdx0slXtjt1vL//am2
         mvpzq2h9MC40Brc9fbR9yZMWXrB5nEfrOdIphrr/vBx1olkVL4mYLpoU4THwSN2EI6Z7
         HJdqDigvet9rYAeNyZ4c+CwMtRbb1CQ54MOWsl6xNXyiN3Onn6CdR0x9dPKVarV05xUu
         1Z5gOzShqJF69vWWnQGvJmD8QkA/VVpvPNncpCmcL+9zsOx4uV2N9jdNPdrCSwWheSqt
         3FwjHc4teZk4C9jkZjs3isFhisJc0klk2qwTQeyrDIl5laF+MVjedTVeGUUER2oHDfUT
         kjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6BPP4zcGntDxG9+syTp3LzOQnM40MGtq+V0dAFMWzMM=;
        b=bMVOvBrd8e//NWQlNKIXTNEwC1Eu+b6VcxC8OJ+/p5EeEehUmh+8tvPy7L1wLWrVbb
         LLwJFxjIaCYyF7GJEgisr3vLzD78fOEVK51UKdZ779nGrWp4KSVu5ZTmMc1jfSU7Eh52
         UGhxicRy2OcjM6KwnZP4eSkRgYo2FIofc+cfS9rp5gzzPgeedMe20qxspK9wp11vLi1+
         XIYCEj1kdjDh2AlL6Gk/kDgkih16KCuImdWxlKc0aPX5dPPLNrnVYe2X6IX0iWUsQ26S
         XPyVa6ATcLbE7dCL7DUPHJG49A+ICiDyR2Cue6xyU69LCw8pKWNN4Lburv9Um9UM8k9a
         Rvsg==
X-Gm-Message-State: APt69E28s/xJMzxhgeiWhogN/AmGVwloHoMvw+AQtYI0LJ64zxHeIs8k
        v4bx1RWxDBffSGjzASCAbwo=
X-Google-Smtp-Source: ADUXVKLcRyC62cBI+MFoqF3u+TBN1XhjSnleLO1uhGvSJKkRSP6eYzjxqt+VipJ+xzi3df1GBt85bg==
X-Received: by 2002:a50:8d8d:: with SMTP id r13-v6mr1094575edh.86.1529052402157;
        Fri, 15 Jun 2018 01:46:42 -0700 (PDT)
Received: from ziggy.stardust ([37.223.147.195])
        by smtp.gmail.com with ESMTPSA id c13-v6sm3186395edr.78.2018.06.15.01.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 01:46:41 -0700 (PDT)
Subject: Re: [PATCH v3 16/27] docs: Fix more broken references
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <e1bf52a721005b2017434acc54ec5ddc152d6fe4.1528990947.git.mchehab+samsung@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <cba1f9da-7dce-af9c-d5c2-3a7e18ce4760@gmail.com>
Date:   Fri, 15 Jun 2018 10:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e1bf52a721005b2017434acc54ec5ddc152d6fe4.1528990947.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/06/18 18:09, Mauro Carvalho Chehab wrote:
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
> 	./scripts/documentation-file-ref-check --fix
> 
> Manually checked that produced results are valid.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

for mt6397.txt:

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  .../devicetree/bindings/clock/st/st,clkgen.txt |  8 ++++----
>  .../devicetree/bindings/clock/ti/gate.txt      |  2 +-
>  .../devicetree/bindings/clock/ti/interface.txt |  2 +-
>  .../bindings/cpufreq/cpufreq-mediatek.txt      |  2 +-
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt |  2 +-
>  .../bindings/gpu/arm,mali-midgard.txt          |  2 +-
>  .../bindings/gpu/arm,mali-utgard.txt           |  2 +-
>  .../devicetree/bindings/mfd/mt6397.txt         |  2 +-
>  .../devicetree/bindings/mfd/sun6i-prcm.txt     |  2 +-
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt |  2 +-
>  .../devicetree/bindings/net/dsa/ksz.txt        |  2 +-
>  .../devicetree/bindings/net/dsa/mt7530.txt     |  2 +-
>  .../devicetree/bindings/power/fsl,imx-gpc.txt  |  2 +-
>  .../bindings/power/wakeup-source.txt           |  2 +-
>  .../devicetree/bindings/usb/rockchip,dwc3.txt  |  2 +-
>  Documentation/hwmon/ina2xx                     |  2 +-
>  Documentation/maintainer/pull-requests.rst     |  2 +-
>  Documentation/translations/ko_KR/howto.rst     |  2 +-
>  MAINTAINERS                                    | 18 +++++++++---------
>  drivers/net/ethernet/intel/Kconfig             |  8 ++++----
>  drivers/soundwire/stream.c                     |  8 ++++----
>  fs/Kconfig.binfmt                              |  2 +-
>  fs/binfmt_misc.c                               |  2 +-
>  23 files changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
> index 7364953d0d0b..45ac19bfa0a9 100644
> --- a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
> +++ b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
> @@ -31,10 +31,10 @@ This binding uses the common clock binding[1].
>  Each subnode should use the binding described in [2]..[7]
>  
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -[3] Documentation/devicetree/bindings/clock/st,clkgen-mux.txt
> -[4] Documentation/devicetree/bindings/clock/st,clkgen-pll.txt
> -[7] Documentation/devicetree/bindings/clock/st,quadfs.txt
> -[8] Documentation/devicetree/bindings/clock/st,flexgen.txt
> +[3] Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
> +[4] Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
> +[7] Documentation/devicetree/bindings/clock/st/st,quadfs.txt
> +[8] Documentation/devicetree/bindings/clock/st/st,flexgen.txt
>  
>  
>  Required properties:
> diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Documentation/devicetree/bindings/clock/ti/gate.txt
> index 03f8fdee62a7..56d603c1f716 100644
> --- a/Documentation/devicetree/bindings/clock/ti/gate.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
> @@ -10,7 +10,7 @@ will be controlled instead and the corresponding hw-ops for
>  that is used.
>  
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -[2] Documentation/devicetree/bindings/clock/gate-clock.txt
> +[2] Documentation/devicetree/bindings/clock/gpio-gate-clock.txt
>  [3] Documentation/devicetree/bindings/clock/ti/clockdomain.txt
>  
>  Required properties:
> diff --git a/Documentation/devicetree/bindings/clock/ti/interface.txt b/Documentation/devicetree/bindings/clock/ti/interface.txt
> index 3111a409fea6..3f4704040140 100644
> --- a/Documentation/devicetree/bindings/clock/ti/interface.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/interface.txt
> @@ -9,7 +9,7 @@ companion clock finding (match corresponding functional gate
>  clock) and hardware autoidle enable / disable.
>  
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -[2] Documentation/devicetree/bindings/clock/gate-clock.txt
> +[2] Documentation/devicetree/bindings/clock/gpio-gate-clock.txt
>  
>  Required properties:
>  - compatible : shall be one of:
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> index d36f07e0a2bb..0551c78619de 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> @@ -8,7 +8,7 @@ Required properties:
>  	"intermediate"	- A parent of "cpu" clock which is used as "intermediate" clock
>  			  source (usually MAINPLL) when the original CPU PLL is under
>  			  transition and not stable yet.
> -	Please refer to Documentation/devicetree/bindings/clk/clock-bindings.txt for
> +	Please refer to Documentation/devicetree/bindings/clock/clock-bindings.txt for
>  	generic clock consumer properties.
>  - operating-points-v2: Please refer to Documentation/devicetree/bindings/opp/opp.txt
>  	for detail.
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> index d6d2833482c9..fc2bcbe26b1e 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -12,7 +12,7 @@ Required properties:
>  - clocks:		 Phandles for clock specified in "clock-names" property
>  - clock-names :		 The name of clock used by the DFI, must be
>  			 "pclk_ddr_mon";
> -- operating-points-v2:	 Refer to Documentation/devicetree/bindings/power/opp.txt
> +- operating-points-v2:	 Refer to Documentation/devicetree/bindings/opp/opp.txt
>  			 for details.
>  - center-supply:	 DMC supply node.
>  - status:		 Marks the node enabled/disabled.
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> index 039219df05c5..18a2cde2e5f3 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -34,7 +34,7 @@ Optional properties:
>  - mali-supply : Phandle to regulator for the Mali device. Refer to
>    Documentation/devicetree/bindings/regulator/regulator.txt for details.
>  
> -- operating-points-v2 : Refer to Documentation/devicetree/bindings/power/opp.txt
> +- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
>    for details.
>  
>  
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> index c1f65d1dac1d..63cd91176a68 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> @@ -44,7 +44,7 @@ Optional properties:
>  
>    - memory-region:
>      Memory region to allocate from, as defined in
> -    Documentation/devicetree/bindi/reserved-memory/reserved-memory.txt
> +    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>  
>    - mali-supply:
>      Phandle to regulator for the Mali device, as defined in
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index d1df77f4d655..0ebd08af777d 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -12,7 +12,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
>  It is interfaced to host controller using SPI interface by a proprietary hardware
>  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
>  See the following for pwarp node definitions:
> -Documentation/devicetree/bindings/soc/pwrap.txt
> +Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
>  
>  This document describes the binding for MFD device and its sub module.
>  
> diff --git a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> index dd2c06540485..4d21ffdb0fc1 100644
> --- a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> @@ -9,7 +9,7 @@ Required properties:
>  
>  The prcm node may contain several subdevices definitions:
>   - see Documentation/devicetree/clk/sunxi.txt for clock devices
> - - see Documentation/devicetree/reset/allwinner,sunxi-clock-reset.txt for reset
> + - see Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt for reset
>     controller devices
>  
>  
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index a58c173b7ab9..0419a63f73a0 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -62,7 +62,7 @@ Required properties for a slot (Deprecated - Recommend to use one slot per host)
>    rest of the gpios (depending on the bus-width property) are the data lines in
>    no particular order. The format of the gpio specifier depends on the gpio
>    controller.
> -(Deprecated - Refer to Documentation/devicetree/binding/pinctrl/samsung-pinctrl.txt)
> +(Deprecated - Refer to Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt)
>  
>  Example:
>  
> diff --git a/Documentation/devicetree/bindings/net/dsa/ksz.txt b/Documentation/devicetree/bindings/net/dsa/ksz.txt
> index fd23904ac68e..a700943218ca 100644
> --- a/Documentation/devicetree/bindings/net/dsa/ksz.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/ksz.txt
> @@ -6,7 +6,7 @@ Required properties:
>  - compatible: For external switch chips, compatible string must be exactly one
>    of: "microchip,ksz9477"
>  
> -See Documentation/devicetree/bindings/dsa/dsa.txt for a list of additional
> +See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of additional
>  required and optional properties.
>  
>  Examples:
> diff --git a/Documentation/devicetree/bindings/net/dsa/mt7530.txt b/Documentation/devicetree/bindings/net/dsa/mt7530.txt
> index a9bc27b93ee3..aa3527f71fdc 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mt7530.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/mt7530.txt
> @@ -31,7 +31,7 @@ Required properties for the child nodes within ports container:
>  - phy-mode: String, must be either "trgmii" or "rgmii" for port labeled
>  	 "cpu".
>  
> -See Documentation/devicetree/bindings/dsa/dsa.txt for a list of additional
> +See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of additional
>  required, optional properties and how the integrated switch subnodes must
>  be specified.
>  
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> index b31d6bbeee16..726ec2875223 100644
> --- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> @@ -14,7 +14,7 @@ Required properties:
>    datasheet
>  - interrupts: Should contain one interrupt specifier for the GPC interrupt
>  - clocks: Must contain an entry for each entry in clock-names.
> -  See Documentation/devicetree/bindings/clocks/clock-bindings.txt for details.
> +  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
>  - clock-names: Must include the following entries:
>    - ipg
>  
> diff --git a/Documentation/devicetree/bindings/power/wakeup-source.txt b/Documentation/devicetree/bindings/power/wakeup-source.txt
> index 5d254ab13ebf..cfd74659fbed 100644
> --- a/Documentation/devicetree/bindings/power/wakeup-source.txt
> +++ b/Documentation/devicetree/bindings/power/wakeup-source.txt
> @@ -22,7 +22,7 @@ List of legacy properties and respective binding document
>  3. "has-tpo"			Documentation/devicetree/bindings/rtc/rtc-opal.txt
>  4. "linux,wakeup"		Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
>  				Documentation/devicetree/bindings/mfd/tc3589x.txt
> -				Documentation/devicetree/bindings/input/ads7846.txt
> +				Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
>  5. "linux,keypad-wakeup"	Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
>  6. "linux,input-wakeup"		Documentation/devicetree/bindings/input/samsung-keypad.txt
>  7. "nvidia,wakeup-source"	Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> index 50a31536e975..252a05c5d976 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> @@ -16,7 +16,7 @@ A child node must exist to represent the core DWC3 IP block. The name of
>  the node is not important. The content of the node is defined in dwc3.txt.
>  
>  Phy documentation is provided in the following places:
> -Documentation/devicetree/bindings/phy/rockchip,dwc3-usb-phy.txt
> +Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
>  
>  Example device nodes:
>  
> diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
> index cfd31d94c872..72d16f08e431 100644
> --- a/Documentation/hwmon/ina2xx
> +++ b/Documentation/hwmon/ina2xx
> @@ -53,7 +53,7 @@ bus supply voltage.
>  
>  The shunt value in micro-ohms can be set via platform data or device tree at
>  compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
> -refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings
> +refer to the Documentation/devicetree/bindings/hwmon/ina2xx.txt for bindings
>  if the device tree is used.
>  
>  Additionally ina226 supports update_interval attribute as described in
> diff --git a/Documentation/maintainer/pull-requests.rst b/Documentation/maintainer/pull-requests.rst
> index a19db3458b56..22b271de0304 100644
> --- a/Documentation/maintainer/pull-requests.rst
> +++ b/Documentation/maintainer/pull-requests.rst
> @@ -41,7 +41,7 @@ named ``char-misc-next``, you would be using the following command::
>  
>  that will create a signed tag called ``char-misc-4.15-rc1`` based on the
>  last commit in the ``char-misc-next`` branch, and sign it with your gpg key
> -(see :ref:`Documentation/maintainer/configure_git.rst <configuregit>`).
> +(see :ref:`Documentation/maintainer/configure-git.rst <configuregit>`).
>  
>  Linus will only accept pull requests based on a signed tag. Other
>  maintainers may differ.
> diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
> index 624654bdcd8a..a8197e072599 100644
> --- a/Documentation/translations/ko_KR/howto.rst
> +++ b/Documentation/translations/ko_KR/howto.rst
> @@ -160,7 +160,7 @@ mtk.manpages@gmail.com의 메인테이너에게 보낼 것을 권장한다.
>      독특한 행동에 관하여 흔히 있는 오해들과 혼란들을 해소하고 있기
>      때문이다.
>  
> -  :ref:`Documentation/process/stable_kernel_rules.rst <stable_kernel_rules>`
> +  :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
>      이 문서는 안정적인 커널 배포가 이루어지는 규칙을 설명하고 있으며
>      여러분들이 이러한 배포들 중 하나에 변경을 하길 원한다면
>      무엇을 해야 하는지를 설명한다.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec65e33e2cf1..5871dd5060f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4513,7 +4513,7 @@ DRM DRIVER FOR ILITEK ILI9225 PANELS
>  M:	David Lechner <david@lechnology.com>
>  S:	Maintained
>  F:	drivers/gpu/drm/tinydrm/ili9225.c
> -F:	Documentation/devicetree/bindings/display/ili9225.txt
> +F:	Documentation/devicetree/bindings/display/ilitek,ili9225.txt
>  
>  DRM DRIVER FOR INTEL I810 VIDEO CARDS
>  S:	Orphan / Obsolete
> @@ -4599,13 +4599,13 @@ DRM DRIVER FOR SITRONIX ST7586 PANELS
>  M:	David Lechner <david@lechnology.com>
>  S:	Maintained
>  F:	drivers/gpu/drm/tinydrm/st7586.c
> -F:	Documentation/devicetree/bindings/display/st7586.txt
> +F:	Documentation/devicetree/bindings/display/sitronix,st7586.txt
>  
>  DRM DRIVER FOR SITRONIX ST7735R PANELS
>  M:	David Lechner <david@lechnology.com>
>  S:	Maintained
>  F:	drivers/gpu/drm/tinydrm/st7735r.c
> -F:	Documentation/devicetree/bindings/display/st7735r.txt
> +F:	Documentation/devicetree/bindings/display/sitronix,st7735r.txt
>  
>  DRM DRIVER FOR TDFX VIDEO CARDS
>  S:	Orphan / Obsolete
> @@ -4824,7 +4824,7 @@ M:	Eric Anholt <eric@anholt.net>
>  S:	Supported
>  F:	drivers/gpu/drm/v3d/
>  F:	include/uapi/drm/v3d_drm.h
> -F:	Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt
> +F:	Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
>  DRM DRIVERS FOR VC4
> @@ -5735,7 +5735,7 @@ M:	Madalin Bucur <madalin.bucur@nxp.com>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/freescale/fman
> -F:	Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> +F:	Documentation/devicetree/bindings/net/fsl-fman.txt
>  
>  FREESCALE QORIQ PTP CLOCK DRIVER
>  M:	Yangbo Lu <yangbo.lu@nxp.com>
> @@ -8700,7 +8700,7 @@ M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/hwmon/max6697
> -F:	Documentation/devicetree/bindings/i2c/max6697.txt
> +F:	Documentation/devicetree/bindings/hwmon/max6697.txt
>  F:	drivers/hwmon/max6697.c
>  F:	include/linux/platform_data/max6697.h
>  
> @@ -9080,7 +9080,7 @@ M:	Martin Donnelly <martin.donnelly@ge.com>
>  M:	Martyn Welch <martyn.welch@collabora.co.uk>
>  S:	Maintained
>  F:	drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> -F:	Documentation/devicetree/bindings/video/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
> +F:	Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
>  
>  MEGARAID SCSI/SAS DRIVERS
>  M:	Kashyap Desai <kashyap.desai@broadcom.com>
> @@ -10728,7 +10728,7 @@ PARALLEL LCD/KEYPAD PANEL DRIVER
>  M:	Willy Tarreau <willy@haproxy.com>
>  M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
>  S:	Odd Fixes
> -F:	Documentation/misc-devices/lcd-panel-cgram.txt
> +F:	Documentation/auxdisplay/lcd-panel-cgram.txt
>  F:	drivers/misc/panel.c
>  
>  PARALLEL PORT SUBSYSTEM
> @@ -13291,7 +13291,7 @@ M:	Vinod Koul <vkoul@kernel.org>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Supported
> -F:	Documentation/sound/alsa/compress_offload.txt
> +F:	Documentation/sound/designs/compress-offload.rst
>  F:	include/sound/compress_driver.h
>  F:	include/uapi/sound/compress_*
>  F:	sound/core/compress_offload.c
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index 14d287bed33c..1ab613eb5796 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -33,7 +33,7 @@ config E100
>  	  to identify the adapter.
>  
>  	  More specific information on configuring the driver is in
> -	  <file:Documentation/networking/e100.txt>.
> +	  <file:Documentation/networking/e100.rst>.
>  
>  	  To compile this driver as a module, choose M here. The module
>  	  will be called e100.
> @@ -49,7 +49,7 @@ config E1000
>  	  <http://support.intel.com>
>  
>  	  More specific information on configuring the driver is in
> -	  <file:Documentation/networking/e1000.txt>.
> +	  <file:Documentation/networking/e1000.rst>.
>  
>  	  To compile this driver as a module, choose M here. The module
>  	  will be called e1000.
> @@ -94,7 +94,7 @@ config IGB
>  	  <http://support.intel.com>
>  
>  	  More specific information on configuring the driver is in
> -	  <file:Documentation/networking/e1000.txt>.
> +	  <file:Documentation/networking/e1000.rst>.
>  
>  	  To compile this driver as a module, choose M here. The module
>  	  will be called igb.
> @@ -130,7 +130,7 @@ config IGBVF
>  	  <http://support.intel.com>
>  
>  	  More specific information on configuring the driver is in
> -	  <file:Documentation/networking/e1000.txt>.
> +	  <file:Documentation/networking/e1000.rst>.
>  
>  	  To compile this driver as a module, choose M here. The module
>  	  will be called igbvf.
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 8974a0fcda1b..4b5e250e8615 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1291,7 +1291,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
>   *
>   * @stream: Soundwire stream
>   *
> - * Documentation/soundwire/stream.txt explains this API in detail
> + * Documentation/driver-api/soundwire/stream.rst explains this API in detail
>   */
>  int sdw_prepare_stream(struct sdw_stream_runtime *stream)
>  {
> @@ -1348,7 +1348,7 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
>   *
>   * @stream: Soundwire stream
>   *
> - * Documentation/soundwire/stream.txt explains this API in detail
> + * Documentation/driver-api/soundwire/stream.rst explains this API in detail
>   */
>  int sdw_enable_stream(struct sdw_stream_runtime *stream)
>  {
> @@ -1400,7 +1400,7 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
>   *
>   * @stream: Soundwire stream
>   *
> - * Documentation/soundwire/stream.txt explains this API in detail
> + * Documentation/driver-api/soundwire/stream.rst explains this API in detail
>   */
>  int sdw_disable_stream(struct sdw_stream_runtime *stream)
>  {
> @@ -1456,7 +1456,7 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>   *
>   * @stream: Soundwire stream
>   *
> - * Documentation/soundwire/stream.txt explains this API in detail
> + * Documentation/driver-api/soundwire/stream.rst explains this API in detail
>   */
>  int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>  {
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 57a27c42b5ac..56df483de619 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -168,7 +168,7 @@ config BINFMT_MISC
>  	  will automatically feed it to the correct interpreter.
>  
>  	  You can do other nice things, too. Read the file
> -	  <file:Documentation/binfmt_misc.txt> to learn how to use this
> +	  <file:Documentation/admin-guide/binfmt-misc.rst> to learn how to use this
>  	  feature, <file:Documentation/admin-guide/java.rst> for information about how
>  	  to include Java support. and <file:Documentation/admin-guide/mono.rst> for
>            information about how to include Mono-based .NET support.
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 4de191563261..4b5fff31ef27 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -4,7 +4,7 @@
>   * Copyright (C) 1997 Richard Günther
>   *
>   * binfmt_misc detects binaries via a magic or filename extension and invokes
> - * a specified wrapper. See Documentation/binfmt_misc.txt for more details.
> + * a specified wrapper. See Documentation/admin-guide/binfmt-misc.rst for more details.
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
