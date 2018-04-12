Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684311-1523561505-2-2016378318601393756
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523561505; b=AjX0LIYCgX/FrwDP0QxiYBZHCsvqeY92Kw/TY4JFxikBARldgP
    gMvkdFDaUdtAzCeIWHEItX3SFKGekNjeFn4+xj3ag/DcSiXsSp3xBKlv7wXrOySP
    FPqLBi5RHB8xQH6Cs/SlUZJzTF3SdIb0Rg3chvnDqoOu3A/y7JE/gsiSdFTo4LK7
    fi8HsXXBtpv2DGbjivSSghyf74M4k70mvnGv85aNqaB9Q4lu9q5LHdQGw0d9fzTP
    pxn7hy6V0F2kwf2AlTKVSXgIFtUE8/k6OKB+xxcnOmpF4nUdogbD4J2jNp7GKg3x
    1O8n5vdWg1aUZOl/nK9GjVXZ3tuX2438JLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523561505; bh=
    dcur22JDHDIuz6Ptm13/Jm1gRSQ+xRQyzuKJKWYgchk=; b=ZUICA4XsZgkokA3A
    6TwStuBp+bWwWFljobFMe+bXw6e3HYLTX0JV2nf5hxA0YAb6bY7D9rLSQjZdM1nf
    NEfHh6D17z0KAs1SchiXKJc4VdOFVL4IGdWDEvvLFdgodDGHAUaNN0ZYjuKY/vfH
    53flTdl5OIcWuTQ+XA/McLBV6Iw3q3/gmge1uQh++ysf/u69mn2ytbhvGyoi+DF1
    ihk+1slHLqCrs2KpMr01uxNgD14UHg/Hvh6K8YL/qM7QFARWU+QgrRrKB3IBWYkK
    PRTVcfuAMy5vRJ+EUx7uJIesFZWrgUctaC7CquvDuvwjYjrqsMDzcoDlgkZTjCnl
    ZHjPAg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM7vtvrmIuPsjZ1K/4wdHCCOagWnXkhUjM3QsHSHzdeDaiht4vRyQSqLQxBkKSLIhSWM6qMtVUzWs0DkzeRDc/ILMcAZRtzhyAJBCIYzAgA8WL8Rp/d/
    ETWzxeSc+cdN3k5SPZ+tL+Xzwe2pU821OI3olBJwZHZ533iR19AmgjJ21n2eX9ysGwbhGq7GET3cYWb1Kwr4SVkVOd+5PMJy/o/EjIwYQwNKYBhPSmjPZntA
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=7d_E57ReAAAA:8
    a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=1XWaLZrsAAAA:8
    a=SOq6UgPBAAAA:8 a=WfulkdPnAAAA:8 a=FOH2dFAWAAAA:8 a=NufY4J3AAAAA:8
    a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=meVymXHHAAAA:8 a=UPm3pfgAAAAA:8
    a=Z4Rwk6OoAAAA:8 a=drOt6m5kAAAA:8 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8
    a=VwQbUJbxAAAA:8 a=7Yi-VXTq316iJd_TQ4oA:9 a=uIU9Ku8kCUt5WLs9:21
    a=GUVaFKeskDDNQk5u:21 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=3hv5r9HjGAh9o5iR9qwG:22 a=56QPVbyS4OZCpcuOg7Z9:22
    a=i3VuKzQdj-NEYjvDI-p3:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=uD9XBtlS4o1URY3aiGdj:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbeDLTbm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 15:31:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:45784 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeDLT2Y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 15:28:24 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.18 10/23] mm: Introduce vm_map_user_ram, vm_unmap_user_ram
