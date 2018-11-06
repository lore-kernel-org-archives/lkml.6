Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE138C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6977820862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHrUCI/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6977820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeKFRKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:10:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35085 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeKFRKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:10:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so5784728plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 23:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LoPekBv4ecKgNNEo5tW7CAeKBEcSexsyyurwBOBdMEw=;
        b=VHrUCI/qHIB6awukFBbx6Ej+M+JEpfrSip7vIcOekvVO9a5ITIV55GRLl8iR84CKhU
         wND1OKDQ4MIZythqmUOs6VTTN7ZQ93lQUGLfzvBfdgN9wAHGxgF6FIHfrlsJLlIke715
         ayZOJrSJb/KGn/3JMrHXApnglwbqh+MeBfpVMlZO/KGPJEEtWFd5vpV69P0iWXGzOgnx
         cNs1vKE1nwGPiDyRoUWBM7FERjxn5DCmLyIfC8xfS5nnggRPIVWqvaYYtIrjeP+FqjK7
         CfEg6mvwi9m1V1Jrq8eZcOPDOU77yxD4nSHTDErf/LBWBcTOGLpA6lHjitzFS3eEQrDP
         0sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LoPekBv4ecKgNNEo5tW7CAeKBEcSexsyyurwBOBdMEw=;
        b=ou/1wFF4fitF3YeBsnUmGSOvO28j/EBxIAE6MZ8nz1K9IndyOskI6x0tohRv0ZGyZX
         wJ8zfn1ZIGVlbCIPW9UccMypBTdcQJjbaBiaqULtIw2+6QYKQhJ47+A4Ut97Dl3h7Pzr
         nYtBnrP8x+VUNaJq8g5LqK3GwV6jmm0hF5NSgmlppQU3XRdDQxalxT+Cibukcytukqv3
         7KvrxFzeKmKDZN7rpbIrzy9aFwPV39m4Why+lNfyTEnvS5Vrz3XoqACpgdve5HMoBpiZ
         /ZiL7p6djCr7dCTKVipjmTDXV34BXgHG2Eh+ALiFsURElZdtCGnoH2CqKMVaoKm1W9/p
         +FaQ==
X-Gm-Message-State: AGRZ1gKhYVf/D7nYAz7VyUvNSyprBJRv3wVK3rZDEFsMA7rHj8ckNQNs
        YzKYKPQNf5A4/EtdcdrOxnzyWqWC
X-Google-Smtp-Source: AJdET5csnpgnlXTXojYEz93SOw5hPVclTJzYRyeUa8iMUmrKgQaNTbC9J1vznGAscOCt7WXSyMc9uQ==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10-v6mr25221832plb.130.1541490364194;
        Mon, 05 Nov 2018 23:46:04 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.85])
        by smtp.gmail.com with ESMTPSA id z9-v6sm22039200pfg.174.2018.11.05.23.46.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 23:46:02 -0800 (PST)
Date:   Tue, 6 Nov 2018 13:19:34 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        vbabka@suse.cz, riel@redhat.com, rppt@linux.ibm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: Create the new vm_fault_t type
Message-ID: <20181106074934.GA27620@jordon-HP-15-Notebook-PC>
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

VM_FAULT_SET_HINDEX and VM_FAULT_GET_HINDEX values are changed
to avoid conflict with other VM_FAULT codes.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Updated the change log and corrected the document part.
    name added to the enum that kernel-doc able to parse it.

 include/linux/mm.h       | 46 ------------------------------
 include/linux/mm_types.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 47 deletions(-)

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
index 5ed8f62..beee607 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -22,7 +22,6 @@
 #endif
 #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
 
-typedef int vm_fault_t;
 
 struct address_space;
 struct mem_cgroup;
@@ -609,6 +608,78 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 
 struct vm_fault;
 
+/**
+ * typedef vm_fault_t - Return type for page fault handlers.
+ *
+ * Page fault handlers return a bitmask of %VM_FAULT values.
+ */
+typedef __bitwise unsigned int vm_fault_t;
+
+/**
+ * enum - VM_FAULT code
+ *
+ * Page fault handlers return a bitmask of these values to tell
+ * the core VM what happened when handling the fault. Used to decide
+ * whether a process gets delivered SIGBUS or just gets major/minor
+ * fault counters bumped up.
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
+enum vm_fault_reason {
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

