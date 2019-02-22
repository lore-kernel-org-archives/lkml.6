Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE24DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE002077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="P8jYx2DE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfBVJET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:04:19 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51035 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBVJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:04:18 -0500
Received: by mail-it1-f194.google.com with SMTP id m137so2012877ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hQ8CkzyGqK59D74CH8I4edWHR9SkpQ9HCgG7RFV5u4c=;
        b=P8jYx2DEepv3/Ml54PcuR2/AeIAk9uLQ6RblLzNL9vp89DM6D4bK9dyK4yyPX666si
         eM3HNLj2LoLxGhqv9h0DDwzmb21yht5IrWqrSqsIdnOHx9lh8Wn6XdtWkwsQpeEX9miT
         6qicooiLd8cFx4d0kQV4oWOBdSU/SKD/G4OFrc6dFjahXlmGwBc9en64QHcapmdN5VFR
         DvezSUesoT7xlRGZr6mkSTjtuyzCRDcVoZtF1uv183SUcTSdS66b14AwcOLinis2KApW
         GHPoAj4AhsrThL4kLkzylEo1/ULxxKMmVz/Nw3ErHWni3T9diryEnFC/FG2QaVluA4Tu
         4pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hQ8CkzyGqK59D74CH8I4edWHR9SkpQ9HCgG7RFV5u4c=;
        b=XqlxW+/5xjJhLj0rXP+GC/krg9ydzq0nZ5wW3+wLJ6UYd+2hVc0hr0RZSVk+3Uk1xK
         gMDYP2dp/wBcl8K3PXnTO3goerQI5sjGqhXujaY+Bhh9YeBpBJmG+6KUEI9jEAMYMD1O
         iMDBv4+eZzZOpqHElaETqHFhIJ/IZqh1PDHwBYgmq6J/M1IlSxhaoFRSyGd9aU90xxGW
         Tc80cYV1fdf7ifFQi9k3HszZrU9x/h48XuYySArbOeOnn14Y3C67m0eF9hZ2cZK5pOzC
         GtwY1v/69isgSVJFyref9lEnJ8m0I9suiE+SrAGHXplo8hLRNThRTqLbIBK54VnsM/0b
         innA==
X-Gm-Message-State: AHQUAubv7/TlKEX1eafQ6COENZNHh57pVGj0DeUxiYKGA3PK8un6s6i4
        DL3ed7sge14/AuYRUnecCsSGRzFWhLsVczKfmAuqTg==
X-Google-Smtp-Source: AHgI3IZTyAKtZQU15NutMRTnvIdursrAUcYkDv09n/uXvG322caLbrHwNlwOG++Y2Ay0WCtiZm4kk6tULB4bSSm4Pxg=
X-Received: by 2002:a24:7284:: with SMTP id x126mr1797759itc.96.1550826257929;
 Fri, 22 Feb 2019 01:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20190221162627.3476-1-brgl@bgdev.pl> <CAHp75VfKq5rkLUzW3HL8+a0wmaqGz7nz09Ki0nc0TxQDJb=9DA@mail.gmail.com>
 <CAHp75Vdz=qQCie1PrcoTmF-TL+swWKLEzHQE=D5ubnmufxRD9g@mail.gmail.com>
In-Reply-To: <CAHp75Vdz=qQCie1PrcoTmF-TL+swWKLEzHQE=D5ubnmufxRD9g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 22 Feb 2019 10:04:07 +0100
Message-ID: <CAMRc=Me0A6FHKUjuhsk9U-tHo7dLK4U0-NXk+M4129tLn3KV_w@mail.gmail.com>
Subject: Re: [PATCH] drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

czw., 21 lut 2019 o 20:56 Andy Shevchenko <andy.shevchenko@gmail.com>
napisa=C5=82(a):
>
> On Thu, Feb 21, 2019 at 9:55 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Feb 21, 2019 at 6:27 PM Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> > >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > We only build devm_ioremap_resource() if HAS_IOMEM is selected, so th=
is
> > > dependency must cascade down to devm_platform_ioremap_resource().
> >
> > > +#ifdef CONFIG_HAS_IOMEM
> > >  void __iomem *devm_platform_ioremap_resource(struct platform_device =
*pdev,
> > >                                              unsigned int index)
> > >  {
> > > @@ -96,6 +97,7 @@ void __iomem *devm_platform_ioremap_resource(struct=
 platform_device *pdev,
> > >         return devm_ioremap_resource(&pdev->dev, res);
> > >  }
> > >  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> > > +#endif /* CONFIG_HAS_IOMEM */
> >
> > What about declaration in *.h?
> >
> > Perhaps you may just do this inside the function?
>
> #ifdef ...
> #else
> return ERR_PTR(-ENOTSUPP);
> #endif
>

I followed the example of devm_ioremap_resource() which doesn't do
this - it just expects never to be used by systems without IOMEM.

Bart
