Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F47C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2C62084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aeqtnjGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2C62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJELty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:49:54 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:15553 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeJELtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:49:53 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181005045250epoutp0342cf46453eeed04d88e4381ab31101cc~anUuHpeQA2500825008epoutp03g
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 04:52:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181005045250epoutp0342cf46453eeed04d88e4381ab31101cc~anUuHpeQA2500825008epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538715170;
        bh=0uqrntC0FBjiKDUM66TtKKpsYOir1j9GwtIe6LRLN40=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aeqtnjGhWK3Z3687HNUkGkzWBfjGg5KKgyH21qGkK8rjBL8XxYaxySYQKhuRxef+q
         JbNX9Hmissvwa0ulVtDG4jWwE+RiAxPeDtCyP1MaZwNq3FirG7J5EiSloi0W5iB/3L
         uspuN8Uj2K2qGpXm9qawc+diSfpikUzdKxM0SolM=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.192]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20181005045249epcas5p13d272d420c94d7f7406f8b6d1c11c2b7~anUtWUpkN1720317203epcas5p11;
        Fri,  5 Oct 2018 04:52:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.1F.04167.12EE6BB5; Fri,  5 Oct 2018 13:52:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba~anUhv_CDP0965009650epcas5p34;
        Fri,  5 Oct 2018 04:52:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181005045237epsmtrp13abcb0f1fd344189a14a60a9f4fa70a7~anUhuUnQX3142531425epsmtrp1T;
        Fri,  5 Oct 2018 04:52:37 +0000 (GMT)
X-AuditID: b6c32a49-735ff70000001047-16-5bb6ee212f04
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.8A.03831.41EE6BB5; Fri,  5 Oct 2018 13:52:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181005045234epsmtip2e82e2e662fd96a81845bc00ed90e5c81~anUfl38tD0957609576epsmtip2k;
        Fri,  5 Oct 2018 04:52:34 +0000 (GMT)
From:   Manjeet Pawar <manjeet.p@samsung.com>
To:     linux@armlinux.org.uk, ebiederm@xmission.com, arnd@arndb.de,
        akpm@linux-foundation.org, mhiramat@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     pankaj.m@samsung.com, a.sahrawat@samsung.com,
        Rohit Thapliyal <r.thapliyal@samsung.com>,
        Manjeet Pawar <manjeet.p@samsung.com>
