Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4854CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C61720672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="l0ds9tv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C61720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeLKPjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:39:07 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44076 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeLKPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:39:06 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so12090269iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z67cECj/N8A+GztAxrBX6BJXkk6pkF30/HSeWqeZTVE=;
        b=l0ds9tv2UKGL66zlj+teDMfqrbzMa5ePyPCexFJ0WTgtQZ5aEjcsxMGrV4pxc828KK
         IPoMU1tGgkQ+UZA2wqOL8eFwzxIO/xvzLmSqQ3FFCRMl9lBTsOLP1xWYfomgriLvp5dR
         EI03HaLsbZYwvztBvR05g4cXSg9y9XiAjJVKtWHQBxXrYae7z+TKkYEbN3ecZ5cvcqh1
         MoaB8k43/Adrf5fVlpCZ8bSAXpiDJVofaGpIOn/a5FLzi5tYjsh6BZfM/DrQzholH2Fq
         YnpUboCEJ0OszBFlD5wBUrHak+4O9z7NynabNU3NQbyR/g1akCRC41X8HR0YfJcwKNI7
         xJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z67cECj/N8A+GztAxrBX6BJXkk6pkF30/HSeWqeZTVE=;
        b=gI6hBUZhxZoXieEsBJ+5UWODNMrl/QsT/wAHS0/pPbId1bHZHKIVgzVHJGsdUTRNl5
         0OroqZprW77AhmekVhQx+h1UEuWzg79FLQIDxrWZ0aMuOrvwlY7hzLTgwdTZolDHMhhK
         UFCQ7O4Cys8q1a8OyqnsYHNCV4rh5dS0aB1G7b4+8PFiHMtziB9wqtk2lqJYwO6nStrN
         Soy9rBjsaKIBw+UYfYDFCpT/wqH+I9zk7fd5tYXZ/T04ufZi7iTxv/7KwadskRCPWZ95
         rHgbAWamg5Lf8esbHCscc6yaZmyQ6czENyvhgaGxMXiPCwYaWZ4vq5VhNJ3eA5XG2eXU
         lYPg==
X-Gm-Message-State: AA+aEWaG3bPcY07xFUdFrWwg4KmbZT2qobSKxAyUfoXYdd15NiLGFTE5
        deynA+i7LOmntlhhEEcNCW8wTHKhZkZlgKg8GoC22g==
X-Google-Smtp-Source: AFSGD/V/dRZRfa1JKWOYTmQh03EBByV6dbf/fju/CVzgAIZD2SZT0yfZEHNC6qSNgWKgbt0znEBXxP52K74bGUJMmO4=
X-Received: by 2002:a5d:9298:: with SMTP id s24mr14555922iom.111.1544542745437;
 Tue, 11 Dec 2018 07:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20181120134032.31645-1-brgl@bgdev.pl> <20181120134032.31645-3-brgl@bgdev.pl>
 <20181203110916.eseh2udxvhi4lf3v@pengutronix.de> <20181211141509.6x74jlzipj6o2exh@pengutronix.de>
In-Reply-To: <20181211141509.6x74jlzipj6o2exh@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 11 Dec 2018 16:38:54 +0100
Message-ID: <CAMRc=MepmF4phnh_cSE5sFDMYcYEtyh0KGeBot_tu1jnq1276A@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mockup: use irq_sim_fire_edge()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 11 gru 2018 o 15:15 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> Hello Bartosz,
>
> On Mon, Dec 03, 2018 at 12:09:16PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Nov 20, 2018 at 02:40:32PM +0100, Bartosz Golaszewski wrote:
> > > @@ -213,7 +213,8 @@ static ssize_t gpio_mockup_event_write(struct fil=
e *file,
> > >     chip =3D priv->chip;
> > >
> > >     gpiod_set_value_cansleep(desc, val);
> > > -   irq_sim_fire(&chip->irqsim, priv->offset);
> > > +   edge =3D val =3D=3D 0 ? IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RIS=
ING;
> > > +   irq_sim_fire_edge(&chip->irqsim, priv->offset, edge);
> >
> > If I write 0 twice into the debugfs file, does it fire two irqs or only
> > one? I think it fires two but only one would be the right behaviour?!
>
> If you still think that patch 1 of this series is the way to go, I think
> this objection is still valid. Then you need to check the state of the
> line by at least calling (something like) .get_value to determine if the
> previous value was different.
>

Hi Uwe,

I've already started working on a series improving the entire concept.
I've taken some of your suggestions into account.

Since we're already at rc-6 I'd like to get those upstream despite
there being some disagreements to keep the userspace intact.

For now it will generate two falling edge interrupts when you write 0 twice=
.

Bart
