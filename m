Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F565C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4DD2147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPhAirnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4DD2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeKUQ6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:58:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44130 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUQ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:58:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so3763860lji.11;
        Tue, 20 Nov 2018 22:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ko9YARgAyRX78sxvri5f14/qXUZ8umuHqgdBI6JKvKQ=;
        b=TPhAirnuQVRxcsU9zhiqVoJsPisZdi0faYF7BAwY3KP7LCzu5UNMty21yxuwZlS0Rr
         +DTJowdJVhYAYOAQ6817knUEH9XUhsHoJIzcL4zLyqXcKIE3/d78gtGvh6/8YMWh9KTC
         3b5r1YzebuWjfYw1kPy/socqJxOCBKe0cQJsQgl7XkqHZ+u2sSr5kpg1ggT8rAB+My1c
         p8NCR/aTd4kC103gmJODIXyqFNorBT0RGp8yRNUVEc+F7OecVTFQlNXC2Uamyl3v+dOQ
         yViz65XXunrK2isuSIP2jkgOGlZbbRIWQTTBgPJsT8uvj/oq2IUMepWIJbKafvIsuNX5
         y/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ko9YARgAyRX78sxvri5f14/qXUZ8umuHqgdBI6JKvKQ=;
        b=OdXTYRZKrf/emEzyWnM0ZS+fL0eFAA9SlE/9YzfY84OVg4wCTQZllRkOrKByRgDUBF
         GOhlWy3AicB/QJXlkTkySBIlwyB5hHRfksl1ACqb3x5ON5rlIHuji9T+ucz0iAkZzZIl
         kdueSqFJC15JH3B8IO/eKOQjO6wRakl7ryf+pAvV6TXT3EyJ23Et5CqvxTK2eqmeiNSC
         yuOAjfhdBC5tk12Cm0RiWqC+pxP5wefq61XKG50lyKTRvnCkma0/1J9pauPUINGEwksY
         XZxDGLVX1SMZ0QpYrRnyoTR11EoENJJvqVDlg7VMvajLI2hlhsn1bxdbha4FS4OXP62k
         LmPg==
X-Gm-Message-State: AGRZ1gJlw2lamRKNDAnsPxtOXroN/mWWGtwUYQhQuhtE56RBTEflNgc8
        43ge9tK7rpdpFZZtiJyvf72k0qEULcka4WNVw5I=
X-Google-Smtp-Source: AJdET5ezHe4qvaAMIYBGgnaHbTV+9+5BqXnUNjQChsXPOFGplWAHLiYVvRtwjDRN4o+25kmOKsnngunNw2HMmwcRKlA=
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr2989595ljg.64.1542781504802;
 Tue, 20 Nov 2018 22:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20181115154314.GA27850@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181115154314.GA27850@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 21 Nov 2018 11:54:52 +0530
Message-ID: <CAFqt6zZGP5DnAQd_19xKcLezOYaLsZpPr=FGxiTb7JRjTEJ4cA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Use vm_insert_range
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, Rik van Riel <riel@surriel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>,
        mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 9:09 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Previouly drivers have their own way of mapping range of
> kernel pages/memory into user vma and this was done by
> invoking vm_insert_page() within a loop.
>
> As this pattern is common across different drivers, it can
> be generalized by creating a new function and use it across
> the drivers.
>
> vm_insert_range is the new API which will be used to map a
> range of kernel memory/pages to user vma.
>
> All the applicable places are converted to use new vm_insert_range
> in this patch series.
>
> Souptick Joarder (9):
>   mm: Introduce new vm_insert_range API
>   arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
>   drivers/firewire/core-iso.c: Convert to use vm_insert_range
>   drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
>   drm/xen/xen_drm_front_gem.c: Convert to use vm_insert_range
>   iommu/dma-iommu.c: Convert to use vm_insert_range
>   videobuf2/videobuf2-dma-sg.c: Convert to use vm_insert_range
>   xen/gntdev.c: Convert to use vm_insert_range
>   xen/privcmd-buf.c: Convert to use vm_insert_range

Any further comment on driver changes ?
>
>  arch/arm/mm/dma-mapping.c                         | 21 ++++++-----------
>  drivers/firewire/core-iso.c                       | 15 ++----------
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 20 ++--------------
>  drivers/gpu/drm/xen/xen_drm_front_gem.c           | 20 +++++-----------
>  drivers/iommu/dma-iommu.c                         | 12 ++--------
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 ++++++-------------
>  drivers/xen/gntdev.c                              | 11 ++++-----
>  drivers/xen/privcmd-buf.c                         |  8 ++-----
>  include/linux/mm_types.h                          |  3 +++
>  mm/memory.c                                       | 28 +++++++++++++++++++++++
>  mm/nommu.c                                        |  7 ++++++
>  11 files changed, 70 insertions(+), 98 deletions(-)
>
> --
> 1.9.1
>
