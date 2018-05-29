Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934883AbeE2N74 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:59:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40643 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S934533AbeE2N7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:59:50 -0400
From: nixiaoming <nixiaoming@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <ard.biesheuvel@linaro.org>, <marc.zyngier@arm.com>,
        <james.morse@arm.com>, <kristina.martsenko@arm.com>,
        <steve.capper@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <mhocko@suse.com>, <dave.hansen@linux.intel.com>,
        <dan.j.williams@intel.com>, <kirill.shutemov@linux.intel.com>,
        <zhang.jia@linux.alibaba.com>, <schwidefsky@de.ibm.com>,
        <heiko.carstens@de.ibm.com>, <gregkh@linuxfoundation.org>
CC: <nixiaoming@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for mark_rodata_ro
Date: Tue, 29 May 2018 21:36:15 +0800
Message-ID: <20180529133615.26889-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark_rodata_ro is only called by the function mark_readonly when
CONFIG_STRICT_KERNEL_RWX=y,
if CONFIG_STRICT_KERNEL_RWX is not set
a compile warning may be triggered: unused function

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 arch/arm64/mm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9..849f326 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -491,6 +491,7 @@ static void __init map_mem(pgd_t *pgdp)
 #endif
 }
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
 void mark_rodata_ro(void)
 {
 	unsigned long section_size;
@@ -505,6 +506,7 @@ void mark_rodata_ro(void)
 
 	debug_checkwx();
 }
+#endif
 
 static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
 				      pgprot_t prot, struct vm_struct *vma,
-- 
2.10.1
