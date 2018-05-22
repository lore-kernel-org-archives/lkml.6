Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2741439-1527005132-2-16615590354814036939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527005132; b=CrlSDUMYce0AEhZ2AsJF6UPO6vt9dGF1E3KjVNW8L3tyGjHUJE
    iu2z4cd5Wq+Wr9QRwq2H7nn2nF+zbOCLILYL+TbEtHNztr6l7RZLd+/K1zT9xMNB
    /bZbcajDF0DKxCzDM7WcoVcaTO0Jah5JPWKmCsDurEtDBgnysKq1uDwKMzAyJGHx
    vXrM++UXe5MwEZDqDJkz21UWqkE+lVqFZ/0bveTqvVYK2KtheA5HPp64/qf710TF
    8JQNbeWeqZ3EaAwJIWxOzD96VG5GWLlIutIddhbtGr40pJkxCF5X4cwZK60IbZmq
    S5OW2WvD1aEQ3ahhmqWZlgcO7+K+Ng2gGT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527005132; bh=ruQBqk+4YZ24lsT+G51p7o24ptIEs0
    +mcR5ZbX905CQ=; b=Gb7l13WLbYzGn9x3t9bOl0oGhDbZEQiy4NabZcDo8Iigxo
    +WuaEoZadbqoqv2H8X10ncyVaxlKm4UXaBNqUkdqItwmrAsoApxxQvHGBcDHmuqV
    49tAg+Mrd5L5teU78edD2MJO9zMnDl0QNDmId9oksz2HN9TD44X6WseLrcGEe9ks
    /A/mGlquRtaTPjkFcD+6DYWahhIusozxmJWDVvI0dgNJV9hdVYf3jPBabEItviGN
    ldom3I494jzU1+AbYqhNjmKjhVS1MuVqSAzCLxbYT8J16VHmkOrblPbMnSO8HBPh
    KJy9UztzPuev+LXs7ZelyyU511si3DWqbcU6UjjA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLLmbL8k1erzH2et4adano5Qs+pY1sf8l4bkpZfnZcnOot4XqS9JG7HO3FF6VsqMm5u+pAIwS1qu65/BJkRjBdcNTsGbZuzzKZqh/mCPU8AsQb4UPbK9
    7MCfu7db1sLoDAiAZdJgu6tyUW5LlrzSrH79/K75He3+sMW66BSppMootpJ4DE9kBeu0BCJJKAP4gbCOe/4GyjnPOL+fArURI7RBbdio5wed4bzYPKB9vYS6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=p7Au9uXeTtAe-OaG0FYA:9 a=Q2i2xoE4Z_IA:10 a=I7Fl0iNTEZgA:10 a=G5WYf6J1rTwA:10
    a=d0Eap3aq__YA:10 a=aXqy-N0K3ocA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbeEVQF3 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 12:05:29 -0400
Received: from foss.arm.com ([217.140.101.70]:40550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbeEVQF2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 May 2018 12:05:28 -0400
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Cc: linux-arm-kernel@lists.infradead.org,
        Christoffer Dall <cdall@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v10 00/18] KVM: arm64: Optimise FPSIMD context switching
Date: Tue, 22 May 2018 17:05:01 +0100
Message-Id: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Note: Most of these patches are Arm-specific.  People not Cc'd on the
whole series can find it in the linux-arm-kernel archive [2].

This series aims to improve the way FPSIMD context is handled by KVM.
Changes since the previous v9 [1] are mostly minor, but there are some
fixes worthy of closer attention.

In addition to addressing a review comment by Marc on the changes in v9,
this series attempts to fix a NULL-dereference bug observed by Marc on
ESPRESSOBin [5].  A reproducer for a similar bug is documented in [6],
and this series fixes the observed bug (in patches 1 and 7).  At the
moment, this is my best hypothesis for the ESPRESSOBin failure, though
the relationship is unproven and we have no reproducer for the latter.

The changes are summarised in the individual patches.

Reviewers please note:

 * Since v8, patches 10 and 14 have changed.  Reviewer tags have been
   stripped from patch 14, due to non-trivial changes in v9 of the
   series: see the patch for details.

 * Since v9, patches 1 and 7 are also new, and correct a latent bug in
   FPSIMD context handling which is exposed by this series.