Subject: [PATCH] traps:Recover undefined user instruction on ARM
Date:   Fri,  5 Oct 2018 10:15:57 +0530
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOzqrFYRV+GZodydAwd8ytk3gDI05YIIQEWayTfjlrN3Y2
        7QYFTSUxNc0IbwiW1bLEaUu6UCw007SGTuuPJGakqIWKWaPLmUepf8/7vM/7Pg/f9xKYqgQP
        JnJNNmQ1cQYKXyV1v4zcFr1lxp2pLunbzHifIKa2pRlnflV0yZk/boeccY0NyZiBx7U446l6
        BpiRgvs4c2vYK2Eab0cwI1MPJUzryKmUNWxzfTNgB4a8GOv/WQFYl/Myznbf8EvZtpsX2NJ2
        J2DnXKHsNU+RNF1x2JCgR1w2soYhU5Y5O9eUk0ilHdSl6jRaNR1N72Z2UWEmzogSqT3706P3
        5hqEvFRYHmewC1Q6x/NUTFKC1Wy3oTC9mbclUsiSbbDQsZYdPGfk7aacHVlmYzytVsdqBOUx
        g7769jhmqY047fs9KLkIxkOLgYKAZBwcvfFBWgxWESryCYBlPqdcLGYB7O5+JROLBQD7+r3S
        lZGe6UYgNp4BON9XiIvFPIA9DV+xgAont8Oni4VLu9aTfQDOtnwDgQZGOoTFi+oAXkemwLfu
        O7IAlpJb4fXvBZhoEQpfd1UKPCHgFzj0LdFKMg++G6yUi5I98OrsS5mI18HJV+3LfDCcKBN9
        IXkJwNHmNolYlAPornHgoioZfnzfKQ8YYGQkbHkcI9IhsKrngUTMuRZe8X+SiLwSdtSv4HDY
        9LZtGW+ENW86lzOz8K5jeCmQijwKW9+48HIQUv3PoQEAJ9iILLwxB/EaC21C+f9/lQssXWLU
        vg5Q3b/fA0gCUGuUX8LdmSoZl8efMXoAJDBqvfKQTaCU2dyZs8hq1lntBsR7gEZ4wKtY8IYs
        s3DXJpuO1sRqterdas1ORktTQcq6kLpMFZnD2dAphCzIujInIRTBF0GacfVT5jmvPdrkn0zy
        pXZQrVOb0ohps29yMWKgTvft54XIjPaJ1fFpvRWq+pnGTn/GrSPj4akn5nr5+Om80qaOmfPq
        4ZlHQT/6I2TOswvb77lK839RhZKtGY6xA8cT9CEue9fnotJzdScLBx/EPR8dp5ODeMVQrTe2
        pkwR9chFSXk9R0dhVp77Cy7gQa2fAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSvK7Iu23RBs+P2Fhc3J1qMWf9GjaL
        v5OOsVv839bCbrHp8TVWi8u75rBZHJq6l9HiXutaNoul1y8yWSxermZx781WJouN97IdeDzW
        zFvD6HH52kVmj9+/JjF6bFrVyeZxYsZvFo/NS+o9+rasYvT4vEnOY8qhdpYAzigum5TUnMyy
        1CJ9uwSujFnLnzIXzFGruPrvClMD41O5LkZODgkBE4lTbxczdjFycQgJ7GaUmHN2KhNEQlKi
        f91UFghbWGLlv+fsEEWfGCWerPgDVsQmoC2x50cbWEJE4DqjxLofJ8E6mAU6GCVaN7mD2MIC
        DhLnt61gBbFZBFQlpn1vZe5i5ODgFXCVWHzQDGKBnMTJY5NZJzDyLGBkWMUomVpQnJueW2xY
        YJiXWq5XnJhbXJqXrpecn7uJERyYWpo7GC8viT/EKMDBqMTDO0FxW7QQa2JZcWXuIUYJDmYl
        Ed7wEqAQb0piZVVqUX58UWlOavEhRmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFINjKEB
        Ly1DO30L027m9DOeWZKtEW4YU1apGZ4s1qukqPO9Y0rWI/aHdV+iUgKe7LNbZ/S2ROjzVaXH
        J9oisvTTFvEvqwh6NjXAa84dtwmSKnPyt/DstUvb1eX8xO7a85I7Unnnq7+WeYS9Mv7hsSxj
        4fTKpp3LU0PYFJ8bndSI39+SlfTM5SOHEktxRqKhFnNRcSIAA0lOa0gCAAA=
Message-Id: <20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba~anUhv_CDP0965009650epcas5p34@epcas5p3.samsung.com>
X-CMS-MailID: 20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba
References: <CGME20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohit Thapliyal <r.thapliyal@samsung.com> 

During user undefined instruction exception, the arm exception
handler currently results in application crash through SIGILL.
The bad instruction can be due to ddr/hardware issue.
For such cases, exception trap handler could try to recover the corrupted
text by clearing pagetable entry of undefined instruction pc and trying to fetch
the instruction opcode by generating major page fault.
Resulting in loading the page with correct instruction from mapped file.
If there is no error in root filesystem i.e. the opcode is intact
in file, then filemap fault shall be able to recover
the instruction and continue execution normally instead of crashing.

Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
---
 arch/arm/kernel/traps.c | 100 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index badf02c..d971834 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -29,6 +29,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/irq.h>
+#include <linux/rmap.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -51,6 +52,9 @@
 };
 
 void *vectors_page;
