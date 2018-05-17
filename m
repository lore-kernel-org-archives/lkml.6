Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeEQRWK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:22:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40099 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeEQRWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:22:05 -0400
X-Google-Smtp-Source: AB8JxZqAMiOXXAeOf8vFKg7ki6ME6ndy+24uyFHyJeGp0jS9yoRqm8vlQkmi3Cl6DWy7AqR0x8LzDA==
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, rkrcmar@redhat.com, kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 4.17-rc6
Date: Thu, 17 May 2018 19:21:59 +0200
Message-Id: <1526577719-39368-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 633711e82878dc29083fc5d2605166755e25b57a:

  kvm: rename KVM_HINTS_DEDICATED to KVM_HINTS_REALTIME (2018-05-17 19:12:13 +0200)

----------------------------------------------------------------
* ARM/ARM64 locking fixes
* x86 fixes: PCID, UMIP, locking
* Improved support for recent Windows version that have a 2048 Hz
APIC timer.
* Rename KVM_HINTS_DEDICATED CPUID bit to KVM_HINTS_REALTIME
* Better behaved selftests.

----------------------------------------------------------------
Andre Przywara (4):
      KVM: arm/arm64: Properly protect VGIC locks from IRQs
      KVM: arm/arm64: VGIC/ITS: Promote irq_lock() in update_affinity
      KVM: arm/arm64: VGIC/ITS: protect kvm_read_guest() calls with SRCU lock
      KVM: arm/arm64: VGIC/ITS save/restore: protect kvm_read_guest() calls

Junaid Shahid (1):
      kvm: x86: Suppress CR3_PCID_INVD bit only when PCIDs are enabled

Marian Rotariu (1):
      x86: Delay skip of emulated hypercall instruction

Michael S. Tsirkin (1):
      kvm: rename KVM_HINTS_DEDICATED to KVM_HINTS_REALTIME

Paolo Bonzini (2):
      KVM: hyperv: idr_find needs RCU protection
      KVM: selftests: exit with 0 status code when tests cannot be run

Sean Christopherson (1):
      KVM: vmx: update sec exec controls for UMIP iff emulating UMIP

Wanpeng Li (2):
      KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs
      KVM: X86: Lower the default timer frequency limit to 200us

 Documentation/virtual/kvm/cpuid.txt               |  6 ++--
 arch/arm/include/asm/kvm_mmu.h                    | 16 +++++++++
 arch/arm64/include/asm/kvm_mmu.h                  | 16 +++++++++
 arch/x86/include/uapi/asm/kvm_para.h              |  2 +-
 arch/x86/kernel/kvm.c                             |  8 ++---
 arch/x86/kvm/hyperv.c                             |  6 ++--
 arch/x86/kvm/vmx.c                                | 28 ++++++++--------
 arch/x86/kvm/x86.c                                | 26 +++++++++------
 include/linux/kvm_host.h                          |  8 +----
 tools/testing/selftests/kvm/Makefile              |  2 +-
 tools/testing/selftests/kvm/include/test_util.h   |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c        | 16 ++++-----
 tools/testing/selftests/kvm/sync_regs_test.c      | 40 ++++++++++++++++++-----
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c |  4 +--
 virt/kvm/arm/vgic/vgic-debug.c                    |  5 +--
 virt/kvm/arm/vgic/vgic-its.c                      | 34 ++++++++++---------
 virt/kvm/arm/vgic/vgic-v3.c                       |  4 +--
 virt/kvm/arm/vgic/vgic.c                          | 22 ++++++++-----
 18 files changed, 157 insertions(+), 87 deletions(-)
