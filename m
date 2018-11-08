Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A029CC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D41E2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D41E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeKHQqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:46:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35613 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:46:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id e18-v6so4102111eds.2;
        Wed, 07 Nov 2018 23:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGE1zq6WIscQJ/i/2eSho8DZ1cEBYdVFOD9tCiOz6d0=;
        b=SBoLxnhYUDrrNRLBeyjlF3NVNSFD6xlzUZpb02a1+klHdKl89BjO306X2KoodPgRuQ
         DEIcEw/ETuiTzoPMi7RLw4m1DGKMq0P1X/ME0sa1BHHGps++2Ld1VcVO+7OieFDKhYQk
         DeLrH8bkYLLhmje04Qm8xc51x033xR/4Y4cQdZIxSR43oC00FJ+pq24polxyYhdcp6Rm
         yPEF3/clfJsldcFykY1tchq+VcZz2tSD+zvzpaUD1R2Fo66Fmn512nJoXIahzAijYi76
         XK65UG4nojwPTAaBKJKH5/leliiHzY1A2H4rGzbI6jarIsQRbRLt22MYoQHt94MO4VQv
         woXg==
X-Gm-Message-State: AGRZ1gIZBAT7HO8xpAAo6TNfH5h5yrXwZHMCDPzTnsEw+rsI3O1TBAYY
        Iyw+i6l93JPBzxw07uizXACymLa0DII=
X-Google-Smtp-Source: AJdET5cxBcfMCQSv9MwG5mU3Cvftj5HnFNMtXarHiNDHAUYemkwJRltSgh0LjJqddILTv0ko/L3+MQ==
X-Received: by 2002:a05:6402:1509:: with SMTP id f9mr2579268edw.286.1541661114128;
        Wed, 07 Nov 2018 23:11:54 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id j26-v6sm897846ede.73.2018.11.07.23.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 23:11:53 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id o15-v6so16375153wrv.4;
        Wed, 07 Nov 2018 23:11:53 -0800 (PST)
X-Received: by 2002:adf:e307:: with SMTP id b7-v6mr3118521wrj.91.1541661113350;
 Wed, 07 Nov 2018 23:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20181108063929.29720-1-anarsoul@gmail.com> <20181108063929.29720-3-anarsoul@gmail.com>
In-Reply-To: <20181108063929.29720-3-anarsoul@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 8 Nov 2018 15:11:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v64GUsd2gsZ8B-4AJodJN5_rfafGAiaOng5HsphkGJYxGA@mail.gmail.com>
Message-ID: <CAGb2v64GUsd2gsZ8B-4AJodJN5_rfafGAiaOng5HsphkGJYxGA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] arm64: dts: allwinner: a64: enable sound on Pine64
 and SoPine
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 2:42 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> This commit enables I2S, digital and analog parts of audiocodec on
> Pine64 and SoPine boards.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 28 +++++++++++++++++++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts | 28 +++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index c077b6c1f458..ff352bdfbb93 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -75,6 +75,18 @@
>         };
>  };
>
> +&codec {
> +       status = "okay";
> +};
> +
> +&codec_analog {
> +       status = "okay";
> +};
> +
> +&dai {
> +       status = "okay";
> +};
> +
>  &de {
>         status = "okay";
>  };
> @@ -264,6 +276,22 @@
>         status = "disabled";
>  };
>
> +&sound {
> +       status = "okay";
> +       simple-audio-card,widgets = "Microphone", "Microphone Jack",
> +                                   "Headphone", "Headphone Jack";
> +       simple-audio-card,routing =
> +                       "Left DAC", "AIF1 Slot 0 Left",
> +                       "Right DAC", "AIF1 Slot 0 Right",
> +                       "Headphone Jack", "HP",
> +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> +                       "Left ADC", "ADC",
> +                       "Right ADC", "ADC",

As mentioned the above two don't belong in the device tree.

> +                       "Microphone Jack", "HBIAS",

Schematics says this is NC or not connected by default.
You may want to ask Pine64 about this?

Same comments for SoPine.

> +                       "MIC2", "Microphone Jack";
> +};
> +
>  /* On Exp and Euler connectors */
>  &uart0 {
>         pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index 53fcc9098df3..25d732df37c4 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -80,6 +80,18 @@
>         };
>  };
>
> +&codec {
> +       status = "okay";
> +};
> +
> +&codec_analog {
> +       status = "okay";
> +};
> +
> +&dai {
> +       status = "okay";
> +};
> +
>  &de {
>         status = "okay";
>  };
> @@ -164,6 +176,22 @@
>         vcc-hdmi-supply = <&reg_dldo1>;
>  };
>
> +&sound {
> +       status = "okay";
> +       simple-audio-card,widgets = "Microphone", "Microphone Jack",
> +                                   "Headphone", "Headphone Jack";
> +       simple-audio-card,routing =
> +                       "Left DAC", "AIF1 Slot 0 Left",
> +                       "Right DAC", "AIF1 Slot 0 Right",
> +                       "Headphone Jack", "HP",
> +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> +                       "Left ADC", "ADC",
> +                       "Right ADC", "ADC",
> +                       "Microphone Jack", "HBIAS",
> +                       "MIC2", "Microphone Jack";
> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pb_pins>;
> --
> 2.19.1
>
