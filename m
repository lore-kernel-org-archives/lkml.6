Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /8lFGwkYG1sROgAAmS7hNA
	; Fri, 08 Jun 2018 23:58:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7963E607DC; Fri,  8 Jun 2018 23:58:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C8D3A600D0;
	Fri,  8 Jun 2018 23:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8D3A600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeFHX6n convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 19:58:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:64340 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752945AbeFHX6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:58:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 16:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,492,1520924400";
   d="scan'208";a="47594312"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga007.jf.intel.com with ESMTP; 08 Jun 2018 16:58:29 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 8 Jun 2018 16:58:29 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.167]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.20]) with mapi id 14.03.0319.002;
 Fri, 8 Jun 2018 16:58:29 -0700
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: [GIT PULL] libnvdimm for 4.18
Thread-Topic: [GIT PULL] libnvdimm for 4.18
Thread-Index: AQHT/4SYG/WDvA8//k27NMd/2WoCaw==
Date: Fri, 8 Jun 2018 23:58:29 +0000
Message-ID: <1528502307.25740.14.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.8.129]
Content-Type: text/plain; charset="utf-7"
Content-ID: <86896C0D4D77914E8F521A70B6A1C926@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.18

...to receive the first part of the libnvdimm / persistent memory
support update for 4.18. These patches have all been in -next for
several releases. The 'DAX DMA vs Truncate' work has had extra soak
time as it nearly missed 4.17.

This pull request adds a user for the new 'bytes-remaining' updates to
memcpy+AF8-mcsafe() that you already received through Ingo via the x86-dax-
for-linus pull. There is a minor collision with bdev+AF8-dax+AF8-supported()
reworks that you pulled from xfs, and another minor collision of the
vm+AF8-fault+AF8-t conversion you received from Andrew. A potential merge
resolution is here: https://git.kernel.org/pub/scm/linux/kernel/git/nvd
imm/nvdimm.git/log/?h+AD0-libnvdimm-for-4.18-merge

Not included in this pull, but still targeting this cycle, is support
for handling memory media errors (poison) consumed via userspace dax
mappings.

---

