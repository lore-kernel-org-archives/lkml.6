Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF55ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0027C2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2exghkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0027C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeGTJtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:49:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42298 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbeGTJtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:49:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so8875954ljc.9;
        Fri, 20 Jul 2018 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U069ezTu9a8T3yJUzNnHhZaN/jGy110g2sDUDrjcc0E=;
        b=c2exghkVoKmx/CjOJKaJx/vU8QkN/6BuEHUDaB3dR+bfRTy3dNdyRPJp4mB7bZ+PT5
         68DuL0703yrL+vhOxqxryCF8uhYBjV2GJYe0dSLMPuK8cPodVz0dbisge8RXX2vK/tQs
         uHr25OpRPnurjzDzNIT1XoHN4Hk/33LH6Ma0zzMa/vvVLMv40gwsxvBE/vimQgZQ9aGW
         3zlCUkiHuxJuHB4wpngjSISwQAaK08DgqDOifC64Dvn21XO6ui5whO5h4BJceNmxucm1
         sNFZTsW/E0xJutb2HUKYDmsZYgAZqiQ+HIMQH/OIhKmMzCuL66NoEocIfapjsCwroMj5
         WPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U069ezTu9a8T3yJUzNnHhZaN/jGy110g2sDUDrjcc0E=;
        b=f/C+2WipqNfXXjcHecr9PfMcMoCOuj4KPoppY7ZOrLl1+LSG4ilN94WIPG6QW3LZT7
         nEHe4mY8ljYXAqwvxMjJzExbfdjjEPjYI4PGNpBEaePiz1E37agGnLcSKrG/rJpDnD8n
         j5H4ec5fINCWALYizwm9d7u7uWtNdpCHd0jsVxvTsh4YD5iMBmcGTL1B1r6XG+6bdJ/0
         Z2Uk0GsAoo9iGqfmne4DdGsPznTh7ynKRgBCPfJQqWW+uKa923ejz+u9pQh9zl+MgLEG
         /oLj9nEroIBFxvUDD4ZPD2eXtxkBDE7jBivT2pXDMw6Jf66/8XLUU5ahYQy2X+RQs6qs
         825g==
X-Gm-Message-State: AOUpUlFA6IERqEFeLsWKSeU/kOILBCSRHWa4n7E5yIUZTzgdsRqTYKr6
        7lVWlxhYC+h9gkLila2iFtRJ+tNpt64=
X-Google-Smtp-Source: AAOMgpfntpezbLu4Wh8hzG0EC8Ory7P6R1f16lrY6Jr/Y7Guwrj5Zbr5Qhiavo3wVynRIJGfAHQ5eQ==
X-Received: by 2002:a2e:9095:: with SMTP id l21-v6mr1043111ljg.15.1532077318346;
        Fri, 20 Jul 2018 02:01:58 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id w2-v6sm252394lje.73.2018.07.20.02.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jul 2018 02:01:57 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v5 0/8] xen: dma-buf support for grant device
Date:   Fri, 20 Jul 2018 12:01:42 +0300
Message-Id: <20180720090150.24560-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

This work is in response to my previous attempt to introduce Xen/DRM
zero-copy driver [1] to enable Linux dma-buf API [2] for Xen based
frontends/backends. There is also an existing hyper_dmabuf approach
available [3] which, if reworked to utilize the proposed solution,
can greatly benefit as well.

RFC for this series was published and discussed [9], comments addressed.

The original rationale behind this work was to enable zero-copying
use-cases while working with Xen para-virtual display driver [4]:
when using Xen PV DRM frontend driver then on backend side one will
need to do copying of display buffers' contents (filled by the
frontend's user-space) into buffers allocated at the backend side.
Taking into account the size of display buffers and frames per
second it may result in unneeded huge data bus occupation and
performance loss.

The helper driver [4] allows implementing zero-copying use-cases
when using Xen para-virtualized frontend display driver by implementing
a DRM/KMS helper driver running on backend's side.
It utilizes PRIME buffers API (implemented on top of Linux dma-buf)
to share frontend's buffers with physical device drivers on
backend's side:

 - a dumb buffer created on backend's side can be shared
   with the Xen PV frontend driver, so it directly writes
   into backend's domain memory (into the buffer exported from
   DRM/KMS driver of a physical display device)
 - a dumb buffer allocated by the frontend can be imported
   into physical device DRM/KMS driver, thus allowing to
   achieve no copying as well

Finally, it was discussed and decided ([1], [5]) that it is worth
implementing such use-cases via extension of the existing Xen gntdev
driver instead of introducing new DRM specific driver.
Please note, that the support of dma-buf is Linux only,
as dma-buf is a Linux only thing.

Now to the proposed solution. The changes  to the existing Xen drivers
in the Linux kernel fall into 2 categories:
1. DMA-able memory buffer allocation and increasing/decreasing memory
   reservation of the pages of such a buffer.
   This is required if we are about to share dma-buf with the hardware
   that does require those to be allocated with dma_alloc_xxx API.
   (It is still possible to allocate a dma-buf from any system memory,
   e.g. system pages).
2. Extension of the gntdev driver to enable it to import/export dma-buf’s.

