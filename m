Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F17C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C72320851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xctf7CCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C72320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeKSVTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:19:12 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46634 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeKSVTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:19:12 -0500
Received: by mail-yw1-f66.google.com with SMTP id t13so8560473ywe.13;
        Mon, 19 Nov 2018 02:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yDHJ9WEAtZrh6l0A43FDDnSkxSeOLqOQXHJ8GFKJQfw=;
        b=Xctf7CCOacmXbjHIi00dtpD2tLPvfTbFKEBFapYkeJYOl7Tfd8LaILKYAYBX33X0SG
         /fGCbGGm9rncblUbo4UNKXpFCMk3B2LCyrZ1ypZEPj+EyB5MUe/I/z+K/js4t8DZe3CM
         WlGr1hwsQBM1W6DU8VBAlVd6PINsLZvL4dzX2mS5YyJZ87rvYD5mVRlCCuF9wuHRULlh
         ywJKNd2+kFW2fzbbzVpJKdYXtT1QGlZ7fzxcxJPiyatTCbu4nPTmIQHX0V5YaQWy1PiJ
         GTqzzqLE4KdaLwbV/SAA4hcWyqlPA/f6BVYmyGBwvIk5m6J65NYMdMF5ChYin5kZUCG4
         fIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yDHJ9WEAtZrh6l0A43FDDnSkxSeOLqOQXHJ8GFKJQfw=;
        b=r6pmVc8iHBwLdUDiUKdkCibHQZDcCOXASjVgksAtCOAWghq4Yvnw/GH6nZMCKNSa3P
         0yFUPz4owLuKHOWbE4jvR3JiCaSNSFgA+LXrrfx9EYuIidmmR15HdOgPzMRp7BkXgLNI
         jNauxxtXPbQRyVG/Sw10Y8YnjJfgpbP7FF+MBY48XJcCyZA4ABJm37lRBtxo3NHU8+GS
         EUXGqYTplEM0YTCGwYVQlxkPY2WVe2ZC6u+f1bg3hJRbTX4KWQxKiVCDIM+5lo9AeOOS
         wnRStontOOY4A2wvQzNgIjmqJ7bOjsdsU+xlFK4INOKrmEC9daDT7gn8sYsbxSVGUMnf
         RdQw==
X-Gm-Message-State: AGRZ1gLIy7wPRWgwPdFcJiCGOFd8gUxDZiGSDYwtfrRhtKnO1DVwprS+
        rlovtiqesqgWr7mMD2B4Zf2T7eGmcvasqqijfNM=
X-Google-Smtp-Source: AJdET5eRHIafhbpd1Ua7PxzXnPTEWox01a4X9s/miBIR/spca5Edia+2UOLCyr+0CUPEvxBcb4yZHTkGO59GDEVcp60=
X-Received: by 2002:a81:a40d:: with SMTP id b13-v6mr7114398ywh.345.1542624955349;
 Mon, 19 Nov 2018 02:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20181114121642.1404-1-peron.clem@gmail.com> <20181114121642.1404-2-peron.clem@gmail.com>
 <20181117155140.GA11554@bogus>
In-Reply-To: <20181117155140.GA11554@bogus>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 19 Nov 2018 11:55:44 +0100
Message-ID: <CAJiuCceJTd-h2WDZHtkpeO=-Zqcc2Kf-AY8KV8LrY9NM-BP+jg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: add bindings for AK4118 transceiver
To:     Rob Herring <robh@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sat, 17 Nov 2018 at 16:51, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 14, 2018 at 01:16:42PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Document the bindings for AK4118 S/PDIF transceiver
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  .../devicetree/bindings/sound/ak4118.txt      | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/ak4118.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/ak4118.txt b/Docum=
entation/devicetree/bindings/sound/ak4118.txt
> > new file mode 100644
> > index 000000000000..6e11a2f7404c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/ak4118.txt
> > @@ -0,0 +1,22 @@
> > +AK4118 S/PDIF transceiver
> > +
> > +This device supports I2C mode.
> > +
> > +Required properties:
> > +
> > +- compatible : "asahi-kasei,ak4118"
> > +- reg : The I2C address of the device for I2C
> > +- reset-gpios: A GPIO specifier for the reset pin
> > +- irq-gpios: A GPIO specifier for the IRQ pin
>
> This should use 'interrupts' instead.
Yes, this will also simplify the driver.

>
> > +
> > +Example:
> > +
> > +&i2c {
> > +     ak4118: ak4118@13 {
>
> spdif@13 ? Node names should be based on the class of device, but
> there's not really one defined for this.

Ok I will use spdif.

Thanks for the comments,
Clement

>
> > +             #sound-dai-cells =3D <0>;
> > +             compatible =3D "asahi-kasei,ak4118";
> > +             reg =3D <0x13>;
> > +             reset-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW>
> > +             irq-gpios =3D <&gpio 1 GPIO_ACTIVE_HIGH>;
> > +     };
> > +};
> > --
> > 2.19.1
> >
