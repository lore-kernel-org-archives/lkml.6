Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-364912-1525449945-2-2332061624375773173
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525449945; b=IUbsulTRrK3wEWI80KO+BUFtNBL7LebFkpBuBQw/qIqvRvHBG2
    nDNMEJe7xyDIDRilsp5ln+bqnP10T+XPD/FykQiQ3zpVIBsZniW3ke6yrXtjX+uQ
    5til9c4O7A3sc/m/For3e/48/SQ162E9XCaTzPwMB8H0NYKcgCNGUlw9glPp0MMc
    8bXoav5n6GiMS9esE8TZaxTyXexxmg0zOtwYqOQoIBd+Gji/A9GeNEcF6agAoB3L
    YzwogQnQNKrqibCGQjVQW20xpHq0/I4MlI8jvh/5/C4h97byyamNLl7vJpC1E5TT
    tJYffHR/P5AlRFOhaadBhIBT71el4oR4bY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525449945; bh=J3Up0BNsu6VUVTc/Grab42eXv5uOML
    Th9axUFREpI5w=; b=jxezr2aKzu0PNTsBm3uHmiKukSGKW7yqeCA5M2Z4eSR0JT
    AXbxtob8Tln1bm0OE2lHRdKzfGwLQk7h7VerIJnAalmwT22AIMsiePDDYKmdSGjL
    DpxqUD0+ZrJW415Ug6r4dGtV9hPOl4ll+H+yrxZUmfbibmMw9s/xMNYORQ7c2NGY
    SfKVSTQN5lG7BbwbyL4wJ0XynSdnMqyf6D+bMrltZx31HCAECjv4f5ZPBFcckLse
    MnyldJLoA6AD0BUBo2o+OQO0TFdxO5Wo1OaUzKHRvuZm1Uc5HOoE4ZsFFryMPY8x
    9/blgV7X8MfH9OGqSk8fEnmMCu6kSTXgm9IrqSJA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfKI/AxYTzw6Ib+LUBqyEenvU4+djbSysK1+swGDRW0DbQc/TCnAjtCGGq8QQGpuQyURK+3Hqi5PgiFAhb7kPYO6jD/EfNUjA1y/95Cv+00VITWP1WeFV
    HLzCVbQQePXXKUYmiTpxu9VPyxBTGaqKbjUSFpfRgLCECE22Jxu/jGn1xnCG3dwFs1n2u4dLS4OZM07CbLm/YIH/+ZU85XsXBjz1smm+I2SUyEiiOB3eUkWD
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=D19gQVrFAAAA:8 a=ooa_4PH5m_2rkRsaLvwA:9 a=GM4LZePky0kA:10 a=I7Fl0iNTEZgA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeEDQFm (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 12:05:42 -0400
Received: from foss.arm.com ([217.140.101.70]:55594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeEDQFl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 May 2018 12:05:41 -0400
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
Subject: [PATCH v5 00/14] KVM: arm64: Optimise FPSIMD context switching
Date: Fri,  4 May 2018 17:05:21 +0100
Message-Id: <1525449935-31424-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Note: Most of these patches are Arm-specific.  People not Cc'd on the
whole series can find it in the linux-arm-kernel archive [3].

This series aims to improve the way FPSIMD context is handled by KVM,
building on the previous RFC v4 [1].

Patches 1-2 are picked from a separate RFC series [2] since they
introduce a helper I wanted to use here.


The main changes since RFC v4 are:

 * Rebased to -rc3.

 * Patches 1-2 pulled into series from [2], and other patches modified
   to use it.

 * Redundant additions by patch 3 that were reverted by other patches
   are now gone.

 * New patches 12-14 move the call to __hyp_switch_fpsimd() out of asm
   completely, moving it to the fixup_guest_exit() path instead.  This
   should significantly cleaner, but does add a bit of overhead to
   FPSIMD trapping.

   This is presented as an independent change in case people want to
   benchmark with/without.


Other minor changes as noted.


Some testing done on Juno and the Arm fast model (arm64), including
combinations of (non-)SVE and (non-)VHE configurations.

Cheers
---Dave

[1] [RFC PATCH 0/8] KVM: arm64: Optimise FPSIMD context switching
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/572781.html

[2] [RFC PATCH 0/6] Simplify setting thread flags to a particular value
https://lkml.org/lkml/2018/4/19/225

[3] linux-arm-kernel archive
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/thread.html


Christoffer Dall (1):
  KVM: arm/arm64: Introduce kvm_arch_vcpu_run_pid_change

Dave Martin (13):
  thread_info: Add update_thread_flag() helpers
  arm64: Use update{,_tsk}_thread_flag()
  KVM: arm64: Convert lazy FPSIMD context switch trap to C
  arm64: fpsimd: Generalise context saving for non-task contexts
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
 arch/arm64/Kconfig                  |   7 +++
 arch/arm64/include/asm/cpufeature.h |  29 ---------
 arch/arm64/include/asm/fpsimd.h     |  20 ++++++
 arch/arm64/include/asm/kvm_host.h   |  22 ++++---
 arch/arm64/include/asm/processor.h  |   2 +
 arch/arm64/kernel/fpsimd.c          | 120 +++++++++++++++++------------------
 arch/arm64/kernel/ptrace.c          |   1 +
 arch/arm64/kvm/Kconfig              |   1 +
 arch/arm64/kvm/Makefile             |   2 +-
 arch/arm64/kvm/fpsimd.c             | 105 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/entry.S          |  43 -------------
 arch/arm64/kvm/hyp/hyp-entry.S      |  19 ------
 arch/arm64/kvm/hyp/switch.c         | 121 +++++++++++++++++++++++++-----------
 include/linux/kvm_host.h            |   9 +++
 include/linux/sched.h               |   6 ++
 include/linux/thread_info.h         |  11 ++++
 virt/kvm/Kconfig                    |   3 +
 virt/kvm/arm/arm.c                  |  25 +++++++-
 virt/kvm/kvm_main.c                 |   7 ++-
 20 files changed, 360 insertions(+), 202 deletions(-)
 create mode 100644 arch/arm64/kvm/fpsimd.c

-- 
2.1.4
