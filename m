Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAC2C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC5720875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX0zh0Dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC5720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeJEO6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:58:12 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44039 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:58:12 -0400
Received: by mail-wr1-f51.google.com with SMTP id 63-v6so12511275wra.11;
        Fri, 05 Oct 2018 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=I5oPy4mjIGt4RwQFWBs7Us1KKgazopWF7Za8lYqm7+Q=;
        b=RX0zh0DreQUnpsOr7D2kGN3wlUOxdp/7Tfw/60176t+fme6XXe76p6ThurPy8hVgQC
         QRW2H2ufbl6puHDcRGKpl51VeDdhEMTSIvJj+zN+tzZptSH66jzfg2h628hTqPVSzKgU
         Dv4ueKHDMEyF1DQV0in1r6DaGYKKRqpQ/MhZrLPk6EjBPcjhokdTvWmONDY6ln4cziII
         gFoHEAXu/1dJGP7FE4GrHnjfyKs0Ev2gYbOmotrCnhvwcZWPCsbL5epvNm4nfZk58kGM
         utR3XN/odOpjxn7VaI4uOZ2jfK2Ce2znWqYt4VtY9y/WxzcJg0C8EVDfNF9JgaUwy5kL
         n4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=I5oPy4mjIGt4RwQFWBs7Us1KKgazopWF7Za8lYqm7+Q=;
        b=ATIMtZ3XHKUXZOSQOV2w5UyZLky+vWZpJKN0sv/9ASEL7bMvOztYzEy93Pdyu1IdpX
         jKtWHf3xA0nEPI6jAmFEbpc/OokWlZmEA76NIr1U4mls2CnhB25n4uu69iqLpuKps+LY
         o3iurOlXWwPtt4XfOfaiYDozY6vLbKIOKUXzz7kKrQBuywfQtgrExaYO2a8+7VAgfoXO
         nKmgmHGYuemnUadDONTSO3lRxSOxckYE59LO2z83NwZzFX0gMtDACu4pG0D6/yJGKZE3
         QO3qlh3VF1rYMEwLgRyv4faAuZRseIzD7zJHG2qUiyeLbHnC1+FG0EsgrEXh3TgoYKmH
         jlhA==
X-Gm-Message-State: ABuFfogsUfgTx6trzYaZYj1qTbghw8Upxhbf75p0f4DT0HLm8XI8LzWH
        R/66fXTpn+joFV23LnNK8v0V81Ov
X-Google-Smtp-Source: ACcGV614vgpE4cqFqzSp6G6S4/sZVldmxUHnHMffdF5FUYiLUoERLGkmeiK/1b3WjzHhgmqBCtmE2A==
X-Received: by 2002:a5d:4c90:: with SMTP id z16-v6mr6797183wrs.239.1538726437475;
        Fri, 05 Oct 2018 01:00:37 -0700 (PDT)
Received: from 640k.lan (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.gmail.com with ESMTPSA id c184-v6sm1015118wma.15.2018.10.05.01.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:00:36 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     gregkh@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for 4.19-rc7
Date:   Fri,  5 Oct 2018 10:00:33 +0200
Message-Id: <1538726433-17221-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

The following changes since commit a27fb6d983c7b5bb0129ae4d7a7c81758173bfab:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2018-09-21 16:21:42 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to cc906f07d7d569a30bb6f0baf8f80b2968353dc9:

  Merge tag 'kvm-ppc-fixes-4.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into kvm-master (2018-10-05 09:39:53 +0200)

----------------------------------------------------------------

x86 and PPC bugfixes, mostly introduced in 4.19-rc1.

----------------------------------------------------------------
Liran Alon (3):
      KVM: nVMX: Do not expose MPX VMX controls when guest MPX disabled
      KVM: x86: Do not use kvm_x86_ops->mpx_supported() directly
      KVM: nVMX: Fix emulation of VM_ENTRY_LOAD_BNDCFGS

Paolo Bonzini (4):
      KVM: x86: never trap MSR_KERNEL_GS_BASE
      KVM: VMX: hide flexpriority from guest when disabled at the module level
      kvm: nVMX: fix entry with pending interrupt if APICv is enabled
      Merge tag 'kvm-ppc-fixes-4.19-3' of git://git.kernel.org/.../paulus/powerpc into kvm-master

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Avoid crash from THP collapse during radix page fault

Sean Christopherson (2):
      KVM: x86: fix L1TF's MMIO GFN calculation
      KVM: VMX: check for existence of secondary exec controls before accessing

Stefan Raspl (1):
      tools/kvm_stat: cut down decimal places in update interval dialog

 arch/powerpc/kvm/book3s_64_mmu_radix.c |  10 +++
 arch/x86/kvm/mmu.c                     |  24 +++++-
 arch/x86/kvm/vmx.c                     | 137 ++++++++++++++++++---------------
 arch/x86/kvm/x86.c                     |   2 +-
 tools/kvm/kvm_stat/kvm_stat            |   2 +-
 5 files changed, 108 insertions(+), 67 deletions(-)
