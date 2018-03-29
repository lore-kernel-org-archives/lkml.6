Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeC2VKY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 17:10:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750971AbeC2VKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 17:10:23 -0400
Date: Thu, 29 Mar 2018 23:10:20 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 4.16-rc8
Message-ID: <20180329211019.GB27079@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit daaf216c06fba4ee4dc3f62715667da929d68774:

  KVM: x86: Fix device passthrough when SME is active (2018-03-16 14:32:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus

for you to fetch changes up to 17a1079d9c63579d6e392a526405b8888e9ede37:

  KVM: x86: Fix pv tlb flush dependencies (2018-03-28 15:53:34 +0200)

----------------------------------------------------------------
KVM fixes for v4.16-rc8

PPC:
 - Fix a bug causing occasional machine check exceptions on POWER8 hosts
   (introduced in 4.16-rc1)

x86:
 - Fix a guest crashing regression with nested VMX and restricted guest
   (introduced in 4.16-rc1)

 - Fix dependency check for pv tlb flush (The wrong dependency that
   effectively disabled the feature was added in 4.16-rc4, the original
   feature in 4.16-rc1, so it got decent testing.)

----------------------------------------------------------------
Paolo Bonzini (1):
      Merge tag 'kvm-ppc-fixes-4.16-3' of git://git.kernel.org/.../paulus/powerpc into kvm-master

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Fix duplication of host SLB entries

Sean Christopherson (1):
      KVM: nVMX: sync vmcs02 segment regs prior to vmx_set_cr0

Wanpeng Li (1):
      KVM: x86: Fix pv tlb flush dependencies

 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 35 +++++++++++++++++----------------
 arch/x86/kernel/kvm.c                   |  4 ++--
 arch/x86/kvm/vmx.c                      | 10 +++++-----
 3 files changed, 25 insertions(+), 24 deletions(-)
