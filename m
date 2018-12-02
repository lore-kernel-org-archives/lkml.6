Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E635C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AF920672
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/tndmL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AF920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbeLBGN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:13:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35466 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBGN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:13:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so4292759pgs.2;
        Sat, 01 Dec 2018 22:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QkWGefk1uOV7uhsAtF573lEHHJSsrTRZEoJ/EEqbupA=;
        b=M/tndmL+7unpD7Cz+MMnYUMmmLKKNQl2BcHQL30JGC2EvipOkXmc7nP92Ecrfl8h+j
         nPudgrN4aT+LEP6HoeYYSZr/o7m3KVuiIv8x7vDJqnzHd9shZNkfBUeDVPPBncdU8F/p
         oTA9DYBsya674xroQ9+qG49yr/zZ/k5vxL/QJUwE7Bg0XVW53OCRmpTLPny662uFmuic
         8B4+FQF4OlxnAVuwkhb96Sm25HTS1UsMqufynVfnoz24ZZvhF/ROhv5TxeaNYetXD+sF
         zK/2UojyJVWVHGae0s8Qclnm/vtcbyXp2swTYWdf9EdnUZCyyxpn44GxcU7K3iQD6Uwl
         6paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QkWGefk1uOV7uhsAtF573lEHHJSsrTRZEoJ/EEqbupA=;
        b=TwHZEYJtTo3HZ0E/tTgbbrPidb/SoSHGK1pQzHmsusTYrHnlkBQ5JaBbmRZG4iMBZ5
         UujkJovpyrIcnc/NucU8Mvv1R5V+G4+/lipiutNn+Mt19RrhS8CmDAxm3BUtVDzR2IBS
         EB4XmHfhiW/gIx9Jwq5507guot/gfqbSCpryQxZwQMG1R0fPFWSjIw1e7yz6vb5estj+
         h7lYhF8a0thoz1VfmwT+MKpiRTIk0CzMlP1TSw5xrHSlXv7vKNClCo1UC/Lgd+AVrynl
         ELAOxlTzs0lTUPONPj8E6x/froz/tzmI0UHZs0Np4bs43zcrIFiL3BXTa/BpBYpR+7Du
         YZbg==
X-Gm-Message-State: AA+aEWZ4Da5HL4zFTE495DFafg0S3pyVe6NHaHJNYmOqMhXgUcTj2JFk
        RPWlp3/8z4/WkaycgDVtZiyhel75
X-Google-Smtp-Source: AFSGD/VadVkIzzhs3ZrvwCPB7PLdPaDENychA8ssT0abv5PurP9XiiGYd+5YwEv4HTNWB3Yc/RO8mQ==
X-Received: by 2002:a62:b9a:: with SMTP id 26mr11586637pfl.196.1543731204982;
        Sat, 01 Dec 2018 22:13:24 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
        by smtp.gmail.com with ESMTPSA id d80sm33964454pfm.146.2018.12.01.22.13.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 22:13:23 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:47:07 +0530
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
Subject: [PATCH v2 0/9] Use vm_insert_range
Message-ID: <20181202061707.GA3070@jordon-HP-15-Notebook-PC>
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

v1 -> v2:
	Address review comment on mm/memory.c. Add EXPORT_SYMBOL
	for vm_insert_range and corrected the documentation part
	for this API.

	In drivers/gpu/drm/xen/xen_drm_front_gem.c, replace err
	with ret as suggested.

	In drivers/iommu/dma-iommu.c, handle the scenario of partial
	mmap() of large buffer by passing *pages + vma->vm_pgoff* to
	vm_insert_range().

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

 arch/arm/mm/dma-mapping.c                         | 21 +++++--------
 drivers/firewire/core-iso.c                       | 15 ++-------
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 20 ++----------
 drivers/gpu/drm/xen/xen_drm_front_gem.c           | 20 ++++--------
 drivers/iommu/dma-iommu.c                         | 13 ++------
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 +++++---------
 drivers/xen/gntdev.c                              | 11 +++----
 drivers/xen/privcmd-buf.c                         |  8 ++---
 include/linux/mm_types.h                          |  3 ++
 mm/memory.c                                       | 38 +++++++++++++++++++++++
 mm/nommu.c                                        |  7 +++++
 11 files changed, 81 insertions(+), 98 deletions(-)

-- 
1.9.1

