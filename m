Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbeDDHRN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:17:13 -0400
Received: from mail.monom.org ([188.138.9.77]:49480 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbeDDHRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:17:12 -0400
From: Daniel Wagner <wagi@monom.org>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com,
        Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/7] 4.4.126-rt141-rc1
Date: Wed,  4 Apr 2018 09:16:45 +0200
Message-Id: <20180404071652.24196-1-wagi@monom.org>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.4.126-rt141-rc1.

The series contains a few patches which never made it to the v4.4-rt
tree. I identified the patches using Steven's workflow. Next thing I
try to do is to use Julia's script to idendtify missing
patches. In theory nothing should be. 

Please scream at me if I messed something up. Please test the patches too.

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 16.04.2017.

Enjoy,
-- Daniel

ps: Bare with me, I didn't have time to get all the magic tooling
working for releasing a -rc series as Steven has done in the past.
That's why this mail looks slightly different then what you are used.

Changes from 4.4.126-rt141:

Daniel Wagner (1):
  Linux 4.4.126-rt141-rc1

Sebastian Andrzej Siewior (4):
  locking: add types.h
  mm/slub: close possible memory-leak in kmem_cache_alloc_bulk()
  arm*: disable NEON in kernel mode
  crypto: limit more FPU-enabled sections

Steven Rostedt (VMware) (1):
  Revert "memcontrol: Prevent scheduling while atomic in cgroup code"

Thomas Gleixner (1):
  timer: Invoke timer_start_debug() where it makes sense

 arch/arm/Kconfig                           |  2 +-
 arch/arm64/crypto/Kconfig                  | 14 +++++++-------
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 20 ++++++++++++++++++++
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 19 +++++++++++++++++++
 arch/x86/crypto/cast6_avx_glue.c           | 24 +++++++++++++++++++-----
 arch/x86/crypto/chacha20_glue.c            |  8 +++++---
 arch/x86/crypto/serpent_avx2_glue.c        | 19 +++++++++++++++++++
 arch/x86/crypto/serpent_avx_glue.c         | 23 +++++++++++++++++++----
 arch/x86/crypto/serpent_sse2_glue.c        | 23 +++++++++++++++++++----
 arch/x86/crypto/twofish_avx_glue.c         | 27 +++++++++++++++++++++++++--
 arch/x86/include/asm/fpu/api.h             |  1 +
 arch/x86/kernel/fpu/core.c                 | 12 ++++++++++++
 include/linux/spinlock_types_raw.h         |  2 ++
 kernel/time/timer.c                        |  4 ++--
 localversion-rt                            |  2 +-
 mm/memcontrol.c                            |  7 ++-----
 mm/slub.c                                  |  1 +
 17 files changed, 174 insertions(+), 34 deletions(-)

-- 
2.14.3
