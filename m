Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758700AbeD0QXV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:23:21 -0400
Received: from foss.arm.com ([217.140.101.70]:43494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757562AbeD0QXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:23:20 -0400
Date: Fri, 27 Apr 2018 17:23:39 +0100
From: Will Deacon <will.deacon@arm.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: fixes for -rc3
Message-ID: <20180427162339.GB5286@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc3. Nothing too bad, but the spectre
updates to smatch identified a few places that may need sanitising so we've
got those covered. As per usual, details are in the tag.

It's worth noting that we had some DMARC hiccups this week which should be
resolved now, so hopefully this won't go into your spam folder.

Thanks,

Will

--->8

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 3789c122d0a016b947ce5c05d3f1fbafa5db8f26:

  arm64: avoid instrumenting atomic_ll_sc.o (2018-04-27 12:14:44 +0100)

----------------------------------------------------------------
arm64 fixes:

- Close some potential spectre-v1 vulnerabilities found by smatch

- Add missing list sentinel for CPUs that don't require KPTI

- Removal of unused 'addr' parameter for I/D cache coherency

- Removal of redundant set_fs(KERNEL_DS) calls in ptrace

- Fix single-stepping state machine handling in response to kernel traps

- Clang support for 128-bit integers

- Avoid instrumenting our out-of-line atomics in preparation for enabling
  LSE atomics by default in 4.18

----------------------------------------------------------------
Jason A. Donenfeld (1):
      arm64: support __int128 with clang

Kim Phillips (1):
      arm64/kernel: rename module_emit_adrp_veneer->module_emit_veneer_for_adrp

Mark Rutland (7):
      arm64: add sentinel to kpti_safe_list
      arm64: ptrace: remove addr_limit manipulation
      arm64: only advance singlestep for user instruction traps
      arm64: fix possible spectre-v1 in ptrace_hbp_get_event()
      KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_get_irq()
      KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_mmio_read_apr()
      arm64: avoid instrumenting atomic_ll_sc.o

Shaokun Zhang (1):
      arm64: mm: drop addr parameter from sync icache and dcache

 arch/arm64/Makefile              |  4 ++++
 arch/arm64/include/asm/module.h  |  2 +-
 arch/arm64/include/asm/pgtable.h |  4 ++--
 arch/arm64/kernel/cpufeature.c   |  1 +
 arch/arm64/kernel/module-plts.c  |  2 +-
 arch/arm64/kernel/module.c       |  2 +-
 arch/arm64/kernel/ptrace.c       | 20 ++++++++++----------
 arch/arm64/kernel/traps.c        |  3 ++-
 arch/arm64/lib/Makefile          |  4 ++++
 arch/arm64/mm/flush.c            |  2 +-
 virt/kvm/arm/vgic/vgic-mmio-v2.c |  5 +++++
 virt/kvm/arm/vgic/vgic.c         | 14 ++++++++++----
 12 files changed, 42 insertions(+), 21 deletions(-)
