Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3496C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EC1205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hLgFZtnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EC1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeKBEKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:10:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42136 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeKBEKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 00:10:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id f3-v6so19027808ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x28CHtYBtAke9zTgGDsG/ukgJudNEAh8iZdeHyd+R1k=;
        b=hLgFZtnZERZ9H59z5uwiAZw+H0WzyvgBFIZCB6tjrCdv7wYePYTNI+jQjK/8gulzd6
         YXQULCb4AchpUuRKKgueb96aRTr1P4ipPMPMuvHErqgknHfBnVBkv0jo6U2mlCDHMs2q
         K+ewtcuIsTBox8V4mAxJIUZqs5D8eWw8TuE7kPKM47kJDsl5UYUAAosMfv8VUXUlpDhd
         XKf+aCGVbXQUFSPwEmoStZRyUUrpmQ8Op8VSZIWS3BsIaHdLpkWQtjPbqlals7cetpw/
         9+IDjvFOdoyrqR3XhBLpZBFlxGy5D2FZmkg1eh2ndXTIQbbQLZSq7+J8lT4Sk5HF+eEl
         0u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x28CHtYBtAke9zTgGDsG/ukgJudNEAh8iZdeHyd+R1k=;
        b=qDOr+NOH3t8jBlMr0xijvJWYiwA14HhfiKUHaIicWiA0kX82wbzqq2L5UwmACG2wTP
         JV/pwVoGljdhc7yTZGZcorq5xX7yBU9WiLdR16zn+bHkO0UmdcTtitDEVEzQ6RcBndn4
         EfddniWpBGVL/V7kiLcQTccSP5gUsZYYsgn0KSqKyDpHt7ryJMVlxhLfUHEGDwznhTJg
         j1mC5SyNVekUgipgo9sAetmPW/bOqtmId1SS3lkagEIPgPgYlKmb3gQHfYKavBBrZKkf
         eYiorvt9R0gPxyLysleQitn3FfDTlVjW4gq3n7Vxdn+hHxMkF1e76BUcWqcuOIAtIOLx
         6YtQ==
X-Gm-Message-State: AGRZ1gLC/cbGjwAF+ahwX6gIh8wUD0EYf9jAs3TAkMYrIB1HCgQgpoVO
        inLgue+KTeGyX4X2N0RKE7A6oOdnq17wpLLYMocsew==
X-Google-Smtp-Source: AJdET5et+vlHc6DnMdpRXDE2AfmbcwFh978skpBxlhPu48u2nyx7ynli7tyn83Z1kJgLE0QIcWX8ocCKeAReSW/2060=
X-Received: by 2002:a2e:f02:: with SMTP id 2-v6mr5636257ljp.134.1541099158295;
 Thu, 01 Nov 2018 12:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181101185340.32664-1-olof@lixom.net> <5b524dcf-f78c-25af-6a70-9c85aa8e4a42@gmail.com>
In-Reply-To: <5b524dcf-f78c-25af-6a70-9c85aa8e4a42@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 1 Nov 2018 12:05:46 -0700
Message-ID: <CAOesGMin7S+xhNq3OH9zNOawpo-nWPys3k4wy_n+7Voqxh_+aQ@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dma: move swiotlb helpers under CONFIG_IOMMU_DMA
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 12:03 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 11/1/18 11:53 AM, Olof Johansson wrote:
> > Fixes the following tinyconfig warnings:
> > arch/arm64/mm/dma-mapping.c:174:12: warning: '__swiotlb_mmap_pfn' defined but not used [-Wunused-function]
> > arch/arm64/mm/dma-mapping.c:163:12: warning: '__swiotlb_get_sgtable_page' defined but not used [-Wunused-function]
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
>
> Christoph sent an alternative solution here:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-October/609480.html

Thanks!

This was my bad, I searched for the symbols before posting but missed
that thread. Either patch is fine with me.


-Olof
>
> > ---
> >  arch/arm64/mm/dma-mapping.c | 58 ++++++++++++++++++++++-----------------------
> >  1 file changed, 29 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> > index 3a703e5d4e32..62356c64e180 100644
> > --- a/arch/arm64/mm/dma-mapping.c
> > +++ b/arch/arm64/mm/dma-mapping.c
> > @@ -160,35 +160,6 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
> >       __dma_unmap_area(phys_to_virt(paddr), size, dir);
> >  }
> >
> > -static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
> > -                                   struct page *page, size_t size)
> > -{
> > -     int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> > -
> > -     if (!ret)
> > -             sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> > -
> > -     return ret;
> > -}
> > -
> > -static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
> > -                           unsigned long pfn, size_t size)
> > -{
> > -     int ret = -ENXIO;
> > -     unsigned long nr_vma_pages = vma_pages(vma);
> > -     unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -     unsigned long off = vma->vm_pgoff;
> > -
> > -     if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
> > -             ret = remap_pfn_range(vma, vma->vm_start,
> > -                                   pfn + off,
> > -                                   vma->vm_end - vma->vm_start,
> > -                                   vma->vm_page_prot);
> > -     }
> > -
> > -     return ret;
> > -}
> > -
> >  static int __init atomic_pool_init(void)
> >  {
> >       pgprot_t prot = __pgprot(PROT_NORMAL_NC);
> > @@ -358,6 +329,35 @@ arch_initcall(arm64_dma_init);
> >  #include <linux/platform_device.h>
> >  #include <linux/amba/bus.h>
> >
> > +static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
> > +                                   struct page *page, size_t size)
> > +{
> > +     int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> > +
> > +     if (!ret)
> > +             sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> > +
> > +     return ret;
> > +}
> > +
> > +static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
> > +                           unsigned long pfn, size_t size)
> > +{
> > +     int ret = -ENXIO;
> > +     unsigned long nr_vma_pages = vma_pages(vma);
> > +     unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > +     unsigned long off = vma->vm_pgoff;
> > +
> > +     if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
> > +             ret = remap_pfn_range(vma, vma->vm_start,
> > +                                   pfn + off,
> > +                                   vma->vm_end - vma->vm_start,
> > +                                   vma->vm_page_prot);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  /* Thankfully, all cache ops are by VA so we can ignore phys here */
> >  static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
> >  {
> >
>
>
> --
> Florian
