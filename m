Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbeEFJ4j (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 05:56:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751123AbeEFJ4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 05:56:38 -0400
Date: Sun, 6 May 2018 11:56:35 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 4.17-rc4
Message-ID: <20180506095634.GA29747@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus

for you to fetch changes up to ecf08dad723d3e000aecff6c396f54772d124733:

  KVM: x86: remove APIC Timer periodic/oneshot spikes (2018-05-05 23:09:39 +0200)

----------------------------------------------------------------
KVM fixes for v4.17-rc4

ARM:
 - Fix proxying of GICv2 CPU interface accesses
 - Fix crash when switching to BE
 - Track source vcpu git GICv2 SGIs
 - Fix an outdated bit of documentation

x86:
 - Speed up injection of expired timers (for stable)

----------------------------------------------------------------
Anthoine Bourgeois (1):
      KVM: x86: remove APIC Timer periodic/oneshot spikes

James Morse (2):
      KVM: arm64: Fix order of vcpu_write_sys_reg() arguments
      arm64: vgic-v2: Fix proxying of cpuif access

Marc Zyngier (1):
      KVM: arm/arm64: vgic: Fix source vcpu issues for GICv2 SGI

Radim Krčmář (1):
      Merge tag 'kvmarm-fixes-for-4.17-2' of git://git.kernel.org/.../kvmarm/kvmarm

Valentin Schneider (1):
      KVM: arm/arm64: vgic_init: Cleanup reference to process_maintenance

 arch/arm64/include/asm/kvm_emulate.h     |  2 +-
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c | 24 ++++++++++++----
 arch/x86/kvm/lapic.c                     | 37 +++++++++++++-----------
 include/kvm/arm_vgic.h                   |  1 +
 virt/kvm/arm/vgic/vgic-init.c            |  2 +-
 virt/kvm/arm/vgic/vgic-mmio.c            | 10 +++++--
 virt/kvm/arm/vgic/vgic-v2.c              | 38 ++++++++++++++-----------
 virt/kvm/arm/vgic/vgic-v3.c              | 49 +++++++++++++++++++-------------
 virt/kvm/arm/vgic/vgic.c                 | 30 +++++--------------
 virt/kvm/arm/vgic/vgic.h                 | 14 +++++++++
 10 files changed, 122 insertions(+), 85 deletions(-)