If people could take a close look at the above patches, that would be
much appreciated.

Cheers
---Dave

[1] [PATCH v9 00/16] KVM: arm64: Optimise FPSIMD context switching
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/579569.html

[2] linux-arm-kernel archive
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/thread.html

[3] [kvmarm:queue 9/29] arch/arm/kvm/../../../virt/kvm/arm/arm.c:783:3: error: implicit declaration of function 'kvm_arch_vcpu_ctxsync_fp'; did you mean 'kvm_arch_vcpu_put_fp'?
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/579400.html

[4] [kvmarm:queue 13/29] arch/arm/kvm/../../../virt/kvm/arm/arm.c:1598:6: error: implicit declaration of function 'system_supports_sve'
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/579399.html

[5] [PULL v8] KVM: arm64: Optimise FPSIMD context switching
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/579353.html


Christoffer Dall (1):
  KVM: arm/arm64: Introduce kvm_arch_vcpu_run_pid_change

Dave Martin (17):
  arm64: fpsimd: Fix TIF_FOREIGN_FPSTATE after invalidating cpu regs
  thread_info: Add update_thread_flag() helpers
  arm64: Use update{,_tsk}_thread_flag()
  KVM: arm64: Convert lazy FPSIMD context switch trap to C
  arm64: fpsimd: Generalise context saving for non-task contexts
  arm64: fpsimd: Eliminate task->mm checks
  arm64/sve: Refactor user SVE trap maintenance for external use
  KVM: arm64: Repurpose vcpu_arch.debug_flags for general-purpose flags
  KVM: arm64: Optimise FPSIMD handling to reduce guest/host thrashing
  arm64/sve: Move read_zcr_features() out of cpufeature.h
  arm64/sve: Switch sve_pffr() argument from task to thread
  arm64/sve: Move sve_pffr() to fpsimd.h and make inline
  KVM: arm64: Save host SVE context as appropriate
  KVM: arm64: Remove eager host SVE state saving
  KVM: arm64: Remove redundant *exit_code changes in fpsimd_guest_exit()
  KVM: arm64: Fold redundant exit code checks out of fixup_guest_exit()
  KVM: arm64: Invoke FPSIMD context switch trap from C

 arch/arm/include/asm/kvm_host.h      |  10 +-
 arch/arm64/Kconfig                   |   7 ++
 arch/arm64/include/asm/cpufeature.h  |  29 ------
 arch/arm64/include/asm/fpsimd.h      |  21 +++++
 arch/arm64/include/asm/kvm_asm.h     |   3 -
 arch/arm64/include/asm/kvm_host.h    |  45 +++++++--
 arch/arm64/include/asm/processor.h   |   2 +
 arch/arm64/include/asm/thread_info.h |   1 +
 arch/arm64/kernel/fpsimd.c           | 176 +++++++++++++++++------------------
 arch/arm64/kernel/ptrace.c           |   1 +
 arch/arm64/kvm/Kconfig               |   1 +
 arch/arm64/kvm/Makefile              |   2 +-
 arch/arm64/kvm/debug.c               |   8 +-
 arch/arm64/kvm/fpsimd.c              | 110 ++++++++++++++++++++++
 arch/arm64/kvm/hyp/debug-sr.c        |   6 +-
 arch/arm64/kvm/hyp/entry.S           |  43 ---------
 arch/arm64/kvm/hyp/hyp-entry.S       |  19 ----
 arch/arm64/kvm/hyp/switch.c          | 124 ++++++++++++++++--------
 arch/arm64/kvm/hyp/sysreg-sr.c       |   4 +-
 arch/arm64/kvm/sys_regs.c            |   9 +-
 include/linux/kvm_host.h             |   9 ++
 include/linux/sched.h                |   6 ++
 include/linux/thread_info.h          |  11 +++
 virt/kvm/Kconfig                     |   3 +
 virt/kvm/arm/arm.c                   |  14 ++-
 virt/kvm/kvm_main.c                  |   7 +-
 26 files changed, 416 insertions(+), 255 deletions(-)
 create mode 100644 arch/arm64/kvm/fpsimd.c

-- 
2.1.4
