Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFEFC64EB1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12042084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Redco6jM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12042084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbeJASrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:47:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46462 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbeJASrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:47:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so11823111ljj.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=or0k/KDBFS7XoFVtpYSukgXjEIjxOUQ3+mQqlqeObsY=;
        b=Redco6jM0wIVGI4VEhTd4RbBdoic8s/AYvHI2MIReKPb9GxzkXC3527BOXIHEgW37b
         dKPejMy0zjSsrtFh8R4mI4X720g7iYkDAORihu8OEVyKeht+WXLGm91WkUZeG4MU+rNC
         8lBe7I0MTjTiDv5SiuonS8UIISanIKIegHmQo7YXx95KxOfioGi+Yp6mIZv5D7sLZqiF
         tQlaAmThhjgAk10G3h0Vw7nsri8pX7N8JBqe0XlcGk45/krmo1+jgfEis0S6DnYixk0A
         NQWNQ5ISF3XB7QgBehpw+8q4rSdN4R1xuEEnIHgocCvPZmNALTEn5vPGNK/YbqW/aeqg
         8rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=or0k/KDBFS7XoFVtpYSukgXjEIjxOUQ3+mQqlqeObsY=;
        b=LDCpWrVRtyWTFrYzfozZi/AnBjZGawJ6JwvARHMwg4nlzXRCQZpt4RMP9NatylahSB
         uqvhM3sD8mBCBf7ciy+GFXVS5cQC+FmiaNahc/v1Ff5CwXk33ojphcMddZWNqbfDMTl4
         d4M92vIc+F6+ls9Uck6onVMCsgUDQrVrzdBwI89dd5I6NOJpcE1mj3fBX8oLWIDZU0n7
         H9XUX0XkTKheLX0BxbAlbKan4AsrghqyMPctY6TvpCwdX76OZRTiTpfalajyH2AbHkaC
         J/86FwDXAOVczs9eR3fOyldnl2mXVe5jrOzgDA59H5JC1rkdMaXPX2P2+MtU9xfMznm4
         SFBw==
X-Gm-Message-State: ABuFfoiK3TaGxj7mbJc0H3favy8k/OygpgH9bzBahmaUp6ZRDd/+nIJV
        gUu7KFIeUA3f2ddiXv6ohtLalm2Jf/9OnZfGkvg=
X-Google-Smtp-Source: ACcGV63cL+9AmtpASj/rgAUSXAVbzhuFJu7j7Qjfl3BdjquLBuVpqFzzrwfqjhvuAxSFxHqU5lz1qV4kQMi8/kstI6c=
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr6949055ljj.90.1538395819783;
 Mon, 01 Oct 2018 05:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
 <20180905143643.9871-6-ricardo.ribalda@gmail.com> <20180927134216.1952f668@bbrezillon>
In-Reply-To: <20180927134216.1952f668@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Mon, 1 Oct 2018 14:10:03 +0200
Message-ID: <CAPybu_18jdEWEbAbYd4k-GPD+77sCA_5na0RJznixPEXkcs+kQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] mtd: maps: gpio-addr-flash: Replace array with an integer
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

On Thu, Sep 27, 2018 at 1:42 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Wed,  5 Sep 2018 16:36:40 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > By replacing the array with an integer we can avoid completely
> > the bit comparison loop if the value has not changed (by far
> > the most common case).
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> >  drivers/mtd/maps/gpio-addr-flash.c | 31 +++++++++++++++---------------
> >  1 file changed, 16 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio=
-addr-flash.c
> > index 22e100f07112..8f5e3dce9be3 100644
> > --- a/drivers/mtd/maps/gpio-addr-flash.c
> > +++ b/drivers/mtd/maps/gpio-addr-flash.c
> > @@ -43,7 +43,7 @@ struct async_state {
> >       struct map_info map;
> >       size_t gpio_count;
> >       unsigned *gpio_addrs;
> > -     int *gpio_values;
> > +     unsigned int gpio_values;
> >       unsigned int win_order;
> >  };
> >  #define gf_map_info_to_state(mi) ((struct async_state *)(mi)->map_priv=
_1)
> > @@ -55,22 +55,25 @@ struct async_state {
> >   *
> >   * Rather than call the GPIO framework every time, cache the last-prog=
rammed
> >   * value.  This speeds up sequential accesses (which are by far the mo=
st common
> > - * type).  We rely on the GPIO framework to treat non-zero value as hi=
gh so
> > - * that we don't have to normalize the bits.
> > + * type).
> >   */
> >  static void gf_set_gpios(struct async_state *state, unsigned long ofs)
> >  {
> > -     size_t i =3D 0;
> > -     int value;
> > +     int i;
> >
> >       ofs >>=3D state->win_order;
> > -     do {
> > -             value =3D ofs & (1 << i);
> > -             if (state->gpio_values[i] !=3D value) {
> > -                     gpio_set_value(state->gpio_addrs[i], value);
> > -                     state->gpio_values[i] =3D value;
> > -             }
> > -     } while (++i < state->gpio_count);
> > +
> > +     if (ofs =3D=3D state->gpio_values)
> > +             return;
> > +
> > +     for (i =3D 0; i < state->gpio_count; i++) {
> > +             if ((ofs & BIT(i)) =3D=3D (state->gpio_values & BIT(i)))
>
> Parens around the xx & BIT(i) operations are unneeded.

If I remove it:


ricardo@neopili:~/curro/kernel-upstream$ make drivers/mtd/maps/gpio-addr-fl=
ash.o
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CC      drivers/mtd/maps/gpio-addr-flash.o
drivers/mtd/maps/gpio-addr-flash.c: In function =E2=80=98gf_set_gpios=E2=80=
=99:
drivers/mtd/maps/gpio-addr-flash.c:70:20: warning: suggest parentheses
around comparison in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
   if (ofs & BIT(i) =3D=3D (state->gpio_values & BIT(i)))


>
> > +                     continue;
> > +
> > +             gpio_set_value(state->gpio_addrs[i], !!(ofs & BIT(i)));
> > +     }
> > +
> > +     state->gpio_values =3D ofs;
> >  }
> >
> >  /**
> > @@ -215,7 +218,7 @@ static int gpio_flash_probe(struct platform_device =
*pdev)
> >       if (!memory || !gpios || !gpios->end)
> >               return -EINVAL;
> >
> > -     arr_size =3D sizeof(int) * gpios->end;
> > +     arr_size =3D sizeof(state->gpio_addrs[0]) * gpios->end;
> >       state =3D devm_kzalloc(&pdev->dev, sizeof(*state) + arr_size, GFP=
_KERNEL);
> >       if (!state)
> >               return -ENOMEM;
> > @@ -226,9 +229,7 @@ static int gpio_flash_probe(struct platform_device =
*pdev)
> >        */
> >       state->gpio_count     =3D gpios->end;
> >       state->gpio_addrs     =3D (void *)(unsigned long)gpios->start;
> > -     state->gpio_values    =3D (void *)(state + 1);
> >       state->win_order      =3D get_bitmask_order(resource_size(memory)=
) - 1;
> > -     memset(state->gpio_values, 0xff, arr_size);
> >
> >       state->map.name       =3D DRIVER_NAME;
> >       state->map.read       =3D gf_read;
>


--=20
Ricardo Ribalda
