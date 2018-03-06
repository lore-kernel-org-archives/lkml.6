Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELuVLSa2GOTb0dSCdtPsJKOC19Q79+0I4hqBlWufrtE/0NOcJrxOzALNERUBddCbelnk+S6m
ARC-Seal: i=1; a=rsa-sha256; t=1520295995; cv=none;
        d=google.com; s=arc-20160816;
        b=CMSz1RLqI+8TyIIhkieUOqGJxMdoGfdnsmhNazqAl1CaeGYyToh6MYbRgFCG/p3TR5
         wrMEHu3GwvFWrSpL9HNc1wrBvKukSzXeuXun1nPwMA/TK7NU6ZvUwLQf1PtY4VDlXE70
         +OYyZ05lxmn04StLcI9rm2wNi5+v6JgIWb5eZmPxrEj6bA4M6+ORG2WysJtMOFN1sh8Y
         iXFKsE0PtvSqbiAtEdJnaSX5+BrjpkDPSPaHYzH1BfIa0rvnV3y47yaaiKPAr8T4Erib
         HM4z6Xt8rh4Riysm1CY61lGHSIpb/D1wB0gYAV+Lx5/9Hple/xT25HJUYl62kVR4LSA0
         AaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=ifn5/c242fLSWzJLeY0HAtVqsU/uUEjkq7YpoCPdUBU=;
        b=e0FVHXTxNmZ7j2+uvEjnmz4VSPSrUzUhUf86iVS6quYQVr2X0QKLajSezm2GpE7fZy
         Y8jwWbQXxAJkbidIYmcMiW4PNbBRz4eDGvBiq2lddTgWjS/BabslTCIkGEodi1w6g8O/
         0O3pxzEK3IIHomvsh1OPAluoaZW25cZ73ZAlfKgnW0F5t3ForibzCrH8i/VB92ipTco8
         tGLWk7m6eObu4nTb84afyaDV7z5a8FwC41ecurbY5vK6yygeIU7tPbOgPeJEZszvAMtj
         tJooNHBsfJcL69aT/gyUoEcpQmeFc3jEh32iBAf18w6ToVgMNTzuSRLVQHXmeflME/z5
         S3cw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Ja5o19ev;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Ja5o19ev;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 38/65] kaiser: cleanups while trying for gold link
Date: Mon,  5 Mar 2018 19:25:11 -0500
Message-Id: <20180306002538.1761-39-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145893798736527?=
X-GMAIL-MSGID: =?utf-8?q?1594145893798736527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

While trying to get our gold link to work, four cleanups:
matched the gdt_page declaration to its definition;
in fiddling unsuccessfully with PERCPU_INPUT(), lined up backslashes;
lined up the backslashes according to convention in percpu-defs.h;
deleted the unused irq_stack_pointer addition to irq_stack_union.

Sad to report that aligning backslashes does not appear to help gold
align to 8192: but while these did not help, they are worth keeping.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit c52e55a2a82d3a44189810d35717d81cb4cf61d4)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/desc.h       |  2 +-
 arch/x86/include/asm/processor.h  |  5 -----
 include/asm-generic/vmlinux.lds.h | 18 ++++++++----------
 include/linux/percpu-defs.h       | 22 +++++++++++-----------
 4 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 4e10d73cf018..880db91d9457 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -43,7 +43,7 @@ struct gdt_page {
 	struct desc_struct gdt[GDT_ENTRIES];
 } __attribute__((aligned(PAGE_SIZE)));
 
-DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
+DECLARE_PER_CPU_PAGE_ALIGNED_USER_MAPPED(struct gdt_page, gdt_page);
 
 static inline struct desc_struct *get_cpu_gdt_table(unsigned int cpu)
 {
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4abbd7d7cfb0..21c7924595e4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -449,11 +449,6 @@ union irq_stack_union {
 		char gs_base[40];
 		unsigned long stack_canary;
 	};
-
-	struct {
-		char irq_stack_pointer[64];
-		char unused[IRQ_STACK_SIZE - 64];
-	};
 };
 
 DECLARE_PER_CPU_FIRST(union irq_stack_union, irq_stack_union) __visible;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 88c02f965f2e..8e265917b0a9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -715,16 +715,14 @@
  */
 #define PERCPU_INPUT(cacheline)						\
 	VMLINUX_SYMBOL(__per_cpu_start) = .;				\
