Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeE1D52 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 23:57:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753118AbeE1D51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 23:57:27 -0400
From: nixiaoming <nixiaoming@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <ard.biesheuvel@linaro.org>, <marc.zyngier@arm.com>,
        <james.morse@arm.com>, <kristina.martsenko@arm.com>,
        <steve.capper@arm.com>
CC: <nixiaoming@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for mark_rodata_ro
Date: Mon, 28 May 2018 11:33:53 +0800
Message-ID: <20180528033353.54725-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
