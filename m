Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-797182-1526912247-2-6289326590129365672
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526912247; b=XfD0OGMixNkZd4i77RAOsWisuQ/O/aFS3EH000OdWzRkkA3QPR
    oi9dTEzYdcTGXoHfIAZP9tJfHDxmYRqAjExJZziBY0TmnMenVGEocajvUjUsdh9B
    MLsRRsS8xNkUHAXrLAEdbDCWUHlUbWc1mawk7rAwGCEbTvluuoq0K5Y6q9bWZmsz
    tq+v+dhqxdU8iSTidUNB/DmaYlnhDP9vGvldUd18nKs0xXQJH7TRLGu+clEUaxqU
    /wgc008K8ol6V/9ywmd4hHhGbTlxct5NOOpiLn7i/PV+CX86bhEdODRnyDwcAWBB
    IW4uo2Y2CE+kjqrhYngWxaPrIAAPNvAwUOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526912247; bh=SYpWCD/zVR2fr2AN6ayHF0XfkoxETL
    eBM+V6NwghpN0=; b=k62VlaOlTJ8gemytTBIF7bs8qXEsSPby4oHX1ys8d+WT3L
    06yHmc6DIW0UQXDgdpZqPz7yjTZHH68KH0PjnYmI+2+eLAH1CdDgemgmx0a2CeNR
    IXyoKegtH4dACO79CArZSWJOHCzWRttDyWSigamMNLnaoMkPjWnbzXlurVd+F9HG
    co8OEoz32ZKpXMmxznhtoing5/16kN/pnuM+R9B0Rfju6ewSQ7vbUPtB4XseyHiN
    f0vQejpr4brEy+P51pHRZCxBMP2yv698Nw8O12ZrpWqDbJsNC/Km7RXyPUvyCBsu
    lts5B4bFfe8PQZM5hUoB4YoehV5dZlUYP3bvylfg==
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
X-CM-Envelope: MS4wfPOGZQXUQsa+YNOh+xBfaYGymuKftcmTnoELdugbBFbncV0MbCSIXH3w00NltcKSkGsjaYBYyLLvorQkF4AU+hCiFQkJLFCqZfNm7kZbHauaw5ZU9Ssp
    yz+DRo/e7Qkb5cLXo8tEKuWz5YvhW8FxCTP3Ej64w/3aVPbMytKbGkPf5JJXULMsRn4+bfaKLev85syjUhl4zqlBX6zUP9sLKAmVWWwGBJu9p2GvQu19s1K4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=pk9vOewVUvBdo0IRyQ4A:9 a=I7Fl0iNTEZgA:10 a=G5WYf6J1rTwA:10 a=d0Eap3aq__YA:10
    a=aXqy-N0K3ocA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeEUORZ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 10:17:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50292 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbeEUORY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 May 2018 10:17:24 -0400
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
Subject: [PATCH v9 00/16] KVM: arm64: Optimise FPSIMD context switching
Date: Mon, 21 May 2018 15:17:01 +0100
Message-Id: <1526912237-25308-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Note: Most of these patches are Arm-specific.  People not Cc'd on the
whole series can find it in the linux-arm-kernel archive [2].

This series aims to improve the way FPSIMD context is handled by KVM.
Only minor changes have been made since the previous v8 [1], though
this posting does apply a couple of fixes.

This is a minor update to fix a couple of build breaks introduced late
in the evolution of the series. [3] [4]

There is also an unexplained NULL-dereference bug observed by Marc on
ESPRESSOBin [5] that I need to look into.  We've not been able to
reproduce this so far.

In the meantime, this post will give people an opportunity to look over
the current changes.


The changes are summarised in the individual patches.

Reviewers please note:

 * **Only patches 8 and 12** have changed since v8.

 * I have stripped tags from patch 12 due to the introduction of a new
   source file, which may not be the best approach.

   If Christoffer, Marc and Catalin could take another look that
   would be much appreciated.

Cheers
---Dave

[1] [PULL v8] KVM: arm64: Optimise FPSIMD context switching
lists.infradead.org/pipermail/linux-arm-kernel/2018-May/578184.html

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

 arch/arm/include/asm/kvm_host.h     |  10 ++-
 arch/arm64/Kconfig                  |   7 ++
 arch/arm64/include/asm/cpufeature.h |  29 -------
 arch/arm64/include/asm/fpsimd.h     |  21 ++++++
 arch/arm64/include/asm/kvm_asm.h    |   3 -
 arch/arm64/include/asm/kvm_host.h   |  33 +++++---
 arch/arm64/include/asm/processor.h  |   2 +
 arch/arm64/kernel/fpsimd.c          | 147 +++++++++++++++++++-----------------
 arch/arm64/kernel/ptrace.c          |   1 +
 arch/arm64/kvm/Kconfig              |   1 +
 arch/arm64/kvm/Makefile             |   4 +-
 arch/arm64/kvm/debug.c              |   8 +-
 arch/arm64/kvm/fpsimd.c             | 111 +++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/debug-sr.c       |   6 +-
 arch/arm64/kvm/hyp/entry.S          |  43 -----------
 arch/arm64/kvm/hyp/hyp-entry.S      |  19 -----
 arch/arm64/kvm/hyp/switch.c         | 124 ++++++++++++++++++++----------
 arch/arm64/kvm/hyp/sysreg-sr.c      |   4 +-
 arch/arm64/kvm/init.c               |  33 ++++++++
 arch/arm64/kvm/sys_regs.c           |   9 +--
 include/linux/kvm_host.h            |   9 +++
 include/linux/sched.h               |   6 ++
 include/linux/thread_info.h         |  11 +++
 virt/kvm/Kconfig                    |   3 +
 virt/kvm/arm/arm.c                  |  13 +++-
 virt/kvm/kvm_main.c                 |   7 +-
 26 files changed, 430 insertions(+), 234 deletions(-)
 create mode 100644 arch/arm64/kvm/fpsimd.c
 create mode 100644 arch/arm64/kvm/init.c

-- 
2.1.4
