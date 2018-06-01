Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeFAQGB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:06:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54952 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbeFAQGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:06:00 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 0/9] Rewrite asm-generic/bitops/{atomic,lock}.h and use on arm64
Date: Fri,  1 Jun 2018 17:06:20 +0100
Message-Id: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series has previously been posted in RFC form here:

  RFCv1: https://www.spinics.net/lists/arm-kernel/msg634719.html
  RFCv2: https://www.spinics.net/lists/arm-kernel/msg636875.html
     v1: https://www.spinics.net/lists/arm-kernel/msg655262.html

The only change since v1 is that some of the fetch ops are replaced
by non-value-returning ops for some of the atomic bitops.

Thanks,

Will

--->8

Will Deacon (9):
  h8300: Don't include linux/kernel.h in asm/atomic.h
  m68k: Don't use asm-generic/bitops/lock.h
  asm-generic: Move some macros from linux/bitops.h to a new bits.h file
  openrisc: Don't pull in all of linux/bitops.h in asm/cmpxchg.h
  sh: Don't pull in all of linux/bitops.h in asm/cmpxchg-xchg.h
  asm-generic/bitops/atomic.h: Rewrite using atomic_*
  asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*
  arm64: Replace our atomic/lock bitop implementations with asm-generic
  arm64: bitops: Include <asm-generic/bitops/ext2-atomic-setbit.h>

 arch/arm64/include/asm/bitops.h     |  21 +---
 arch/arm64/lib/Makefile             |   2 +-
 arch/arm64/lib/bitops.S             |  76 ---------------
 arch/h8300/include/asm/atomic.h     |   4 +-
 arch/m68k/include/asm/bitops.h      |   6 +-
 arch/openrisc/include/asm/cmpxchg.h |   3 +-
 arch/sh/include/asm/cmpxchg-xchg.h  |   3 +-
 include/asm-generic/bitops/atomic.h | 188 +++++++-----------------------------
 include/asm-generic/bitops/lock.h   |  68 ++++++++++---
 include/linux/bitops.h              |  22 +----
 include/linux/bits.h                |  26 +++++
 11 files changed, 131 insertions(+), 288 deletions(-)
 delete mode 100644 arch/arm64/lib/bitops.S
 create mode 100644 include/linux/bits.h

-- 
2.1.4
