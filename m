Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CBE2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPVuLGto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLRMGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:06:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41203 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRMGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:06:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so13969597ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgH7tJU86A63ysDva0gHrk1mfC2sisonLET/9h8k1Tc=;
        b=KPVuLGtoqVJTgTNdQBThrlDOpS4QJO1KtfxY8D0rUcWVKcmNNwiYzi7U2M1PhBtshc
         iL/ODWxtvZIEg+D47ChA7mcCGdHLNWNcEaZp7oIadyDNNwlcch9BofU/Rvv89Lig16kw
         HFhEJ8BjQUcqiSnTZL4mN0JmSJY2G25VfhYB09DPLaJvOc5xkJAtSKDrWphtwsmeNfgu
         l4J/z79tVc6NUxjmphjPjBGzwmgCvRdhi9sQKuooGLO11keY3/bMybxovVqtBeKE1Owj
         HhFqdSWrviMpp3oGUww6LbaEBTRK1NDp1Ql+gK2bqBMJum0shPqwPGPtMS2sd8oIY6/n
         3HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgH7tJU86A63ysDva0gHrk1mfC2sisonLET/9h8k1Tc=;
        b=jpD2xZczuhL8pthYaAOXCi6i7gnzLTNIMB4hhV2CN3sj/SerPeUnz3RoOIUFA10dBe
         FJyGcBEGd1W6XaDcoX5HtFVFX4HZ+/OgKxBeVHpLpRpdkTocbagESImRzBakGoicDSDn
         jQ661M0Cki90loVsBl4ixL8KaOIdUuinpWomMrCK2ekX9Q28CeokRNeSfJjIbcYSlDpS
         7p5Mo+tZMZ2Er92PLwo88EnQsk59+lYz+OVYBYy4NMrXmi4xlf8CKaWZ6pkz+T9W669P
         dA3CDi9UPCAm8OWMH9E2rmF6UYA2VEM+9nE7RYE7BW1iqXoqL3yMBlY1MkagpKv99a2o
         fWMw==
X-Gm-Message-State: AA+aEWY58G+3kpGlmaa0dA6XWD6MdO6kZ8BWxovrS+cn+9a4C58ebx8+
        4MJw1uB5H24+c+yQGkhOjbJ4cXxHMbxNrwPlAU8=
X-Google-Smtp-Source: AFSGD/WOgYL2p2sFz4uiELV6e/RpgDqDhwBfTgy+6gM5dCl5ZdB4LS9Gs48e3HBZcMt3eV1g4z05vNSOvyvNHBOQvXw=
X-Received: by 2002:a2e:4601:: with SMTP id t1-v6mr10927299lja.111.1545134777792;
 Tue, 18 Dec 2018 04:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC> <20181218095709.GJ26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218095709.GJ26090@n2100.armlinux.org.uk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 18 Dec 2018 17:36:04 +0530
Message-ID: <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        Linux-MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 18, 2018 at 01:53:34AM +0530, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Acked-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 ++-----------------
> >  1 file changed, 2 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > index a8db758..8279084 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > @@ -221,26 +221,11 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
> >                                             struct vm_area_struct *vma)
> >  {
> >       struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
> > -     unsigned int i, count = obj->size >> PAGE_SHIFT;
> >       unsigned long user_count = vma_pages(vma);
> > -     unsigned long uaddr = vma->vm_start;
> >       unsigned long offset = vma->vm_pgoff;
> > -     unsigned long end = user_count + offset;
> > -     int ret;
> > -
> > -     if (user_count == 0)
> > -             return -ENXIO;
> > -     if (end > count)
> > -             return -ENXIO;
> >
> > -     for (i = offset; i < end; i++) {
> > -             ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
> > -             if (ret)
> > -                     return ret;
> > -             uaddr += PAGE_SIZE;
> > -     }
> > -
> > -     return 0;
> > +     return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
> > +                             user_count - offset);
>
> This looks like a change in behaviour.
>
> If user_count is zero, and offset is zero, then we pass into
> vm_insert_range() a page_count of zero, and vm_insert_range() does
> nothing and returns zero.
>
> However, as we can see from the above code, the original behaviour
> was to return -ENXIO in that case.

I think these checks are not necessary. I am not sure if we get into mmap
handlers of driver with user_count = 0.

>
> The other thing that I'm wondering is that if (eg) count is 8 (the
> object is 8 pages), offset is 2, and the user requests mapping 6
> pages (user_count = 6), then we call vm_insert_range() with a
> pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> end up inserting four pages.

Considering the scenario, user_count will remain 8 (user_count =
vma_pages(vma) ). ? No ?
Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
a pages_count
of 8 - 2 = 6. So we end up inserting 6 pages.

Please correct me if I am wrong.

>
> The original code would calculate end = 6 + 2 = 8.  i would iterate
> from 2 through 8, inserting six pages.
>
> (I hadn't spotted that second issue until I'd gone through the
> calculations manually - which is worrying.)
>
> I don't have patches 5 through 9 to look at, but I'm concerned that
> similar issues also exist in those patches.

yes, you were not cc'd for 5 - 9. Below are the patchwork links -

https://patchwork.kernel.org/patch/10734269/
https://patchwork.kernel.org/patch/10734271/
https://patchwork.kernel.org/patch/10734273/
https://patchwork.kernel.org/patch/10734277/
https://patchwork.kernel.org/patch/10734279/

>
> I'm concerned that this series seems to be introducing subtle bugs,
> it seems to be unnecessarily difficult to use this function correctly.
> I think your existing proposal for vm_insert_range() provides an
> interface that is way too easy to get wrong, and, therefore, is the
> wrong interface.
>
> I think it would be way better to have vm_insert_range() take the
> object page array without any offset adjustment, and the object
> page_count again without any adjustment, and have vm_insert_range()
> itself handle the offsetting and VMA size validation.  That would
> then give a simple interface and probably give a further reduction
> in code at each call site.
>
> Thanks.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
