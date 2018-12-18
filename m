Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D87AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414D8217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+ofMn9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeLRMyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:54:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40657 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeLRMyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:54:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so12194183lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiOdRpCcB5RW4TqZM074ipMTqVW9QTa6+4OEUBKgdz0=;
        b=j+ofMn9pL7ziht+9i0YlnsPRRQqrmCSc4PVj/dbHod6e/WoLSYlDBKG1uxj4Na/pDa
         PwE3Xpe1xLM1NPPLYmoidU0CP6z1RhTWzECLuDk5STL9DmXNbHRY9FedFR7U0szEccEb
         ZDupnI94UxtHcmquG9+MtHI60NA7YbhcOjRYn1vWFnCUU/8jjibpTPj7Sp8R2bYWtlHH
         mZsUFsLvcf4k/LBBr45kTtwHU726vrhdId/Kcv7KTI9HNxvdDcuSHKHWX0cWyRk73Q6z
         84AhcUoV5K2PY43vQnajEkeBFoEnP9OJ1m6ZRmLvPu/668Te21in2Lq6PLvfjMO6fZAU
         v3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiOdRpCcB5RW4TqZM074ipMTqVW9QTa6+4OEUBKgdz0=;
        b=YZv0ygtB4rCWs9GXG6zJpfvab0L7nVONE6oKpBeMuJgsm+hAti0jPXgBJ2gGxKsfuh
         /pP+YA2Ba7m8Ig0sxeLke7dTKYvEBFoHEhZ0PXbSkl1yOdqjuJXmfEbe6HJKcAgin7ed
         Cw8pB3ZdyarkTV2ShLCqyQIeJdaohHQZdlofs1nI+stoXKL05UQsVKSE15zkf0A75Xzp
         ioBy8prvIeqNGVHFOo+iTgouR5elD0N+15s6cO/cPsowDAW1aWNyKpC7zkuntHJT5OG5
         3otWtFc3gVcHFqQZUMeKCsbeFE+3H5tVnsKAudLxzsg2ROtUvAEaaGS58HuPjcNq3v3z
         QVqQ==
X-Gm-Message-State: AA+aEWZH0B5Cy3CpingGR2I0H2VF85ydMUEojVIfAxF2zh/rXjpU92uS
        Mz8uRp20PP1o5+FYjrpV3SliJusPMfZkJbZqniY=
X-Google-Smtp-Source: AFSGD/UIp+suEbV1Uz3/N4wGmi4vyjsGqh6gbFo1pbJjxwEbFS7gl5FTWcERUtIl1pWigBZO8qIlQd8+seR1/mcS11E=
X-Received: by 2002:a19:6514:: with SMTP id z20mr2633604lfb.31.1545137681798;
 Tue, 18 Dec 2018 04:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk> <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
 <20181218123318.GN26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218123318.GN26090@n2100.armlinux.org.uk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 18 Dec 2018 18:24:29 +0530
Message-ID: <CAFqt6zbqaS-pFETyjRR2-1V57MiJuX65xoMjgkr-DjUnrJYzSg@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, airlied@linux.ie,
        hjc@rock-chips.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 6:03 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 18, 2018 at 05:36:04PM +0530, Souptick Joarder wrote:
> > On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > This looks like a change in behaviour.
> > >
> > > If user_count is zero, and offset is zero, then we pass into
> > > vm_insert_range() a page_count of zero, and vm_insert_range() does
> > > nothing and returns zero.
> > >
> > > However, as we can see from the above code, the original behaviour
> > > was to return -ENXIO in that case.
> >
> > I think these checks are not necessary. I am not sure if we get into mmap
> > handlers of driver with user_count = 0.
>
> I'm not sure either, I'm just pointing out the change of behaviour.

Ok. I think feedback from Heiko might be helpful here :)

>
> > > The other thing that I'm wondering is that if (eg) count is 8 (the
> > > object is 8 pages), offset is 2, and the user requests mapping 6
> > > pages (user_count = 6), then we call vm_insert_range() with a
> > > pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> > > end up inserting four pages.
> >
> > Considering the scenario, user_count will remain 8 (user_count =
> > vma_pages(vma) ). ? No ?
> > Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
> > a pages_count
> > of 8 - 2 = 6. So we end up inserting 6 pages.
> >
> > Please correct me if I am wrong.
>
> vma_pages(vma) is the number of pages that the user requested, it is
> the difference between vma->vm_end and vma->vm_start in pages.  As I
> said above, "the user requests mapping 6 pages", so vma_pages() will
> be 6, and so user_count will also be 6.  You are passing
> user_count - offset into vm_insert_range(), which will be 6 - 2 = 4
> in my example.  This is two pages short of what the user requested.
>

So, this should be the correct behavior.

                 return vm_insert_range(vma, vma->vm_start,
rk_obj->pages + offset,
                                                          user_count);
