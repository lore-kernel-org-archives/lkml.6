Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755354AbeDTOy4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:54:56 -0400
Received: from foss.arm.com ([217.140.101.70]:50106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755191AbeDTOyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:54:55 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
To: kvmarm@lists.cs.columbia.edu
Cc: Punit Agrawal <punit.agrawal@arm.com>,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH 0/4] KVM: Support PUD hugepages at stage 2
Date: Fri, 20 Apr 2018 15:54:05 +0100
Message-Id: <20180420145409.24485-1-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.17.0
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds support for PUD hugepages at stage 2. This feature
is useful on cores that have support for large sized TLB mappings
(e.g., 1GB for 4K granule). Previous posting[0].

Support is added to code that is shared between arm and arm64. Dummy
helpers for arm are provided as the port does not support PUD hugepage
sizes.

There is a small conflict with the series to add support for 52 bit
IPA[1]. The patches have been functionally tested on an A57 based
system. The patchset is based on v4.17-rc1.

Thanks,
Punit

[0] https://www.spinics.net/lists/arm-kernel/msg628053.html
[1] https://lwn.net/Articles/750176/

Punit Agrawal (4):
  KVM: arm/arm64: Share common code in user_mem_abort()
  KVM: arm/arm64: Introduce helpers to manupulate page table entries
  KVM: arm64: Support dirty page tracking for PUD hugepages
  KVM: arm64: Add support for PUD hugepages at stage 2

 arch/arm/include/asm/kvm_mmu.h         | 40 ++++++++++++
 arch/arm64/include/asm/kvm_mmu.h       | 30 +++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  4 ++
 arch/arm64/include/asm/pgtable.h       |  2 +
 virt/kvm/arm/mmu.c                     | 84 +++++++++++++++++++-------
 5 files changed, 139 insertions(+), 21 deletions(-)

-- 
2.17.0
