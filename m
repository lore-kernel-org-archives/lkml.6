Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeC1A1T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:27:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:56187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752060AbeC1A1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:27:18 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 5/5] powerpc/mm/32: Remove the reserved memory hack
Date: Wed, 28 Mar 2018 02:25:44 +0200
Message-Id: <20180328002544.18526-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328002544.18526-1-j.neuschaefer@gmx.net>
References: <20180328002544.18526-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:FwabCVc6bPqY5Jfw8h78ij0muBKRLTAgvOlck9BsbAEVFRz88BV
 DYG7ZJqqo1fCRkpOKpC8ZBIT8Wi0B7Bs1JwYeQO6TwuntNObmJYAX3wFPE+stLYnanQGlkz
 ugfHK2CuhxcHN5o48PlPXZ807hcNEnTi/Eelsmws7zcdeHE77h3Q4iyfmFxmSl99r/Md7J0
 szJ+YFURFVBeEToGIcSuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jh7TBymVrqc=:s8N/6TbBIPyK037TeBXmbo
 F/WLjN4kTFINpCxTXpIeuyH21+CeLbvo8iZArwxiEXUkQ9f7OKGj2UeJQmw8F37b73LoIEu7M
 Fw6X/Oejt9VJ9QH/lhAxLxn1oeoOuOngkg49V1GcfACsqVOXVESnLO2XyfaL8y+Ij9oEX8ZHn
 d+cnBw78GLtUH+PziLEJiJ/64JMrZK8hpJXzfbSJgUMCWhc8QqqoYqKyGaIReDLygAW2cMJ+m
 PoGn57/dKPAwM1rVNFHijwGgFHoHb0kyRuhMY2B3RFgJ00l8s72Nomt6Cq3UxlR10BigcvaAO
 JD6kdHxyiRl9xvjdsoVjAIPujv3nv/VYKMpYTl2ay5vvGiiRHv+VsKB5Yxj5uqKpB4YZImYWc
 Y0IEe/mR2kR4OmYMNU0cdqnK68pizZZdVFzTuORc9AdC3GPhubqhmV8zFIu3vGT79bWzp2BUR
 nMJEqxwjunrru7dxpgt5COu7RGfDM+Iv60yBh8aQ6W+dDaVuBKiFxDKnsTXCkNq3XAFEUYPsk
 uWfWlm6VvjKUtEJpiRFhsMUWGjYOt75q56b4xOCTqnS3BWlHmGDRiUQiqSwVUVdNkRicM2Zi2
 Fjz5w1sz3ON9haCGXjr6XVz6Oz+oGyjFsrpiezW1Cb/AgebJcQQ7uqNRebvwctf7CWHrGnOkC
 ga+cyJbPiGc+T3ybuQ1wWIjxnArE7JxqEDZRplRT/6uxjdfhmiVmAq1ZN84IwNuYgNcJYnFVu
 m2+1OQiLSG8U6oNDkkfsK8jdegJrSx4QTllxfQoIz2jYIsaxibxRUI0Sdz2DQ/6opdNZBmPLK
 opi6o0c6P6oLeg/UOV45i6Y/iJLaLci11qYKBOBjD7VQntO03E=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This hack, introduced in commit c5df7f775148 ("powerpc: allow ioremap
within reserved memory regions") is now unnecessary.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2: no changes
---
 arch/powerpc/mm/init_32.c    | 5 -----
 arch/powerpc/mm/mmu_decl.h   | 1 -
 arch/powerpc/mm/pgtable_32.c | 3 +--
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index a2bf6965d04f..3e59e5d64b01 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -88,11 +88,6 @@ void MMU_init(void);
 int __map_without_bats;
 int __map_without_ltlbs;
 
-/*
- * This tells the system to allow ioremapping memory marked as reserved.
- */
-int __allow_ioremap_reserved;
-
 /* max amount of low RAM to map in */
 unsigned long __max_low_memory = MAX_LOW_MEM;
 
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 57fbc554c785..c4c0a09a7775 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -98,7 +98,6 @@ extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot);
 
 extern int __map_without_bats;
-extern int __allow_ioremap_reserved;
 extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 6668ecc041ad..120a49bfb9c6 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -148,8 +148,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
 	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
-	    page_is_ram(__phys_to_pfn(p)) &&
-	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
+	    page_is_ram(__phys_to_pfn(p))) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
 		return NULL;
-- 
2.16.2
