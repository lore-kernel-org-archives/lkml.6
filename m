Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A557F222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="au7qM2zD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406670AbfBNKmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:42:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38466 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393812AbfBNKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:42:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id j19so4004410ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 02:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qFPkcS//3I+S5T0F1bJlYKgsC3PYj80U5NCyOX/5Lqg=;
        b=au7qM2zD8IKwvBTBG0z5UnS3O1YivNdV2gls98r8D7BT1Bd1fhQO+BGgnJdTHmHEeL
         xYayL168uSnvm2amizSfX0l1+yj9HqjHjqgIghZtkBL5H2Pb8LmYqv1TkTgqKysC9am6
         qU+NQX8/INrgm/JUWSLcBztDt4sPzjudSR/FgKjy+N+yCmZPjh5IGj+zkhtgpGrlaa3a
         U1ZSa+YxmiuR3oTwDtiUlYqLYqpDo3yh5NuKS1axWoXJSpXpJMi1hfab74LcOAqbacGZ
         KxciXSQrnINioiwCNXmP7RLHPNuFmAuuKCROf5CfejJACzZ5xebLe4WEwa3IPSawVPkR
         IDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qFPkcS//3I+S5T0F1bJlYKgsC3PYj80U5NCyOX/5Lqg=;
        b=kpaOvv0waYbyThHVutGVPqHF+0PDYOZqthzQeRJYgV8M7YKae2nLzm79QXcS9NuWUm
         7o3xfqdS9esODwWZ1jAM5kPmBJcg94SIKCuwR1k5g4dkBguxCQBp7t+FARzA8vG/x1hD
         M/ktIV9C/ohL27Z+rxri/RcUoIh0LNo7VfSRFs/zVgA8JG8vTLvV+1kNJ52QK5p51hbJ
         CytUZw0wCAE1Ehq2AgZYMDZAPKKEou+F5y76loclnTv8Lnd7cKR954Y1nnMSvT1/iaeU
         dg/abLLlFFr0js4XSKcjBputQmJ1cWI1ACeK7W8Dp/pApdJ/VZJm/yX53wtyeF02gA5K
         UnVw==
X-Gm-Message-State: AHQUAubiaBVT9MdTMFz2l0YAA6VE6k9k7AYmexohmkOWobetzaVzAiB2
        URcQFZs8j/RRQ6PA7g1FtsiBLP2Qn6khv6JxqjxKgg==
X-Google-Smtp-Source: AHgI3IZk/daeRU+FznHeZG5+hBq/p94p1aoEE6lp5FZhYaLqGZ9FcjzJaIyuOWDw8fOAIOy1UDeFq8s22siHHqydSlE=
X-Received: by 2002:a2e:3807:: with SMTP id f7mr232492lja.9.1550140954815;
 Thu, 14 Feb 2019 02:42:34 -0800 (PST)
MIME-Version: 1.0
References: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
 <0438b78c7f9f9bc3f0e7bcbcef3873fd2dd7e259.1550061925.git.baolin.wang@linaro.org>
 <CAMpxmJWuMWBSPjoJWkfagAAopYjohA0rhxUacNPXhhiTFZJorA@mail.gmail.com>
 <CAMz4kuJRvYo699J5SiG9mhjy5pt1hke8yXwoj9KfmZBTKkkKzw@mail.gmail.com>
 <CAMpxmJXbuOuMvxe+bXqjaCrVU5WXxQ=fZTU9iA8Opnqrx25eMQ@mail.gmail.com> <CACRpkdZ8vrNjju=Lmqu5x7VqKB7C2GU-oiryCRpcpCf2rBo4UA@mail.gmail.com>
In-Reply-To: <CACRpkdZ8vrNjju=Lmqu5x7VqKB7C2GU-oiryCRpcpCf2rBo4UA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 14 Feb 2019 18:42:21 +0800
Message-ID: <CAMz4kuKeMgZNf-_kO8j=8xPPy3o3pfZ=asv5hZX=2DKUSQBOhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sprd: Change to use SoC compatible string
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Thu, 14 Feb 2019 at 15:56, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Wed, Feb 13, 2019 at 5:10 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> > =C5=9Br., 13 lut 2019 o 14:15 Baolin Wang <baolin.wang@linaro.org> napi=
sa=C5=82(a):
> > >
> > > On Wed, 13 Feb 2019 at 20:59, Bartosz Golaszewski
> > > <bgolaszewski@baylibre.com> wrote:
> > > >
> > > > =C5=9Br., 13 lut 2019 o 13:49 Baolin Wang <baolin.wang@linaro.org> =
napisa=C5=82(a):
> > > > >
> > > > > Change to use SoC compatible string instead of wildcard string.
> > > > >
> > > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > > ---
> > > > >  drivers/gpio/gpio-pmic-eic-sprd.c |    2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpi=
o-pmic-eic-sprd.c
> > > > > index ac573da..24228cf 100644
> > > > > --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> > > > > +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> > > > > @@ -364,7 +364,7 @@ static int sprd_pmic_eic_probe(struct platfor=
m_device *pdev)
> > > > >  }
> > > > >
> > > > >  static const struct of_device_id sprd_pmic_eic_of_match[] =3D {
> > > > > -       { .compatible =3D "sprd,sc27xx-eic", },
> > > > > +       { .compatible =3D "sprd,sc2731-eic", },
> > > > >         { /* end of list */ }
> > > > >  };
> > > > >  MODULE_DEVICE_TABLE(of, sprd_pmic_eic_of_match);
> > > > > --
> > > > > 1.7.9.5
> > > > >
> > > >
> > > > We guarantee to make older device-trees to work with new kernel so =
you
> > > > can add the new compatible, but you can't remove the old one.
> > >
> > > But the old one is incorrect, and we still keep it?
> > >
> >
> > Well in theory the device-tree is supposed to be a stable ABI so once
> > it's released, it should work with any following kernel version.
> >
> > In practice changes are sometimes allowed and there are also bugs in DT=
 files.
> >
> > Linus: what do you think?
>
> In this specific case I'd keep both strings, it doesn't hurt does it?
>
> You could add a comment to the wildcard string saying it is only there
> for compatibility with elder device trees.
>
> In general as long as there are not (a lot of) products shipped with
> a certain device tree, I don't care much whether we change the bindings
> or contents.
>
> The hard rule to keep the device trees backward-compatible comes
> from SPARC SunOS where the DTB was burned into a BIOS ROM
> that was hard or impossible to update, Linux just had to handle
> whatever was in there. If the situation with the device tree we change
> is not similiar, we should not care either.
>
> In practice there are companies and developers that always
> recompile and ship their device trees at the same time as they
> compile and ship their kernel, and in that case we need not care
> about backward compatibility.
>
> While the device tree enablement on ARM started out with the
> former (strict) assumption, the practice of using DTs has shown
> that it is an unrealistic and inappropriate stance to have for all
> device trees. (IMO!) So I don't mind if you break compatibility here.
>

Thanks for your explanation. Yes, as our dts and drivers development
are still in progress, I do not think we need care about the backward
compatibility issue. So I still intend to remove the incorrect
wildcard string.

--=20
Baolin Wang
Best Regards
