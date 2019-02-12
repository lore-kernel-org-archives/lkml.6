Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69E0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8265921773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="waRsQ09L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfBLJdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:33:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53491 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfBLJdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:33:08 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so5598138ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FgkpX838fo9oz8NedVb0MpKtzZYxkXRP2Z32tbBQYjA=;
        b=waRsQ09LqsI2iWinAIYUZINqbTBFjxarlOd9+DC0LVysmqOPGKyQZXQevhoZD7ZEhQ
         XD6QWGVPF9jAVb560JxHn83NKaENr7/kAFe5UF/at8t97HGm2qfLl4hwl+vkY7t6aVEa
         p5skMV07v/rZfNIddNi1zp6IEh5hCzL4S/raw5qZV0fXiDeF3EZsRA705lMf+8cUP/xy
         VzfQ3yGG91stvmYNjoj9jqCWXV8xt8kipg929/iDJs4T/Ih4BTw8mDCjIg/k1p0IZGWb
         Le44pBV/dpOCtn1qBYBzvdVh9cLAB0pL9cSV4SWBW1AramVHrqYdZWcKTlG96mxlrbII
         mUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FgkpX838fo9oz8NedVb0MpKtzZYxkXRP2Z32tbBQYjA=;
        b=C0zslS57XX8R5MhhbblXYRvVod/rY55OJlHaoKrALbilvDKmUR6pKMn21ygcv/LGSW
         MpuwD0I9nF0W/v74r5Fy7/M07wYTW5UEKA9I7/cJvKGoaOAuwhdDrBqqif8stNW+HpSO
         Ndf56NxXW2zgh5AG1GP7PUKVGuO8lNVx7UvNjrvOnI2uywXtPhtNgfI+a/uBlWt8S2DQ
         L8c+12lOon0iZYCenOZ5L0r7EQZXU4K2n5OXHL/yNlapQQzhMc9+6T9llTxFb3MEB4l1
         Y8eX94kiHzuWvdSTRQQaMZLy88hp9RDJz7mfqm8/rGNFIW79q+1K3rkZkzMiFvgsyPUL
         h09Q==
X-Gm-Message-State: AHQUAuZEMhn5ix+2+4pvj+ZA6Z09jZV06eZr8PmHsb/RfUOuZDS86sWQ
        t3lSIL6wesBtHbLBM0uz9afHROqkInMsrfo09orPsQ==
X-Google-Smtp-Source: AHgI3IaZhlIJttqHaE8stFCUqH6pEM8VirZlSAAtboWLHMCHPeC4nmwDh+OVJj7VeGRCDUjAZULyaH7JZ6Axl3ToCoo=
X-Received: by 2002:a24:7284:: with SMTP id x126mr1557363itc.96.1549963987312;
 Tue, 12 Feb 2019 01:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20190211122606.8662-1-brgl@bgdev.pl> <20190211122606.8662-30-brgl@bgdev.pl>
 <2bf9393a-d747-2d86-f298-5f4cf899b85e@arm.com>
In-Reply-To: <2bf9393a-d747-2d86-f298-5f4cf899b85e@arm.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 10:32:56 +0100
Message-ID: <CAMRc=MfmKTJcoLzRb5Auz2mYD8pka-=p46MSxjrnXwDYKDR3=Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 29/33] ARM: davinci: cp-intc: use readl/writel_relaxed()
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 11 lut 2019 o 14:08 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82(=
a):
>
> On 11/02/2019 12:26, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed(=
)
> > and writel_relaxed() respectively. It's safe to do as there's no
> > endianness conversion being done in the code.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  arch/arm/mach-davinci/cp_intc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp=
_intc.c
> > index c1efb9390655..4bbf0eba1920 100644
> > --- a/arch/arm/mach-davinci/cp_intc.c
> > +++ b/arch/arm/mach-davinci/cp_intc.c
> > @@ -45,13 +45,13 @@ static struct irq_domain *davinci_cp_intc_irq_domai=
n;
> >
> >  static inline unsigned int davinci_cp_intc_read(unsigned int offset)
> >  {
> > -     return __raw_readl(davinci_cp_intc_base + offset);
> > +     return readl_relaxed(davinci_cp_intc_base + offset);
> >  }
> >
> >  static inline void davinci_cp_intc_write(unsigned long value,
> >                                        unsigned int offset)
> >  {
> > -     __raw_writel(value, davinci_cp_intc_base + offset);
> > +     writel_relaxed(value, davinci_cp_intc_base + offset);
> >  }
> >
> >  static void davinci_cp_intc_ack_irq(struct irq_data *d)
> >
>
> Same thing. Please merge this patch with the one that introduced the
> __raw_writel() stuff.
>

In this case, none of my patches introduced it - it used to be like
that from the beginning, so a separate patch is justified.

Bart
