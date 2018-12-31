Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C93C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27F621019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546263374;
	bh=tXCnYMeQWRObpJ37q4tKhu5guivGxoqG+sedlVwZjOM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f8XWpWv9GrmlnNjr59JuEHh0FuK9zrpZvi/Wxq1Cx0BC1+eniboqIt39oSitES1k2
	 V0E+jJ+ohogcwIokBAgAxcCjc1kD8j/jMkhl7DRIkLdD1Gh3Q6y+TFDyax3vS6CzFn
	 MOYEhvVT+4qqjK8Ci2M7sYsEI7NTNvlnhhuOWz0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeLaNgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 08:36:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbeLaNgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 08:36:10 -0500
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 701992133F;
        Mon, 31 Dec 2018 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546263368;
        bh=tXCnYMeQWRObpJ37q4tKhu5guivGxoqG+sedlVwZjOM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ho7v6gsqKUc9H4fxSv3dgdqtZu0I1RxFT35xwoY4S8Ju2ExOxHIoXsD2nU510KBhy
         8IoQLbt5R+O3JQzuHLlVMRpl21XEqfwYLnDWQBqGTjw5HKBFtFnqT6pEW0Eci2rlvs
         YNAAkNr0WhOr5iMzdU1+tYKDAe6/yZsVw4SJzvwM=
Received: by mail-lj1-f173.google.com with SMTP id v1-v6so23655208ljd.0;
        Mon, 31 Dec 2018 05:36:08 -0800 (PST)
X-Gm-Message-State: AJcUukcw0gBcNVxw9CwElfcI5ouLAqPhjWop7SVHbVrR45WmpyKGg7lH
        8V/je4jxhyEMlzAnLhTyYv9gbsuvz0bdkc9YnVU=
X-Google-Smtp-Source: ALg8bN6ZnZ8v3AdOQSsMsFhmNvc24doDUzk83f3TiKRz7QlVWXONzFPDHZCJzlZduPHoqPYKBEXAq3aFCehzHK6p02A=
X-Received: by 2002:a2e:c41:: with SMTP id o1-v6mr21530785ljd.152.1546263366548;
 Mon, 31 Dec 2018 05:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com> <20181228161819.18931-6-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181228161819.18931-6-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 31 Dec 2018 14:35:55 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf3Z9=mjq_UWyD1oVEapvnNR71cDfyJP1Y_VLkXkFcyew@mail.gmail.com>
Message-ID: <CAJKOXPf3Z9=mjq_UWyD1oVEapvnNR71cDfyJP1Y_VLkXkFcyew@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: s5pv210: aries: Support for more devices
 present on Aries
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, xc-racer2@live.ca,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 at 17:18, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> From: Jonathan Bakker <xc-racer2@live.ca>
>
> This commit enables following devices present on Aries based phones:
> - pwm-vibrator attached to PWM 1
> - poweroff support
> - Atmel maXTouch touchscreen. It's connected to i2c2
> - Broadcom BCM4329 bluetooth over uart0
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 68 ++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5p=
v210-aries.dtsi
> index 35ba009a1a33..b7246f879648 100644
> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> @@ -41,6 +41,13 @@
>                 };
>         };
>
> +       vibrator_pwr: regulator-fixed-0 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vibrator-en";
> +               enable-active-high;
> +               gpio =3D <&gpj1 1 GPIO_ACTIVE_HIGH>;
> +       };
> +
>         wifi_pwrseq: wifi-pwrseq {
>                 compatible =3D "mmc-pwrseq-simple";
>                 reset-gpios =3D <&gpg1 2 GPIO_ACTIVE_LOW>;
> @@ -314,6 +321,22 @@
>                         reg =3D <0x36>;
>                 };
>         };
> +
> +       vibrator: pwm-vibrator {
> +               compatible =3D "pwm-vibrator";
> +               pwms =3D <&pwm 1 44642 0>;
> +               pwm-names =3D "enable";
> +               vcc-supply =3D <&vibrator_pwr>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pwm1_out>;
> +       };
> +
> +       poweroff: syscon-poweroff {
> +               compatible =3D "syscon-poweroff";
> +               regmap =3D <&pmu_syscon>;
> +               offset =3D <0x681c>; /* PS_HOLD_CONTROL */
> +               value =3D <0x5200>;
> +       };
>  };
>
>  &fimd {
> @@ -347,6 +370,23 @@
>         status =3D "okay";
>  };
>
> +&i2c2 {
> +       samsung,i2c-sda-delay =3D <100>;
> +       samsung,i2c-max-bus-freq =3D <400000>;
> +       samsung,i2c-slave-addr =3D <0x10>;
> +       status =3D "okay";
> +
> +       touchscreen@4a {
> +               compatible =3D "atmel,maxtouch";
> +               reg =3D <0x4a>;
> +               interrupt-parent =3D <&gpj0>;
> +               interrupts =3D <5 IRQ_TYPE_LEVEL_LOW>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&ts_irq>;
> +               reset-gpios =3D <&gpj1 3 GPIO_ACTIVE_HIGH>;
> +       };
> +};
> +
>  &mfc {
>         memory-region =3D <&mfc_left>, <&mfc_right>;
>  };
> @@ -372,6 +412,13 @@
>                 samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> +       bt_host_wake: bt-host-wake {
> +               samsung,pins =3D "gph2-5";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_DOWN>;
> +               samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
> +       };
> +
>         tf_detect: tf-detect {
>                 samsung,pins =3D "gph3-4";
>                 samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> @@ -384,6 +431,17 @@
>                 samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
>                 samsung,pin-pud =3D <S3C64XX_PIN_PULL_NONE>;
>         };
> +
> +       ts_irq: ts-irq {
> +               samsung,pins =3D "gpj0-5";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_UP>;

It seems there is a difference here between Aries and Fascinate. At
least in vendor kernel. One disables pull and second pulls down.
Anyway neither of them pulls it up.

Best regards,
Krzysztof
