Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F8DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5416021855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ylLZUh+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfBKNKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:10:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46967 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfBKNKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:10:41 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so17198648otm.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w50+3ASKiEiTs8l6R7PImkIxaHDwdrCXPI3EEoULF/Q=;
        b=ylLZUh+EAxAKOvZ0r2I6S/s8TRR94avJkN9ghhtt3Crrkt9ZWha5yk8jAT8+XAFXN8
         h02rjoHEgAixJPczMnVDg18BYrGuO2GMxN2WPXGKWpMm3XdeG9Ls+MDwt4Ysprkn3lN4
         xzOkXbXZdJOfy6foDnuhGkd6SvTqJsnxgkLVe5usUgwzPclJVuovVbxEiOl63yZBq9eM
         vUWo/QgYeBlTfnpiAFK6Vn6524Vgi+eHJI2xiLuvZH+UF1H1vpcNFmutTjcbAjj0HiH/
         DWTf9P3av4B3k8f6NwMKFVsw9qPrJP4RdAqhyDLVxawu4R3RuwKaQqtMNG6HpVtJvPKq
         89wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w50+3ASKiEiTs8l6R7PImkIxaHDwdrCXPI3EEoULF/Q=;
        b=dN29IpSNJP6J+vr1l1hvtN9oJAd0O/T1k+96RPpijp8rySVwbQDaUU21gsHi/FRJeu
         dDGdTXZTtQ9RDgUX7/NjEUmeLUFtpnmOV35P/CZTtWRB4QIN+QceE4xedZyOt6FcGv6M
         WT//L/YV8PsF2ME+qESGxUQPy8oXZhqa74ddZqx1PuMW2JTxOtiDyGrz/979NmQOtH3E
         7w4KIQVbOXVZQ39pB69ehHJEmYnUpdBr4bIFbej8NJvwOi9dYOmdrO6kQrwiHkh9WcR1
         m5k7hYxlIYrp3Gs07RWjVpPUgDqvBFt+q+voFjhlSLZApl5Zeg2UIKHh1jaff194K91h
         pMLA==
X-Gm-Message-State: AHQUAubS1znlr+pEVQrb5SJjJMOizXJoFqaN1h5AShlgTQiFrqbumauH
        h9jA0BzR84I/eIoajuM6iNxSBsQgIogCBveBIQ9fTH73
X-Google-Smtp-Source: AHgI3Ia4tUepeDzqYWBWee0Ussok87OvXuN31D03SvsqJY9qdmP7IYZBEdGwiuWf63V3pha9F/9wVnSL92muhrl1Gzo=
X-Received: by 2002:a9d:4595:: with SMTP id x21mr18606097ote.234.1549890640607;
 Mon, 11 Feb 2019 05:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20190211122606.8662-1-brgl@bgdev.pl> <20190211122606.8662-29-brgl@bgdev.pl>
 <7b494951-7b37-3ee5-5ece-f486b7a566fe@arm.com>
In-Reply-To: <7b494951-7b37-3ee5-5ece-f486b7a566fe@arm.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 11 Feb 2019 14:10:29 +0100
Message-ID: <CAMpxmJVeQe7sxfharvA8REsOdmeaQUr2f1ByJwHCc5NnaFYEsw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 28/33] ARM: davinci: cp-intc: unify error handling
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
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
> > Use WARN_ON() on eny error in cp-intc initialization and drop all
> > custom error messages.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: David Lechner <david@lechnology.com>
> > ---
> >  arch/arm/mach-davinci/cp_intc.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp=
_intc.c
> > index f3787ae4cdbd..c1efb9390655 100644
> > --- a/arch/arm/mach-davinci/cp_intc.c
> > +++ b/arch/arm/mach-davinci/cp_intc.c
> > @@ -200,20 +200,16 @@ davinci_cp_intc_do_init(const struct davinci_cp_i=
ntc_config *config,
> >                       DAVINCI_CP_INTC_CHAN_MAP(offset));
> >
> >       irq_base =3D irq_alloc_descs(-1, 0, config->num_irqs, 0);
> > -     if (irq_base < 0) {
> > -             pr_warn("Couldn't allocate IRQ numbers\n");
> > -             irq_base =3D 0;
> > -     }
> > +     if (WARN_ON(irq_base < 0))
> > +             return irq_base;
> >
> >       /* create a legacy host */
> >       davinci_cp_intc_irq_domain =3D irq_domain_add_legacy(
> >                                       node, config->num_irqs, irq_base,=
 0,
> >                                       &davinci_cp_intc_irq_domain_ops, =
NULL);
> >
> > -     if (!davinci_cp_intc_irq_domain) {
> > -             pr_err("cp_intc: failed to allocate irq host!\n");
> > +     if (WARN_ON(!davinci_cp_intc_irq_domain))
> >               return -EINVAL;
> > -     }
> >
> >       set_handle_irq(davinci_cp_intc_handle_irq);
> >
> >
>
> I'm sorry, but how is turning an explicit message into a long stack
> trace really useful?
>

If any of these calls fails, the system is fried. I assumed that a
stack trace will point users straight to the offending line.

Bart
