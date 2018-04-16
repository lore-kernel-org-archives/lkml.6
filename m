Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeDPQMy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:12:54 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38074 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeDPQMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:12:46 -0400
X-Google-Smtp-Source: AIpwx4/Uet+S845D1thbVfv6avtoi9clZi39pw40uh2FyNADdksncTBp2dxTDyLhSU91TaxN2h1ipw==
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, rkrcmar@redhat.com, kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for 4.17-rc2
Date: Mon, 16 Apr 2018 18:12:42 +0200
Message-Id: <1523895162-43521-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit e01bca2fc698d7f0626f0214001af523e18ad60b:

  kvm: x86: fix a prototype warning (2018-04-06 18:20:31 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to d5edb7f8e7ab9fd5fd54a77d957b1733f117a813:

  kvm: selftests: add vmx_tsc_adjust_test (2018-04-16 17:50:23 +0200)

----------------------------------------------------------------
Bug fixes, plus a new test case and the associated infrastructure for
writing nested virtualization tests.

----------------------------------------------------------------

In case you spot some patches committed about 20 seconds before tagging,
that's just to acknowledge Reviewed-bys.  But maybe you only check that on
late-Saturday-night-before-end-of-the-merge-window pull requests. :)

Paolo

Colin Ian King (1):
      kvm: selftests: fix spelling mistake: "divisable" and "divisible"

KarimAllah Ahmed (3):
      X86/VMX: Disable VMX preemption timer if MWAIT is not intercepted
      X86/KVM: Do not allow DISABLE_EXITS_MWAIT when LAPIC ARAT is not available
      X86/KVM: Properly update 'tsc_offset' to represent the running guest

Krish Sadhukhan (1):
      x86: Add check for APIC access address for vmentry of L2 guests

Paolo Bonzini (2):
      kvm: x86: move MSR_IA32_TSC handling to x86.c
      kvm: selftests: add vmx_tsc_adjust_test

Peng Hao (1):
      kvm: selftests: add -std=gnu99 cflags

hu huajun (1):
      KVM: X86: fix incorrect reference of trace_kvm_pi_irte_update

 arch/x86/include/asm/kvm_host.h                   |   1 +
 arch/x86/kvm/svm.c                                |  31 +-
 arch/x86/kvm/vmx.c                                |  95 +++--
 arch/x86/kvm/x86.c                                |  15 +-
 tools/testing/selftests/kvm/Makefile              |   5 +-
 tools/testing/selftests/kvm/include/kvm_util.h    |  15 +-
 tools/testing/selftests/kvm/include/vmx.h         | 494 ++++++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c        |  20 +-
 tools/testing/selftests/kvm/lib/sparsebit.c       |   4 +-
 tools/testing/selftests/kvm/lib/vmx.c             | 243 +++++++++++
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c | 231 ++++++++++
 11 files changed, 1081 insertions(+), 73 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/vmx.h
 create mode 100644 tools/testing/selftests/kvm/lib/vmx.c
 create mode 100644 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
