Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeAaVJe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:09:34 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46049 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbeAaVJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:09:30 -0500
X-Google-Smtp-Source: AH8x224cMHIcX4EnMhonKdqmxXSwQcEdKvkL2Ds7LGAlqzLI30/zX95MAVQE9P0DKTAQ2WmQFjo9cw==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v3 0/3] Per-VCPU MSR bitmaps patches - topic branch for x86/pti
Date: Wed, 31 Jan 2018 16:09:21 -0500
Message-Id: <20180131210924.22812-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David and others,

the following changes since commit ba804bb4b72e57374b5f567b783aa0298fba0ce6:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-01-26 09:03:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm.git msr-bitmaps

for you to fetch changes up to 904e14fb7cb96401a7dc803ca2863fd5ba32ffe6:

  KVM: VMX: make MSR bitmaps per-VCPU (2018-01-26 22:59:32 +0100)

The patches are on top of Linus's tree and I checked that they apply okay
on top of the latest 4.14 tree as well as required for tip x86/pti.
One extra commit is needed that is pretty safe and would have been merged
for 4.16 anyway.

Radim, please pull this into kvm.git too.  As before I've placed my
resolution on kvm.git, branch refs/heads/msr-bitmaps-merge-resolution.
It's based on kvm/next this time.

Thanks,

Paolo


Jim Mattson (1):
  KVM: nVMX: Eliminate vmcs02 pool

Paolo Bonzini (2):
  KVM: VMX: introduce alloc_loaded_vmcs
  KVM: VMX: make MSR bitmaps per-VCPU

 arch/x86/kvm/vmx.c | 440 ++++++++++++++++++++++-------------------------------
 1 file changed, 186 insertions(+), 254 deletions(-)

-- 
2.14.3
