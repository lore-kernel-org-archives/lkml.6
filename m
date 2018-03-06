Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELvZql1Hn8MJX3RYSx1peA1PBSHKlV5Y9Ravn8lgU/xryhr86hGAW4TybZJZeQx/nwvwZnCT
ARC-Seal: i=1; a=rsa-sha256; t=1520296007; cv=none;
        d=google.com; s=arc-20160816;
        b=xgzyM31Yh7fD83hKLEVehbICFUc5GSZHQw0pUXP6AgGP/BqzT4FORjfMJTA17EvYpJ
         EC9qiOICwyevgmE0D/C3vaBAil7iQS8+qEq5Jo1o8t+pvvjf7ipoY0Z0ecMd+Sau3y4L
         /s+g7mqlgdpwP/BR07EPM8VeVbf03GIxfUGG0/FTWFUBbuKBGY2Yw69TODXkdt7H0im7
         qszeCuKpePDrQAQX8mKTZsE2dDVx4RrTXHtfF45VQevkBJYVBlogAPO6sicXuFBeLlOX
         2JBZBa2nqp+blXEcrmkRTZk/5cv8s+3tYYKj6kNfw0tv6nWoh8ZMCFog6+QQV/tUkir4
         COEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=Vz86igTPHo5J/6qoEzXJX+m9LzxtKitnToNZZ29ko+Y=;
        b=NU74pVrXCFg7JL43jnLTnWCEJpZUG+JGdjf81co/w+KVhoVNM1UTbgrUPydB7l860F
         kKLTnjLf3BYqvrZ61fMfEMpRS/tixsbuNQAsZa+5R2jPPJxDwttiGosPWwMg5SN/EXR0
         C3JUKTVNM2R4q1l92zrv72AdC7KIQJUCgxWRHMqgAbG+azIkhrLsqY6czx9IlXsqRsqT
         Hg3hzd3gHb3mzHkyzjbKTYpaF8t8cC2kTgJhcqX31pPYxKKv1cKPByzjG9lKt9mkPRGw
         IhB8Bf7jyn6eKiLgZ2fj/I5xwAqWUleuJ59kG6iLTg2yGPuzC8ODIspFov8qggGeERQ9
         MoBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LTnlhGfF;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LTnlhGfF;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 51/65] x86/kaiser: Rename and simplify X86_FEATURE_KAISER handling
Date: Mon,  5 Mar 2018 19:25:24 -0500
Message-Id: <20180306002538.1761-52-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145906082855324?=
X-GMAIL-MSGID: =?utf-8?q?1594145906082855324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

Concentrate it in arch/x86/mm/kaiser.c and use the upstream string "nopti".

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit dea9aa9ffae11c91285335cc3215b4f0e48e8139)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 Documentation/kernel-parameters.txt |  2 +-
 arch/x86/kernel/cpu/common.c        | 18 ------------------
 arch/x86/mm/kaiser.c                | 20 +++++++++++++++++++-
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 2d75f55419e0..c1f3dbed0021 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2439,7 +2439,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 	nojitter	[IA-64] Disables jitter checking for ITC timers.
 
-	nokaiser	[X86-64] Disable KAISER isolation of kernel from user.
+	nopti		[X86-64] Disable KAISER isolation of kernel from user.
 
 	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4404a78bdc0a..e80e6e5ede48 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -188,20 +188,6 @@ static int __init x86_pcid_setup(char *s)
 	return 1;
 }
 __setup("nopcid", x86_pcid_setup);
-
-static int __init x86_nokaiser_setup(char *s)
-{
-	/* nokaiser doesn't accept parameters */
-	if (s)
-		return -EINVAL;
-#ifdef CONFIG_KAISER
-	kaiser_enabled = 0;
-	setup_clear_cpu_cap(X86_FEATURE_KAISER);
-	pr_info("nokaiser: KAISER feature disabled\n");
-#endif
-	return 0;
-}
-early_param("nokaiser", x86_nokaiser_setup);
 #endif
 
 static int __init x86_noinvpcid_setup(char *s)
@@ -776,10 +762,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_power = cpuid_edx(0x80000007);
 
 	init_scattered_cpuid_features(c);
-#ifdef CONFIG_KAISER
-	if (kaiser_enabled)
-		set_cpu_cap(c, X86_FEATURE_KAISER);
-#endif
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index bfd48347eaac..a724496a5852 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -275,8 +275,13 @@ void __init kaiser_init(void)
 {
 	int cpu;
 
-	if (!kaiser_enabled)
+	if (!kaiser_enabled) {
+		setup_clear_cpu_cap(X86_FEATURE_KAISER);
 		return;
+	}
+
+	setup_force_cpu_cap(X86_FEATURE_KAISER);
+
 	kaiser_init_all_pgds();
 
 	for_each_possible_cpu(cpu) {
@@ -419,3 +424,16 @@ void kaiser_flush_tlb_on_return_to_user(void)
 			X86_CR3_PCID_USER_FLUSH | KAISER_SHADOW_PGD_OFFSET);
 }
 EXPORT_SYMBOL(kaiser_flush_tlb_on_return_to_user);
+
+static int __init x86_nokaiser_setup(char *s)
+{
+	/* nopti doesn't accept parameters */
+	if (s)
+		return -EINVAL;
+
+	kaiser_enabled = 0;
+	pr_info("Kernel/User page tables isolation: disabled\n");
+
+	return 0;
+}
+early_param("nopti", x86_nokaiser_setup);
-- 
2.16.2
