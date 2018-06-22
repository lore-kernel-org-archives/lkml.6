Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15754C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A7424805
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A7424805
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeFVToa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:44:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934264AbeFVTo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:44:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC9C1402345E;
        Fri, 22 Jun 2018 19:44:28 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3FB9821565E1;
        Fri, 22 Jun 2018 19:44:27 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 22 Jun 2018 21:44:26 +0200
Date:   Fri, 22 Jun 2018 21:44:26 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 4.18-rc2
Message-ID: <20180622194426.GE2377@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 22 Jun 2018 19:44:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 22 Jun 2018 19:44:28 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus

for you to fetch changes up to 2ddc649810133fcf8e5282eea898ee7ececf161e:

  KVM: fix KVM_CAP_HYPERV_TLBFLUSH paragraph number (2018-06-22 17:30:20 +0200)

----------------------------------------------------------------
KVM fixes for 4.18-rc2

ARM:
 - Lazy FPSIMD switching fixes
 - Really disable compat ioctls on architectures that don't want it
 - Disable compat on arm64 (it was never implemented...)
 - Rely on architectural requirements for GICV on GICv3
 - Detect bad alignments in unmap_stage2_range

x86:
 - Add nested VM entry checks to avoid broken error recovery path
 - Minor documentation fix

----------------------------------------------------------------
Ard Biesheuvel (1):
      KVM: arm/arm64: Drop resource size check for GICV window

Dave Martin (3):
      KVM: arm64: Don't mask softirq with IRQs disabled in vcpu_put()
      KVM: arm64/sve: Fix SVE trap restoration for non-current tasks
      KVM: arm64: Avoid mistaken attempts to save SVE state for vcpus

Jia He (1):
      KVM: arm/arm64: add WARN_ON if size is not PAGE_SIZE aligned in unmap_stage2_range

Marc Orr (1):
      kvm: vmx: Nested VM-entry prereqs for event inj.

Marc Zyngier (2):
      KVM: Enforce error in ioctl for compat tasks when !KVM_COMPAT
      KVM: arm64: Prevent KVM_COMPAT from being selected

Mark Rutland (1):
      arm64: Introduce sysreg_clear_set()

Radim Krčmář (1):
      Merge tag 'kvmarm-fixes-for-4.18-1' of git://git.kernel.org/.../kvmarm/kvmarm

Vitaly Kuznetsov (1):
      KVM: fix KVM_CAP_HYPERV_TLBFLUSH paragraph number

 Documentation/virtual/kvm/api.txt |  2 +-
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/include/asm/sysreg.h   | 11 +++++++
 arch/arm64/kvm/fpsimd.c           | 36 +++++++++++++++------
 arch/x86/include/asm/vmx.h        |  3 ++
 arch/x86/kvm/vmx.c                | 67 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h                |  9 ++++++
 virt/kvm/Kconfig                  |  2 +-
 virt/kvm/arm/mmu.c                |  2 ++
 virt/kvm/arm/vgic/vgic-v3.c       |  5 ---
 virt/kvm/kvm_main.c               | 19 ++++++-----
 11 files changed, 131 insertions(+), 26 deletions(-)
