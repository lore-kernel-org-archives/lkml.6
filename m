Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899B6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5082D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhLumYCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5082D20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbeKPBsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:48:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46594 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:48:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so9158267pgp.13;
        Thu, 15 Nov 2018 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=k7YhP8SU7rzdO2cfLJKZnWQx6wMxbtBlZWcB8cpbHjE=;
        b=PhLumYCaR5dQAx+R6tkONFpiyswMbRUWcrJ1mQjfmmA1SGYKUYbEOJQPQ2AK3kq3+4
         IOM8sAzHrjxeOrirmUAbMn+zo6vimswT13HtlD/k7BpW7rYEktbU75JenrU9hPrPcfkJ
         0hsrJyA9uvibiIr+3HazOg04EOnnuyAajTtL06ZT6Gc7OM0sqsXU8LW/VvDhG2KG+g20
         hxYA3+ORfxC3D+nCoAi3p27ztW+Jdoe++HvPyWK+a8Mk9FOGZI0SoA616D1yZmhGzZPg
         o+HFiO6NeG/FJ0NC4nLc1yDOgrM3IJKgaTp8cfOmC+4sh15lO9EqOt8SXB3TaAxccWxc
         c3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=k7YhP8SU7rzdO2cfLJKZnWQx6wMxbtBlZWcB8cpbHjE=;
        b=bWP7R2jItfD/vJHt6HkCJIKBqCK4MyRP1uowtd8tglCMmfKlUzLcdKdB5N398Yh27U
         lbHsKTksB/O0NedUL3Uc1y7jf6dMVDEnjkRohqWCliRhHpMFhakSeM/QLfjtcgNCvCog
         05EOnl0ySX1bf1I56rnWY2JymVQpXo/uQ3TAUnVpQh9mCFBKXO4yxjNE62gBustZOlD3
         zmaepNN/LHIueL/dQSOyIuD0NPLCA11j2w1eyIkPCgS7GsV/s0vjObhp0TvP1MEf1W/n
         x8m1U1xncxUOizc7k6/PmRYVrbTRUXcjO6COOuFGRptc5o09UOd9aM2rNJWQf/75Nwqb
         ozVw==
X-Gm-Message-State: AGRZ1gK24X+isZoPtcDRVvrq+qxeJAtS+X1L8kDd/NlPzTVK+f9bpjv/
        3TDxkfqcVQOWMsFmHG/2yBwGPNQUar4=
X-Google-Smtp-Source: AJdET5dFBMDj1krLNWt58fbSZfUFEu9jXazKuDbFpNQ7sH8hvnircMBzVteGRl8Y5b94E1Pkm8aUyg==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr6176757pgl.186.1542296379954;
        Thu, 15 Nov 2018 07:39:39 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.233])
        by smtp.gmail.com with ESMTPSA id v12sm29037162pgg.41.2018.11.15.07.39.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 07:39:38 -0800 (PST)
Date:   Thu, 15 Nov 2018 21:13:14 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com,
        sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com,
        peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Subject: [PATCH 0/9] Use vm_insert_range
Message-ID: <20181115154314.GA27850@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previouly drivers have their own way of mapping range of
kernel pages/memory into user vma and this was done by
invoking vm_insert_page() within a loop.

As this pattern is common across different drivers, it can
be generalized by creating a new function and use it across
the drivers.

vm_insert_range is the new API which will be used to map a
range of kernel memory/pages to user vma.

All the applicable places are converted to use new vm_insert_range
in this patch series.

Souptick Joarder (9):
  mm: Introduce new vm_insert_range API
  arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
  drivers/firewire/core-iso.c: Convert to use vm_insert_range
  drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
  drm/xen/xen_drm_front_gem.c: Convert to use vm_insert_range
  iommu/dma-iommu.c: Convert to use vm_insert_range
  videobuf2/videobuf2-dma-sg.c: Convert to use vm_insert_range
  xen/gntdev.c: Convert to use vm_insert_range
  xen/privcmd-buf.c: Convert to use vm_insert_range

 arch/arm/mm/dma-mapping.c                         | 21 ++++++-----------
 drivers/firewire/core-iso.c                       | 15 ++----------
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 20 ++--------------
 drivers/gpu/drm/xen/xen_drm_front_gem.c           | 20 +++++-----------
 drivers/iommu/dma-iommu.c                         | 12 ++--------
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 ++++++-------------
 drivers/xen/gntdev.c                              | 11 ++++-----
 drivers/xen/privcmd-buf.c                         |  8 ++-----
 include/linux/mm_types.h                          |  3 +++
 mm/memory.c                                       | 28 +++++++++++++++++++++++
 mm/nommu.c                                        |  7 ++++++
 11 files changed, 70 insertions(+), 98 deletions(-)

-- 
1.9.1

