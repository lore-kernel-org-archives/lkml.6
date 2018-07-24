Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D838CECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9237C20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9237C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbeGXD01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:26:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39159 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388233AbeGXD01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:26:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so2688752edi.6;
        Mon, 23 Jul 2018 19:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IB57hxyMg3t8Yq/nhLo4sLOs8MIjTHXGAY16bm88x5I=;
        b=cRP4VoN9wbsASM1vPeNyZ6wTJBirM1WuBuxS2IdxaItkd15eosoJzXu5BMz/NcShhV
         Z1hrMaY/saFfI/rVfq16zsx0ePMXi+pvTPlBjnEhjbFuv6DpXI05NCgH6w3lIhKK+hiG
         DB3f3L3aqk5gNfETd1vQT3DfbKLx5yzmtJQfSuOd7xuB7BbZtrbwywE4X8tC3Xjz35FR
         JvpnXHt8qXKXkQ6q160umhuDHI7+XCAuD7ncRgBMB3WNrGRYEhku9cpt/fgw14hR0tqG
         6gs0LR5qA/jkMtupyHhUIEZl5pzS/tU4KLOnkyiFstcdt4sAYDttcqeysWxc58NXQ7ya
         G7XA==
X-Gm-Message-State: AOUpUlE3Ul/GSOX4sbYPxT/v4VENDJHhdUIlWhmtuPH7F/lDfdi5NRdk
        l4+dln/6h9fsF5tswEPRrc/JCN75
X-Google-Smtp-Source: AAOMgpfNBLiVcE9QP2G+R+N1R/Yz6SbRJruyl60tNK+7JcVliruQJUBrcnf5uCN1C8fE+W5cpdKImw==
X-Received: by 2002:a50:8466:: with SMTP id 93-v6mr16915193edp.304.1532398940604;
        Mon, 23 Jul 2018 19:22:20 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a13-v6sm13967137edf.84.2018.07.23.19.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 19:22:20 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id g6-v6so2538866wrp.0;
        Mon, 23 Jul 2018 19:22:20 -0700 (PDT)
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr10128202wra.19.1532398939896;
 Mon, 23 Jul 2018 19:22:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 19:21:59
 -0700 (PDT)
In-Reply-To: <20180724011551.49603-4-icenowy@aosc.io>
References: <20180724011551.49603-1-icenowy@aosc.io> <20180724011551.49603-4-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 24 Jul 2018 10:21:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v67zR-Q9n7L6CaFKDUJFHFEC_h8-RYxkdyeyJb_GbNmkJw@mail.gmail.com>
Message-ID: <CAGb2v67zR-Q9n7L6CaFKDUJFHFEC_h8-RYxkdyeyJb_GbNmkJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: allwinner: dts: h6: add Wi-Fi support for Pine
 H64 model A/B
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:15 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The Pine H64 model A has a Wi-Fi module connector and the model B has an
> on-board RTL8723BS Wi-Fi module.
>
> Add support for them. For model A, as it's not defaultly present, keep
> it disabled now.

Nope. Pine64 actually has two WiFi/BT modules. And they require different
device tree snippets for both the WiFi and BT side. This is better resolved
with device tree overlays.

I have both, though I've yet found time to work on them.

ChenYu

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../allwinner/sun50i-h6-pine-h64-model-b.dts  |  8 +++++
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 29 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> index d0fcc25efb00..d0f775613c9b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> @@ -18,3 +18,11 @@
>                 };
>         };
>  };
> +
> +&mmc1 {
> +       status = "okay";
> +};
> +
> +&wifi_pwrseq {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index a85867f8b684..75db6d4139bf 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -40,6 +40,12 @@
>                         gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
>                 };
>         };
> +
> +       wifi_pwrseq: wifi_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PL2 */
> +               status = "disabled";
> +       };
>  };
>
>  &mmc0 {
> @@ -50,6 +56,17 @@
>         status = "okay";
>  };
>
> +&mmc1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_pins>;
> +       vmmc-supply = <&reg_cldo2>;
> +       vqmmc-supply = <&reg_bldo2>;
> +       mmc-pwrseq = <&wifi_pwrseq>;
> +       bus-width = <4>;
> +       non-removable;
> +       status = "disabled";
> +};
> +
>  &mmc2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc2_pins>;
> @@ -128,12 +145,24 @@
>                         };
>
>                         reg_cldo2: cldo2 {
> +                               /*
> +                                * This regulator is connected with CLDO3.
> +                                * Before the kernel can support synchronized
> +                                * enable of coupled regulators, keep them
> +                                * both always on as a ugly hack.
> +                                */
> +                               regulator-always-on;
>                                 regulator-min-microvolt = <3300000>;
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-name = "vcc-wifi-1";
>                         };
>
>                         reg_cldo3: cldo3 {
> +                               /*
> +                                * This regulator is connected with CLDO2.
> +                                * See the comments for CLDO2.
> +                                */
> +                               regulator-always-on;
>                                 regulator-min-microvolt = <3300000>;
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-name = "vcc-wifi-2";
> --
> 2.18.0
>
