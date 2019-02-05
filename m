Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ECEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6447F207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nfrBI8vI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfBEQ3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:29:21 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51499 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBEQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:29:20 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so9866969ite.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SV1i3PXnzDh3LkMg06RuFmI8bAptTjTQLNWSI7V+BsI=;
        b=nfrBI8vIVIzdxQvYtesVBizPLq2/5gdnEtV+ZpOfP4dTu4wkzPhW33lSejHIqW0132
         O1lpAcVDbUA4ogUfOxqQtyusWUdyhCqj8K5YZeh0x9hC1qTNRKdMMLhSyQWirRN4wYfl
         HVMwWy0B+JAsO1zXmyX7xMuE2R6/XQRQYTPhyAOABrloO3ghYdu2Y9CXJIaYyL49cvjO
         if6DPx4Mepv1MyFZ2NCN1H403IY/yU73vRSmrtvnbkV0T/tUWwuhugIfpIu00K8xT0Ks
         iVRDiksziup6jvKH8cr5oW7i4wn5ZY0qlMOknKVm7Kt0so919kQ8ANLBY3vffpTMIkHb
         gnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SV1i3PXnzDh3LkMg06RuFmI8bAptTjTQLNWSI7V+BsI=;
        b=Md2gahk/XxZVSkxfAb+ACPyf1QS9rmXe/LFzhkqIdavqzPqBGIn2/OAsc5NbdLax2R
         U38czge6U9vjR6+LLcNthSYq9qO/oxAsEw6gS1w2B5TO6NMoiJCkW33cOa2qcefXIsLg
         M4PnjFikf0lZp7LiwLSqzU+opF1zOTvgSZgo/xMQpI1yADzsqdn7U7lhbfryzA6dVMG6
         L2IQVh2aXjq4lscdCOyL2UOKT/XVHk3XD5ObJedhHUa6ap0t0RU9cSvBortNw8tlPUmG
         DU+ats1nWH/8agU9qhPwvD1RjyTKgNvUGLlY8f7vJCeZG5PCKkORlxj3itWbwoshe9s8
         lt+w==
X-Gm-Message-State: AHQUAua5RvHd0dEITkrf/vFdErlnOEut0nVGvEJNAe4/8pPqNUuM2rsN
        gDWCklqf9at+lNwCP9/9N0IhuERoNbcYK79H5q2qKsouey4=
X-Google-Smtp-Source: AHgI3IbtZrZmxNH5z++voZrXoIprzBvCcyVMkYAVfA51Ap54Z9uGy1uFR81CTsa7450MjY3slf+ck6hU9VH7lMdMOas=
X-Received: by 2002:a24:f909:: with SMTP id l9mr2814397ith.74.1549384159899;
 Tue, 05 Feb 2019 08:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl> <20190131133928.17985-8-brgl@bgdev.pl>
 <90995667-37cd-62a9-a40e-ee104016faf9@lechnology.com>
In-Reply-To: <90995667-37cd-62a9-a40e-ee104016faf9@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 5 Feb 2019 17:29:09 +0100
Message-ID: <CAMRc=Me67M+JPg-mxKpCnuMm6NFkL-OLrJ+5XiKztd=bmm+PKw@mail.gmail.com>
Subject: Re: [PATCH 07/35] ARM: davinci: aintc: use irq domain
To:     David Lechner <david@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 4 lut 2019 o 23:42 David Lechner <david@lechnology.com> napisa=C5=82(=
a):
>
> On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We need to create an irq domain if we want to select SPARSE_IRQ. The
> > cp-intc driver already supports it, but aintc doesn't. Use the helpers
> > provided by the generic irq chip abstraction.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   arch/arm/mach-davinci/irq.c | 38 ++++++++++++++++++++++++++----------=
-
> >   1 file changed, 27 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> > index e539bc65d4ef..c874ea269411 100644
> > --- a/arch/arm/mach-davinci/irq.c
> > +++ b/arch/arm/mach-davinci/irq.c
> > @@ -23,6 +23,7 @@
> >   #include <linux/interrupt.h>
> >   #include <linux/irq.h>
> >   #include <linux/io.h>
> > +#include <linux/irqdomain.h>
> >
> >   #include <mach/hardware.h>
> >   #include <mach/cputype.h>
> > @@ -43,6 +44,7 @@
> >   #define IRQ_INTPRI7_REG_OFFSET      0x004C
> >
> >   static void __iomem *davinci_intc_base;
> > +static struct irq_domain *davinci_irq_domain;
> >
> >   static inline void davinci_irq_writel(unsigned long value, int offset=
)
> >   {
> > @@ -55,17 +57,15 @@ static inline unsigned long davinci_irq_readl(int o=
ffset)
> >   }
> >
> >   static __init void
> > -davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned =
int num)
> > +davinci_irq_setup_gc(void __iomem *base,
> > +                  unsigned int irq_start, unsigned int num)
> >   {
> >       struct irq_chip_generic *gc;
> >       struct irq_chip_type *ct;
> >
> > -     gc =3D irq_alloc_generic_chip("AINTC", 1, irq_start, base, handle=
_edge_irq);
> > -     if (!gc) {
> > -             pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
> > -                    __func__, irq_start);
> > -             return;
> > -     }
> > +     gc =3D irq_get_domain_generic_chip(davinci_irq_domain, irq_start)=
;
>
> check for (gc =3D=3D NULL) here?
>

I can add it, but it's not really needed. We know we pass correct
parameters to this routine and if it fails, the system won't boot
anyway.

Bart
