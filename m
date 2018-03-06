Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELvBJpPlWhyqjAP08MY367QT081JrPJmfiQ9tPotE7XEApsRHZDYvxKT4uBusxwMBWtFRLiL
ARC-Seal: i=1; a=rsa-sha256; t=1520295978; cv=none;
        d=google.com; s=arc-20160816;
        b=XjK8YrLcyQywJI8kbzwyMxrdZsmNxBAaigTkFHZBqsBaNpulJmvVBVom6k35a7CIX+
         LBd9Fav0PgMtc2mhuO5O3M3lZeBgTv1vQXex2y90ALJ932GOOnlnB0Uh5ofR5idhT1hX
         fCJXXjqci2fOI2hfdu73zp4iefN4sYUwKF9O+AjvWMs6v6urdxeBtT1LEg6epLH3FvRq
         Q4WE4LKNcPpA7ZYKeKS3i8xae+Sfso7tMaTqSMM+NuKEin8fmJEIi6U/tMFCKEa1DP6D
         qZf7Lrvp0Zzjp1FjRcLdob6UmLvd9cKNgDNGN6dWH/QW+Z5FkZaPxRfBfzh7E1v+S9DF
         Cdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=vN+Qt0UQwlOJ+BaEhV4YeL2tvSderFbvl2fIT+FXHpY=;
        b=lx0L3MNIktemJ4N9YTP/gB+tBA1nj/1KQcGTXDafJ0xmpXRcE839ZndUC9CjmNWLvc
         EZ4Ym5LXoEdr0GeXIFwxXmGWdYZBL2Q7Mjvg6FJXIUNxFcIZa7TT04bZtX+rfNVdF43q
         8uRmPO+P34Jqlycfe5YExy2gt4CuFQOApzvO67S3aTJc1ZkpxwNIUHCW7zfffcFfJpV2
         shVp9gWz1hPLscczkjyMuXthmuzAYGgMKnsb0dsteR48ykgvvu7Cz/Hu2xUjxKP09FEZ
         ctHE/nZk4wxR4vSQTSSoQHXuxbtGLyVk25AWTUENdjHIYIiJqOZ3LBwI5iVibe7xWTig
         vsmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=s17X40b0;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=s17X40b0;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 20/65] x86/mm: Enable CR4.PCIDE on supported systems
Date: Mon,  5 Mar 2018 19:24:53 -0500
Message-Id: <20180306002538.1761-21-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145875542172157?=
X-GMAIL-MSGID: =?utf-8?q?1594145875542172157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit 660da7c9228f685b2ebe664f9fd69aaddcc420b5 upstream.

We can use PCID if the CPU has PCID and PGE and we're not on Xen.

By itself, this has no effect. A followup patch will start using PCID.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/6327ecd907b32f79d5aa0d466f04503bbec5df88.1498751203.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

(cherry picked from commit fd0504525efd2ce2063cd4229baabd3e3a56ecbc)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tlbflush.h |  8 ++++++++
 arch/x86/kernel/cpu/common.c    | 22 ++++++++++++++++++++++
 arch/x86/xen/enlighten.c        |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 4f7017c9cae8..09a70d8d293e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -183,6 +183,14 @@ static inline void __flush_tlb_all(void)
 		__flush_tlb_global();
 	else
 		__flush_tlb();
+
+	/*
+	 * Note: if we somehow had PCID but not PGE, then this wouldn't work --
+	 * we'd end up flushing kernel translations for the current ASID but
+	 * we might fail to flush kernel translations for other cached ASIDs.
+	 *
+	 * To avoid this issue, we force PCID off if PGE is off.
+	 */
 }
 
 static inline void __flush_tlb_one(unsigned long addr)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 843be1de5ddb..f5647d238337 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -339,6 +339,25 @@ static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 	}
 }
 
+static void setup_pcid(struct cpuinfo_x86 *c)
+{
+	if (cpu_has(c, X86_FEATURE_PCID)) {
+		if (cpu_has(c, X86_FEATURE_PGE)) {
+			cr4_set_bits(X86_CR4_PCIDE);
+		} else {
+			/*
+			 * flush_tlb_all(), as currently implemented, won't
+			 * work if PCID is on but PGE is not.  Since that
+			 * combination doesn't exist on real hardware, there's
+			 * no reason to try to fully support it, but it's
+			 * polite to avoid corrupting data if we're on
+			 * an improperly configured VM.
+			 */
+			clear_cpu_cap(c, X86_FEATURE_PCID);
+		}
+	}
+}
+
 /*
  * Some CPU features depend on higher CPUID levels, which may not always
  * be available due to CPUID level capping or broken virtualization
@@ -968,6 +987,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_smep(c);
 	setup_smap(c);
 
+	/* Set up PCID */
+	setup_pcid(c);
+
 	/*
 	 * The vendor-specific functions might have changed features.
 	 * Now we do "generic changes."
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 1ecae556d4ed..809730c09e2b 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -432,6 +432,12 @@ static void __init xen_init_cpuid_mask(void)
 		~((1 << X86_FEATURE_MTRR) |  /* disable MTRR */
 		  (1 << X86_FEATURE_ACC));   /* thermal monitoring */
 
+	/*
+	 * Xen PV would need some work to support PCID: CR3 handling as well
+	 * as xen_flush_tlb_others() would need updating.
+	 */
+	cpuid_leaf1_ecx_mask &= ~(1 << (X86_FEATURE_PCID % 32));  /* disable PCID */
+
 	if (!xen_initial_domain())
 		cpuid_leaf1_edx_mask &=
 			~((1 << X86_FEATURE_ACPI));  /* disable ACPI */
-- 
2.16.2
