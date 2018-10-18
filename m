Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ABAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124962145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124962145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeJRWEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:04:43 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:32855 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJRWEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:04:43 -0400
Received: by mail-vk1-f193.google.com with SMTP id l186so6663317vke.0;
        Thu, 18 Oct 2018 07:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8l5ofKErrj4f90Fkpahh0Q67ZoqT1lt7stgTkH/ESs=;
        b=Epf7hODM+2qpXwISjpz7WIXpAb7iTJpMub2WtnPlYlP9jcYd84+yUN6Jhgg7UdJqF3
         m0QbxHsV5nA2JWZVvEriCSLsioF/YK6PoP4DshIvP9y1WM/xbZs8lECoNYcS3E5X8T5E
         mA7x6VZL7dKAk8g5/yAhCpEEWpYJy/EvPmYXogfnE67vBp7N++KGestMOTJdIz8EFQeE
         FPpBdlXmww4oSvTEwHpM3/KW7/n/GSCmbWaVYWkfPHmeG98+jyOIgUt15wNdo0SM3jtw
         JG+vvAuGX/lVMtVqUcfhImqdQDXa1N777PaQjzbfFOP5VA2PyRY3F9TiiOBzLlOWL8eH
         WCmg==
X-Gm-Message-State: ABuFfoiwbDhRXe66S1psBJgs4ZtcFa8IiIT8pIEZpZGvbDumv18A4juj
        vIfGEPKDeN6Ux7jIJwADEAYq5Su1exEw+1yB9iMg1sm0
X-Google-Smtp-Source: ACcGV607EXovraQX6iRSW+P0yh+L0yGvQxM410WJQF2tDhMOC9xMRZ/IQhFqzPK0GVT1lo5srjvxAtcvHXgqqrgebHc=
X-Received: by 2002:a1f:b547:: with SMTP id e68-v6mr12652957vkf.72.1539871412397;
 Thu, 18 Oct 2018 07:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
 <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
 <20181018124118.GA10376@infradead.org> <20181018131210eucas1p14a11ec7555ca9ef3003387f1985326e6~ethZ7giWB0310803108eucas1p1X@eucas1p1.samsung.com>
In-Reply-To: <20181018131210eucas1p14a11ec7555ca9ef3003387f1985326e6~ethZ7giWB0310803108eucas1p1X@eucas1p1.samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Oct 2018 16:03:19 +0200
Message-ID: <CAMuHMdVe1KgQWYZ_BfBkSo3zr0c+TenLMEw3T=BLEQNoZ6ex7A@mail.gmail.com>
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej, Christoph,

On Thu, Oct 18, 2018 at 3:12 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On 10/18/2018 02:41 PM, Christoph Hellwig wrote:
> >> +static int __init pata_buddha_init_one(void)
> >> +{
> >> +    struct zorro_dev *z = NULL;
> >> +
> >> +    while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
> >
> > I'm not really an m68k expert, but shouldn't this implement a
> > struct zorro_driver instead?  (or maybe two of them as xsurf
> > seems sufficiently different).
>
> I didn't want to introduce too many changes over old IDE's
> driver in the initial version of the libata driver as
> I can't test them myself. Once the new driver is verified
> to work I plan to convert it into proper Zorro_driver.

Unfortunately that conversion cannot happen right now, as zorro8390.c
already binds against the X-Surf zorro device.

I think the proper solution would be to start using MFD for multi-function
Zorro devices, cfr. the work I started years ago, but never completed
https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=zorro-mfd

Then the Buddha MFD driver can instantiate 2 Buddha IDE cells, the
Catweasel MFD driver can instantiate 3 Buddha IDE cells and a Catweasel
floppy cell, and the X-Surf MFD driver can instantiate 2 Buddha IDE
cells and a zorro8390 cell.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
