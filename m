Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A93DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D96208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D96208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbeG0QV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:21:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388674AbeG0QVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:21:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6REtE2b070947
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:59:06 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kg2kur631-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:59:06 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 27 Jul 2018 10:59:05 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 10:59:01 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6REx0Xc7340668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 14:59:00 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 466D9AC05B;
        Fri, 27 Jul 2018 10:59:43 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09DA6AC059;
        Fri, 27 Jul 2018 10:59:38 -0400 (EDT)
Received: from kermit-br-ibm-com.ibmmodules.com (unknown [9.80.82.251])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 10:59:37 -0400 (EDT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 03/10] powerpc/reg: Add REG_FMT definition
Date:   Fri, 27 Jul 2018 11:58:04 -0300
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727145811.12334-1-muriloo@linux.ibm.com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072714-0052-0000-0000-00000314601E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009438; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066907; UDB=6.00548186; IPR=6.00844773;
 MB=3.00022354; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 14:59:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072714-0053-0000-0000-00005D82CEB1
Message-Id: <20180727145811.12334-4-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make REG definition, in arch/powerpc/kernel/process.c, generic enough by
renaming it to REG_FMT and placing it in arch/powerpc/include/asm/reg.h to
be used elsewhere.

Replace occurrences of REG by REG_FMT in arch/powerpc/kernel/process.c.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/include/asm/reg.h |  6 ++++++
 arch/powerpc/kernel/process.c  | 22 ++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 858aa7984ab0..d6c5c77383de 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1319,6 +1319,12 @@
 #define PVR_ARCH_207	0x0f000004
 #define PVR_ARCH_300	0x0f000005
 
+#ifdef CONFIG_PPC64
+#define REG_FMT		"%016lx"
+#else
+#define REG_FMT		"%08lx"
+#endif /* CONFIG_PPC64 */
+
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLY__
 #define mfmsr()		({unsigned long rval; \
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e9533b4d2f08..25b562c21b7b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1381,11 +1381,9 @@ static void print_msr_bits(unsigned long val)
 }
 
 #ifdef CONFIG_PPC64
-#define REG		"%016lx"
 #define REGS_PER_LINE	4
 #define LAST_VOLATILE	13
 #else
-#define REG		"%08lx"
 #define REGS_PER_LINE	8
 #define LAST_VOLATILE	12
 #endif
@@ -1396,21 +1394,21 @@ void show_regs(struct pt_regs * regs)
 
 	show_regs_print_info(KERN_DEFAULT);
 
-	printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
+	printk("NIP:  "REG_FMT" LR: "REG_FMT" CTR: "REG_FMT"\n",
 	       regs->nip, regs->link, regs->ctr);
 	printk("REGS: %px TRAP: %04lx   %s  (%s)\n",
 	       regs, regs->trap, print_tainted(), init_utsname()->release);
-	printk("MSR:  "REG" ", regs->msr);
+	printk("MSR:  "REG_FMT" ", regs->msr);
 	print_msr_bits(regs->msr);
-	pr_cont("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
+	pr_cont("  CR: "REG_FMT"  XER: "REG_FMT"\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
 	if ((TRAP(regs) != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
-		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
+		pr_cont("CFAR: "REG_FMT" ", regs->orig_gpr3);
 	if (trap == 0x200 || trap == 0x300 || trap == 0x600)
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-		pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
+		pr_cont("DEAR: "REG_FMT" ESR: "REG_FMT" ", regs->dar, regs->dsisr);
 #else
-		pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
+		pr_cont("DAR: "REG_FMT" DSISR: "REG_FMT" ", regs->dar, regs->dsisr);
 #endif
 #ifdef CONFIG_PPC64
 	pr_cont("IRQMASK: %lx ", regs->softe);
@@ -1423,7 +1421,7 @@ void show_regs(struct pt_regs * regs)
 	for (i = 0;  i < 32;  i++) {
 		if ((i % REGS_PER_LINE) == 0)
 			pr_cont("\nGPR%02d: ", i);
-		pr_cont(REG " ", regs->gpr[i]);
+		pr_cont(REG_FMT " ", regs->gpr[i]);
 		if (i == LAST_VOLATILE && !FULL_REGS(regs))
 			break;
 	}
@@ -1433,8 +1431,8 @@ void show_regs(struct pt_regs * regs)
 	 * Lookup NIP late so we have the best change of getting the
 	 * above info out without failing
 	 */
-	printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
-	printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
+	printk("NIP ["REG_FMT"] %pS\n", regs->nip, (void *)regs->nip);
+	printk("LR ["REG_FMT"] %pS\n", regs->link, (void *)regs->link);
 #endif
 	show_stack(current, (unsigned long *) regs->gpr[1]);
 	if (!user_mode(regs))
@@ -2038,7 +2036,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 		newsp = stack[0];
 		ip = stack[STACK_FRAME_LR_SAVE];
 		if (!firstframe || ip != lr) {
-			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
+			printk("["REG_FMT"] ["REG_FMT"] %pS", sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			if ((ip == rth) && curr_frame >= 0) {
 				pr_cont(" (%pS)",
-- 
2.17.1

