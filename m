Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B2EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249D2222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4U8F7EB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbfBMNPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:15:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41126 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733075AbfBMNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:15:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id e17-v6so1952513lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kk0uXEtDGFeuQ7BmGJpm/lypD4HdVbYq30UwslEG62I=;
        b=J4U8F7EBI0rzGCj+N0bD6iQBDrmLeDhNcQ+g+lNl46ez+aow4ai10TxYBT85b8Pn01
         /p6TVm1bQ7AjJfQ2ZETvmvP51eYjjQFgHS4wkr4++jm6knExmqY2cLDwegklDaQXTxig
         yk4YvE5C0rp5hLdVyWV7FuNtHxEu3h2dtLvE5piEPo7bjP3cLj1EKbj+f/Bl0kp7IX+0
         3xVXmVPHoYUsXSk/tpXmUBLinhsJ2+fa+Bh3nIyxqmGdcHYzKH4TinhVLF3GYWmrPmWd
         ov3beLAIeyj+kZRzySKJ4ddTnGVUONWY7Hs2BDltzvKpTwkt69Q8veJlC7UYUxHAD6hz
         Mx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kk0uXEtDGFeuQ7BmGJpm/lypD4HdVbYq30UwslEG62I=;
        b=mT65ziz+WKlb7kqwMIoE+J1/XSG/TidAT1Xo8JN6KmTp2nrSWyOTO+NXebDvnEd0wl
         TUMM/oQonSzlfj0nVH3A3iFvHJ+bo0sH30LMpcELoGWOSDElL7wn3X1e9lGeGYBxyG7Z
         5b/tQujMb7HMeZ3NpMw2VNaey6knrZ5rneL48u4a4qqjgSdcv8Yh1mTmCWv9+xAof+2p
         vyAqZpbvcf6NhwEzj/029onZxKklHGBjhTNWlMxf0QqIeaZXJ7RhlbDcGD9Dh8dksvE8
         wD7smt5od5yg4qglPGYWa0w9tXqkefPWg77Vl37wWsAQ31OvC6u0kO+n+tKqdF7IRp22
         cK8A==
X-Gm-Message-State: AHQUAuZf9uVDcj4GVX351dE4t5UWW6o1icUD+fYBUBysDM5eoW+gsAq1
        rW7q2C1Ijo/8+BhzPealJKlMSZiB2V0c9H8lvG33kQ==
X-Google-Smtp-Source: AHgI3IYfQHZlf/+TKgo9gjcXFsKx6ZtD0H9uRU2Emos79oqs5v29WLAe+EYzoUOoCR2Vo5DjL/yRLT9v3Fvb1TzEJ0Q=
X-Received: by 2002:a2e:868c:: with SMTP id l12-v6mr302969lji.90.1550063701990;
 Wed, 13 Feb 2019 05:15:01 -0800 (PST)
MIME-Version: 1.0
References: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
 <0438b78c7f9f9bc3f0e7bcbcef3873fd2dd7e259.1550061925.git.baolin.wang@linaro.org>
 <CAMpxmJWuMWBSPjoJWkfagAAopYjohA0rhxUacNPXhhiTFZJorA@mail.gmail.com>
In-Reply-To: <CAMpxmJWuMWBSPjoJWkfagAAopYjohA0rhxUacNPXhhiTFZJorA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 13 Feb 2019 21:14:49 +0800
Message-ID: <CAMz4kuJRvYo699J5SiG9mhjy5pt1hke8yXwoj9KfmZBTKkkKzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sprd: Change to use SoC compatible string
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 20:59, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> =C5=9Br., 13 lut 2019 o 13:49 Baolin Wang <baolin.wang@linaro.org> napisa=
=C5=82(a):
> >
> > Change to use SoC compatible string instead of wildcard string.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/gpio/gpio-pmic-eic-sprd.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic=
-eic-sprd.c
> > index ac573da..24228cf 100644
> > --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> > +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> > @@ -364,7 +364,7 @@ static int sprd_pmic_eic_probe(struct platform_devi=
ce *pdev)
> >  }
> >
> >  static const struct of_device_id sprd_pmic_eic_of_match[] =3D {
> > -       { .compatible =3D "sprd,sc27xx-eic", },
> > +       { .compatible =3D "sprd,sc2731-eic", },
> >         { /* end of list */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, sprd_pmic_eic_of_match);
> > --
> > 1.7.9.5
> >
>
> We guarantee to make older device-trees to work with new kernel so you
> can add the new compatible, but you can't remove the old one.

But the old one is incorrect, and we still keep it?

--=20
Baolin Wang
Best Regards