+#define MAX_UNDEF_RECOVERY_ATTEMPT     NR_CPUS
+static DEFINE_RATELIMIT_STATE(undef_recov_rs, 10 * HZ, NR_CPUS);
+static int undef_recovery_attempt;
 
 #ifdef CONFIG_DEBUG_USER
 unsigned int user_debug;
@@ -435,14 +439,9 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 	return fn ? fn(regs, instr) : 1;
 }
 
-asmlinkage void do_undefinstr(struct pt_regs *regs)
+static unsigned int getInstr(void __user *pc, struct pt_regs *regs)
 {
-	unsigned int instr;
-	siginfo_t info;
-	void __user *pc;
-
-	clear_siginfo(&info);
-	pc = (void __user *)instruction_pointer(regs);
+	unsigned int instr = 0;
 
 	if (processor_mode(regs) == SVC_MODE) {
 #ifdef CONFIG_THUMB2_KERNEL
@@ -472,11 +471,32 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 			goto die_sig;
 		instr = __mem_to_opcode_arm(instr);
 	}
+die_sig:
+	return instr;
+}
+
+asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
+{
+	unsigned int instr, instr2;
+	siginfo_t info;
+	void __user *pc;
+	unsigned long addr;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	spinlock_t *ptl;
+	clear_siginfo(&info);
 
-	if (call_undef_hook(regs, instr) == 0)
+	pc = (void __user *)instruction_pointer(regs);
+
+	instr = getInstr(pc, regs);
+
+	if (instr && call_undef_hook(regs, instr) == 0)
 		return;
 
-die_sig:
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_UNDEFINED) {
 		pr_info("%s (%d): undefined instruction: pc=%p\n",
@@ -485,7 +505,67 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 		dump_instr(KERN_INFO, regs);
 	}
 #endif
-
+	/* Trying to recover an invalid userspace instruction from here */
+	if ((undef_recovery_attempt < MAX_UNDEF_RECOVERY_ATTEMPT) && __ratelimit(&undef_recov_rs)) {
+		addr = (unsigned long) pc;
+		if (processor_mode(regs) == USR_MODE) {
+			struct page *page = NULL;
+
+			mm = current->mm;
+			vma = find_vma(mm, (unsigned long)pc);
+			if (!vma)
+				goto fail_recovery;
+
+			if (!vma->vm_file)
+				goto fail_recovery;
+
+			dump_instr(KERN_ALERT, regs);
+			down_write(&mm->mmap_sem);
+			/* Check first, just in case, recovery already done by some other thread simultaneously */
+			flush_cache_range(vma, vma->vm_start, vma->vm_end);
+			instr2 = getInstr(pc, regs);
+			if (instr != instr2) {
+				up_write(&mm->mmap_sem);
+				return;
+			}
+			pgd = pgd_offset(vma->vm_mm, addr);
+			pud = pud_offset(pgd, addr);
+			if (!pud_present(*pud)) {
+				up_write(&mm->mmap_sem);
+				goto fail_recovery;
+			}
+			pmd = pmd_offset(pud, addr);
+			if (!pmd_present(*pmd)) {
+				up_write(&mm->mmap_sem);
+				goto fail_recovery;
+			}
+			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			if (!pte_present(*pte)) {
+				pte_unmap_unlock(pte, ptl);
+				up_write(&mm->mmap_sem);
+				goto fail_recovery;
+			}
+			page = pte_page(*pte);
+
+			pte_clear(mm, address, pte);
+			pte_unmap_unlock(pte, ptl);
+			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			page_remove_rmap(page, false);
+			put_page(page);
+			pte_unmap_unlock(pte, ptl);
+
+			flush_tlb_range(vma, vma->vm_start, vma->vm_end);
+			up_write(&mm->mmap_sem);
+
+			instr2 = getInstr(pc, regs);
+			dump_instr(KERN_ALERT, regs);
+			if (instr != instr2) {
+				undef_recovery_attempt++;
+				return;
+			}
+		}
+	}
+fail_recovery:
 	info.si_signo = SIGILL;
 	info.si_errno = 0;
 	info.si_code  = ILL_ILLOPC;
-- 
1.9.1

