Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D61CC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3B5217CC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J+rqaIUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3B5217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbeHMWnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:43:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHMWno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+SWu7ZDxwD2YcRcRUcbUmGwW5EyeK2Jbd10NDD/wOE0=; b=J+rqaIUmGWc76/uEa9wdDTL7l4
        05fU4OtKk/2iFnxUjtr1LcU7KWyUUGC/2eD6vsdOjBsw92I8lMMEjQmBNU3FZ2woc9gvXcgk2BuOV
        ESHDJpoagXUYuzJgFughTVM3bir/NYj9cELDP4FBDQcGcgdO+gj2L+b5LUhtBf1j4PsjDtMEMXpfs
        M1kHFYyXS7ZATU8Gtmqftu6xE5J+O6w+1i+KVwgj3ZuMwTp9kmL4OAPysGqXGqhS0akXdLlhvsCvq
        ps4/YxmRuSL3LoJtlW6xCRXbaLO/ftz39JxPJ8WnCmzNnOLZp5++e/ORjrZTcEsRhHdjlWLcJ2EPG
        HX/ertYQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpJ0V-00020O-8Y; Mon, 13 Aug 2018 20:00:03 +0000
Date:   Mon, 13 Aug 2018 13:00:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] IDA changes for 4.19
Message-ID: <20180813200003.GA5931@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull the IDA patchset.  It depends on the XArray patchset, so
ignore this pull request if you've decided not to pull the XArray patches.
The new IDA API is similar to ida_simple_get() but better named.  The
internal restructuring of the IDA code removes the bitmap preallocation
nonsense.

----------------------------------------------------------------
The following changes since commit 8d7cf3e16ed4a12ab6bfc05ccb60d70cb6200ffb:

  radix tree: Remove radix_tree_clear_tags (2018-08-10 00:49:25 -0400)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git ida

for you to fetch changes up to e204222244f0d7dd2b43adafc4e8f0f8298868ab:

  ida: Convert to XArray (2018-08-10 09:55:02 -0400)

----------------------------------------------------------------
Matthew Wilcox (27):
      ida: Lock the IDA in ida_destroy
      ida: Add new API
      mtip32xx: Convert to new IDA API
      fs: Convert unnamed_dev_ida to new API
      fs: Convert namespace IDAs to new API
      devpts: Convert to new IDA API
      sd: Convert to new IDA API
      osd: Convert to new IDA API
      rsxx: Convert to new IDA API
      cb710: Convert to new IDA API
      Convert net_namespace to new IDA API
      ppc: Convert mmu context allocation to new IDA API
      media: Convert entity ID allocation to new IDA API
      ppc: Convert vas ID allocation to new IDA API
      dmaengine: Convert to new IDA API
      drm/vmwgfx: Convert to new IDA API
      target/iscsi: Allocate session IDs from an IDA
      ida: Start new test_ida module
      idr-test: Convert ida_check_nomem to new API
      test_ida: Move ida_check_leaf
      test_ida: Move ida_check_max
      test_ida: Convert check_ida_conv to new API
      test_ida: check_ida_destroy and check_ida_alloc
      ida: Remove old API
      ida: Change ida_get_new_above to return the id
      xarray: Track free entries in an XArray
      ida: Convert to XArray

Mike Christie (1):
      iscsi target: fix session creation failure handling

 Documentation/core-api/xarray.rst             |  19 +-
 arch/powerpc/mm/mmu_context_book3s64.c        |  44 +--
 arch/powerpc/platforms/powernv/vas-window.c   |  26 +-
 drivers/block/mtip32xx/mtip32xx.c             |  29 +-
 drivers/block/rsxx/core.c                     |  21 +-
 drivers/dma/dmaengine.c                       |  23 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |  41 +--
 drivers/media/media-device.c                  |  16 +-
 drivers/misc/cb710/core.c                     |  23 +-
 drivers/scsi/osd/osd_uld.c                    |  22 +-
 drivers/scsi/sd.c                             |  21 +-
 drivers/target/iscsi/iscsi_target.c           |  10 +-
 drivers/target/iscsi/iscsi_target.h           |   4 +-
 drivers/target/iscsi/iscsi_target_login.c     |  41 ++-
 fs/devpts/inode.c                             |  47 +--
 fs/namespace.c                                |  50 +---
 fs/super.c                                    |  67 ++---
 include/linux/idr.h                           |  79 +++--
 include/linux/xarray.h                        |   6 +
 lib/Kconfig.debug                             |   3 +
 lib/Makefile                                  |   1 +
 lib/idr.c                                     | 412 +++++++++++---------------
 lib/radix-tree.c                              |  40 +--
 lib/test_ida.c                                | 177 +++++++++++
 lib/test_xarray.c                             |  61 ++++
 lib/xarray.c                                  | 120 ++++++--
 net/core/net_namespace.c                      |  16 +-
 tools/testing/radix-tree/Makefile             |   1 +
 tools/testing/radix-tree/idr-test.c           | 218 +++-----------
 tools/testing/radix-tree/main.c               |   3 +-
 tools/testing/radix-tree/test.h               |   3 +-
 31 files changed, 781 insertions(+), 863 deletions(-)
 create mode 100644 lib/test_ida.c
