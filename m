Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AIpwx48x5RMKX6U+StuSEGkH9AFtovcQw4qFuAHYlUF35uublQ///Zc+T+02lWbRMqVjOA17KVhb
ARC-Seal: i=1; a=rsa-sha256; t=1523931073; cv=none;
        d=google.com; s=arc-20160816;
        b=QSzqpz/Euflp29iRFRz7YpYb3NuHnJry6cYEZVmcsCZUx9bE7VxBX1ilxdP2jlxpWL
         Ml+FCYLR62hLysR2MpAJDj/pUhy4fIkX0PyP/ob7L8AuXN41LorucKrAuNqXQO2AJ++d
         2wXPHFghEtr1KZmlWUCjSpYkxJT1gsOx2riiOKSDC1zrEGgr1K1NV/+Y8ebeM24ZxLWk
         tb7GCY935B8lUXwjlaI52hZVYwqxjoyLkLy7d70lhYkMlWSkGQzPz8bQtwZ5hBQrZtht
         BMMUDptiAJNwm4GDrx5FKFb1DZraFqUfJnLF7JgawXdjUU8iJN4ywVNzQZxaf7jqvyur
         Z7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GTo+8cxxZb9dOdki4ExNv4s+z1dTSdhhA2McTkI6Vos=;
        b=o5KKNoo7clv+EhZgfKaPhSqMG+Y8sUgC3BUMi6jBZVjy9lBffuJt8sIr/z/a3VUqzj
         pC5z4qc6MtKkG0pHEuj4qAX7eVI2f2TP2+z3C4ivQu8RslKHhSgxLRc/MV9z3B6BiBmT
         7a/D2r0sr4ieyrDFba+JWvSTLvNgdLQY403sdUDznEUTf4sfdbrw8qgQwrs09I1Kw9KS
         bf8e5neqFFR12xpDNkmvPOeewpqozNdrHitcMbEvnXuxuGpAP4oBlamr1Tw+yhWV9bjB
         dHS6nBFjBpipoA4OWuAp07SP1H6nsR0gg5QuinDYAiWoHh/AN5+2QPH2Iz/ufAMrXyLh
         8JCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH 1/7] powerpc: Add TIDR CPU feature for Power9
Date: Tue, 17 Apr 2018 12:09:44 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180417020950.21446-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041702-0008-0000-0000-000004EC0E0B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041702-0009-0000-0000-00001E800EC1
Message-Id: <20180417020950.21446-2-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170020
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957549327672109?=
X-GMAIL-MSGID: =?utf-8?q?1597957549327672109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

This patch adds a CPU feature bit to show whether the CPU has
the TIDR register available, enabling as_notify/wait in userspace.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/cputable.h  | 3 ++-
 arch/powerpc/include/asm/switch_to.h | 1 -
 arch/powerpc/kernel/dt_cpu_ftrs.c    | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 4e332f3531c5..54c4cbbe57b4 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -215,6 +215,7 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_P9_TM_HV_ASSIST		LONG_ASM_CONST(0x0000100000000000)
 #define CPU_FTR_P9_TM_XER_SO_BUG	LONG_ASM_CONST(0x0000200000000000)
 #define CPU_FTR_P9_TLBIE_BUG		LONG_ASM_CONST(0x0000400000000000)
+#define CPU_FTR_P9_TIDR			LONG_ASM_CONST(0x0000800000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -462,7 +463,7 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
 	    CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | CPU_FTR_PKEY | \
-	    CPU_FTR_P9_TLBIE_BUG)
+	    CPU_FTR_P9_TLBIE_BUG | CPU_FTR_P9_TIDR)
 #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
 			     (~CPU_FTR_SAO))
 #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index be8c9fa23983..5b03d8a82409 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -94,6 +94,5 @@ static inline void clear_task_ebb(struct task_struct *t)
 extern int set_thread_uses_vas(void);
 
 extern int set_thread_tidr(struct task_struct *t);
-extern void clear_thread_tidr(struct task_struct *t);
 
 #endif /* _ASM_POWERPC_SWITCH_TO_H */
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 11a3a4fed3fb..10f8b7f55637 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -722,6 +722,7 @@ static __init void cpufeatures_cpu_quirks(void)
 	if ((version & 0xffff0000) == 0x004e0000) {
 		cur_cpu_spec->cpu_features &= ~(CPU_FTR_DAWR);
 		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TLBIE_BUG;
+		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TIDR;
 	}
 }
 
-- 
2.14.3