The following changes since commit b04e217704b7f879c6b91222b066983a44a7a09f:

  Linux 4.17-rc7 (2018-05-27 13:01:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.18

for you to fetch changes up to 930218affeadd1325ea17e053f0dcecf218f5a4f:

  Merge branch 'for-4.18/mcsafe' into libnvdimm-for-next (2018-06-08 15:16:44 -0700)

----------------------------------------------------------------
libnvdimm for 4.18

+ACo- DAX broke a fundamental assumption of truncate of file mapped pages.
  The truncate path assumed that it is safe to disconnect a pinned page
  from a file and let the filesystem reclaim the physical block. With DAX
  the page is equivalent to the filesystem block. Introduce
  dax+AF8-layout+AF8-busy+AF8-page() to enable filesystems to wait for pinned DAX
  pages to be released. Without this wait a filesystem could allocate
  blocks under active device-DMA to a new file.

+ACo- DAX arranges for the block layer to be bypassed and uses
  dax+AF8-direct+AF8-access() +- copy+AF8-to+AF8-iter() to satisfy read(2) calls.
  However, the memcpy+AF8-mcsafe() facility is available through the pmem
  block driver. In order to safely handle media errors, via the DAX
  block-layer bypass, introduce copy+AF8-to+AF8-iter+AF8-mcsafe().

+ACo- Fix cache management policy relative to the ACPI NFIT Platform
  Capabilities Structure to properly elide cache flushes when they are not
  necessary. The table indicates whether CPU caches are power-fail
  protected. Clarify that a deep flush is always performed on
  REQ+AF8Aew-FUA,PREFLUSH+AH0- requests.

----------------------------------------------------------------
Dan Williams (17):
      memremap: split devm+AF8-memremap+AF8-pages() and memremap() infrastructure
      mm: introduce MEMORY+AF8-DEVICE+AF8-FS+AF8-DAX and CONFIG+AF8-DEV+AF8-PAGEMAP+AF8-OPS
      mm: fix +AF8AXw-gup+AF8-device+AF8-huge vs unmap
      mm, fs, dax: handle layout changes to pinned dax mappings
      xfs: prepare xfs+AF8-break+AF8-layouts() to be called with XFS+AF8-MMAPLOCK+AF8-EXCL
      xfs: prepare xfs+AF8-break+AF8-layouts() for another layout type
      xfs, dax: introduce xfs+AF8-break+AF8-dax+AF8-layouts()
      uio, lib: Fix CONFIG+AF8-ARCH+AF8-HAS+AF8-UACCESS+AF8-MCSAFE compilation
      dax: Introduce a -+AD4-copy+AF8-to+AF8-iter dax operation
      dax: Report bytes remaining in dax+AF8-iomap+AF8-actor()
      pmem: Switch to copy+AF8-to+AF8-iter+AF8-mcsafe()
      x86, nfit+AF8-test: Add unit test for memcpy+AF8-mcsafe()
      libnvdimm: Debug probe times
      libnvdimm, e820: Register all pmem resources
      acpi, nfit: Remove ecc+AF8-unit+AF8-size
      Merge branch 'for-4.18/dax' into libnvdimm-for-next
      Merge branch 'for-4.18/mcsafe' into libnvdimm-for-next

Matthew Wilcox (1):
      dax: dax+AF8-insert+AF8-mapping+AF8-entry always succeeds

Robert Elliott (1):
      linvdimm, pmem: Preserve read-only setting for pmem devices

Ross Zwisler (4):
      libnvdimm, pmem: Complete REQ+AF8-FLUSH +AD0APg- REQ+AF8-PREFLUSH
      libnvdimm, pmem: Unconditionally deep flush on +ACo-sync
      libnvdimm, pmem: Do not flush power-fail protected CPU caches
      dax: Use dax+AF8-write+AF8-cache+ACo- helpers

 Documentation/ABI/removed/sysfs-bus-nfit +AHw-  17 +-+-+-
 Documentation/ABI/testing/sysfs-bus-nfit +AHw-  19 ---
 arch/x86/Kconfig                         +AHw-   1 +-
 arch/x86/Kconfig.debug                   +AHw-   3 +-
 arch/x86/include/asm/mcsafe+AF8-test.h       +AHw-  75 +-+-+-+-+-+-+-+-+-+-+-
 arch/x86/include/asm/string+AF8-64.h         +AHw-  10 +--
 arch/x86/include/asm/uaccess+AF8-64.h        +AHw-  14 +-+-+-
 arch/x86/lib/memcpy+AF8-64.S                 +AHw- 112 +-+-+-+-+-+-+-+----------
 arch/x86/lib/usercopy+AF8-64.c               +AHw-  21 +-+-+-+-
 drivers/acpi/nfit/core.c                 +AHw-  11 --
 drivers/dax/super.c                      +AHw-  33 +-+-+---
 drivers/md/dm-linear.c                   +AHw-  16 +-+-+-
 drivers/md/dm-log-writes.c               +AHw-  15 +-+-+-
 drivers/md/dm-stripe.c                   +AHw-  21 +-+-+-+-
 drivers/md/dm.c                          +AHw-  25 +-+-+-+-
 drivers/nvdimm/bus.c                     +AHw-  19 +-+--
 drivers/nvdimm/claim.c                   +AHw-   3 +--
 drivers/nvdimm/e820.c                    +AHw-  41 +-+-+----
 drivers/nvdimm/pfn+AF8-devs.c                +AHw-   2 -
 drivers/nvdimm/pmem.c                    +AHw-  52 +-+-+-+-+-+---
 drivers/nvdimm/region+AF8-devs.c             +AHw-   3 +--
 drivers/s390/block/dcssblk.c             +AHw-   7 +-+-
 fs/Kconfig                               +AHw-   1 +-
 fs/dax.c                                 +AHw- 136 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-----
 fs/xfs/xfs+AF8-file.c                        +AHw-  72 +-+-+-+-+-+-+-+-+-+--
 fs/xfs/xfs+AF8-inode.h                       +AHw-  16 +-+-+-
 fs/xfs/xfs+AF8-ioctl.c                       +AHw-   8 +--
 fs/xfs/xfs+AF8-iops.c                        +AHw-  16 +-+--
 fs/xfs/xfs+AF8-pnfs.c                        +AHw-  15 +---
 fs/xfs/xfs+AF8-pnfs.h                        +AHw-   5 +--
 include/linux/dax.h                      +AHw-  12 +-+-
 include/linux/device-mapper.h            +AHw-   5 +--
 include/linux/memremap.h                 +AHw-  36 +-+-----
 include/linux/mm.h                       +AHw-  71 +-+-+-+-+-+-+-+----
 include/linux/string.h                   +AHw-   4 +--
 include/linux/uio.h                      +AHw-  15 +-+-+-
 kernel/Makefile                          +AHw-   3 +--
 kernel/iomem.c                           +AHw- 167 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
 kernel/memremap.c                        +AHw- 210 +-+-+-+-+---------------------------
 kernel/resource.c                        +AHw-   1 +-
 lib/Kconfig                              +AHw-   3 +-
 lib/iov+AF8-iter.c                           +AHw-  61 +-+-+-+-+-+-+-+-+-
 mm/Kconfig                               +AHw-   5 +-
 mm/gup.c                                 +AHw-  36 +-+-+-+---
 mm/hmm.c                                 +AHw-  13 +--
 mm/swap.c                                +AHw-   3 +--
 tools/testing/nvdimm/test/nfit.c         +AHw- 104 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
 47 files changed, 1092 insertions(+-), 446 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-bus-nfit
 create mode 100644 arch/x86/include/asm/mcsafe+AF8-test.h
 create mode 100644 kernel/iomem.c
