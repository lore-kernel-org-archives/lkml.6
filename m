Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3600220823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb6OVA01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBVKZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:25:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44615 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfBVKZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:25:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id c4so897508pls.11;
        Fri, 22 Feb 2019 02:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KelViqTFxcQnVlbfcwA3gjNLj+2tpIjM8hT3+oWvqIQ=;
        b=nb6OVA01liAl8XiwhAD3wZzgHvFZhdhUB50vC63r0ucW6wov4IcLABz+CCIq5UBgYV
         tIC7/ieNGH8yMF064Dkdbjhifv336eFtqfKvA+zbGOGSRHaacFKUK1hjST5PYAE25n4V
         4kuB3scfPgOSOKG2+hkD0NjXKXMxNMlCOqoj/SLsW6g5RWdM7vlclrkp3l4fkvkyvrBz
         aBXrbWUMD1aioQk8vkZuLXxcAT7i8wyHWUrv/tyEAkboYuJZrOhVuU6hTyr2qu9l0Sdb
         sGFgoEqX0o8HUQSRkBIn4QCp/vgHQQEkOTPFxMjJAThigvhE5KX1jvdG+15SqzU2c67P
         rTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KelViqTFxcQnVlbfcwA3gjNLj+2tpIjM8hT3+oWvqIQ=;
        b=Msi3/YZcJeKd6ymX0q47D+YwLToT5kcDs5Qxm35Gj0ndmRMUKuenqwYZqF8WYEl//T
         vHTfIBsM1aFaAeHiomx3D+aiU86VQAU4VeRXDrQS9eDJ1hK03dKjmGc1w0CXIz9vo9k8
         PTOoTcx9eHWnuCdpq1+x1TnKsgo+hOORaj5tsRUzgTJBaBrmSSajctADdxz/nJh2E4r/
         wMEzQ+xhbO3wwX4NgP5jt7e02Hxto51FESUn0/pSbSl3Y6Vu+DUqrTRYVx6SQSXzvnU0
         +npJuzXYK/NQqx6xqLoWrMg8+q9C12oqN/zoAnn5wTWjsQVSxAStckXSWttp+uP9E5CK
         fRWA==
X-Gm-Message-State: AHQUAuZBJNM+fI/erhd4aA3olTDjQYhdzUjyFp+ooZxMSIhWW5364i41
        DML6LepZBQXA12Z882yLPFiD+1qOfuEVGV+zRSs=
X-Google-Smtp-Source: AHgI3IYk5o72dgA5I1o8hsRW8C1VZopxPJwH148crPsYI0hkBsGSWgW+IWdn0gOBToiF/TXWB35gvCP21gsIpKZzvG8=
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr3462170plg.314.1550831108251;
 Fri, 22 Feb 2019 02:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20190221162627.3476-1-brgl@bgdev.pl> <CAHp75VfKq5rkLUzW3HL8+a0wmaqGz7nz09Ki0nc0TxQDJb=9DA@mail.gmail.com>
 <CAHp75Vdz=qQCie1PrcoTmF-TL+swWKLEzHQE=D5ubnmufxRD9g@mail.gmail.com> <CAMRc=Me0A6FHKUjuhsk9U-tHo7dLK4U0-NXk+M4129tLn3KV_w@mail.gmail.com>
In-Reply-To: <CAMRc=Me0A6FHKUjuhsk9U-tHo7dLK4U0-NXk+M4129tLn3KV_w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 Feb 2019 12:24:56 +0200
Message-ID: <CAHp75Vdpjqqbmz6z8NfMqk5-463-BQdvE3QdD64jVReGp9s48g@mail.gmail.com>
Subject: Re: [PATCH] drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:04 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> czw., 21 lut 2019 o 20:56 Andy Shevchenko <andy.shevchenko@gmail.com>
> napisa=C5=82(a):
> >
> > On Thu, Feb 21, 2019 at 9:55 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Thu, Feb 21, 2019 at 6:27 PM Bartosz Golaszewski <brgl@bgdev.pl> w=
rote:
> > > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > We only build devm_ioremap_resource() if HAS_IOMEM is selected, so =
this
> > > > dependency must cascade down to devm_platform_ioremap_resource().
> > >
> > > > +#ifdef CONFIG_HAS_IOMEM
> > > >  void __iomem *devm_platform_ioremap_resource(struct platform_devic=
e *pdev,
> > > >                                              unsigned int index)
> > > >  {
> > > > @@ -96,6 +97,7 @@ void __iomem *devm_platform_ioremap_resource(stru=
ct platform_device *pdev,
> > > >         return devm_ioremap_resource(&pdev->dev, res);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> > > > +#endif /* CONFIG_HAS_IOMEM */
> > >
> > > What about declaration in *.h?
> > >
> > > Perhaps you may just do this inside the function?
> >
> > #ifdef ...
> > #else
> > return ERR_PTR(-ENOTSUPP);
> > #endif
> >
>
> I followed the example of devm_ioremap_resource() which doesn't do
> this - it just expects never to be used by systems without IOMEM.

Okay, that's fine!


--=20
With Best Regards,
Andy Shevchenko
