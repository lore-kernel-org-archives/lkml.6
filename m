Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeCRIWC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 04:22:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34669 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeCRIV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 04:21:59 -0400
X-Google-Smtp-Source: AG47ELsd24hr/iwSMxlOcLcXjYhHa+mtN3TiDQg7rFFzldORx6CUPzzm1HvI8SiwumoVdknTUViI6A==
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, rkrcmar@redhat.com, kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for 4.16-rc6
Date: Sun, 18 Mar 2018 09:21:52 +0100
Message-Id: <1521361312-28506-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit e2c15aff5f353ba80bd3bb49840837f65fa5cc43:

  Merge tag 'sound-4.16-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2018-03-15 11:07:35 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to daaf216c06fba4ee4dc3f62715667da929d68774:

  KVM: x86: Fix device passthrough when SME is active (2018-03-16 14:32:23 +0100)

----------------------------------------------------------------
* PPC: Fix bug leading to lost IPIs and smp_call_function_many()
lockups on POWER9.
* ARM: locking fix, reset fix, GICv2 multi-source SGI injection fix,
GICv2-on-v3 MMIO synchronization fix, make the console less verbose.
* x86: fix device passthrough on AMD SME.

----------------------------------------------------------------
Andre Przywara (1):
      KVM: arm/arm64: vgic: Add missing irq_lock to vgic_mmio_read_pending

Ard Biesheuvel (1):
      KVM: arm/arm64: Reduce verbosity of KVM init log

Christoffer Dall (2):
      KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
      KVM: arm/arm64: Reset mapped IRQs on VM reset

Marc Zyngier (2):
      KVM: arm/arm64: vgic: Don't populate multiple LRs with the same vintid
      kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 on v3

Paolo Bonzini (2):
      Merge tag 'kvm-arm-fixes-for-v4.16-2' of git://git.kernel.org/.../kvmarm/kvmarm into kvm-master
      Merge tag 'kvm-ppc-fixes-4.16-2' of git://git.kernel.org/.../paulus/powerpc into kvm-master

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Fix trap number return from __kvmppc_vcore_entry

Tom Lendacky (1):
      KVM: x86: Fix device passthrough when SME is active

 arch/arm64/kvm/guest.c                  |  3 --
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 10 ++--
 arch/x86/kvm/mmu.c                      |  4 +-
 include/kvm/arm_vgic.h                  |  1 +
 include/linux/irqchip/arm-gic-v3.h      |  1 +
 include/linux/irqchip/arm-gic.h         |  1 +
 virt/kvm/arm/arch_timer.c               |  6 ++-
 virt/kvm/arm/arm.c                      |  9 ----
 virt/kvm/arm/hyp/vgic-v3-sr.c           |  3 +-
 virt/kvm/arm/mmu.c                      |  6 +--
 virt/kvm/arm/vgic/vgic-mmio.c           |  3 ++
 virt/kvm/arm/vgic/vgic-v2.c             | 11 ++++-
 virt/kvm/arm/vgic/vgic-v3.c             |  9 +++-
 virt/kvm/arm/vgic/vgic.c                | 87 +++++++++++++++++++++++++++------
 virt/kvm/arm/vgic/vgic.h                |  3 ++
 15 files changed, 117 insertions(+), 40 deletions(-)