-	\
-	VMLINUX_SYMBOL(__per_cpu_user_mapped_start) = .;        \
-	*(.data..percpu..first)           \
-	. = ALIGN(cacheline);           \
-	*(.data..percpu..user_mapped)            \
-	*(.data..percpu..user_mapped..shared_aligned)        \
-	. = ALIGN(PAGE_SIZE);           \
-	*(.data..percpu..user_mapped..page_aligned)          \
-	VMLINUX_SYMBOL(__per_cpu_user_mapped_end) = .;        \
-	\
+	VMLINUX_SYMBOL(__per_cpu_user_mapped_start) = .;		\
+	*(.data..percpu..first)						\
+	. = ALIGN(cacheline);						\
+	*(.data..percpu..user_mapped)					\
+	*(.data..percpu..user_mapped..shared_aligned)			\
+	. = ALIGN(PAGE_SIZE);						\
+	*(.data..percpu..user_mapped..page_aligned)			\
+	VMLINUX_SYMBOL(__per_cpu_user_mapped_end) = .;			\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 141d0de913a9..7cecbdbf5c25 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -121,10 +121,10 @@
 #define DEFINE_PER_CPU(type, name)					\
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
-#define DECLARE_PER_CPU_USER_MAPPED(type, name)         \
+#define DECLARE_PER_CPU_USER_MAPPED(type, name)				\
 	DECLARE_PER_CPU_SECTION(type, name, USER_MAPPED_SECTION)
 
-#define DEFINE_PER_CPU_USER_MAPPED(type, name)          \
+#define DEFINE_PER_CPU_USER_MAPPED(type, name)				\
 	DEFINE_PER_CPU_SECTION(type, name, USER_MAPPED_SECTION)
 
 /*
@@ -156,11 +156,11 @@
 	DEFINE_PER_CPU_SECTION(type, name, PER_CPU_SHARED_ALIGNED_SECTION) \
 	____cacheline_aligned_in_smp
 
-#define DECLARE_PER_CPU_SHARED_ALIGNED_USER_MAPPED(type, name)			\
+#define DECLARE_PER_CPU_SHARED_ALIGNED_USER_MAPPED(type, name)		\
 	DECLARE_PER_CPU_SECTION(type, name, USER_MAPPED_SECTION PER_CPU_SHARED_ALIGNED_SECTION) \
 	____cacheline_aligned_in_smp
 
-#define DEFINE_PER_CPU_SHARED_ALIGNED_USER_MAPPED(type, name)			\
+#define DEFINE_PER_CPU_SHARED_ALIGNED_USER_MAPPED(type, name)		\
 	DEFINE_PER_CPU_SECTION(type, name, USER_MAPPED_SECTION PER_CPU_SHARED_ALIGNED_SECTION) \
 	____cacheline_aligned_in_smp
 
@@ -185,18 +185,18 @@
 /*
  * Declaration/definition used for per-CPU variables that must be page aligned and need to be mapped in user mode.
  */
-#define DECLARE_PER_CPU_PAGE_ALIGNED_USER_MAPPED(type, name)      \
-  DECLARE_PER_CPU_SECTION(type, name, USER_MAPPED_SECTION"..page_aligned")   \
-  __aligned(PAGE_SIZE)
+#define DECLARE_PER_CPU_PAGE_ALIGNED_USER_MAPPED(type, name)		\
+	DECLARE_PER_CPU_SECTION(type, name, USER_MAPPED_SECTION"..page_aligned") \
+	__aligned(PAGE_SIZE)
 
-#define DEFINE_PER_CPU_PAGE_ALIGNED_USER_MAPPED(type, name)       \
-  DEFINE_PER_CPU_SECTION(type, name, USER_MAPPED_SECTION"..page_aligned")    \
-  __aligned(PAGE_SIZE)
+#define DEFINE_PER_CPU_PAGE_ALIGNED_USER_MAPPED(type, name)		\
+	DEFINE_PER_CPU_SECTION(type, name, USER_MAPPED_SECTION"..page_aligned") \
+	__aligned(PAGE_SIZE)
 
 /*
  * Declaration/definition used for per-CPU variables that must be read mostly.
  */
-#define DECLARE_PER_CPU_READ_MOSTLY(type, name)			\
+#define DECLARE_PER_CPU_READ_MOSTLY(type, name)				\
 	DECLARE_PER_CPU_SECTION(type, name, "..read_mostly")
 
 #define DEFINE_PER_CPU_READ_MOSTLY(type, name)				\
-- 
2.16.2
