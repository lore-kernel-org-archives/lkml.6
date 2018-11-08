Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3031BECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF14F20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSfeWMRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF14F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeKICEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:04:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45658 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKICEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:04:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id p144-v6so17382607oic.12;
        Thu, 08 Nov 2018 08:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqwC/MXTF+MXiQ+QadDmgzWzBhRRPFCZ5JeJPIisQkk=;
        b=mSfeWMRQIvkWPpWf1maE430x58mCX+qGCZ9UviQ7Z/t56aOS5MBkAmv51OWjx26LOD
         gs9h9SpYqLkwVlbJRQt8c1UaEy1lnVU4038ztJ2R0CPqEyDAINX8kdU+xp7cxUtitA7B
         SCYgrpzGceGPMoOEC8VSUgsulnOszWlHLr4MMcEcXlSgiNZWOzn6GFKvbzlr8RqcNabI
         RxSJmVpZWAyt/XreTRJwH6gJBiiak+f0tRTfxsPj0IjE/GF5xEZMonbCKYwAC/YJMhwp
         TpeyrDssgY1JBp3VkMzAIVOtBIqSEC30hasA6Zb6LuyhB9vvxTcRX+WTWkKz8mBiSyhG
         j6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqwC/MXTF+MXiQ+QadDmgzWzBhRRPFCZ5JeJPIisQkk=;
        b=cl+BZAGMtkzYMmOAPwjzcv7MZs/QuIvKmjBlj+ZNIVVx0CJPeBJW9g99/f2a9VPv3H
         0dGVPsiJCvwF2gDQlArCw7eJOYr4Gxp1Whns57TjpbJ06XXeg6hU+saX0VC1MBUNfY9f
         3Hf2nk0lO2Td7jRDTH85dGntkffDzv6d9Wom1FUWa6mP+B+M+mvegSZp5EtDww7+qNpj
         aD6jXoPXOfMP0iyd/vkwe374B+OrHwmGoVCKAFUXBeXQ8K7lqe9bVucHqs8osl/lLMWA
         qZrQwNhDMugZCm/Vi6NAykScyW8dcCm08vEIv8e1BvyppO0B1vIEV9H1e117GCZZUJ09
         Wpqg==
X-Gm-Message-State: AGRZ1gLddmgPBGprR0cKinosis8oXr9qyp9v7z4dy4ugfp7S/Vuk35rh
        zqviT/5u2K4aEGvXY5I1yvgpr2JUcfVoodi0g7E=
X-Google-Smtp-Source: AJdET5fY1uhfJsajK+RDLyexjONaqzI0+YS2CHz1W1vmxm5LTBswqdL7JZ/cE2terepb7h1Zlf3zDvGmSrJA+JZcj4M=
X-Received: by 2002:aca:3441:: with SMTP id b62-v6mr855470oia.145.1541694513687;
 Thu, 08 Nov 2018 08:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20181108063929.29720-1-anarsoul@gmail.com> <20181108063929.29720-4-anarsoul@gmail.com>
 <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
In-Reply-To: <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 8 Nov 2018 08:28:07 -0800
Message-ID: <CA+E=qVeG0g1axC1YhAhMOo2xcM3_5RupkiJEu3Aebaomx_7Gww@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: allwinner: a64: enable sound on Pinebook
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 11:30 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 8, 2018 at 2:42 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > This commit enables I2S, digital and analog parts of audiocodec on
> > Pinebook
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../dts/allwinner/sun50i-a64-pinebook.dts     | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > index 77fac84797e9..73f171f4ba9b 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > @@ -64,6 +64,23 @@
> >                 compatible = "mmc-pwrseq-simple";
> >                 reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> >         };
> > +
> > +       speaker_amp: speaker_amp {
> > +               compatible = "simple-audio-amplifier";
> > +               enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
>
> You might want to add a sound-name-prefix property. See

No need, there's only speaker amplifier in Pinebook.

>
>     Documentation/devicetree/bindings/sound/name-prefix.txt
>
> Also this should have a reference to its power supply regulator.

It's powered from V5P0_USB according to schematics, which comes out of
5V BOOST USB HOST MODE POWER - and it's not controlled by software. So
there's nothing to reference.

>
> > +       };
> > +};
> > +
> > +&codec {
> > +       status = "okay";
> > +};
> > +
> > +&codec_analog {
> > +       status = "okay";
> > +};
> > +
> > +&dai {
> > +       status = "okay";
> >  };
> >
> >  &ehci0 {
> > @@ -267,6 +284,31 @@
> >         vcc-hdmi-supply = <&reg_dldo1>;
> >  };
> >
> > +&sound {
> > +       status = "okay";
> > +       simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
> > +                                   "Microphone", "Internal Microphone Right",
> > +                                   "Headphone", "Headphone Jack",
> > +                                   "Speaker", "Internal Speaker";
> > +       simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
> > +       simple-audio-card,routing =
> > +                       "Left DAC", "AIF1 Slot 0 Left",
> > +                       "Right DAC", "AIF1 Slot 0 Right",
> > +                       "INL", "LINEOUT",
> > +                       "INR", "LINEOUT",
> > +                       "Internal Speaker", "OUTL",
> > +                       "Internal Speaker", "OUTR",
> > +                       "Headphone Jack", "HP",
> > +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> > +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> > +                       "Left ADC", "ADC",
> > +                       "Right ADC", "ADC",
> > +                       "Internal Microphone Left", "MBIAS",
> > +                       "MIC1", "Internal Microphone Left",
> > +                       "Internal Microphone Right", "HBIAS",
> > +                       "MIC2", "Internal Microphone Right";
>
> The schematics is missing the actual jack, but this looks to be correct.
>
> ChenYu
>
> > +};
> > +
> >  &uart0 {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&uart0_pb_pins>;
> > --
> > 2.19.1
> >
