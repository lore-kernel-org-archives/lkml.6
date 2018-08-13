Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C86C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA71217FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t6VfmOlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA71217FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeHMJ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:57:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeHMJ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2f+swPmeeunK1AN6IRwDcRfWD7lYlN/i+g8efpfxtGs=; b=t6VfmOlUxg2XWt8Q80tG+RCdq+
        bdkrPxADgEiASKmv7xusd5VRr54YeMzZyCKW9+8NmJZlsiUePoKS/VQuLuvsKmoZHkFBVRxgojJbZ
        J7pqxFhiodqTvdUgDx7mqlDNQdORv4ggZt+Wz7pmNgVnycNTML5tCcYuHx7P7QbVd3VQ3GBcg2LGw
        /etyZXrxY/M6yDIPFbSj3mJk7RjwTbQNDBio251fQUBOtf34H3A2zMIb+3Jhmr7b3kzwnYhRQ0hnH
        kZXgYOhXhjl6QurdS+tz6SpkLKX6W50lYOCdznk97IH3XntipXNPbb9TZ/cA2Wy8agsNhMzKBftNv
        IJ780XHw==;
Received: from [62.169.200.78] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fp758-0005LS-64; Mon, 13 Aug 2018 07:16:03 +0000
Date:   Mon, 13 Aug 2018 10:15:20 +0300
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma mapping updates for 4.19
Message-ID: <20180813071520.GA25481@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.19

for you to fetch changes up to 6fa1d28e38cfa0c90f8d64c0cab37769e5337b85:

  sh: use generic dma_noncoherent_ops (2018-08-02 13:54:20 +0200)

----------------------------------------------------------------
dma-mapping updates for 4.19

 - a series from Robin to fix bus imposed dma limits by adding a separate
   mask for them to struct device instead of trying to squeeze a second
   meaning out of the existing dma mask as we did before.  This has ACKs
   from the various other subsystems touched
 - a small swiotlb cleanup from Kees (acked by Konrad)
 - conversion of nios2 and sh to the new generic dma-noncoherent code.
   Various other architecture conversions will come through the
   architectures maintainers trees.

----------------------------------------------------------------
Christoph Hellwig (6):
      nios2: use generic dma_noncoherent_ops
      sh: simplify get_arch_dma_ops
      sh: introduce a sh_cacheop_vaddr helper
      sh: use dma_direct_ops for the CONFIG_DMA_COHERENT case
      sh: split arch/sh/mm/consistent.c
      sh: use generic dma_noncoherent_ops

Kees Cook (1):
      swiotlb: clean up reporting

Robin Murphy (9):
      dma-mapping: relax warning for per-device areas
      of/platform: Initialise default DMA masks
      ACPI/IORT: Support address size limit for root complexes
      dma-mapping: Generalise dma_32bit_limit flag
      ACPI/IORT: Set bus DMA mask as appropriate
      of/device: Set bus DMA mask as appropriate
      iommu/dma: Respect bus DMA limit for IOVAs
      ACPI/IORT: Don't set default coherent DMA mask
      OF: Don't set default coherent DMA mask

 arch/nios2/Kconfig                   |   3 +
 arch/nios2/include/asm/Kbuild        |   1 +
 arch/nios2/include/asm/dma-mapping.h |  20 -----
 arch/nios2/mm/dma-mapping.c          | 139 ++++-------------------------------
 arch/sh/Kconfig                      |   4 +-
 arch/sh/include/asm/Kbuild           |   1 +
 arch/sh/include/asm/cacheflush.h     |   7 ++
 arch/sh/include/asm/dma-mapping.h    |  23 ------
 arch/sh/kernel/Makefile              |   4 +-
 arch/sh/kernel/dma-coherent.c        |  83 +++++++++++++++++++++
 arch/sh/kernel/dma-nommu.c           |  88 ----------------------
 arch/sh/mm/consistent.c              |  87 ----------------------
 arch/sh/mm/init.c                    |  10 ---
 arch/x86/kernel/pci-dma.c            |   2 +-
 drivers/acpi/arm64/iort.c            |  48 ++++++++----
 drivers/iommu/dma-iommu.c            |   3 +
 drivers/of/device.c                  |  21 +++---
 drivers/of/platform.c                |   3 +
 drivers/sh/maple/maple.c             |   7 +-
 include/linux/device.h               |   6 +-
 include/linux/dma-mapping.h          |   9 ++-
 kernel/dma/direct.c                  |   6 +-
 kernel/dma/swiotlb.c                 |  18 ++---
 23 files changed, 192 insertions(+), 401 deletions(-)
 delete mode 100644 arch/nios2/include/asm/dma-mapping.h
 delete mode 100644 arch/sh/include/asm/dma-mapping.h
 create mode 100644 arch/sh/kernel/dma-coherent.c
 delete mode 100644 arch/sh/kernel/dma-nommu.c
