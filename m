Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9022AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24306208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4blqBTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24306208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755812AbeFOG2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:28:06 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43025 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755617AbeFOG2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:28:03 -0400
Received: by mail-lf0-f67.google.com with SMTP id n15-v6so12965127lfn.10;
        Thu, 14 Jun 2018 23:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANmJSC5ObL9vvsIpT/SOaSBf64ENe+lxtmBJwMer4yc=;
        b=b4blqBTZUhjgHTOQkZpWWtM+GeV/WTqdDMI+xzEbrDo6MTRZl9x8SUPD6wAlG7K6mb
         KYZDogtFGk+orD9Hu3NtSk+q0U19xzN5ezk5hhB1OkRVq0nKzIaIpMbOs72pYTybi4Oa
         KnZgqDvwGF2sSLbHzsN4HVeAO7w3uHK8JbOehB6omrNqxv1aY1HcaXPYCN8xpp3Tolhn
         GzBdFthSOcTvcGkSwcZyXFs9VnG0H7tq4VMO2TLKbe1HpnuPqxl1+HAVyAF+Ag4F9yLe
         Nop4nnpmF5vdkftZVifikkoKiR9WAofebDZuvG+mW7F2D7kjvGkCTL/hvWebCBIdRgYG
         jaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANmJSC5ObL9vvsIpT/SOaSBf64ENe+lxtmBJwMer4yc=;
        b=bdp35s6NFP+ssmcZ4I2V7Ap0atg3PvbtRg7BZMxQPFWgs1w6NB7KoXiV940Sr5PwMc
         nt2lKAYd/RfPiGPwJxnyvGh76QXxVcvrifP5mgoJUFHp/FSwIBKnP9jfS1oBnBeCnjih
         ct+xZe6r0tL//ta9nGeuW3Nn8Df6myHVCoDB7F3KJsWWNTLFeUeOY+r233rPx3t69eMf
         xJ1ooZHM0Hf1j4toVDVjjoa+E6ExoGwJedINnrINLvJ6WpUwomJGjmgYzXKI5k7yAgAc
         /+UjuZZIIT27Kvha1diOQOvhxmq4WWnzAOdkO4U7QN0xTvf3kUSz+pg1HsACYNPSMAFK
         oUBw==
X-Gm-Message-State: APt69E06SqtK4kP6XTtL/ZgNO6WDi8dBeUCGVCIfT7tQ3Vi5yMR+7G1I
        8fEFhQme8/5AZlVaXQuqkFg=
X-Google-Smtp-Source: ADUXVKLnpSm6TPecpHfyExCKOY1AOMccuLnZRNCiR633XHjzXn9uvLiqbny9aL7xPEF0iFSAA6N/pQ==
X-Received: by 2002:a19:1b11:: with SMTP id b17-v6mr284255lfb.50.1529044081704;
        Thu, 14 Jun 2018 23:28:01 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id t126-v6sm1355040lff.7.2018.06.14.23.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 23:28:00 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v4 0/9] xen: dma-buf support for grant device
Date:   Fri, 15 Jun 2018 09:27:44 +0300
Message-Id: <20180615062753.9229-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
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

The first six patches are in preparation for Xen dma-buf support,
but I consider those usable regardless of the dma-buf use-case,
e.g. other frontend/backend kernel modules may also benefit from these
for better code reuse:
    0001-xen-grant-table-Export-gnttab_-alloc-free-_pages-as-.patch
    0002-xen-grant-table-Make-set-clear-page-private-code-sha.patch
    0003-xen-balloon-Share-common-memory-reservation-routines.patch
    0004-xen-grant-table-Allow-allocating-buffers-suitable-fo.patch
    0005-xen-gntdev-Allow-mappings-for-DMA-buffers.patch
    0006-xen-gntdev-Make-private-routines-structures-accessib.patch

The next three patches are Xen implementation of dma-buf as part of
the grant device:
    0007-xen-gntdev-Add-initial-support-for-dma-buf-UAPI.patch
    0008-xen-gntdev-Implement-dma-buf-export-functionality.patch
    0009-xen-gntdev-Implement-dma-buf-import-functionality.patch

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

Oleksandr Andrushchenko (9):
  xen/grant-table: Export gnttab_{alloc|free}_pages as GPL
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
 drivers/xen/gntdev-dmabuf.c   | 870 ++++++++++++++++++++++++++++++++++
 drivers/xen/gntdev-dmabuf.h   |  33 ++
 drivers/xen/gntdev.c          | 220 ++++++---
 drivers/xen/grant-table.c     | 153 +++++-
 drivers/xen/mem-reservation.c | 118 +++++
 include/uapi/xen/gntdev.h     | 106 +++++
 include/xen/grant_table.h     |  21 +
 include/xen/mem-reservation.h |  59 +++
 12 files changed, 1615 insertions(+), 160 deletions(-)
 create mode 100644 drivers/xen/gntdev-common.h
 create mode 100644 drivers/xen/gntdev-dmabuf.c
 create mode 100644 drivers/xen/gntdev-dmabuf.h
 create mode 100644 drivers/xen/mem-reservation.c
 create mode 100644 include/xen/mem-reservation.h

-- 
2.17.1

