Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC7EC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F602081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2/j/FON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F602081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeKCOLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 10:11:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33179 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKCOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 10:11:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6-v6so1913330pln.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 22:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=H6vjzSYHdXeMDhN+Rwiu5OZOuRwTYFnzFfoeMp5ZVu0=;
        b=V2/j/FON7g7g8rwYTp+rxe4af/2+w41SZkQC82sI2r36WlNafvqB3plQB/qYVFUSfp
         i9Ql0NfnTNYeuSACEeo90UrLyue4/osRorK6rphqt81QRNb69vxPiW5IcTELB1Z9Yseb
         7XBvBtPxmKUx3CTLJmUI5evLM1aoSInXpS6qpBPgoFp4j6724UsTQRVZC14vVKYpw3L2
         88GRXsuuY/9cv8DD4VLa4QUe+Y8+016R/YbDaflv21PeJ5RZ3TAFGPIQUcg8T5Lfdnbc
         K8UiXRUT2Y+4cKVU5L+FiICJjyymCLzeBLp55RMFd/s4ZuMaW5ttYCn0rGB218IF6FrA
         rD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=H6vjzSYHdXeMDhN+Rwiu5OZOuRwTYFnzFfoeMp5ZVu0=;
        b=kXlwASLDvnJLd4qeygDdaMWOjlcoRYfuNEBx8znGsEgB7lxh58xwBAUQdwJgfA5of4
         oPDdd/7bo/MstYZJPtgV8WH/3tgvguTznwYRb7os5TRNS/N4128o0ICQ0MFTpAViwZES
         7o+NLtLMDfFOhTCTjodQoNwFdTIYCZ1X1OrSh+//sGVZ7VQhkGzzZsW1EymFRiWRQiGA
         FAiPv4E0+CX9AxYik7ibSZQLx4YZRLYgNCCsLgH8PmQ4Qt7r444DblHjiePcWQIQMkRm
         fc3gU5DkJiEnvprDxwTckfk6ZjgqrrlPdQXBrNB1WRTf/IzruXPgGZa2DfSfCyI+907P
         RM3Q==
X-Gm-Message-State: AGRZ1gLxwGD/R452gtMzR1IrglcYqky5LVFhtPmJETZbD1U/Pzd3LEK4
        Y0OvwVxkMgnGWolM1FIRm58Fh2TD
X-Google-Smtp-Source: AJdET5cJSg7DnsEpjwNIX3BfHj19NlARK9ChbngQfoPpsUkhBgmYyK8ra0XxE6saAT/Iv2G1mjyTug==
X-Received: by 2002:a17:902:2bc3:: with SMTP id l61-v6mr9232881plb.5.1541221295493;
        Fri, 02 Nov 2018 22:01:35 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.32])
        by smtp.gmail.com with ESMTPSA id b75-v6sm1423851pfb.96.2018.11.02.22.01.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 22:01:33 -0700 (PDT)
Date:   Sat, 3 Nov 2018 10:35:04 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        pasha.tatashin@oracle.com, vbabka@suse.cz, riel@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Create the new vm_fault_t type
Message-ID: <20181103050504.GA3049@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page fault handlers are supposed to return VM_FAULT codes,
but some drivers/file systems mistakenly return error
numbers. Now that all drivers/file systems have been converted
to use the vm_fault_t return type, change the type definition
to no longer be compatible with 'int'. By making it an unsigned
int, the function prototype becomes incompatible with a function
which returns int. Sparse will detect any attempts to return a
value which is not a VM_FAULT code.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 include/linux/mm.h       | 46 -----------------------------
 include/linux/mm_types.h | 75 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 47 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fcf9cc9..511a3ce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1267,52 +1267,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
 }
 
 /*
- * Different kinds of faults, as returned by handle_mm_fault().
- * Used to decide whether a process gets delivered SIGBUS or
- * just gets major/minor fault counters bumped up.
- */
-
-#define VM_FAULT_OOM	0x0001
-#define VM_FAULT_SIGBUS	0x0002
-#define VM_FAULT_MAJOR	0x0004
-#define VM_FAULT_WRITE	0x0008	/* Special case for get_user_pages */
-#define VM_FAULT_HWPOISON 0x0010	/* Hit poisoned small page */
-#define VM_FAULT_HWPOISON_LARGE 0x0020  /* Hit poisoned large page. Index encoded in upper bits */
-#define VM_FAULT_SIGSEGV 0x0040
-
-#define VM_FAULT_NOPAGE	0x0100	/* ->fault installed the pte, not return page */
-#define VM_FAULT_LOCKED	0x0200	/* ->fault locked the returned page */
-#define VM_FAULT_RETRY	0x0400	/* ->fault blocked, must retry */
-#define VM_FAULT_FALLBACK 0x0800	/* huge page fault failed, fall back to small */
-#define VM_FAULT_DONE_COW   0x1000	/* ->fault has fully handled COW */
-#define VM_FAULT_NEEDDSYNC  0x2000	/* ->fault did not modify page tables
-					 * and needs fsync() to complete (for
-					 * synchronous page faults in DAX) */
-
-#define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
-			 VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
-			 VM_FAULT_FALLBACK)
-
-#define VM_FAULT_RESULT_TRACE \
-	{ VM_FAULT_OOM,			"OOM" }, \
-	{ VM_FAULT_SIGBUS,		"SIGBUS" }, \
-	{ VM_FAULT_MAJOR,		"MAJOR" }, \
-	{ VM_FAULT_WRITE,		"WRITE" }, \
-	{ VM_FAULT_HWPOISON,		"HWPOISON" }, \
-	{ VM_FAULT_HWPOISON_LARGE,	"HWPOISON_LARGE" }, \
-	{ VM_FAULT_SIGSEGV,		"SIGSEGV" }, \
-	{ VM_FAULT_NOPAGE,		"NOPAGE" }, \
-	{ VM_FAULT_LOCKED,		"LOCKED" }, \
-	{ VM_FAULT_RETRY,		"RETRY" }, \
-	{ VM_FAULT_FALLBACK,		"FALLBACK" }, \
-	{ VM_FAULT_DONE_COW,		"DONE_COW" }, \
-	{ VM_FAULT_NEEDDSYNC,		"NEEDDSYNC" }
-
-/* Encode hstate index for a hwpoisoned large page */
-#define VM_FAULT_SET_HINDEX(x) ((x) << 12)
-#define VM_FAULT_GET_HINDEX(x) (((x) >> 12) & 0xf)
-
-/*
  * Can be called by the pagefault handler when it gets a VM_FAULT_OOM.
  */
 extern void pagefault_out_of_memory(void);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f62..48c2108 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -22,7 +22,6 @@
 #endif
 #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
 
