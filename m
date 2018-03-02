Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934240AbeCBVnK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:43:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934207AbeCBVnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:43:08 -0500
Date: Fri, 2 Mar 2018 22:42:31 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 4.16-rc4
Message-ID: <20180302214231.GB28948@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit d4858aaf6bd8a90e2dacc0dfec2077e334dcedbf:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2018-02-26 09:28:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus

for you to fetch changes up to b7e31be385584afe7f073130e8e570d53c95f7fe:

  KVM: x86: fix vcpu initialization with userspace lapic (2018-03-01 22:32:45 +0100)

----------------------------------------------------------------
KVM fixes for v4.16-rc4

x86:
- fix NULL dereference when using userspace lapic
- optimize spectre v1 mitigations by allowing guests to use LFENCE
- make microcode revision configurable to prevent guests from
  unnecessarily blacklisting spectre v2 mitigation features

----------------------------------------------------------------
Radim Krčmář (1):
      KVM: x86: fix vcpu initialization with userspace lapic

Tom Lendacky (2):
      KVM: x86: Add a framework for supporting MSR-based features
      KVM: SVM: Add MSR-based feature support for serializing LFENCE

Wanpeng Li (2):
      KVM: X86: Introduce kvm_get_msr_feature()
      KVM: X86: Allow userspace to define the microcode version

 Documentation/virtual/kvm/api.txt |  40 ++++++++++-----
 arch/x86/include/asm/kvm_host.h   |   3 ++
 arch/x86/kvm/lapic.c              |  10 ++--
 arch/x86/kvm/svm.c                |  44 ++++++++++++++--
 arch/x86/kvm/vmx.c                |   7 +++
 arch/x86/kvm/x86.c                | 102 +++++++++++++++++++++++++++++++++++---
 include/uapi/linux/kvm.h          |   2 +
 7 files changed, 179 insertions(+), 29 deletions(-)
