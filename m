Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3884ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39D021470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UEmgO+/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39D021470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJSWtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:49:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52221 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeJSWtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:49:05 -0400
Received: by mail-it1-f194.google.com with SMTP id 74-v6so4555220itw.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W9x5ZZTIrxtxDRXf0UvErCyQvXx6idksoLaOvjmGsAI=;
        b=UEmgO+/xXDkZoD5A4uqdX0sSLK9r02HW3hDhwfMy4aVe9OFhKO9yht/IzR/ftUuhjf
         HkMXNhX9tMmvrhegKzEequc+3sbaZHTLnENGqTmLwUKPslv4i7tqYrdxrVhiOfu+tWbF
         /aKbHvEgKR9lTo92uXHmMghYSiRufOZu69SUuGAhvqVlAfa2/J/hQYqKySvvDN9HWDrU
         9ip7fZTtR7SPcnnkiGfsRG7JVr3jorCUCtxPo0G/d6hFcRJIaZlJdOFhxDYPDx0pUe9v
         GP2FzpL9W+KTmIhuKPTgzvh4bamJD7pPhvNPx3IJh+cd+Zkxf3OlGvezNkm6qN1fJszm
         khsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W9x5ZZTIrxtxDRXf0UvErCyQvXx6idksoLaOvjmGsAI=;
        b=HRW9qqzbBtJfxwf3R+XLKRWAsjzMEhM2t83QZAhaLKnAX70S5mpLSbrbT6Q928I8+9
         hoYgM2v0NOOxT0Lot7upczVYszbyhUKW1YV4bLa8ARhjd6tYZ8oRopkGPuM0O3OnXxqt
         ydrveQxzO53yu8ZIvhhCsjE0SfwHHLb5aCgVOOoRIPdVI9dVYzRDBetgmzCrwkvZo33W
         hiOUc1QG+DZ9VWaIFub6Je4gX+3NUxPcd1KGHAuVPcFkjoBKkRh1u702qGBDObUPMHl2
         pfsX26/QsFQ9YvG0hCT/meY7fJ1Z5CmHHNxTDGocdOmstCojGVL1MRFuVLS5IoysZ6u8
         tDAA==
X-Gm-Message-State: ABuFfogckjlwtFB7AjDagIWahaNPvsjDNRaqRtFXVslpeYHVDYpk7bs0
        YzR65jjfEIijcRu5efVJ5Snkt5JaaS3nKmR6b90KcM8G
X-Google-Smtp-Source: ACcGV61JLyuLrk6aWrjozhOwgHB5Z3o+8w7MaYLAEpA3o5RJOT2diJkgd1dd2J3aiEBmkv1axSN6oNkA0AMz7IPzrdU=
X-Received: by 2002:a02:9b46:: with SMTP id g6-v6mr28108914jal.136.1539960159588;
 Fri, 19 Oct 2018 07:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181014152010.2021-1-brgl@bgdev.pl> <20181014152010.2021-3-brgl@bgdev.pl>
 <20181016105310.GD4768@kroah.com>
In-Reply-To: <20181016105310.GD4768@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 19 Oct 2018 16:42:28 +0200
Message-ID: <CAMRc=Mdre+ZKQEXGdavHXqoo=41YDmfnU_-im=4FepYdy1ob0g@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 2/4] mm: move is_kernel_rodata() to asm-generic/sections.h
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 16 pa=C5=BA 2018 o 12:53 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> On Sun, Oct 14, 2018 at 05:20:08PM +0200, Bartosz Golaszewski wrote:
> > Export this routine so that we can use it later in devm_kstrdup_const()
> > and devm_kfree().
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/asm-generic/sections.h | 14 ++++++++++++++
> >  mm/util.c                      |  7 -------
> >  2 files changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/asm-generic/sections.h b/include/asm-generic/secti=
ons.h
> > index 849cd8eb5ca0..d79abca81a52 100644
> > --- a/include/asm-generic/sections.h
> > +++ b/include/asm-generic/sections.h
> > @@ -141,4 +141,18 @@ static inline bool init_section_intersects(void *v=
irt, size_t size)
> >       return memory_intersects(__init_begin, __init_end, virt, size);
> >  }
> >
> > +/**
> > + * is_kernel_rodata - checks if the pointer address is located in the
> > + *                    .rodata section
> > + *
> > + * @addr: address to check
> > + *
> > + * Returns: true if the address is located in .rodata, false otherwise=
.
> > + */
> > +static inline bool is_kernel_rodata(unsigned long addr)
> > +{
> > +     return addr >=3D (unsigned long)__start_rodata &&
> > +            addr < (unsigned long)__end_rodata;
>
> Those symbols are not exported, are you sure this is going to work for a
> kernel module that ends up using this function?
>

I tested it with a loaded module, yes.

> I'll take it, but be aware of the future complications that might happen
> here...
>

These symbols are built-in for all architectures. Do they even need
exporting? On the off-chance that something fails, we can move this
function back to mm/util.c as it was in the first version of this
series.

Best regards,
Bartosz Golaszewski
