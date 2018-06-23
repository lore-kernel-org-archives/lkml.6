Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C42C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2379F24C34
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2Zcanin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2379F24C34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeFWOuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 10:50:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35443 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeFWOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 10:50:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id j15-v6so5573675wme.0;
        Sat, 23 Jun 2018 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ImOmUS17L5IuKye3hDV/wxFbESvlvdzZwB5bnaFGAk=;
        b=X2ZcaninlsXOkodiWDpHBMnUvi3CzxKhQqTKccQa3FyJnyMo+f1YEwwNJzsHkVwHOa
         yAHkm4LUzBCkc1foGwUs2cbTHMIUDzD6tDWxZb69xPHHlayPW4ZnuSUvlww89oQw7FVh
         vt4lC9BMNmQjI1/kGEhR2VgFNJMWXJsTuu+cIGhuKBisJ/n4n92xm5NkLNo/nCAOQ3tj
         I+VdvH5KKH4sIQFkv2XZK3RFEF9KWdVfzXAyXTpuZZuwJ5TOBhIsspgQ3qfW4nGLiUmY
         5LDQaot6srLBpUfNKXy4AmnWHL+XzNJ+tlj/tjZAT3A/9+W73bE8mAn4vPitjqDmZdZz
         iFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ImOmUS17L5IuKye3hDV/wxFbESvlvdzZwB5bnaFGAk=;
        b=Z1GYP3UpI/OCx5PnpUGwHJ7YNckUWM6Jm2rD20RPILp4HKrwzHms4K3G5U4M0Mi/49
         jCcpEO50rfrRwdYdXa+MGHU+/0eIWShp8EbmdSF/OFWWJ+45EPbwN7J7pscqW0f/gJrj
         LPV8HMjglVt4c7ggQfWW7X4VYznFuc5vVe2Wps4qV+vkbHfQ5+Tbmld0mCTKpRO7qu2p
         MwFZdpOFpX4s8pE44vuEnZR0dEiO8JoeSP5uvYiV0I4IakXUkDAswO318jTUfLpVDk4X
         zphvukOkVcMtjqLN6tWQ6sCZaFKljkkTUfheSfCrItkjReMqL6eqIg9ApTug9hRiaHTf
         xrSQ==
X-Gm-Message-State: APt69E2MG7mO9lwUaPZOxkML0z5OxzEWXVT9NEsDFx9ABmwRovNnkaac
        CkIGIPu7E/1djmRoj+lGAIIlF4s6fcTuVM8jXT8=
X-Google-Smtp-Source: ADUXVKKagfUY0d1L1UAJbBjfuCvNv+ja9rSW2uVpNNv/16IZC0nzPiQC6FKebZxgZHjC94NvhVPGwmY3n+sFo6Ej1BA=
X-Received: by 2002:a1c:b94a:: with SMTP id j71-v6mr123115wmf.28.1529765404166;
 Sat, 23 Jun 2018 07:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180622124540.56203-1-icenowy@aosc.io> <20180622124540.56203-4-icenowy@aosc.io>
 <CAGRGNgUuEjmEcvJ3OUcQ9_6bPs9fDvKzUFm_NfCsYyjxVOVw3A@mail.gmail.com> <3BDC9318-95A5-41BA-801E-6E0814249AFB@aosc.io>
In-Reply-To: <3BDC9318-95A5-41BA-801E-6E0814249AFB@aosc.io>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sun, 24 Jun 2018 00:49:50 +1000
Message-ID: <CAGRGNgUkVjEmhQS4pTezfhmiOQkCERV-w=aA+i4oLN7C8k4Vnw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 5/7] arm64: allwinner: a64: add necessary
 device tree nodes for DE2 CCU
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, jagan@amarulasolutions.com,
        jernej.skrabec@siol.net, devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On Sun, Jun 24, 2018 at 12:34 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> =E4=BA=8E 2018=E5=B9=B46=E6=9C=8823=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
10:06:27, Julian Calaby <julian.calaby@gmail.com> =E5=86=99=E5=88=B0:
> >Hi Icenowy,
> >
> >On Fri, Jun 22, 2018 at 10:49 PM Icenowy Zheng <icenowy@aosc.io> wrote:
> >>
> >> As we have all necessary parts to enable the DE2 CCU on the Allwinner
> >> A64 SoC, add the needed device tree nodes, including the DE2 CCU
> >itself
> >> and the DE2 bus.
> >>
> >> The "mixer0-lcd0" simplefb device node is updated to use the DE2 CCU.
> >>
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >> Changes in v2:
> >> - Drop SRAM controller device tree node addition (as it's already
> >added
> >>   as part of syscon change.)
> >> - Fix the clock reference in LCD SimpleFB.
> >>
> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 30
> >+++++++++++++++----
> >>  1 file changed, 24 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> index ff2ddde1e117..318c4ba8ae9f 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> @@ -58,17 +60,12 @@
> >>                 #size-cells =3D <1>;
> >>                 ranges;
> >>
> >> -/*
> >> - * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2
> >CCU.
> >> - * However there is no support for this clock on A64 yet, so we
> >depend
> >> - * on the upstream clocks here to keep them (and thus CLK_MIXER0)
> >up.
> >> - */
> >>                 simplefb_lcd: framebuffer-lcd {
> >>                         compatible =3D "allwinner,simple-framebuffer",
> >>                                      "simple-framebuffer";
> >>                         allwinner,pipeline =3D "mixer0-lcd0";
> >>                         clocks =3D <&ccu CLK_TCON0>,
> >> -                                <&ccu CLK_DE>, <&ccu CLK_BUS_DE>;
> >> +                                <&display_clocks CLK_MIXER0>;
> >
> >Doesn't this technically break simplefb if this DT is used with a
> >Linux that doesn't have the display clock driver?
>
> 1. DT doesn't care forware compatibility.

Ah, fair enough, that answers my question.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
