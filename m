Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbeD0VTC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:19:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932373AbeD0VTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:19:00 -0400
Date: Fri, 27 Apr 2018 23:18:57 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 4.17-rc3
Message-ID: <20180427211857.GF23874@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus

for you to fetch changes up to 5e62493f1a70e7f13059544daaee05e40e8548e2:

  x86/headers/UAPI: Move DISABLE_EXITS KVM capability bits to the UAPI (2018-04-27 18:37:17 +0200)

----------------------------------------------------------------
KVM fixes for v4.17-rc3

ARM:
 - PSCI selection API, a leftover from 4.16 (for stable)
 - Kick vcpu on active interrupt affinity change
 - Plug a VMID allocation race on oversubscribed systems
 - Silence debug messages
 - Update Christoffer's email address (linaro -> arm)

x86:
 - Expose userspace-relevant bits of a newly added feature
 - Fix TLB flushing on VMX with VPID, but without EPT

----------------------------------------------------------------
Andre Przywara (1):
      KVM: arm/arm64: vgic: Kick new VCPU on interrupt migration

Christoffer Dall (1):
      MAINTAINERS: Update e-mail address for Christoffer Dall

Junaid Shahid (1):
      kvm: apic: Flush TLB after APIC mode/address change if VPIDs are in use

KarimAllah Ahmed (1):
      x86/headers/UAPI: Move DISABLE_EXITS KVM capability bits to the UAPI

Marc Zyngier (3):
      KVM: arm/arm64: Close VMID generation race
      arm64: KVM: Demote SVE and LORegion warnings to debug only
      arm/arm64: KVM: Add PSCI version selection API

Radim Krčmář (1):
      Merge tag 'kvmarm-fixes-for-4.17-1' of git://git.kernel.org/.../kvmarm/kvmarm

 Documentation/virtual/kvm/api.txt      |  9 ++++-
 Documentation/virtual/kvm/arm/psci.txt | 30 +++++++++++++++++
 MAINTAINERS                            |  4 +--
 arch/arm/include/asm/kvm_host.h        |  3 ++
 arch/arm/include/uapi/asm/kvm.h        |  6 ++++
 arch/arm/kvm/guest.c                   | 13 ++++++++
 arch/arm64/include/asm/kvm_host.h      |  3 ++
 arch/arm64/include/uapi/asm/kvm.h      |  6 ++++
 arch/arm64/kvm/guest.c                 | 14 +++++++-
 arch/arm64/kvm/sys_regs.c              |  6 ++--
 arch/x86/kvm/vmx.c                     | 14 +++-----
 arch/x86/kvm/x86.h                     |  7 ----
 include/kvm/arm_psci.h                 | 16 +++++++--
 include/uapi/linux/kvm.h               |  7 ++++
 virt/kvm/arm/arm.c                     | 15 ++++++---
 virt/kvm/arm/psci.c                    | 60 ++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic/vgic.c               |  8 +++++
 17 files changed, 189 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/virtual/kvm/arm/psci.txt
