Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C38C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7D820871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7D820871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbeGKOUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:20:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44713 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeGKOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:20:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id d17-v6so7246807eds.11;
        Wed, 11 Jul 2018 07:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ODXZMbx30JIE4Kur5s7l1zRtBUt4f8LDdPbMKD40TRg=;
        b=pEWfBzPeqH4IRR4ux+3yfLVY19rX0j0b/pCdeCTmwzbZt5hY+Yqrx3TqKfRqSew/Bz
         3wwOu/XGbUrP2s7gIWeDP8tLF899kL/8GIItbmozEkW0q9tl7TIASeJ+xJ3D9W1AwgMD
         h/hdy+081RarG99do0gJdzubn0beiX4uopxHqilPL1E/fKyh+FtYtcjZDI06AXdo8ZGW
         RaXoM/WTENo9/8kKpwYkLK5RgT1a5AktvLVYQxcLPpLfLK6v7tCoW/koEXfbQt+XUjpP
         8SssW/Gik/+xT72lx1fEiPQb+DpWUA1kYe+Gyc9AQbW1eqrn9T6hcFPf/p6gEhitvXRi
         06TA==
X-Gm-Message-State: APt69E0/F82qas2PuPWulBP+0uLGExFnd75SFQ7FnGmm68Un+LpTaq5K
        B98ORsdOO+am0m0A+Mh7z8dIONmS
X-Google-Smtp-Source: AAOMgpeez5EL85H8Fbdpl789kUlWFDK2DGO7+xoovrtXZCN++cPheIMqhBBmOdCl9Duieml4x8aGKw==
X-Received: by 2002:a50:94c4:: with SMTP id t4-v6mr30873121eda.128.1531318562533;
        Wed, 11 Jul 2018 07:16:02 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id r25-v6sm4640810edb.45.2018.07.11.07.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 07:16:02 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id r16-v6so18360396wrt.11;
        Wed, 11 Jul 2018 07:16:01 -0700 (PDT)
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr20579050wrh.148.1531318561796;
 Wed, 11 Jul 2018 07:16:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 07:15:41
 -0700 (PDT)
In-Reply-To: <20180711134450.43148-1-icenowy@aosc.io>
References: <20180711134450.43148-1-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 22:15:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v65C=gQtkNUX4pV5wudWUPf3hLNnGuxgB48xq=d7nH9qxA@mail.gmail.com>
Message-ID: <CAGb2v65C=gQtkNUX4pV5wudWUPf3hLNnGuxgB48xq=d7nH9qxA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/2] ARM: sun8i: h3: add SY8113B regulator
 on Banana Pi M2 Zero board
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 11, 2018 at 9:44 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Banana Pi M2 Zero board has a SY8113B regulator, which is controlled via
> GPIO and capable of outputing 1.1V when the PL1 GPIO is set to output 0
> or 1.1V when the PL6 GPIO is set to input or output 1, and the output is
> the power supply of the ARM cores in H3 SoC.
>
> Add the device tree node of this regulator and set the cpu's cpu-supply
> property to it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> index eb61dcf32797..abc8dc750f4b 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -59,6 +59,23 @@
>                 };
>         };
>
> +       reg_vdd_cpux: vdd-cpux-regulator {
> +               compatible = "regulator-gpio";
> +               regulator-name = "vdd-cpux";
> +               regulator-type = "voltage";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt = <1100000>;
> +               regulator-max-microvolt = <1300000>;
> +               regulator-ramp-delay = <50>; /* 4ms */
> +
> +               gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
> +               enable-active-high;
> +               gpios-states = <0x1>;
> +               states = <1100000 0x0

So looking at the schematics with the resistor values, this calculates
to roughly 1.108475 (0.6 * (1 + 10 / 11.8)) ...

> +                         1300000 0x1>;

and this to 1.308475.

ChenYu

> +       };
> +
>         wifi_pwrseq: wifi_pwrseq {
>                 compatible = "mmc-pwrseq-simple";
>                 pinctrl-names = "default";
> @@ -66,6 +83,10 @@
>         };
>  };
>
> +&cpu0 {
> +       cpu-supply = <&reg_vdd_cpux>;
> +};
> +
>  &de {
>         status = "okay";
>  };
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
