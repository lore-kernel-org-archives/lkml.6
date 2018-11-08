Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030FFC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DEF2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prKRpOFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DEF2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeKHRCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:02:00 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44692 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeKHRB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:01:59 -0500
Received: by mail-oi1-f194.google.com with SMTP id p82-v6so223952oih.11;
        Wed, 07 Nov 2018 23:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNufBwDcRL3hzjwvjzXhe07LXYOhVM9WbqMAvMBsliU=;
        b=prKRpOFhHxfXX9WCpA2+YapIViFNIvC+64vuStb9ZVRVfVF5nptSq0mOlmLF5zMvDS
         37KbAdopReMODPp3ojkiZPI5D+9bklOkP3aB8i9LXQHe/FGuyWrwUSRkMtuO50ZKpyhi
         vpR1i8dDImraWo2nxOal781F+/u3bEz2AWIWgbmBPGAjXHUNqEX0clSTBx1bCKvvYPf9
         MuyO+EZFcC2+loeBfY4M8dI2ZqfyhAcyzJYWwaPfn8BFvrMR6s1e6NZ8h1NNzUSFGf3x
         KAR3bWJz4plgyTnQ26jAwJBZJH7yWW8zgwR/ejkRBO4hTzvrNnFFJ00XLi6m4xUTeleb
         ExNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNufBwDcRL3hzjwvjzXhe07LXYOhVM9WbqMAvMBsliU=;
        b=bymPBvjkOa8W9ZrYNov7dTe5/docDaURPoJ3i09MpHzbIYxEmdHvI7gwz/aSxNEeae
         P7jMhxLMee+QtOZYmwxBhEJkQL6tva1RM8y1anR9OmRJEwshlMb1fa2VezCvJDJ2evrZ
         gwZy4Sl+lWCi8soebfDhKAlRcRhs8R2NAJeIYfrPOy0rUzAuiqMitaJ2UxJXE+6eYHct
         98E27tCn0IHZCb7er61JmPx6A804LPgaKyTd6+VfpQcid8xSxf2d5iN6ksu4yGMwtV75
         Lk9Ai9aDraDw5xVolkuAQu8UEypNkPk1BfrXGuLWufOqrj6rBdFToeLRa/yriKI1T7lf
         8wMw==
X-Gm-Message-State: AGRZ1gJ5EuOBsWtkTgN/GKOMa66qn9l7jeu0zBj1azFuICx5hNC19d93
        e6cjRb0dHj8a3oEwEB5gqnUg1GZFBsbLk5KXMkY=
X-Google-Smtp-Source: AJdET5d1ggQak7ruVKe5lWmSvw0HFxtkdXC6x0WFqwD9E3QgnmsKVvGU8u7ojZxBHxmS5v33IhqEnHDiXazmglNsNM8=
X-Received: by 2002:aca:b68b:: with SMTP id g133-v6mr2037317oif.25.1541662070349;
 Wed, 07 Nov 2018 23:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20181108063929.29720-1-anarsoul@gmail.com> <20181108063929.29720-3-anarsoul@gmail.com>
 <CAGb2v64GUsd2gsZ8B-4AJodJN5_rfafGAiaOng5HsphkGJYxGA@mail.gmail.com>
In-Reply-To: <CAGb2v64GUsd2gsZ8B-4AJodJN5_rfafGAiaOng5HsphkGJYxGA@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 7 Nov 2018 23:27:23 -0800
Message-ID: <CA+E=qVdwgYoNTncVDV7T1Eh=nRZG_8Q5uHSU4ZmDgUuG7+qP_A@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] arm64: dts: allwinner: a64: enable sound on Pine64
 and SoPine
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

On Wed, Nov 7, 2018 at 11:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 8, 2018 at 2:42 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > This commit enables I2S, digital and analog parts of audiocodec on
> > Pine64 and SoPine boards.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 28 +++++++++++++++++++
> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 28 +++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> > index c077b6c1f458..ff352bdfbb93 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> > @@ -75,6 +75,18 @@
> >         };
> >  };
> >
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
> > +};
> > +
> >  &de {
> >         status = "okay";
> >  };
> > @@ -264,6 +276,22 @@
> >         status = "disabled";
> >  };
> >
> > +&sound {
> > +       status = "okay";
> > +       simple-audio-card,widgets = "Microphone", "Microphone Jack",
> > +                                   "Headphone", "Headphone Jack";
> > +       simple-audio-card,routing =
> > +                       "Left DAC", "AIF1 Slot 0 Left",
> > +                       "Right DAC", "AIF1 Slot 0 Right",
> > +                       "Headphone Jack", "HP",
> > +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> > +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> > +                       "Left ADC", "ADC",
> > +                       "Right ADC", "ADC",
>
> As mentioned the above two don't belong in the device tree.
>
> > +                       "Microphone Jack", "HBIAS",
>
> Schematics says this is NC or not connected by default.
> You may want to ask Pine64 about this?
>
> Same comments for SoPine.

I'll just drop it. Not connected on schematics - we don't put it in dts.

>
> > +                       "MIC2", "Microphone Jack";
> > +};
> > +
> >  /* On Exp and Euler connectors */
> >  &uart0 {
> >         pinctrl-names = "default";
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > index 53fcc9098df3..25d732df37c4 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > @@ -80,6 +80,18 @@
> >         };
> >  };
> >
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
> > +};
> > +
> >  &de {
> >         status = "okay";
> >  };
> > @@ -164,6 +176,22 @@
> >         vcc-hdmi-supply = <&reg_dldo1>;
> >  };
> >
> > +&sound {
> > +       status = "okay";
> > +       simple-audio-card,widgets = "Microphone", "Microphone Jack",
> > +                                   "Headphone", "Headphone Jack";
> > +       simple-audio-card,routing =
> > +                       "Left DAC", "AIF1 Slot 0 Left",
> > +                       "Right DAC", "AIF1 Slot 0 Right",
> > +                       "Headphone Jack", "HP",
> > +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> > +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> > +                       "Left ADC", "ADC",
> > +                       "Right ADC", "ADC",
> > +                       "Microphone Jack", "HBIAS",
> > +                       "MIC2", "Microphone Jack";
> > +};
> > +
> >  &uart0 {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&uart0_pb_pins>;
> > --
> > 2.19.1
> >
