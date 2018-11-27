Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEB8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5358221104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bckujwls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5358221104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeK0TaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbeK0TaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:30:19 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B4D21104;
        Tue, 27 Nov 2018 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543307591;
        bh=WTn/PEg7Cobmk7UGEl8NGRz45ym8LTYqnKjotzR+tl8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bckujwls8zO91802Qpj1XPFIww+qeIIPps8SjI2NOyzkYdylYDR0As7v6e5WKlf3i
         JhLALYi7id8hdwUmPVgGFo06s8YK5QC5E03kmCJtIgJNkQKmgtJOsYmlH+kSfIqzpz
         1+Y2ZStA1+M9aoAI2lp9rmdnYQsMDiimiXrHGgH0=
Received: by mail-wm1-f46.google.com with SMTP id c126so21132236wmh.0;
        Tue, 27 Nov 2018 00:33:11 -0800 (PST)
X-Gm-Message-State: AA+aEWb156iOR02ULtNDCXfEle7McfogNWUZzn50bDk61FR/lVfnPf3M
        WzCzs5zdrKpvjo60ZhaEOo4UHebvLlaD/VqKFTg=
X-Google-Smtp-Source: AFSGD/VEy8tfAwqPgbc4lO+9ipi4FMvlzyjfTlQ8v2LCFZiXHChRZGnd5/sezE3aEh9JXgTB+4tUl8MF9edwIzcum+s=
X-Received: by 2002:a1c:2c56:: with SMTP id s83mr955660wms.48.1543307589639;
 Tue, 27 Nov 2018 00:33:09 -0800 (PST)
MIME-Version: 1.0
References: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
 <1542823573-20228-2-git-send-email-hofrat@osadl.org> <CAGp9LzoT7ueXyyVSYQdWOU0JkQDWMVcwCuSE3gJnEn0fLLjCBA@mail.gmail.com>
 <20181127080113.GA2426@osadl.at>
In-Reply-To: <20181127080113.GA2426@osadl.at>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 27 Nov 2018 00:32:59 -0800
X-Gmail-Original-Message-ID: <CAGp9LzoNKmJvTccQd7Syi_XMew4Mhf_tXsMAAZ+asE5btH9Dag@mail.gmail.com>
Message-ID: <CAGp9LzoNKmJvTccQd7Syi_XMew4Mhf_tXsMAAZ+asE5btH9Dag@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mt7621: pass mediatek_gpio_bank_probe() failure
 up the stack
To:     der.herr@hofr.at
Cc:     bgolaszewski@baylibre.com,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, sergio.paracuellos@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        hofrat@osadl.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Mon, Nov 26, 2018 at 11:49:26PM -0800, Sean Wang wrote:
> > Nicholas Mc Guire <hofrat@osadl.org> ??? 2018???11???21??? ?????? ?????=
?10:13?????????
> > >
> > > The error cases of mediatek_gpio_bank_probe() would go unnoticed (exc=
ept
> > > for the dev_err() messages). The probe function should return an erro=
r
> > > if one of the banks failed to initialize properly.
> > >
> > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> > > ---
> > >
> > > Patch was compile tested with: omega2p_defconfig, SOC_MT7621=3Dy,
> > > GPIOLIB=3Dy, GPIO_MT7621=3Dy
> > >
> > > Patch is against 4.20-rc3 (localversion-next is next-20181121)
> > >
> > >  drivers/gpio/gpio-mt7621.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> > > index 1ec95bc..68fca8b 100644
> > > --- a/drivers/gpio/gpio-mt7621.c
> > > +++ b/drivers/gpio/gpio-mt7621.c
> > > @@ -297,6 +297,7 @@ mediatek_gpio_probe(struct platform_device *pdev)
> > >         struct device_node *np =3D dev->of_node;
> > >         struct mtk *mtk;
> > >         int i;
> > > +       int ret;
> > >
> > >         mtk =3D devm_kzalloc(dev, sizeof(*mtk), GFP_KERNEL);
> > >         if (!mtk)
> > > @@ -311,8 +312,11 @@ mediatek_gpio_probe(struct platform_device *pdev=
)
> > >         platform_set_drvdata(pdev, mtk);
> > >         mediatek_gpio_irq_chip.name =3D dev_name(dev);
> > >
> > > -       for (i =3D 0; i < MTK_BANK_CNT; i++)
> > > -               mediatek_gpio_bank_probe(dev, np, i);
> > > +       for (i =3D 0; i < MTK_BANK_CNT; i++) {
> > > +               ret =3D mediatek_gpio_bank_probe(dev, np, i);
> > > +               if (!ret)
> >
> > it should be if (ret < 0) ?
>
> I don=C2=B4t think so mediatek_gpio_bank_probe() returns 0 on success
> and all other returns are error paths - while the current code
> only returns negative values I do thik that any non 0 would be
> an error indication so !ret should be fine here.
>
!0 would be true

> thx!
> hofrat
>
> >
> > > +                       return ret;
> > > +       }
> > >
> > >         return 0;
> > >  }
> > > --
> > > 2.1.4
> > >
> > >
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