The first five patches are in preparation for Xen dma-buf support,
but I consider those usable regardless of the dma-buf use-case,
e.g. other frontend/backend kernel modules may also benefit from these
for better code reuse:
    0001-xen-grant-table-Make-set-clear-page-private-code-sha.patch
    0002-xen-balloon-Share-common-memory-reservation-routines.patch
    0003-xen-grant-table-Allow-allocating-buffers-suitable-fo.patch
    0004-xen-gntdev-Allow-mappings-for-DMA-buffers.patch
    0005-xen-gntdev-Make-private-routines-structures-accessib.patch

The next three patches are Xen implementation of dma-buf as part of
the grant device:
    0006-xen-gntdev-Add-initial-support-for-dma-buf-UAPI.patch
    0007-xen-gntdev-Implement-dma-buf-export-functionality.patch
    0008-xen-gntdev-Implement-dma-buf-import-functionality.patch

The corresponding libxengnttab changes are available at [6].

All the above was tested with display backend [7] and its accompanying
helper library [8] on Renesas ARM64 based board.
Basic balloon tests on x86.

*To all the communities*: I would like to ask you to review the proposed
solution and give feedback on it, so I can improve and send final
patches for review (this is still work in progress, but enough to start
discussing the implementation).

Thank you in advance,
Oleksandr Andrushchenko

[1] https://lists.freedesktop.org/archives/dri-devel/2018-April/173163.html
[2] https://elixir.bootlin.com/linux/v4.17-rc5/source/Documentation/driver-api/dma-buf.rst
[3] https://lists.xenproject.org/archives/html/xen-devel/2018-02/msg01202.html
[4] https://cgit.freedesktop.org/drm/drm-misc/tree/drivers/gpu/drm/xen
[5] https://patchwork.kernel.org/patch/10279681/
[6] https://github.com/andr2000/xen/tree/xen_dma_buf_v1
[7] https://github.com/andr2000/displ_be/tree/xen_dma_buf_v1
[8] https://github.com/andr2000/libxenbe/tree/xen_dma_buf_v1
[9] https://lkml.org/lkml/2018/5/17/215

Changes since v4:
*****************
- added r-b tags
- rebased onto v4.18-rc5

Changes since v3:
*****************
- added r-b tags
- minor fixes
- removed gntdev_remove_map as it can be coded directly now
- moved IOCTL code to gntdev-dmabuf.c
- removed usless wait list walks and changed some walks to use
  normal version of list iterators instead of safe ones as
  we run under a lock anyways
- cleaned up comments, descriptions, pr_debug messages

Changes since v2:
*****************
- fixed missed break in dmabuf_exp_wait_obj_signal
- re-worked debug and error messages, be less verbose
- removed patch for making gntdev functions available to other drivers
- removed WARN_ON's in dma-buf code
- moved all dma-buf related code into gntdev-dmabuf
- introduced gntdev-common.h with common structures and function prototypes
- added additional checks for number of grants in IOCTLs
- gnttab patch cleanup
- made xenmem_reservation_scrub_page defined in the header as inline
- fixed __pfn_to_mfn use to pfn_to_bfn
- no changes to patches 1-2

Changes since v1:
*****************
- Define GNTDEV_DMA_FLAG_XXX starting from bit 0
- Rename mem_reservation.h to mem-reservation.h
- Remove usless comments
- Change licenses from GPLv2 OR MIT to GPLv2 only
- Make xenmem_reservation_va_mapping_{update|clear} inline
- Change EXPORT_SYMBOL to EXPORT_SYMBOL_GPL for new functions
- Make gnttab_dma_{alloc|free}_pages to request frames array
  be allocated outside
- Fixe gnttab_dma_alloc_pages fail path (added xenmem_reservation_increase)
- Move most of dma-buf from gntdev.c to gntdev-dmabuf.c
- Add required dependencies to Kconfig
- Rework "#ifdef CONFIG_XEN_XXX" for if/else
- Export gnttab_{alloc|free}_pages as GPL symbols (patch 1)

Oleksandr Andrushchenko (8):
  xen/grant-table: Make set/clear page private code shared
  xen/balloon: Share common memory reservation routines
  xen/grant-table: Allow allocating buffers suitable for DMA
  xen/gntdev: Allow mappings for DMA buffers
  xen/gntdev: Make private routines/structures accessible
  xen/gntdev: Add initial support for dma-buf UAPI
  xen/gntdev: Implement dma-buf export functionality
  xen/gntdev: Implement dma-buf import functionality

 drivers/xen/Kconfig           |  24 +
 drivers/xen/Makefile          |   2 +
 drivers/xen/balloon.c         |  75 +--
 drivers/xen/gntdev-common.h   |  94 ++++
 drivers/xen/gntdev-dmabuf.c   | 855 ++++++++++++++++++++++++++++++++++
 drivers/xen/gntdev-dmabuf.h   |  33 ++
 drivers/xen/gntdev.c          | 220 ++++++---
 drivers/xen/grant-table.c     | 151 +++++-
 drivers/xen/mem-reservation.c | 118 +++++
 include/uapi/xen/gntdev.h     | 106 +++++
 include/xen/grant_table.h     |  21 +
 include/xen/mem-reservation.h |  59 +++
 12 files changed, 1599 insertions(+), 159 deletions(-)
 create mode 100644 drivers/xen/gntdev-common.h
 create mode 100644 drivers/xen/gntdev-dmabuf.c
 create mode 100644 drivers/xen/gntdev-dmabuf.h
 create mode 100644 drivers/xen/mem-reservation.c
 create mode 100644 include/xen/mem-reservation.h

-- 
2.18.0

