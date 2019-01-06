Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CA2C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE03E20830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="F2FWkDEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfAFTY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:24:58 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40159 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfAFTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:24:58 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so36007809edr.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 11:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OqLvzW5MQrfuIe3z+jSnzLo7imHs95KAnl9HGxJMCo=;
        b=F2FWkDEVDVew3YMMn6v+I7MCdpHq24Vpx74cQ4+1WenDRduuxPaWT1nH+UagcVNY/I
         9j+MM3JqXRU1jTRFJ1QaMC7ZUyFjzDk9HOZk2mfrKoxS6CsSnE+4dOGBAjMdCG0ZqY6Z
         fKg8kww7dvSHqWEvMcyQM5p1Mb+nO4pBEsH9U3d6wO8kVTan8vGQ3zeJsc+SBDs+kUAX
         tIH7Nh35rWgAbKco27Dblr743WRXoeIUOb4gijOaVOjE6EC81LDR251ceNzoHQ2W0J5X
         xd1eGO0at1rgPFAhJqTedlbQGVmu+igqu/YvJFIa6FvnczeTQMqwH6tUbKObVDvlD6uZ
         yBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OqLvzW5MQrfuIe3z+jSnzLo7imHs95KAnl9HGxJMCo=;
        b=bIjOyoZ7+SZhTkcA8Xw0aZ3CEauV/r8gjjy+EHjoNBZ3mrZwa/orwS30jtdRY7MUgC
         3ORD88tvXExc2ndJhQHZQ8N9quGjDvzkOWr7L3CzGRfVzr9kqZICCs1jwKCfB0zADcup
         Z8Ed+gq6zPdzNE+JQdhZp7ETmngXaTiETVgHgut4qDfIkZEDdSYQtyPnQUF1EWaLC/zM
         JGYUYPLsBfV/ex/NvDJChS1dnZX0QJoXJzRFUyU3w49OJLgk+iCp/yReEk3f32nN09jP
         rXF63YMuOv7Icg+O0J/dyxw7s1jwZTtq/0ZoRIuoioMCGUGtUYbIDQlS8zCX8vMlTl/s
         Q+6A==
X-Gm-Message-State: AA+aEWYPOoNOlJc3a48ANvteC5t9sWQPK5koGnibMtvfnYqX3E8p4LFa
        j8KPgY9gtYVmXE/2hX2EPDvFNA==
X-Google-Smtp-Source: AFSGD/VPXUot8C/JDoy9j2CfsuJWusqxjRCJocmcvk/WhRoNKzklCgm/+ywLSb8P2fdjS6cMqNeXXw==
X-Received: by 2002:aa7:d35a:: with SMTP id m26mr51732300edr.244.1546802695994;
        Sun, 06 Jan 2019 11:24:55 -0800 (PST)
Received: from localhost.localdomain ([156.212.65.252])
        by smtp.gmail.com with ESMTPSA id b46sm29994035edd.94.2019.01.06.11.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 11:24:55 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Subject: [PATCH V8 0/11] KVM: X86: Introducing ROE Protection Kernel Hardening
Date:   Sun,  6 Jan 2019 21:23:34 +0200
Message-Id: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- Summary --

ROE is a hypercall that enables host operating system to restrict guest's access
to its own memory. This will provide a hardening mechanism that can be used to
stop rootkits from manipulating kernel static data structures and code. Once a
memory region is protected the guest kernel can't even request undoing the
protection.

Memory protected by ROE should be non-swapable because even if the ROE protected
page got swapped out, It won't be possible to write anything in its place.

ROE hypercall should be capable of either protecting a whole memory frame or
parts of it. With these two, it should be possible for guest kernel to protect
its memory and all the page table entries for that memory inside the page table.
I am still not sure whether this should be part of ROE job or the guest's job.

Our threat model assumes that an attacker got full root access to a running
guest and his goal is to manipulate kernel code/data (hook syscalls, overwrite
IDT ..etc).


-- Why didn't I implement ROE in host's userspace ? --

The reason why it would be better to implement this from inside kvm: It will
become a big performance hit to vmexit and switch to user space mode on each
fault, on the other hand, having the permission handled by EPT should make some
remarkable performance gain when writing in non protected page that contains
protected chunks. My tests showed that the bottle neck is the time taken in
context switching, reducing the number of switches did improve performance a
lot. Full lengthy explanation with numbers can be found in [2].


-- Future Work -- 
There is future work in progress to also put some sort of protection on the page
table register CR3 and other critical registers that can be intercepted by KVM.
This way it won't be possible for an attacker to manipulate any part of the
guests page table.


-- Test Case --

I was requested to add a test to tools/testing/selftests/kvm/. But the original
testing suite didn't work on my machine, I experienced shutdown due to triple
fault because of EPT fault with the current tests. I tried bisecting but the
triple fault was there from the very first commit.

So instead I would provide here a demo kernel module to test the current
implementation:

