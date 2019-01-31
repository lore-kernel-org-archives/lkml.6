Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB45C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87652087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp269b/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfAaFyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:54:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45802 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfAaFyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:54:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so1542842ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 21:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4F+BIoC5hFXGqBFlBhOZIqVE+Jy7im/3T8WXfXdLwWI=;
        b=bp269b/5XwF27CgSY7s+wmtEk4znSKlB+M7K1RDVTTco3dDvaKmSLnFFquclkJt18k
         LZpHSBmntIEUuMDbjTR114tCnjQkr+3lqKcF50ogrKnu7lrWIhkwYqcP6a7MnfbQdUws
         9E9jOHe6v1AP0ymA4X1LIsSA1F6uI7ekTxHdfi37rPcTNoHLgIaVv6Qg/tx/ZesCXa4K
         MCT7nlJUR/T3B+E+eF0NujO4qRatgvsG9aT5bD6XycZ6AGJsWKTcM8pDRWVXL/8sKxo9
         c/KuhM6CBbyGHgyNibBg8adtha/7r5dnq60ytbuO4unJxjh8QVAcFj5doUN9xxeWmDq/
         16Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4F+BIoC5hFXGqBFlBhOZIqVE+Jy7im/3T8WXfXdLwWI=;
        b=nTLeJdJ25IeOoa/9tusiB68+EnwhqIJhTo+DxaUU0UiE8NTOqh0YKX7THyrlJFtS4W
         ERxXnxbtN0yDO/5H+CIcbFMXHJXCLbIUGAOzg5oSJAnmpjkdKkFQwGlACfCY+MMH+p3c
         mmSzM31B/aHoUN45gP4VPR/JANwokRAbISEgRncwHawE4eYR9CJwzuoylOKSVZLHXGMO
         hOD+HTN9w2BWem3IegdY8XgV2OGnhGJZl4/l7688DD23OU8IipkkGqawkZjeOSkBEXls
         iHV0p6LqWwxmbFQAO9ntrjPms2fp2d4uv3Hg4LS6QFvd7PGIu9Wyb/q3F4lN9ZbLuQHE
         PyGQ==
X-Gm-Message-State: AJcUukecYhhO3ayyVOFrom44B2PthwN4H/7Pup1B9aYrohbaQqL/2oKC
        ZUp22LoC0YGPLtg2hJNP6aV36BPYenT2jowL2kKSaA==
X-Google-Smtp-Source: ALg8bN4UZl+eNXzJK3EHyOKNamr0dpp4Ec4HLveXW/6ZiFj9iQ73NQazBbBLuQK4t9krAIMCTdLCglSsl+6gY6r7o+s=
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr28777535ljj.43.1548914077333;
 Wed, 30 Jan 2019 21:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com> <20190117112803.GC3710@rapoport-lnx>
In-Reply-To: <20190117112803.GC3710@rapoport-lnx>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 31 Jan 2019 11:24:24 +0530
Message-ID: <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
Subject: Re: [PATCH] arch/arm/mm: Remove duplicate header
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michal Hocko <mhocko@suse.com>, rppt@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
> > On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > >
> > > Remove duplicate headers which are included twice.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>
> > Any comment on this patch ?

If no further comment, can we get this patch in queue for 5.1 ?

> >
> > > ---
> > >  arch/arm/mm/mmu.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > index f5cc1cc..dde3032 100644
> > > --- a/arch/arm/mm/mmu.c
> > > +++ b/arch/arm/mm/mmu.c
> > > @@ -23,7 +23,6 @@
> > >  #include <asm/sections.h>
> > >  #include <asm/cachetype.h>
> > >  #include <asm/fixmap.h>
> > > -#include <asm/sections.h>
> > >  #include <asm/setup.h>
> > >  #include <asm/smp_plat.h>
> > >  #include <asm/tlb.h>
> > > @@ -36,7 +35,6 @@
> > >  #include <asm/mach/arch.h>
> > >  #include <asm/mach/map.h>
> > >  #include <asm/mach/pci.h>
> > > -#include <asm/fixmap.h>
> > >
> > >  #include "fault.h"
> > >  #include "mm.h"
> > > --
> > > 1.9.1
> > >
> >
>
> --
> Sincerely yours,
> Mike.
>