Date: Thu, 12 Apr 2018 15:27:47 -0400
Message-Id: <20180412192800.15708-11-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Create and destroy mappings aliased to a user-space mapping with the same
cache coloring as the userspace mapping. Allow the kernel to load from
and store to pages shared with user-space through its own mapping in
kernel virtual addresses while ensuring cache conherency between kernel
and userspace mappings for virtually aliased architectures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andrew Hunter <ahh@google.com>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/vmalloc.h |  4 +++
 mm/vmalloc.c            | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 1e5d8c392f15..d5e5c11ba947 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -58,6 +58,10 @@ struct vmap_area {
 extern void vm_unmap_ram(const void *mem, unsigned int count);
 extern void *vm_map_ram(struct page **pages, unsigned int count,
 				int node, pgprot_t prot);
+extern void vm_unmap_user_ram(const void *mem, unsigned int count);
+extern void *vm_map_user_ram(struct page **pages, unsigned int count,
+				unsigned long uaddr, int node, pgprot_t prot);
+
 extern void vm_unmap_aliases(void);
 
 #ifdef CONFIG_MMU
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ebff729cc956..ae033b825e45 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1199,6 +1199,72 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
 }
 EXPORT_SYMBOL(vm_map_ram);
 
+/**
+ * vm_unmap_user_ram - unmap linear kernel address space set up by vm_map_user_ram
+ * @mem: the pointer returned by vm_map_user_ram
+ * @count: the count passed to that vm_map_user_ram call (cannot unmap partial)
+ */
+void vm_unmap_user_ram(const void *mem, unsigned int count)
+{
+	unsigned long size = (unsigned long)count << PAGE_SHIFT;
+	unsigned long addr = (unsigned long)mem;
+	struct vmap_area *va;
+
+	might_sleep();
+	BUG_ON(!addr);
+	BUG_ON(addr < VMALLOC_START);
+	BUG_ON(addr > VMALLOC_END);
+	BUG_ON(!PAGE_ALIGNED(addr));
+
+	debug_check_no_locks_freed(mem, size);
+	vmap_debug_free_range(addr, addr+size);
+
+	va = find_vmap_area(addr);
+	BUG_ON(!va);
+	free_unmap_vmap_area(va);
+}
+EXPORT_SYMBOL(vm_unmap_user_ram);
+
+/**
+ * vm_map_user_ram - map user space pages linearly into kernel virtual address
+ * @pages: an array of pointers to the virtually contiguous pages to be mapped
+ * @count: number of pages
+ * @uaddr: address within the first page in the userspace mapping
+ * @node: prefer to allocate data structures on this node
+ * @prot: memory protection to use. PAGE_KERNEL for regular RAM
+ *
+ * Create a mapping aliased to a user-space mapping with the same cache
+ * coloring as the userspace mapping. Allow the kernel to load from and
+ * store to pages shared with user-space through its own mapping in kernel
+ * virtual addresses while ensuring cache conherency between kernel and
+ * userspace mappings for virtually aliased architectures.
+ *
+ * Returns: a pointer to the address that has been mapped, or %NULL on failure
+ */
+void *vm_map_user_ram(struct page **pages, unsigned int count,
+		unsigned long uaddr, int node, pgprot_t prot)
+{
+	unsigned long size = (unsigned long)count << PAGE_SHIFT;
+	unsigned long va_offset = ALIGN_DOWN(uaddr, PAGE_SIZE) & (SHMLBA - 1);
+	unsigned long alloc_size = ALIGN(va_offset + size, SHMLBA);
+	struct vmap_area *va;
+	unsigned long addr;
+	void *mem;
+
+	va = alloc_vmap_area(alloc_size, SHMLBA, VMALLOC_START, VMALLOC_END,
+			node, GFP_KERNEL);
+	if (IS_ERR(va))
+		return NULL;
+	addr = va->va_start + va_offset;
+	mem = (void *)addr;
+	if (vmap_page_range(addr, addr + size, prot, pages) < 0) {
+		vm_unmap_user_ram(mem, count);
+		return NULL;
+	}
+	return mem;
+}
+EXPORT_SYMBOL(vm_map_user_ram);
+
 static struct vm_struct *vmlist __initdata;
 /**
  * vm_area_add_early - add vmap area early during boot
-- 
2.11.0

