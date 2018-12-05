Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC8BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B63320878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuL2qdnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B63320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeLEOG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:06:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLEOG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:06:57 -0500
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE212087F;
        Wed,  5 Dec 2018 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544018816;
        bh=qyYD9nSwLer4Uz87oUIOgQIAIclr96yNjXhXskrf75k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LuL2qdnECboiMVoxi0gkKg4Y5leqvVyIuSGDqOULwQSa17sWGKEYAY6iHnwpbgTn+
         CgDebYdEWRT6p3mWK77jgdut+TYjtrnSo5v1ejP+2yc+wsOFK7Qd/si1pOHUQz26gO
         BbJhgKqArbwbfOdd4e6JbxfDyDOKs0VkcaGHjpBE=
Received: by mail-lj1-f172.google.com with SMTP id e5-v6so18457698lja.4;
        Wed, 05 Dec 2018 06:06:55 -0800 (PST)
X-Gm-Message-State: AA+aEWZr0t9xt9Z87y8AugmxyYGEEjMb+7d2yRxaWPsPvHUVMRJa6nH6
        q4wrRe16jf9sa2JU36f0HORsiHO67Xbw5BzeAh4=
X-Google-Smtp-Source: AFSGD/XWzW66RRyUKV9tYJD5ySQMIUjJxTjzdYfF87BgIYchP/GSFSnlNHUrEw5gkZQpee6ZxWKjPunbhNfmi/jBqJk=
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr17640562lji.60.1544018813993;
 Wed, 05 Dec 2018 06:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20181204194025.2719-1-linux.amoon@gmail.com>
In-Reply-To: <20181204194025.2719-1-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 5 Dec 2018 15:06:42 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
Message-ID: <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To:     linux.amoon@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 20:40, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add suspend-to-mem node to regulator core to be enabled or disabled
> during system suspend and also support changing the regulator operating
> mode during runtime and when the system enter sleep mode.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Tested on Odroid U3+
> ---
>  .../boot/dts/exynos4412-odroid-common.dtsi    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 2caa3132f34e..837713a2ec3b 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -285,6 +285,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };

Driver does not support suspend_enable so this will be noop. We could
add this for DT-correctness (and full description of HW) but then I
need explanation why this regulator has to stay on during suspend.

>                         };
>
>                         ldo3_reg: LDO3 {
> @@ -292,6 +295,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };

The same but with suspend_disable.

I am not saying that these are wrong but I would be happy to see
explanations why you chosen these particular properties.

>                         };
>
>                         ldo4_reg: LDO4 {
> @@ -299,6 +305,9 @@
>                                 regulator-min-microvolt = <2800000>;
>                                 regulator-max-microvolt = <2800000>;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo5_reg: LDO5 {
> @@ -307,6 +316,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo6_reg: LDO6 {
> @@ -314,6 +326,9 @@
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo7_reg: LDO7 {
> @@ -321,18 +336,27 @@
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo8_reg: LDO8 {
>                                 regulator-name = "VDD10_HDMI_1.0V";
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo10_reg: LDO10 {
>                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo11_reg: LDO11 {
> @@ -340,6 +364,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo12_reg: LDO12 {
> @@ -348,6 +375,9 @@
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo13_reg: LDO13 {
> @@ -356,6 +386,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo14_reg: LDO14 {
> @@ -364,6 +397,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo15_reg: LDO15 {
> @@ -372,6 +408,9 @@
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo16_reg: LDO16 {
> @@ -380,6 +419,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo20_reg: LDO20 {
> @@ -387,6 +429,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo21_reg: LDO21 {
> @@ -394,6 +439,9 @@
>                                 regulator-min-microvolt = <2800000>;
>                                 regulator-max-microvolt = <2800000>;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;

That's unusual setting... enabled in suspend but not necessarily
during work (no always-on).

> +                               };
>                         };
>
>                         ldo22_reg: LDO22 {
> @@ -411,6 +459,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck1_reg: BUCK1 {
> @@ -419,6 +470,9 @@
>                                 regulator-max-microvolt = <1100000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };

This is seriously wrong so I have doubts whether you tested the
changes or you know what is happening with them. If you turn off
memory bus regulator off, how the memory will work in
Suspend-to-Memory mode?

>                         };
>
>                         buck2_reg: BUCK2 {
> @@ -427,6 +481,9 @@
>                                 regulator-max-microvolt = <1350000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         buck3_reg: BUCK3 {
> @@ -435,6 +492,9 @@
>                                 regulator-max-microvolt = <1050000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;

Looks suspicious as well.

Best regards,
Krzysztof

> +                               };
>                         };
>
>                         buck4_reg: BUCK4 {
> @@ -442,6 +502,9 @@
>                                 regulator-min-microvolt = <900000>;
>                                 regulator-max-microvolt = <1100000>;
>                                 regulator-microvolt-offset = <50000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck5_reg: BUCK5 {
> @@ -450,6 +513,9 @@
>                                 regulator-max-microvolt = <1200000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck6_reg: BUCK6 {
> @@ -458,6 +524,9 @@
>                                 regulator-max-microvolt = <1350000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck7_reg: BUCK7 {
> @@ -465,6 +534,9 @@
>                                 regulator-min-microvolt = <2000000>;
>                                 regulator-max-microvolt = <2000000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck8_reg: BUCK8 {
> --
> 2.19.2
>
