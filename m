Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB1CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3BC214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBOm5wKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3BC214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbeKVGcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:32:48 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34973 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbeKVGcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:32:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so4907819lfc.2;
        Wed, 21 Nov 2018 11:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KPJP4afcPxq3hlpX7wqKHen5JsRKgkXEgCJxX4IGlTA=;
        b=EBOm5wKXRwotd4eL1ToEgJzL/07HsJBrNxB958iMmzqf8GuAG7LUFOBL4iFSPs7lR9
         jdFVcp3X6BIOcfgIDeYXlXE2JA1u/HtQU0FyRk9+sjsvAN9RYCxV8xrAYVmccTVlmGKM
         ejVfOrkQltSjnyDdRGuA8yYXEKBqxXXbTrHGwujAKXAN9BovJS/x+BrGHrJ8h4LeMgOj
         QPeyAXM/eFjUGphiRdktHIyXA9dS6+impVBUr1JDeCbJO9e3vbG1aXtVuIw38IDsVrhl
         1qZtQ4c6GOJlIA2hBXtawGRftCvedWnUW3yp0rOad1SjNv/SZ0UcJ62EuLNH8H1woR7+
         kgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPJP4afcPxq3hlpX7wqKHen5JsRKgkXEgCJxX4IGlTA=;
        b=fWxlZGAymLXLJYolN1I73bgt2SIhgzVLqvYDruLP7Kc+uLQw+8Y2+3DKSAztKNUj+4
         8yh99ro9o8xBGjxsGrzoiYs+cjUpgrh6g/EEKlIz88iFTkFT84MMQvYh7mKzZ3jz9n3A
         vlbSEVNXPb3RDQ99Hxnl1LO1Z02KlobtVzNADBztmU9g8g0t7y7F1S4tWBk+4eIuzRgp
         bNJIEaA59l2mn7Y7wi2lJ6yud4AZv25b6uVJ95OIMKMs+wIZnM1YeFd/7LoRy8cxOzns
         SBmHjHVtN1pXkEIKGt+B2M7czYyTx8yGxHtpGcVcBaBKy7lTGR9RaTBi3790tCKu/2A2
         jXAA==
X-Gm-Message-State: AGRZ1gKTbEzXk1QyzMflTWTXb2Ep0wVSpij3Mes07gOLt4Dv/aas8cLF
        hUM66SZX7+LCKmQN1BXZHzO5sRSnLlWxdAlKn8M=
X-Google-Smtp-Source: AJdET5f42eRWtK1W37H0EMeDzJsB5YlMgsH6quij8zAkUe9g3MLUPhczlJkuKDS9vTifkwNrrzOy+0AF2RcsPHlGSCQ=
X-Received: by 2002:a19:c70a:: with SMTP id x10mr4570891lff.88.1542830223460;
 Wed, 21 Nov 2018 11:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20181115154314.GA27850@jordon-HP-15-Notebook-PC>
 <CAFqt6zZGP5DnAQd_19xKcLezOYaLsZpPr=FGxiTb7JRjTEJ4cA@mail.gmail.com> <0c6f1144-6ee0-29df-5e1f-d35d2264e06e@oracle.com>
In-Reply-To: <0c6f1144-6ee0-29df-5e1f-d35d2264e06e@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 22 Nov 2018 01:26:51 +0530
Message-ID: <CAFqt6zavi-S9ySZJTKG9zChacSD+ZCOVyyW71B1DfjggTH=Jkg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Use vm_insert_range
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        mchehab@kernel.org, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
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

On Thu, Nov 22, 2018 at 1:08 AM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 11/21/18 1:24 AM, Souptick Joarder wrote:
> > On Thu, Nov 15, 2018 at 9:09 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >> Previouly drivers have their own way of mapping range of
> >> kernel pages/memory into user vma and this was done by
> >> invoking vm_insert_page() within a loop.
> >>
> >> As this pattern is common across different drivers, it can
> >> be generalized by creating a new function and use it across
> >> the drivers.
> >>
> >> vm_insert_range is the new API which will be used to map a
> >> range of kernel memory/pages to user vma.
> >>
> >> All the applicable places are converted to use new vm_insert_range
> >> in this patch series.
> >>
> >> Souptick Joarder (9):
> >>   mm: Introduce new vm_insert_range API
> >>   arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
> >>   drivers/firewire/core-iso.c: Convert to use vm_insert_range
> >>   drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
> >>   drm/xen/xen_drm_front_gem.c: Convert to use vm_insert_range
> >>   iommu/dma-iommu.c: Convert to use vm_insert_range
> >>   videobuf2/videobuf2-dma-sg.c: Convert to use vm_insert_range
> >>   xen/gntdev.c: Convert to use vm_insert_range
> >>   xen/privcmd-buf.c: Convert to use vm_insert_range
> > Any further comment on driver changes ?
>
> Xen drivers (the last two patches) look fine to me.

Thanks, can I considered this as Reviewed-by ?

>
> -boris
>
>
> >>  arch/arm/mm/dma-mapping.c                         | 21 ++++++-----------
> >>  drivers/firewire/core-iso.c                       | 15 ++----------
> >>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 20 ++--------------
> >>  drivers/gpu/drm/xen/xen_drm_front_gem.c           | 20 +++++-----------
> >>  drivers/iommu/dma-iommu.c                         | 12 ++--------
> >>  drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 ++++++-------------
> >>  drivers/xen/gntdev.c                              | 11 ++++-----
> >>  drivers/xen/privcmd-buf.c                         |  8 ++-----
> >>  include/linux/mm_types.h                          |  3 +++
> >>  mm/memory.c                                       | 28 +++++++++++++++++++++++
> >>  mm/nommu.c                                        |  7 ++++++
> >>  11 files changed, 70 insertions(+), 98 deletions(-)
> >>
> >> --
> >> 1.9.1
> >>
>
