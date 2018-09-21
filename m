Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216B5ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C365B21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoFkHS5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C365B21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390274AbeIUTzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:55:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34123 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389621AbeIUTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:55:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id t15so5085618wrx.1;
        Fri, 21 Sep 2018 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Ga9LJBhqKr0+ONXckUCgRW1ZIhEbGgPKpmJ/CUUaDtY=;
        b=UoFkHS5rsL9EWG+i+N6aQuwu0D0JI/kpuZD6EewbBSCoC9zYnwniwL6vLyB9n2JCM+
         x5MbiVSBFTx8dwKRPwbGCBq5tm34yJPDMxRbBAQlyioE/RkELg3S5Q+bEdnbKe3PEFns
         /B9HSHg13f8Ji7M1oQNUJ3juY7k5vRaj6RR91bELmhmSvUu5kxb9Vi+DfbieO1jwJSxu
         cKkPRcYw4igMG4Yr8GLpAfkbJa4BNonqcT/zypz7HaAZ8llAWOSOSMZPX4YhuNGa8Ly9
         B/IqE0a8OFNYjpjB1YNpF9eC6R4bjB8oBMgHLKg+QmCHGMiqYto6+G+z7HYS+/P3Xji+
         u3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Ga9LJBhqKr0+ONXckUCgRW1ZIhEbGgPKpmJ/CUUaDtY=;
        b=LaeqOmKn2SmGYvOmKTll68exzPBkIxu45g4Welk2dpQEPBPEWiwKsXnTf1Ny9htGcX
         XR5Xf0QgMG76KcR86ar1R89lMeMsijvH3Z7r2SBYx05h0pnRYuuWq6iuP48pzuX6LwbC
         rJ8BxwTIyni7POGc8Ht0YNjVVFTkHuEihEAVVLO/g2em65AtPgy/4vh0BZwB56xlD/Ot
         Up1kEWY44Rs3lba+txaJLsMdAVcUtwwBa6KzQdOpNW0fJtIGjTNFIAPe3w5gGgeMzNsv
         35isykgqAWsSPOIgGP6ATIQgkVHSJeCe9Ls8YD8M5ZrPfci4HQHMYN2Pqd0Ai0QyQo5Y
         JNJw==
X-Gm-Message-State: APzg51DMXnSzZ1rnHj4lYHPvhrr/KioO1PHdd1OuJqZ5nmmYzHeBvTEu
        Z1LpUJngklSkdXjAkvcAmpbFwgtb
X-Google-Smtp-Source: ANB0VdYB3f2UNdrFvBwjQlXCc3tYmae6Jp3OXL6ZL+voK8dqbJTma2TbjNx0wj/0SUI79oLK30X8xQ==
X-Received: by 2002:adf:c684:: with SMTP id j4-v6mr37952241wrg.243.1537538767994;
        Fri, 21 Sep 2018 07:06:07 -0700 (PDT)
