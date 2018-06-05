Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbeFEEd3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 00:33:29 -0400
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:33735
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750951AbeFEEd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 00:33:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AAAQDsERZb/zXSMGcNTxsBAQEBAwEBA?=
 =?us-ascii?q?QkBAQGEJYEng3iVPAZ/lmwmhFGCMzgUAQIBAQEBAQECgQiFNycVQSgNAiYCbAg?=
 =?us-ascii?q?BAYMeAoFypj1tghwaiCmBaIELiEOBB4EziCeCNIJUAodHkScIAYVsiHGBQoN4g?=
 =?us-ascii?q?lMQhQOSd4FzMxoIKAiCfgmLB4VQXY9CAQE?=
X-IPAS-Result: =?us-ascii?q?A2AAAQDsERZb/zXSMGcNTxsBAQEBAwEBAQkBAQGEJYEng3i?=
 =?us-ascii?q?VPAZ/lmwmhFGCMzgUAQIBAQEBAQECgQiFNycVQSgNAiYCbAgBAYMeAoFypj1tg?=
 =?us-ascii?q?hwaiCmBaIELiEOBB4EziCeCNIJUAodHkScIAYVsiHGBQoN4glMQhQOSd4FzMxo?=
 =?us-ascii?q?IKAiCfgmLB4VQXY9CAQE?=
X-IronPort-AV: E=Sophos;i="5.49,477,1520870400";
   d="scan'208";a="85130835"
From: Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v4.18
To: torvalds@linux-foundation.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <98b130d0-e129-fe79-57fc-bcff8a5a8fea@linux-m68k.org>
Date: Tue, 5 Jun 2018 14:32:05 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you please pull the m68knommu git tree, for-next branch.

These changes all relate to converting the IO access functions for the
ColdFire (and all other non-MMU m68k) platforms to use asm-generic IO
instead. This makes the IO support the same on all ColdFire (regardless
of MMU enabled or not) and means we can now support PCI in non-MMU mode.
As a bonus these changes remove more code than they add.

Regards
Greg



The following changes since commit b04e217704b7f879c6b91222b066983a44a7a09f:

   Linux 4.17-rc7 (2018-05-27 13:01:47 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

for you to fetch changes up to 082f55c459845088c3fee99c3a88ee117c148218:

   m68k: fix ColdFire PCI config reads and writes (2018-05-28 09:45:27 
+1000)

----------------------------------------------------------------
Greg Ungerer (14):
       m68k: move *_relaxed macros into io_no.h and io_mm.h
       m68k: put definition guards around virt_to_phys and phys_to_virt
       m68k: use asm-generic/io.h for non-MMU io access functions
       m68k: rework raw access macros for the non-MMU case
       m68k: group io mapping definitions and functions
       m68k: setup PCI support code in io_no.h
       m68k: use io_no.h for MMU and non-MMU enabled ColdFire
       m68k: remove old ColdFire IO access support code
       m68k: don't redefine access functions if we have PCI
       m68k: fix read/write multi-byte IO for PCI on ColdFire
       m68k: fix ioremapping for internal ColdFire peripherals
       m68k: allow ColdFire PCI bus on MMU and non-MMU configuration
       m68k: introduce iomem() macro for __iomem conversions
       m68k: fix ColdFire PCI config reads and writes

  arch/m68k/Kconfig.bus               |   8 +-
  arch/m68k/coldfire/pci.c            | 114 +---------------
  arch/m68k/include/asm/atarihw.h     |   1 +
  arch/m68k/include/asm/io.h          |  10 +-
  arch/m68k/include/asm/io_mm.h       |  98 ++------------
  arch/m68k/include/asm/io_no.h       | 253 
+++++++++++++++---------------------
  arch/m68k/include/asm/kmap.h        |  80 ++++++++++++
  arch/m68k/include/asm/nubus.h       |   1 +
  arch/m68k/include/asm/q40_master.h  |   2 +-
  arch/m68k/include/asm/raw_io.h      |  14 --
  arch/m68k/include/asm/vga.h         |   9 ++
  arch/m68k/include/asm/virtconvert.h |   2 +
  arch/m68k/include/asm/zorro.h       |   1 +
  arch/m68k/mm/kmap.c                 |   8 ++
  14 files changed, 230 insertions(+), 371 deletions(-)
  create mode 100644 arch/m68k/include/asm/kmap.h
