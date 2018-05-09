Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617204-1525882396-2-2100080736008129700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525882395; b=PbpJzy4ri/pvpbweb1soYYvsbNxC2hCJsWgcdUuFbufGMAgeZA
    GbdYTxMRoFl3Vjb7n4kop1NA3Jr6VrUmnz2Ek3xM3B43WQvyceR8FjBTkv0MbZi7
    GmP7txXK1w0Icn/lIeoNlJ5CfL1CBOdkfAOSRXHg6v4nI2m4x41JDX6TObuypMla
    nYr5ySAcmkfxpDFGvy5GBxAal/leX30rylMTLAmzqzaQtYRA/mhsvu+tWjpXMw9h
    S+eyX9oIHMILoHqN7p9rFzEp/a3ZpfrWH4X4w9bNT0k+TKG54T8A3olBBcbNoNdQ
    vqevw7RVr57RKBKLSiVAhf3dAA1coHbkOMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525882395; bh=K1ECk7Y3l9vOSyTmizhp+Ze2JkzjVm
    6UCZvmDprLHck=; b=YGWk9vUXsFgw5G1XLdrFOV5FZCLfC2o2HQ3lRql9RZ4vcA
    LTPpy4SSpQE3JOeIlwvtIsHyibeYcSWDk/4j+wlinYUqiVf0oNfPW8DqgV/Tkz2h
    Nyrada4nze5lPxnXqQw5SOlhyCptDZo5YyW8fNEZXik0UPXNO12P+9sH7QnCZvwH
    BsJQB9Jn7N0NiLSO9fahJ1Fhvn2ex97yxQgX6g8fDPmfPYte+AEZpu7K0VN+mUp8
    4gdKm1HhE8eIijxK6MHvxAIeVbw4icZ418dMsferKUu/nFLGb/2xany6UnD1gHex
    LnkBI4KK97CQTzJ7TzMgpYqcczIIGG9RVrlKAT0Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfCFlXOiI0CikDkTwSz6ZBsJSVOZcQVranCORCvqO8Fn0iWmwsOt07je4yDUT0ECliblP9o4dbOWQ0YfHCdJ5mSUyiv300E2Asl7MVZA1kVpotEuMZiBz
    JTfLPiEX6daX6Vzfh/cXrUipKAhCosQnsXoVaZZ34abDnr0e45M9wsmMZ6vjqgWCBIfYY3pFFwfpB19NJTldAFG5Dp/7vkzop1sArk0s+kVNNdsu76W3mvLg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=4Q4a2W0rhHdYYCzcRpoA:9 a=_XsxpSXq8YcA:10 a=I7Fl0iNTEZgA:10
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935426AbeEIQNN (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 12:13:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933573AbeEIQNM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 May 2018 12:13:12 -0400
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Cc: linux-arm-kernel@lists.infradead.org,
        Christoffer Dall <cdall@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v7 00/16] KVM: arm64: Optimise FPSIMD context switching
Date: Wed,  9 May 2018 17:12:49 +0100
Message-Id: <1525882385-29181-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Note: Most of these patches are Arm-specific.  People not Cc'd on the
whole series can find it in the linux-arm-kernel archive [2].

This series aims to improve the way FPSIMD context is handled by KVM.
Only minor changes have been made since the previous v6 [1], though
this posting does apply a couple of fixes.

The changes are summarised in the individual patches.

Reviewers please note:

 * Patch 6 is new, and does some minor refactoring to help fix an SVE
   context switching issue on the host, observed during stress-testing
   of v6 on an SVE-enabled model (the actual fix, using this
   refactoring, is incorporated in patch 8).

 * Patch 8 is missing Reviewed-bys/Acked-bys (thanks Marc, but I
   stripped yours in the end due to nontrivial changes.  Reviewer
   attention on these patches would be much appreciated.

Some testing done on Juno and the Arm fast model (arm64), including
combinations of (non-)SVE and (non-)VHE configurations.

Cheers
---Dave

[1] [PATCH v6 00/15] KVM: arm64: Optimise FPSIMD context switching
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/576355.html

[2] linux-arm-kernel archive
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/thread.html


Christoffer Dall (1):
  KVM: arm/arm64: Introduce kvm_arch_vcpu_run_pid_change

Dave Martin (15):
  thread_info: Add update_thread_flag() helpers
  arm64: Use update{,_tsk}_thread_flag()
  KVM: arm64: Convert lazy FPSIMD context switch trap to C
  arm64: fpsimd: Generalise context saving for non-task contexts
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

 arch/arm/include/asm/kvm_host.h     |   9 ++-
 arch/arm64/Kconfig                  |   7 ++
 arch/arm64/include/asm/cpufeature.h |  29 -------
 arch/arm64/include/asm/fpsimd.h     |  21 +++++
 arch/arm64/include/asm/kvm_asm.h    |   3 -
 arch/arm64/include/asm/kvm_host.h   |  32 +++++---
 arch/arm64/include/asm/processor.h  |   2 +
 arch/arm64/kernel/fpsimd.c          | 148 ++++++++++++++++++------------------
 arch/arm64/kernel/ptrace.c          |   1 +
 arch/arm64/kvm/Kconfig              |   1 +
 arch/arm64/kvm/Makefile             |   2 +-
 arch/arm64/kvm/debug.c              |   8 +-
 arch/arm64/kvm/fpsimd.c             | 111 +++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/debug-sr.c       |   6 +-
 arch/arm64/kvm/hyp/entry.S          |  43 -----------
 arch/arm64/kvm/hyp/hyp-entry.S      |  19 -----
 arch/arm64/kvm/hyp/switch.c         | 124 +++++++++++++++++++++---------
 arch/arm64/kvm/hyp/sysreg-sr.c      |   4 +-
 arch/arm64/kvm/sys_regs.c           |   9 +--
 include/linux/kvm_host.h            |   9 +++
 include/linux/sched.h               |   6 ++
 include/linux/thread_info.h         |  11 +++
 virt/kvm/Kconfig                    |   3 +
 virt/kvm/arm/arm.c                  |  25 +++++-
 virt/kvm/kvm_main.c                 |   7 +-
 25 files changed, 405 insertions(+), 235 deletions(-)
 create mode 100644 arch/arm64/kvm/fpsimd.c

-- 
2.1.4
