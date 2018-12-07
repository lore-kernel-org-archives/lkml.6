Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47238C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053A42081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqQCq+kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053A42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeLGU1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:27:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40054 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGU1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:27:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so4624463lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 12:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1gp9b66p+D5If3HDTrYunFFk8/ZJcoOdKYP4Xl/4es=;
        b=ZqQCq+kQXmi7g0s41wlzMA6mevBI36eUjdQcJ1j4qHF1C+8VY38vwn4L2wXd4sE4gO
         YueKqjACGRacaP9gWD/BK8xFJGApCjvofjC57OfvEqNQQd73PPg4etrZVthsV72UDhxa
         Csh0ed5de6f1ht4uaCS4TGVU1UiQ0OtQgj17XczohbuhP6KPgY+Pldub5h2B8vHtuM2k
         CbF9fQeZe+aDh3kRTXp+u12xEcTv9QgHTCIonfv4U2lZ4v6yGlgSvXZmCen6wUtueoUk
         L9/GGhE6EUaA+V6fdghsP91n9SkogwuKy/s9xGJwvMBDBWH+Kg31K8HXfZsZNmRdffE/
         Adpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1gp9b66p+D5If3HDTrYunFFk8/ZJcoOdKYP4Xl/4es=;
        b=lzK2wh2esadSslLsxpweTxgsq0S1Zi4OZeabI4kHAop0UgzRgJUzihRRk5WNvo9nIp
         rlI27KiQHIkDyHqbf3kMak/UbGjEEdCHzIaOC7Vj5dzwgcVOJ5VHYPQNQExbSu6NqBZk
         fWzQ8jhVZuz4JFn6vOigSfZZLewOIzS2siFmv8dNF71a767iZ/PHCTs4WB2seHtwo3E2
         pwajhp3Z83KdvDaWYEFsLRpbju9QwfyCtp/IbRCILa5D61gBZ83SjgqBHgzFKIgij1on
         usqD06XgXlpClsGYEVWMbnKh5RsozS0YrIQiJqpt5MOz1kTSXmGlkHMNZA0N8S4nVW50
         5U3w==
X-Gm-Message-State: AA+aEWbSuNa3zgYRtf3n4Y9FgJBhkt2Cn6yAXud8/3I0wP4TO5xHNYWX
        zSh3I4qe56F+8XHzyAzu/acWhjPDxdnRvssKlYw=
X-Google-Smtp-Source: AFSGD/WiWZ1rxWyUbQM5X7LEj+GUG729CL7ZIKd42DpnOLoWaRi8edYXMTAwfrSuYWaLtpERODE3nz53L066pxDF6AI=
X-Received: by 2002:a2e:9c52:: with SMTP id t18-v6mr1847940ljj.149.1544214420838;
 Fri, 07 Dec 2018 12:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20181206184227.GA28656@jordon-HP-15-Notebook-PC> <ca1779ea-7a87-971c-24c4-4a1c77a72e92@arm.com>
In-Reply-To: <ca1779ea-7a87-971c-24c4-4a1c77a72e92@arm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Dec 2018 02:00:36 +0530
Message-ID: <CAFqt6zbMbvB1ckwhSsBATrq5M-HQ6qk95sCWCoTTFFnwzBAnng@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
To:     robin.murphy@arm.com
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

On Fri, Dec 7, 2018 at 8:20 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 06/12/2018 18:42, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Acked-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 20 ++------------------
> >   1 file changed, 2 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > index a8db758..2cb83bb 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > @@ -221,26 +221,10 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
> >                                             struct vm_area_struct *vma)
> >   {
> >       struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
> > -     unsigned int i, count = obj->size >> PAGE_SHIFT;
> >       unsigned long user_count = vma_pages(vma);
> > -     unsigned long uaddr = vma->vm_start;
> > -     unsigned long offset = vma->vm_pgoff;
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
> > +     return vm_insert_range(vma, vma->vm_start, rk_obj->pages,
> > +                             user_count);
>
> We're losing vm_pgoff handling here, which given the implication in
> 57de50af162b, may well be a regression for at least some combination of
> GPU and userspace driver (I assume that commit was in the context of
> some version of the Arm Mali driver, possibly on RK3288).

In commit  57de50af162b, vma->vm_pgoff = 0 for GEM mmap handler context
and removing it from common path which means if call stack looks like
rockchip_gem_mmap_buf() -> rockchip_drm_gem_object_mmap() ->
rockchip_drm_gem_object_mmap_iommu(), then we might have a non zero
vma->vm_pgoff context which is not handled.

This is the problem you are pointing ? right ?