```
	#include <linux/init.h>
	#include <linux/module.h>
	#include <linux/kernel.h>
	#include <linux/slab.h>
	#include <linux/kvm_para.h>
	#include <linux/mm.h>
	MODULE_LICENSE("GPL");
	MODULE_AUTHOR("OddCoder");
	MODULE_DESCRIPTION("ROE Hello world Module");
	MODULE_VERSION("0.0.1");

	#define KVM_HC_ROE 11
	#define ROE_VERSION 0
	#define ROE_MPROTECT 1
	#define ROE_MPROTECT_CHUNK 2

	static long roe_version(void){
		return kvm_hypercall1 (KVM_HC_ROE, ROE_VERSION);
	}

	static long roe_mprotect(void *addr, long pg_count) {
		return kvm_hypercall3 (KVM_HC_ROE, ROE_MPROTECT, (u64)addr, pg_count);
	}

	static long roe_mprotect_chunk(void *addr, long size) {
		return kvm_hypercall3 (KVM_HC_ROE, ROE_MPROTECT_CHUNK, (u64)addr, size);
	}

 	static int __init hello(void ) {
		int x;
		struct page *pg1, *pg2;
		void *memory;
		pg1 = alloc_page(GFP_KERNEL);
		pg2 = alloc_page(GFP_KERNEL);
		memory = page_to_virt(pg1);
		pr_info ("ROE_VERSION: %ld\n", roe_version());
		pr_info ("Allocated memory: 0x%llx\n", (u64)memory);
		pr_info("Physical Address: 0x%llx\n", virt_to_phys(memory));
		strcpy((char *)memory, "ROE PROTECTED");
		pr_info("memory_content: %s\n", (char *)memory);
		x = roe_mprotect((void *)memory, 1);
		strcpy((char *)memory, "The strcpy should silently fail and"
					"memory content won't be modified");
		pr_info("memory_content: %s\n", (char *)memory);
		memory = page_to_virt(pg2);
		pr_info ("Allocated memory: 0x%llx\n", (u64)memory);
		pr_info("Physical Address: 0x%llx\n", virt_to_phys(memory));
		strcpy((char *)memory, "ROE PROTECTED PARTIALLY");
		roe_mprotect_chunk((void *)memory, strlen((char *)memory));
		pr_info("memory_content: %s\n", (char *)memory);
		strcpy((char *)memory, "XXXXXXXXXXXXXXXXXXXXXXX"
					" <- Text here not modified still Can concat");
		pr_info("memory_content: %s\n", (char *)memory);
		return 0;
	}
	static void __exit bye(void) {
		pr_info("Allocated Memory May never be freed at all!\n");
		pr_info("Actually this is more of an ABI demonstration\n");
		pr_info("than actual use case\n");
		}
	module_init(hello);
	module_exit(bye);

```

I tried this on Gentoo host with Ubuntu guest and Qemu from git after applying
the following changes to Qemu

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4880a05399..57d0973aca 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2035,6 +2035,9 @@ int kvm_cpu_exec(CPUState *cpu)
                              run->mmio.is_write);
             ret = 0;
             break;
+	case KVM_EXIT_ROE:
+	    ret = 0;
+	    break;
         case KVM_EXIT_IRQ_WINDOW_OPEN:
             DPRINTF("irq_window_open\n");
             ret = EXCP_INTERRUPT;
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index f11a7eb49c..67aded8f00 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -235,7 +235,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
-
+#define KVM_EXIT_ROE              28
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
 #define KVM_INTERNAL_ERROR_EMULATION	1



-- Change log V7 -> V8 --

- Bug fix in patch 10, (it didn't work).
- Replacing the linked list structure used to store protected chunks with a red
  black tree. That offered huge performance improvement where the query time
  when writing to a linked list of ~2000 chunks was almost constant.


-- Known Issues --

- THP is not supported yet. In general it is not supported when the guest frame
  size is not the same as the equivalent EPT frame size.

The previous version (V7) of the patch set can be found at [1]

-- links --

[1] https://lkml.org/lkml/2018/12/7/345
[2] https://lkml.org/lkml/2018/12/21/340

-- List of patches --

[PATCH V8 01/11] KVM: State whether memory should be freed in
[PATCH V8 02/11] KVM: X86: Add arbitrary data pointer in kvm memslot
[PATCH V8 03/11] KVM: X86: Add helper function to convert SPTE to GFN
[PATCH V8 04/11] KVM: Document Memory ROE
[PATCH V8 05/11] KVM: Create architecture independent ROE skeleton
[PATCH V8 06/11] KVM: X86: Enable ROE for x86
[PATCH V8 07/11] KVM: Add support for byte granular memory ROE
[PATCH V8 08/11] KVM: X86: Port ROE_MPROTECT_CHUNK to x86
[PATCH V8 09/11] KVM: Add new exit reason For ROE violations
[PATCH V8 10/11] KVM: Log ROE violations in system log
[PATCH V8 11/11] KVM: ROE: Store protected chunks in red black tree

-- Difstat --

Documentation/virtual/kvm/hypercalls.txt |  40 +++
arch/x86/include/asm/kvm_host.h          |   2 +-
arch/x86/kvm/Makefile                    |   4 +-
arch/x86/kvm/mmu.c                       | 121 ++++-----
arch/x86/kvm/mmu.h                       |  31 ++-
arch/x86/kvm/roe.c                       | 104 ++++++++
arch/x86/kvm/roe_arch.h                  |  28 ++
arch/x86/kvm/x86.c                       |  21 +-
include/kvm/roe.h                        |  28 ++
include/linux/kvm_host.h                 |  57 ++++
include/uapi/linux/kvm.h                 |   2 +-
include/uapi/linux/kvm_para.h            |   5 +
virt/kvm/kvm_main.c                      |  54 +++-
virt/kvm/roe.c                           | 445 +++++++++++++++++++++++++++++++
virt/kvm/roe_generic.h                   |  22 ++
15 files changed, 868 insertions(+), 96 deletions(-)


Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
