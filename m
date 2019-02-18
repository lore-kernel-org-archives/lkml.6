Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD44C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7EE2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UVPP6vyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfBRIMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:12:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38423 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfBRIMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:12:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so26875130otf.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A/GWwL8QsoA/seKkkwP2J9Rz4+w3VPL6GFqZWoskLzA=;
        b=UVPP6vyO6mqbqmeag02MDV50meAuUyc/reRiyqD1HAshwhNPf9m48CWFS4i3Rr9vO/
         BpNN6Njm93uloF2GJG9SIM2gSBDEm6FlB1ashfnnP4Ok7i3fPBX4q8sZII/qgvzwZsP4
         ZqTK6tGqVw76f0WNbdW+Mzo24B7GwYgAH0fsMTfZYFb3AcqFn+ItpQoWaTKNfhBwUNeD
         HL6/B/x7tJAeGQmUy9/6+RYdW96hMUoBBOwFmMEBJg78mWEAL/q/wwS8mpfuC8JKOS5I
         phd4wECfsq9dVBSuUhnSVV77/6dyNitmUM8ssZs40jXA79dRSkOapDwzTiY8zy3nAVRz
         Xipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A/GWwL8QsoA/seKkkwP2J9Rz4+w3VPL6GFqZWoskLzA=;
        b=Z7xL6MgHDj3j380EupQVFh285hSMCkw8C583dLJ+wdbDuW1Jmjv0tpifltVe84T+IL
         8vC2ckrmqNb9gRkRDsqXj+HVNAMhIaMC21ZzhF3IRopAwzA9q+roSDcNMjyzJXKd33dy
         Rkz6Toi/0i26trZfrxQ+ooFjcbhRAuE6s+H1NXqHgPGYlmFbkArocthHKRHCEf2uK2B5
         i/jtM+JDaR2OiprNP0nHxuA25HLiy0sqq6ThXrlG4AXxBBQujrSSAFT6VWu/BC7GwR+/
         lFY1jXJ7oOGdQSZ7eYrwHtaqFN1jCyDk3aMxHXFRx1hgMP06VUv5jjDFd5KXscxXzrEP
         D03g==
X-Gm-Message-State: AHQUAuYmQBdmmiKITxEGnkUDBfC7npclGWcU62Yw9F6nIoOPftallAeY
        Vhjsb5I2LZRB6PAS7qKSf11CNgvynKurzVV4wQRf2A==
X-Google-Smtp-Source: AHgI3IbBhU0uXZ3HcV9Mi3MayiF/4EjW2u7ivl66FSIeVS6rpMai7dtp6S21GB5UJuNrejIUHtbT/e8YX+ykhhFSMzY=
X-Received: by 2002:a9d:635a:: with SMTP id y26mr13090952otk.27.1550477554190;
 Mon, 18 Feb 2019 00:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20190214145231.8750-1-brgl@bgdev.pl> <20190214145231.8750-34-brgl@bgdev.pl>
 <681a7831-8c20-d634-a1cb-04064e3077b8@lechnology.com>
In-Reply-To: <681a7831-8c20-d634-a1cb-04064e3077b8@lechnology.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 18 Feb 2019 09:12:23 +0100
Message-ID: <CAMpxmJXvqTCYCHwJujx=A4Ga+bZP+fKpJTf++FkmYdQHR5HJew@mail.gmail.com>
Subject: Re: [PATCH v4 33/37] ARM: davinci: cp-intc: use readl/writel_relaxed()
To:     David Lechner <david@lechnology.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 17 lut 2019 o 11:01 David Lechner <david@lechnology.com> napisa=C5=
=82(a):
>
> On 2/14/19 8:52 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed(=
)
>
> s/Raplace/Replace/
>
> > and writel_relaxed() respectively. It's safe to do as there's no
> > endianness conversion being done in the code.
>
> Should this be combined with patch 14/37?
>

No, this is for cp-intc and the other one is for aintc. I'd keep them separ=
ate.

Bart

> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   arch/arm/mach-davinci/cp_intc.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp=
_intc.c
> > index 1bf11fa8be76..f88b7f0978aa 100644
> > --- a/arch/arm/mach-davinci/cp_intc.c
> > +++ b/arch/arm/mach-davinci/cp_intc.c
> > @@ -45,13 +45,13 @@ static struct irq_domain *davinci_cp_intc_irq_domai=
n;
> >
> >   static inline unsigned int davinci_cp_intc_read(unsigned int offset)
> >   {
> > -     return __raw_readl(davinci_cp_intc_base + offset);
> > +     return readl_relaxed(davinci_cp_intc_base + offset);
> >   }
> >
> >   static inline void davinci_cp_intc_write(unsigned long value,
> >                                        unsigned int offset)
> >   {
> > -     __raw_writel(value, davinci_cp_intc_base + offset);
> > +     writel_relaxed(value, davinci_cp_intc_base + offset);
> >   }
> >
> >   static void davinci_cp_intc_ack_irq(struct irq_data *d)
> >