-typedef int vm_fault_t;
 
 struct address_space;
 struct mem_cgroup;
@@ -609,6 +608,80 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 
 struct vm_fault;
 
+/**
+ * typedef vm_fault_t -  __bitwise unsigned int
+ *
+ * vm_fault_t is the new unsigned int type to return VM_FAULT
+ * code by page fault handlers of drivers/file systems. Now if
+ * any page fault handlers returns non VM_FAULT code instead
+ * of VM_FAULT code, it will be a mismatch with function
+ * prototype and sparse will detect it.
+ */
+typedef __bitwise unsigned int vm_fault_t;
+
+/**
+ * enum - VM_FAULT code
+ *
+ * This enum is used to track the VM_FAULT code return by page
+ * fault handlers.
+ *
+ * @VM_FAULT_OOM:		Out Of Memory
+ * @VM_FAULT_SIGBUS:		Bad access
+ * @VM_FAULT_MAJOR:		Page read from storage
+ * @VM_FAULT_WRITE:		Special case for get_user_pages
+ * @VM_FAULT_HWPOISON:		Hit poisoned small page
+ * @VM_FAULT_HWPOISON_LARGE:	Hit poisoned large page. Index encoded
+ *				in upper bits
+ * @VM_FAULT_SIGSEGV:		segmentation fault
+ * @VM_FAULT_NOPAGE:		->fault installed the pte, not return page
+ * @VM_FAULT_LOCKED:		->fault locked the returned page
+ * @VM_FAULT_RETRY:		->fault blocked, must retry
+ * @VM_FAULT_FALLBACK:		huge page fault failed, fall back to small
+ * @VM_FAULT_DONE_COW:		->fault has fully handled COW
+ * @VM_FAULT_NEEDDSYNC:		->fault did not modify page tables and needs
+ *				fsync() to complete (for synchronous page faults
+ *				in DAX)
+ */
+enum {
+	VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
+	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
+	VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
+	VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,
+	VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
+	VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
+	VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
+	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
+	VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
+	VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
+	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
+	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
+	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
+	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
+};
+
+/* Encode hstate index for a hwpoisoned large page */
+#define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
+#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)
+
+#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS |	\
+			VM_FAULT_SIGSEGV | VM_FAULT_HWPOISON |	\
+			VM_FAULT_HWPOISON_LARGE | VM_FAULT_FALLBACK)
+
+#define VM_FAULT_RESULT_TRACE \
+	{ VM_FAULT_OOM,                 "OOM" },	\
+	{ VM_FAULT_SIGBUS,              "SIGBUS" },	\
+	{ VM_FAULT_MAJOR,               "MAJOR" },	\
+	{ VM_FAULT_WRITE,               "WRITE" },	\
+	{ VM_FAULT_HWPOISON,            "HWPOISON" },	\
+	{ VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" },	\
+	{ VM_FAULT_SIGSEGV,             "SIGSEGV" },	\
+	{ VM_FAULT_NOPAGE,              "NOPAGE" },	\
+	{ VM_FAULT_LOCKED,              "LOCKED" },	\
+	{ VM_FAULT_RETRY,               "RETRY" },	\
+	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
+	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
+	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
 
-- 
1.9.1

