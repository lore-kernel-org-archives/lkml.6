Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2246768-1527181018-2-7591602303938650864
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527181018; b=ZYTz1Zsc1GS4EnHkz7Qw2Fz2pDGaeUNfjzju1IP+3UHceNfTIn
    AjcGzpibFXWDcK7FDh8Q7UOSoiwCu5oBJ0xicuHmzzRKAByMRbsGkzxaFYVLuT6P
    Weq6zWfeVxqhtNTmqkDCRtSQag+8bv4EgNzn3WKTaMB88ikUq6qHFUMWJpnVbz8N
    /WbL+kmopr0OaNFzk8w+FbYqXbwwIpNf3tTsFWNvF17yjh54XhM2iZKkn2r+LRxm
    Q/Sv4LRo+UQ9JMTRaGzVQD8BuDTkJPUgcbHKrXKLvGyM0D8kF8IqrnrI1v+sG9J/
    u6yHPj7oTrBSTfYqnntrOuCdAZW/yppEv17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1527181018; bh=RgnrAPZPf1R+3uJC1HMZOxEZT3gDsq
    qu2EUcYgyGkMg=; b=Y8AwS97tzUhbLtItt6hR/6ezdPCVRmRu0wjVm8+pDlPvtC
    uFI7ydBxeEmm9g9tv1GRbXF2FVZFnxamIGYE/OTCpWLoOmw9GENF/qiMv3h6vnhD
    pjXOyon9BEE13ViBspOQZi+JXgN7mwE01pDNbPiBmU7bVKUZDxeBJ78kYuu4leBN
    c9KSsQ7j6HDY42jyyhW72023Zc6LXEFEy1tPcg9zQIm88z/JjXujXsKiVYjmZ+lB
    RRx+8Cp4MtkWRqH4iKeNkr1uWBQzleI+zRQ3sRBYnC9676Okjb1bHD3gBA+KxO+m
    Bq9tS2QYavU2dvtnUnemey2771dagIzgqGcjgt8Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfPlaawXHu2wQuIbdRkZ8Gjo3hZFV73HhG6fNJUuKQ/eUKRbJegKm7vJ0yvHf1eZvPT4ePsYo7UYyjNXHmWGNm3rxmQkdF8emYX6zDFBy3ZHskEIOwGPH
    M7mt9uo86tVkMpwiLangr2Ykm+kcO4JxkbEzOlJ+FlopMOId5ke1NV/TLvXacK5quRqqUdbTqD1AhPYxPXNmztcjQBgcvVa4gZ/KBR0Bq2YducX94iB4cv0Z
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=tFGGb6cbAAAA:8 a=EvQgPQB7lA_fnyeqOMYA:9 a=QEXdDO2ut3YA:10
    a=Bc7F-JqKLkMA:10 a=I7Fl0iNTEZgA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=EncVJOjz3_jdYkWdPEKv:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032389AbeEXQ4z (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 12:56:55 -0400
Received: from foss.arm.com ([217.140.101.70]:47870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030560AbeEXQ4z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 May 2018 12:56:55 -0400
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
Subject: [PATCH v11 00/19] KVM: arm64: Optimise FPSIMD context switching
Date: Thu, 24 May 2018 17:56:29 +0100
Message-Id: <1527181008-13549-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Note: Most of these patches are Arm-specific.  People not Cc'd on the
whole series can find it in the linux-arm-kernel archive [2].

Git: see [3]

This series aims to improve the way FPSIMD context is handled by KVM.
Changes since the previous v10 [1] are minor, but one patch has been
split.

** To Catalin Marinas, Alex Bennée: **

I have retained your Reviewed-bys on patches 7 and 8: these were split
from patch 7 of v9.  Although the code is (almost) the same as noted
below, I advise you to take a look.

(all) reviewers please note:

 * Patches 7 and 8 have been split from the previous patch 7, since
   the update to INIT_THREAD_INFO is logically a fix and deserves
   a Fixes: tag.

   I have also moved the definition of INIT_THREAD_INFO to after the
   TIF_* definitions that it now depends on (mysteriously this wasn't
   causing a compile error anyway, but I've not dug into why).

 * Other changes are all additions or rewordings of comments, and
   amendments commit messages.

Cheers
---Dave

[1] [PATCH v10 00/18] KVM: arm64: Optimise FPSIMD context switching
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/579899.html

[2] linux-arm-kernel archive
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/thread.html

[3] http://linux-arm.org/git?p=linux-dm.git;a=shortlog;h=refs/heads/kvm-vhe-fpsimd/v11

Christoffer Dall (1):
  KVM: arm/arm64: Introduce kvm_arch_vcpu_run_pid_change

Dave Martin (18):
  arm64: fpsimd: Fix TIF_FOREIGN_FPSTATE after invalidating cpu regs
  thread_info: Add update_thread_flag() helpers
  arm64: Use update{,_tsk}_thread_flag()
  KVM: arm64: Convert lazy FPSIMD context switch trap to C
  arm64: fpsimd: Generalise context saving for non-task contexts
  arm64: fpsimd: Avoid FPSIMD context leakage for the init task
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
 arch/arm64/include/asm/processor.h   |  15 ++-
 arch/arm64/include/asm/thread_info.h |  13 +--
 arch/arm64/kernel/fpsimd.c           | 177 +++++++++++++++++------------------
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
 26 files changed, 437 insertions(+), 260 deletions(-)
 create mode 100644 arch/arm64/kvm/fpsimd.c

-- 
2.1.4
