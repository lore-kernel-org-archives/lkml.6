Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B60C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECCE21738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqb8bAx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfAILLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:11:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46379 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbfAILK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:10:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so3424684ply.13;
        Wed, 09 Jan 2019 03:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtxkEti2IH7NoLqVK7Vk5ZZ5MD/pxeZbGB4KNm8VAs8=;
        b=Cqb8bAx4SPSv9UTPG+o/x+GV7FDSK/Y2KwjelwARcvQ749PVo/s6MI7RFgzbOQqJBR
         487IQsiF1XbVAmyg79+REVjdyI02BM6kRVsSDgOMuvTJFo5kiyAk/5ez22k2070xxhHF
         GVmDgpdU+ZQDXYlWQyawSkdie6HKIoazaDaXfRyi79eaEZNx/7Vj1ftXFdnRyeEWYFJH
         BR8re0LcuoUjJpo8ZoMbZ1MDy9Cubmwu2M2KBQhi6rLKZ0V6UldmCZx+duB1lXWzj5z0
         vjwxJJHES88Ew7G6doyQe91KA/DuE8UKJlddLHJR1EbuVIwKG7tFt0DYH9UfEjPL4IWR
         xBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtxkEti2IH7NoLqVK7Vk5ZZ5MD/pxeZbGB4KNm8VAs8=;
        b=TSVGvOu1fcjT6wRbYTTk8tVObNNFLhtVoEY1OmqYWx+lebcgmQKyh65ZUCLCzV+kld
         KNSkFZkCbI37lmnY/FTCB+r5GkCRQpSerdzpc53GfTOxULmdbLT3aEhhL/I3VHjVJvBC
         xQNH7gQEj6z5woGC7AYLFEZdDSdm/ODubHSJONhQgGzs/PHU26rg7sdAh0EhFcymyWC3
         RAgEeoZaTqBgFz+rfluOZx/84KC4hCxaZprZj9ODeJuXF9KSnz4C2uGTagcm3gggXhRn
         zT0OW6FsaDrrV6tJcyKyN5VjFrIgjkwM8PCPRf71K1bCb6MMfUg7YwS4jbyxs2QuZWlJ
         rBSw==
X-Gm-Message-State: AJcUukdNB/6VBNrBVGfcoHQO4OwWvcigo5TgM7FDc0kLz0rLjPxrEVxl
        36t8IdibLaYUvuGtpocvOUeF3jh/x5lD2NZ9x+kx/v00
X-Google-Smtp-Source: ALg8bN7DaOW+YDb/oW9EENTd5LmqfD9ma501lkNqhT7vywTG3aYPpmRzhqxTNUKfjxJIVOJBiUKk05/OI+wAMFFHt3g=
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr5706103pld.87.1547032257299;
 Wed, 09 Jan 2019 03:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-6-okaya@kernel.org>
 <3184241.VH7flF4h5P@aspire.rjw.lan>
In-Reply-To: <3184241.VH7flF4h5P@aspire.rjw.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Jan 2019 13:10:45 +0200
Message-ID: <CAHp75VeKB_4Fc-G_QG0YnSqhAu9w8csASrgrg0cVAo_gYjeJ_g@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] platform/x86: intel_pmc: Make PCI dependency explicit
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-next <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 12:48 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Saturday, January 5, 2019 11:06:00 AM CET Sinan Kaya wrote:
> > After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> > CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> > satisfied implicitly through dependencies on CONFIG_ACPI have to be
> > specified directly. Code relies on PCI for execution. Specify this
> > in the Kconfig.
> >
> > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  drivers/platform/x86/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index b36ea14b41ad..7afb96cb1cd6 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1174,7 +1174,7 @@ config INTEL_SMARTCONNECT
> >
> >  config INTEL_PMC_IPC
> >       tristate "Intel PMC IPC Driver"
> > -     depends on ACPI
> > +     depends on ACPI && PCI
> >       ---help---
> >       This driver provides support for PMC control on some Intel platforms.
> >       The PMC is an ARC processor which defines IPC commands for communication
>
> Andy, you had some reservations regarding this patch IIRC.
>
> Should I apply it?

Let's do it as a quick fix with something like below being added to
the commit message:

"For sake of a quick fix this introduces a new mandatory dependency to
the driver which may survive without it. Otherwise we need to revisit
the driver architecture to address this properly."

-- 
With Best Regards,
Andy Shevchenko
