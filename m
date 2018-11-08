Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1CAC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B092081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B092081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeKHRE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:04:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43741 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHREZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:04:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id e4so6437867edv.10;
        Wed, 07 Nov 2018 23:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtWEBbGABzAwZgBES+26/cfkHn0ddtHnsn30YoVZrHg=;
        b=sF2qnWYtgWqCaMnNi+spXnbXGmrBNv2N18aD7uAZarAg9n+IpIQwdxv2I/YbYyy4+F
         b6Yq3PyCOtqJJA7hRjsC23SC2wFAEJLdvbDqAG0sQKpfZPfry+TxpP7M8EKC+ljBWjpt
         +oKqdfU7H5ozxTWxJIaoEqDcbAcJSd8pycaTDyLYjsDYk3FUYuLAdOfmJWFQT+kQo4G8
         Q8N6yk4bdCBhfrOU5DlluYZG6OBRjCjgqeWAdFg16P1buIp5BYQ17aq47JlarmlCV7EN
         5QBH7f4pqzC1zcmVolux/NrDSnTIYqobcFVOeCvfg4di9QbZrmi8qmwXWxGlC4GswOPW
         Rn6Q==
X-Gm-Message-State: AGRZ1gIfsSwta8e4ya6o12AlBKoWaxAOZdHZ1wMEAkJsF9ru4rOsTGXr
        GJP4b1cXzavQudBBUiSvHIo9A+tJdQg=
X-Google-Smtp-Source: AJdET5eXFoe0o8GHZ7c0/fUJQ0dLcygGhNopx6Zwiv95tn05WK62TOP+9vzk56j5d1y7OmOIiFyiqw==
X-Received: by 2002:a50:9472:: with SMTP id q47-v6mr2864512eda.260.1541662214375;
        Wed, 07 Nov 2018 23:30:14 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id h1-v6sm451998eja.45.2018.11.07.23.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 23:30:13 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id y3-v6so19747823wrh.10;
        Wed, 07 Nov 2018 23:30:13 -0800 (PST)
X-Received: by 2002:adf:e307:: with SMTP id b7-v6mr3177504wrj.91.1541662213363;
 Wed, 07 Nov 2018 23:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20181108063929.29720-1-anarsoul@gmail.com> <20181108063929.29720-4-anarsoul@gmail.com>
In-Reply-To: <20181108063929.29720-4-anarsoul@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 8 Nov 2018 15:29:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
Message-ID: <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: allwinner: a64: enable sound on Pinebook
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
> Pinebook
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index 77fac84797e9..73f171f4ba9b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -64,6 +64,23 @@
>                 compatible = "mmc-pwrseq-simple";
>                 reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>         };
> +
> +       speaker_amp: speaker_amp {
> +               compatible = "simple-audio-amplifier";
> +               enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */

You might want to add a sound-name-prefix property. See

    Documentation/devicetree/bindings/sound/name-prefix.txt

Also this should have a reference to its power supply regulator.

> +       };
> +};
> +
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
>  };
>
>  &ehci0 {
> @@ -267,6 +284,31 @@
>         vcc-hdmi-supply = <&reg_dldo1>;
>  };
>
> +&sound {
> +       status = "okay";
> +       simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
> +                                   "Microphone", "Internal Microphone Right",
> +                                   "Headphone", "Headphone Jack",
> +                                   "Speaker", "Internal Speaker";
> +       simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
> +       simple-audio-card,routing =
> +                       "Left DAC", "AIF1 Slot 0 Left",
> +                       "Right DAC", "AIF1 Slot 0 Right",
> +                       "INL", "LINEOUT",
> +                       "INR", "LINEOUT",
> +                       "Internal Speaker", "OUTL",
> +                       "Internal Speaker", "OUTR",
> +                       "Headphone Jack", "HP",
> +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> +                       "Left ADC", "ADC",
> +                       "Right ADC", "ADC",
> +                       "Internal Microphone Left", "MBIAS",
> +                       "MIC1", "Internal Microphone Left",
> +                       "Internal Microphone Right", "HBIAS",
> +                       "MIC2", "Internal Microphone Right";

The schematics is missing the actual jack, but this looks to be correct.

ChenYu

> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pb_pins>;
> --
> 2.19.1
>