Received: from 640k.lan (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.gmail.com with ESMTPSA id f12-v6sm6193534wrj.55.2018.09.21.07.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 07:06:07 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     gregkh@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 4.19-rc5
Date:   Fri, 21 Sep 2018 16:06:06 +0200
Message-Id: <1537538766-8252-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 26b471c7e2f7befd0f59c35b257749ca57e0ed70:

  KVM: nVMX: Fix bad cleanup on error of get/set nested state IOCTLs (2018-09-20 18:54:08 +0200)

----------------------------------------------------------------
This pull request is slightly bigger than usual at this stage, but
I swear I would have sent it the same to Linus!  The main cause for
this is that I was on vacation until two weeks ago and it took a while
to sort all the pending patches between 4.19 and 4.20, test them and
so on.

It's mostly small bugfixes and cleanups, mostly around x86 nested
virtualization.  One important change, not related to nested
virtualization, is that the ability for the guest kernel to trap CPUID
instructions (in Linux that's the ARCH_SET_CPUID arch_prctl) is now
masked by default.  This is because the feature is detected through an
MSR; a very bad idea that Intel seems to like more and more.  Some
applications choke if the other fields of that MSR are not initialized
as on real hardware, hence we have to disable the whole MSR by default,
as was the case before Linux 4.12.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      KVM: PPC: Avoid marking DMA-mapped pages dirty in real mode

Andy Shevchenko (1):
      KVM: SVM: Switch to bitmap_zalloc()

Drew Schmitt (3):
      KVM: x86: Turbo bits in MSR_PLATFORM_INFO
      KVM: x86: Control guest reads of MSR_PLATFORM_INFO
      kvm: selftests: Add platform_info_test

Janosch Frank (2):
      s390/mm: Check for valid vma before zapping in gmap_discard
      KVM: s390: Make huge pages unavailable in ucontrol VMs

Junaid Shahid (1):
      kvm: mmu: Don't read PDPTEs when paging is not enabled

Krish Sadhukhan (2):
      nVMX x86: check posted-interrupt descriptor addresss on vmentry of L2
      nVMX x86: Check VPID value on vmentry of L2 guests

Lei Yang (1):
      kvm: selftests: use -pthread instead of -lpthread

Liran Alon (2):
      KVM: nVMX: Wake blocked vCPU in guest-mode if pending interrupt in virtual APICv
      KVM: nVMX: Fix bad cleanup on error of get/set nested state IOCTLs

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: Don't use compound_order to determine host mapping size

Paolo Bonzini (3):
      Merge tag 'kvm-s390-master-4.19-2' of git://git.kernel.org/.../kvms390/linux into HEAD
      Merge tag 'kvm-ppc-fixes-4.19-2' of git://git.kernel.org/.../paulus/powerpc into HEAD
      KVM: VMX: check nested state and CR4.VMXE against SMM

Sean Christopherson (3):
      KVM: VMX: immediately mark preemption timer expired only for zero value
      KVM: VMX: modify preemption timer bit only when arming timer
      KVM: VMX: use preemption timer to force immediate VMExit

Sebastian Andrzej Siewior (1):
      kvm: x86: make kvm_{load|put}_guest_fpu() static

Tianyu Lan (1):
      KVM/MMU: Fix comment in walk_shadow_page_lockless_end()

Vitaly Kuznetsov (2):
      x86/kvm/lapic: always disable MMIO interface in x2APIC mode
      x86/hyper-v: rename ipi_arg_{ex,non_ex} structures

Wei Yang (1):
      KVM: x86: don't reset root in kvm_mmu_setup()

 Documentation/virtual/kvm/api.txt                |  12 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h     |   1 -
 arch/powerpc/include/asm/iommu.h                 |   2 -
 arch/powerpc/include/asm/mmu_context.h           |   1 +
 arch/powerpc/kernel/iommu.c                      |  25 ----
 arch/powerpc/kvm/book3s_64_mmu_radix.c           |  91 ++++++---------
 arch/powerpc/kvm/book3s_64_vio_hv.c              |  39 +++++--
 arch/powerpc/mm/init_64.c                        |  49 --------
 arch/powerpc/mm/mmu_context_iommu.c              |  34 +++++-
 arch/s390/kvm/kvm-s390.c                         |   4 +-
 arch/s390/mm/gmap.c                              |   4 +-
 arch/x86/hyperv/hv_apic.c                        |   8 +-
 arch/x86/include/asm/hyperv-tlfs.h               |  16 +--
 arch/x86/include/asm/kvm_host.h                  |   5 +
 arch/x86/include/uapi/asm/kvm.h                  |   1 +
 arch/x86/kvm/lapic.c                             |  22 +++-
 arch/x86/kvm/mmu.c                               |   9 +-
 arch/x86/kvm/svm.c                               |   7 +-
 arch/x86/kvm/vmx.c                               | 138 ++++++++++++++++-------
 arch/x86/kvm/x86.c                               | 101 +++++++++++------
 include/linux/kvm_host.h                         |   2 -
 include/uapi/linux/kvm.h                         |   1 +
 tools/testing/selftests/kvm/.gitignore           |   1 +
 tools/testing/selftests/kvm/Makefile             |   5 +-
 tools/testing/selftests/kvm/include/kvm_util.h   |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c       |  89 +++++++++++++++
 tools/testing/selftests/kvm/platform_info_test.c | 110 ++++++++++++++++++
 27 files changed, 537 insertions(+), 244 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/platform_info_test.c
