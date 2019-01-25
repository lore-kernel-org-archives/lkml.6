Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66D4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D02218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaxJjQ7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfAYVmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:42:00 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:40415 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfAYVmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:42:00 -0500
Received: by mail-it1-f179.google.com with SMTP id h193so11735745ita.5;
        Fri, 25 Jan 2019 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ya7XYbpo6gmzMvatU7r78rVmkReftYabRYKlkSSN8jg=;
        b=aaxJjQ7ixqslzeBxCEShmA/uez2vyxje7q1KZEGUo/LJeO4qYh6KKV4wTv8kV97T9K
         zXuOeOPIyjNInW97y5XsgrZ3O93MWIu6nnTVnI3X7XO1S/sYt9ONDNtuf1LJYyItJazt
         mnDhi6nEPbJgyTvyX/8cN4nz9vIEDm0GmfBTQYjVWOJD2tnQ5mK+3my1M4yViU74L+df
         VNtaUIRZS1xJTFiPJ4dsNAasp3J9Qm9J7/ghFjBMPYs8o5ox+4SqxQfPzr02BSsUC154
         HukgTdqLoAsUgrDwOksdccqs05iUqR5Xz2tdGD88Bn88zbAQcoVh5PApvzO2rG4IgYbT
         NMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ya7XYbpo6gmzMvatU7r78rVmkReftYabRYKlkSSN8jg=;
        b=guR0stZaZiXaMpx4lUusvDzR6sPj0q4xWEk07NaFm7sKd5p1n6JBUZvpvIf+VtgM2D
         gKww4jwFQOrbR90BmiVVdbj+Ome35Im7ilnInuMxDbozS1yGnzaYYfbuV+T3Fk83iXHN
         Bpnt7ghbuBYa7nr2/NHA93RVzruqPLmGxFRaUCSs3oEBu5J94GwLrRZSGv92KccMmXmj
         Bk286XRxWozLnt0k7fqE3Ld5XHwW3DysCUKSn3GZrNVT4mR7RIJRvWStpxSKPMCjJjcG
         olSj4gET2sleRRjKVxzpaPpV55vD1DglD3C+aIkyP7N8yCBwXzTSGh7Fz6A9j+cUKuf9
         BHcw==
X-Gm-Message-State: AJcUuke/xdeQi7OGkjx2RcXGQE4NmIwTtd8KR3IAXSpZ6B1dgUz6fCTC
        P4NcI0WV3O83gMC+cZwOlQAZzoPu5YNalVLEc1MzXA==
X-Google-Smtp-Source: ALg8bN5C+Jlf0DidEVfm86sMamhqXWCc+wl+hMxH8SUMc6OMzotZTKuoOohRoah7e4UbBBqNZEFRwruXfhkhTTRPmio=
X-Received: by 2002:a24:d4c2:: with SMTP id x185mr5471673itg.34.1548452518772;
 Fri, 25 Jan 2019 13:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20170731182010.GA933@stranger.qboosh.pl> <20190125191437.GA25902@stranger.qboosh.pl>
 <20190125211349.nfbbcuaip5y6l5dr@dcvr>
In-Reply-To: <20190125211349.nfbbcuaip5y6l5dr@dcvr>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 25 Jan 2019 13:41:47 -0800
Message-ID: <CAKdAkRSZ6cT=fO42YG320Po6cYtWaPgg2puAf5jMnC+hD+Em2g@mail.gmail.com>
Subject: Re: [PATCH][RESEND] wistron_btns needs executable BIOS image
To:     Eric Wong <e@80x24.org>
Cc:     Jakub Bogusz <qboosh@pld-linux.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Miloslav Trmac <mitr@volny.cz>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 1:13 PM Eric Wong <e@80x24.org> wrote:
>
> Jakub Bogusz <qboosh@pld-linux.org> wrote:
> > Let's try once again... (take 3)
> >
> > First time I sent this patch when I prepared it in 2013 for Linux 3.12,
> > the second time after update for Linux 4.12 in 2017...
> > And it still applies to Linux 4.20.
>
> Adding Dmitry Torokhov and linux-input to Cc:
> (that's what ./scripts/get_maintainer.pl says)
>
> > Actual description in forwarded message.
> >
> >
> > --
> > Jakub Bogusz    http://qboosh.pl/
>
> > From: Jakub Bogusz <qboosh@pld-linux.org>
> > To: linux-kernel@vger.kernel.org, mitr@volny.cz
> > Subject: [PATCH] wistron_btns needs executable BIOS image
> >
> > Hello,
> >
> > This patch (originally agains 3.1x, now I updated include to build
> > against 4.12.x) fixes winstron_btns module issue with calling BIOS
> > functions in non-executable memory.
> >
> > Tested (on Linux 3.10.x and few later versions) on F-S Amilo 8210 laptop.
> >
> >
> > --
> > Jakub Bogusz    http://qboosh.pl/
>
> > wistron_btns needs executable BIOS image.
> >
> > Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>
> >
> > --- linux-4.12/drivers/input/misc/wistron_btns.c.orig 2013-11-16 09:05:55.612742472 +0100
> > +++ linux-4.12/drivers/input/misc/wistron_btns.c      2013-11-16 09:24:37.356028732 +0100
> > @@ -33,6 +33,7 @@
> >  #include <linux/types.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/leds.h>
> > +#include <asm/set_memory.h>
> >
> >  /* How often we poll keys - msecs */
> >  #define POLL_INTERVAL_DEFAULT        500 /* when idle */
> > @@ -124,6 +125,7 @@
> >       if (entry_point >= 0xF0000) {
> >               bios_code_map_base = base;
> >               bios_entry_point = bios_code_map_base + (entry_point & 0xFFFF);
> > +             set_memory_x((unsigned long)bios_code_map_base, 0x10000 >> PAGE_SHIFT);
> >       } else {
> >               iounmap(base);
> >               bios_code_map_base = ioremap(entry_point & ~0x3FFF, 0x4000);
> > @@ -134,6 +136,7 @@
> >                       goto err;
> >               }
> >               bios_entry_point = bios_code_map_base + (entry_point & 0x3FFF);
> > +             set_memory_x((unsigned long)bios_code_map_base, 0x4000 >> PAGE_SHIFT);
> >       }
> >       /* The Windows driver maps 0x10000 bytes, we keep only one page... */
> >       bios_data_map_base = ioremap(0x400, 0xc00);

It is really weird have __iomem region to have executable bit set. I
wonder if, along with the setting memory to X, we should not change
that ioremap() to memremap()?

Thanks.

-- 
Dmitry
