Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9975C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8251222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXmLJXq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437329AbfBNH4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:56:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46690 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387620AbfBNH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:56:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so3790265lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 23:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4TrRhGwOdgFn3xmHlA9D/ZKuyBptGMlZtNkvWqQnKrw=;
        b=gXmLJXq54IGI2wrSJZKhht/Xe2h5QOjk6SznOMsQUTAKA5OunR3n3MRo4hbacScrPn
         paB3nkhwYQybJH0PPwfSxGhcnKiad8GFvby9i7OjZtEntKZYJgd5PZBANPc96DJg29Hq
         LTh7/Ex759t5tISp6JsTL9+tH8ikRTyf66d9vNnW9uwOQDWkUS0GqVp3jA/njdpFWpT1
         C+a7OQ5odVfVksQwxS5evkno8npBLXgoXnvDJNM29QL0mA3jADaTFVn9o0CA9UK4grwL
         CJ19fI0jg1BlHYsJDN/NnoAkrr2X7IUPDrN8aFuLh5/jUOyYafpPDDRGlX+2eTC4/su9
         Sdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4TrRhGwOdgFn3xmHlA9D/ZKuyBptGMlZtNkvWqQnKrw=;
        b=uCqlAGo8pryAI6CVDRYiHPGcZ8hcpfQTTljDAlx240vTL1PE9AizW7FXX8oXnkhqOJ
         iEq5o1zw0WZY8RzCI4ouCeXGeb2y15geeLaub1FXt2jFkmL126FHSjp/cjJvJSa+acrS
         8IAqBbkFGV3ubBCrHECQyoD8lOVky9fr/wRfqmMWKVaoHHypSUvGlemkVvczu8Oo75Dx
         sGKzTodiILBdI6g4OJrY9vi9R+R6xueIMropu+oIIg0+1yYXgSYzA28WQBkFQHIfU7G0
         PTzf0MZTG8W2YQCfMD9/Ob321WB5V2sfYse6t22lIU1VwOD1OsWTaywL1XfV5XmudxaV
         WHkA==
X-Gm-Message-State: AHQUAubUH8AcVqmYjTdzDn75G2xnhaNiAovwUdb/lSsYS3donKLdA9sR
        DBw7VkqMimy+wCi/TaviymeNZKdWukl6jKctJl4wFw==
X-Google-Smtp-Source: AHgI3IYNoFkaurGQtXYsEic2K5nWpLxbSWARJY7Xt5pq+LAsxag2ec+bZcu0FSbAjBeqeHiCmVqejPZb4YumvBBqpew=
X-Received: by 2002:a19:ec0c:: with SMTP id b12mr1507153lfa.27.1550130997253;
 Wed, 13 Feb 2019 23:56:37 -0800 (PST)
MIME-Version: 1.0
References: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
 <0438b78c7f9f9bc3f0e7bcbcef3873fd2dd7e259.1550061925.git.baolin.wang@linaro.org>
 <CAMpxmJWuMWBSPjoJWkfagAAopYjohA0rhxUacNPXhhiTFZJorA@mail.gmail.com>
 <CAMz4kuJRvYo699J5SiG9mhjy5pt1hke8yXwoj9KfmZBTKkkKzw@mail.gmail.com> <CAMpxmJXbuOuMvxe+bXqjaCrVU5WXxQ=fZTU9iA8Opnqrx25eMQ@mail.gmail.com>
In-Reply-To: <CAMpxmJXbuOuMvxe+bXqjaCrVU5WXxQ=fZTU9iA8Opnqrx25eMQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Feb 2019 08:56:26 +0100
Message-ID: <CACRpkdZ8vrNjju=Lmqu5x7VqKB7C2GU-oiryCRpcpCf2rBo4UA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sprd: Change to use SoC compatible string
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Wed, Feb 13, 2019 at 5:10 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> =C5=9Br., 13 lut 2019 o 14:15 Baolin Wang <baolin.wang@linaro.org> napisa=
=C5=82(a):
> >
> > On Wed, 13 Feb 2019 at 20:59, Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> wrote:
> > >
> > > =C5=9Br., 13 lut 2019 o 13:49 Baolin Wang <baolin.wang@linaro.org> na=
pisa=C5=82(a):
> > > >
> > > > Change to use SoC compatible string instead of wildcard string.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > ---
> > > >  drivers/gpio/gpio-pmic-eic-sprd.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-=
pmic-eic-sprd.c
> > > > index ac573da..24228cf 100644
> > > > --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> > > > +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> > > > @@ -364,7 +364,7 @@ static int sprd_pmic_eic_probe(struct platform_=
device *pdev)
> > > >  }
> > > >
> > > >  static const struct of_device_id sprd_pmic_eic_of_match[] =3D {
> > > > -       { .compatible =3D "sprd,sc27xx-eic", },
> > > > +       { .compatible =3D "sprd,sc2731-eic", },
> > > >         { /* end of list */ }
> > > >  };
> > > >  MODULE_DEVICE_TABLE(of, sprd_pmic_eic_of_match);
> > > > --
> > > > 1.7.9.5
> > > >
> > >
> > > We guarantee to make older device-trees to work with new kernel so yo=
u
> > > can add the new compatible, but you can't remove the old one.
> >
> > But the old one is incorrect, and we still keep it?
> >
>
> Well in theory the device-tree is supposed to be a stable ABI so once
> it's released, it should work with any following kernel version.
>
> In practice changes are sometimes allowed and there are also bugs in DT f=
iles.
>
> Linus: what do you think?

In this specific case I'd keep both strings, it doesn't hurt does it?

You could add a comment to the wildcard string saying it is only there
for compatibility with elder device trees.

In general as long as there are not (a lot of) products shipped with
a certain device tree, I don't care much whether we change the bindings
or contents.

The hard rule to keep the device trees backward-compatible comes
from SPARC SunOS where the DTB was burned into a BIOS ROM
that was hard or impossible to update, Linux just had to handle
whatever was in there. If the situation with the device tree we change
is not similiar, we should not care either.

In practice there are companies and developers that always
recompile and ship their device trees at the same time as they
compile and ship their kernel, and in that case we need not care
about backward compatibility.

While the device tree enablement on ARM started out with the
former (strict) assumption, the practice of using DTs has shown
that it is an unrealistic and inappropriate stance to have for all
device trees. (IMO!) So I don't mind if you break compatibility here.

Yours,
Linus Walleij
