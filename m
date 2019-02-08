Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0744C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8498A20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pm+jw6fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfBHQEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:04:01 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51924 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHQEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:04:00 -0500
Received: by mail-it1-f196.google.com with SMTP id y184so3610754itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MN+tt0M/O3yQP7ix9uKQqFk42RY7a7HW2j0BfCCiIlg=;
        b=pm+jw6fKPJ+4WZqGC2IvbXEdpH+pMkh7cHaOfoX4GzcTbYnp9Yppk5pR5PvDhqKhOW
         70p+ry4NBAz6fmWq0j4b+hQfEHj8cwoUaD64AITLKuSglBVyogFRsQVZEgr9zHOF2kXK
         lp13/5VmthzmPzLO3r0+2CKpbyQbpP0t6PGACCESOYKr/M23SIen+PXmrtqmTlG23I1b
         f/MUfjECBo3rzuWnGbeTMnbGc6LyButwVG4rWFeWmAVTYzUUyHzINMIZscvocwo8MInI
         lzK2FDfOIYXiFNw90dysA8r3DdCPfQbih1bQ4qWYFKb1YEREr0j5vz2KGlg13cCc54pp
         cvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MN+tt0M/O3yQP7ix9uKQqFk42RY7a7HW2j0BfCCiIlg=;
        b=ItuL5t80eY1B1neN1eI4OXtB3asdaziuz9R95K1Qu7xMvNt+A71PZtw3YP0LA0aacz
         uqpM58IItADxMhgCp6X+QC9WGaLM3jRtd050T3MY/AKwrkGCBedVpeKjN14BtjrG5AvB
         jSwUneTQ/nMcUGBlpZF9mt3XBRcWbfBW5AfHfFefLWfKCPhFqskMx8PuYDhhB5CFb6kx
         saEhMVRpyrki+LbTpy34fqTMl5I5Bdh0RW0Zce9gjS38jgQ7L/dnwUEQu9mM7fbeQOS2
         miATJdAZ1fsYocKDumBOj7XRtii0mo/EiyToFKj+ttp401/RVmRwbjpgbF/sMN4mwBUb
         NXdw==
X-Gm-Message-State: AHQUAuYLAQ0/0N0bXWs7G+3wB4hFNfjkz+sKTXd99FoIoZIcVFBa0vfd
        4hAKlmNC54WCNoxNPQ4rLfJFi0xSCsiv5qA2WyYwdA==
X-Google-Smtp-Source: AHgI3IZRv64cdRpB2Qx2UCcSsdUrNleNlxRVqgghTFMUwNS33e0B14YnixZzHQYKYfw3ev9kM6CkLjGFTT8XM61uz2Q=
X-Received: by 2002:a24:5d94:: with SMTP id w142mr7077266ita.74.1549641839811;
 Fri, 08 Feb 2019 08:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl> <20190131133928.17985-19-brgl@bgdev.pl>
 <9fb82a77-9732-b9ec-5394-c6a5148b4f7f@lechnology.com>
In-Reply-To: <9fb82a77-9732-b9ec-5394-c6a5148b4f7f@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 Feb 2019 17:03:49 +0100
Message-ID: <CAMRc=MdCbeaRr54pyPvc9cKBD9=Rz2H-S6cFaNzpkGMkfwthAw@mail.gmail.com>
Subject: Re: [PATCH 18/35] irqchip: davinci-aintc: move the driver to drivers/irqchip
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

wt., 5 lut 2019 o 00:43 David Lechner <david@lechnology.com> napisa=C5=82(a=
):
>
> On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The aintc driver has now been cleaned up. Move it to drivers/irqchip
> > where it belongs. There's no device-tree support for any dm* board so
> > there's no IRQCHIP_OF_DECLARE() - there's only the exported init
> > function called from machine code.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
>
> Reviewed-by: David Lechner <david@lechnology.com>
>
>
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 3d1e60779078..ea0eb82bf1d2 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -129,6 +129,11 @@ config BRCMSTB_L2_IRQ
> >       select GENERIC_IRQ_CHIP
> >       select IRQ_DOMAIN
> >
> > +config DAVINCI_AINTC
> > +     bool
> > +     select GENERIC_IRQ_CHIP
> > +     select IRQ_DOMAIN
>
> No help section? :-)
>

Most Kconfig options that cannot be interactively selected don't have one.

I'll leave it as is.

Bart

> > +
> >   config DW_APB_ICTL
> >       bool
> >       select GENERIC_IRQ_CHIP
>
