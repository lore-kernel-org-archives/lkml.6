Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D7BC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC52217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U8N1OMsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfBEQRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:17:19 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36972 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfBEQRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:17:18 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so9592204iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 08:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bWb0pTnxhTUoywQeJFRJm0IcTK2TaI60KgoBc9nmwE4=;
        b=U8N1OMsOPN6G4pTD4KAVeKdHbThz2yJ6CbvowqBc13Qr60A0YCJCYtwEmeKqlsuRms
         vOE8Sl2bxyfLQdOYHcMWciYcgLUdDvUPtPnzTR6E9S2auZNbflrSUhNRNXwUPr7uCZlY
         2IZm4Hb8Qb5k2jOgle2GmFrmT4sue0TbOAmE2WLH2uei/HsnfDrF9PaU5rgI3AAVNiTW
         KxNGCb/yvqXZfblr1fuAdG4AoAjhSG4+IDK9dGyJ0kppMry0ItSZE3vag0zLhQTManFI
         SDji2+PdoZ23slIpEJwnBzNNH5jtPNndf5BZAntZ8wV9lUgEp7cwFweh3KP0XCx6ZUSQ
         MvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bWb0pTnxhTUoywQeJFRJm0IcTK2TaI60KgoBc9nmwE4=;
        b=H0Koiu4N62aUJrP1AdP47pBAulFLMp6n4UrpFTTJ3nJW3SUBzdbS69zyULRTIc6C3d
         9vzEXxrqCN+kukhVfC6bDc0oJDlpFR+cbZu3EffGKmJKQUPoz/jJXETHlRknH9+Ud60k
         u3SZblyxatYZMXYu7Gk2zHao0gY7yErw/gp/URHTExbZdB8XtgG5DM+Hd6nWKi88V5lx
         IAT5ESGJiYHNrIoi92E1yAL+BmuadOgWahSQILJUbAuVqRdTO8FJ0sfTKrwci8H/ZrBU
         iH7VDzQFSXfLBk9QXQC3oVBp009fcOrb6n0TELLaDzEHny2/Sb5oIHKjOEqPTopGOqPd
         GhLQ==
X-Gm-Message-State: AHQUAuY3WaiQxdwzOTr7WbQF4blt/zYS30CHiNL7Jtes2rOc1fxXvzgE
        aBVb+Rq6IqUQ7TPbFk/z00Q0e5BazABOuCsQF3sdRw==
X-Google-Smtp-Source: AHgI3IbdOB8y/dhjA5XybzsPChOIGqtI0ow010aYaynTBzpSZxB30d59gG55hQT0MWOh3xvTN9ICw2F2u8ufatCT0UQ=
X-Received: by 2002:a24:9d1:: with SMTP id 200mr3386013itm.53.1549383437227;
 Tue, 05 Feb 2019 08:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl> <20190131133928.17985-7-brgl@bgdev.pl>
 <b06cd3b4-b960-15cb-1bf4-f389e18248ac@lechnology.com>
In-Reply-To: <b06cd3b4-b960-15cb-1bf4-f389e18248ac@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 5 Feb 2019 17:17:06 +0100
Message-ID: <CAMRc=MefvcH3HXp4dpnD6D6m9vnPSJLtLmt7LFG+i0dLSfSmgg@mail.gmail.com>
Subject: Re: [PATCH 06/35] ARM: davinci: wrap interrupt definitions with a
 macro for SPARSE_IRQ
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

pon., 4 lut 2019 o 23:32 David Lechner <david@lechnology.com> napisa=C5=82(=
a):
>
> On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This is done in preparation for selecting CONFIG_SPARSE_IRQ. The
> > interrupt numbers will then start at the predefined NR_IRQS offset.
> >
> > For now wrap all interrupt numbers with a macro and define
> > DAVINCI_INTC_START to 0. Logically nothing changes for now.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
>
> Reviewed-by: David Lechner <david@lechnology.com>
>
> > diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-=
davinci/include/mach/irqs.h
> > index 03c446635301..14fa668d4e8d 100644
> > --- a/arch/arm/mach-davinci/include/mach/irqs.h
> > +++ b/arch/arm/mach-davinci/include/mach/irqs.h
> > @@ -30,371 +30,374 @@
> >   /* Base address */
> >   #define DAVINCI_ARM_INTC_BASE 0x01C48000
> >
> > +#define DAVINCI_INTC_START           0
> > +#define DAVINCI_INTC_IRQ(_irqnum)    (DAVINCI_INTC_START + (_irqnum))
>
> Almost not worth mentioning, but DAVINCI_INTC_START is only
> ever used once, so it could be omitted.

I'd like to leave it here - it's more readable that way.

Bart
