Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E75C65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7DC2084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7DC2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJFUM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 16:12:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbeJFUM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 16:12:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w96D7UCs3551677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Oct 2018 06:07:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w96D7TDQ3551674;
        Sat, 6 Oct 2018 06:07:29 -0700
Date:   Sat, 6 Oct 2018 06:07:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-5b12904065798fee8b153a506ac7b72d5ebbe26c@git.kernel.org>
Cc:     hpa@zytor.com, riel@surriel.com, luto@amacapital.net,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, dvlasenk@redhat.com,
        mingo@kernel.org, torvalds@linux-foundation.org, brgerst@gmail.com,
        linux-kernel@vger.kernel.org, bhe@redhat.com
Reply-To: luto@amacapital.net, bp@alien8.de, luto@kernel.org,
          hpa@zytor.com, riel@surriel.com, linux-kernel@vger.kernel.org,
          brgerst@gmail.com, bhe@redhat.com, peterz@infradead.org,
          mingo@kernel.org, dvlasenk@redhat.com, tglx@linutronix.de,
          dave.hansen@linux.intel.com, torvalds@linux-foundation.org
In-Reply-To: <20181006084327.27467-3-bhe@redhat.com>
References: <20181006084327.27467-3-bhe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/doc: Clean up the x86-64 virtual memory layout
 descriptions
Git-Commit-ID: 5b12904065798fee8b153a506ac7b72d5ebbe26c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5b12904065798fee8b153a506ac7b72d5ebbe26c
Gitweb:     https://git.kernel.org/tip/5b12904065798fee8b153a506ac7b72d5ebbe26c
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Sat, 6 Oct 2018 16:43:26 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 6 Oct 2018 14:46:47 +0200

x86/mm/doc: Clean up the x86-64 virtual memory layout descriptions

In Documentation/x86/x86_64/mm.txt, the description of the x86-64 virtual
memory layout has become a confusing hodgepodge of inconsistencies:

 - there's a hard to read mixture of 'TB' and 'bits' notation
 - the entries sometimes mention a size in the description and sometimes not
 - sometimes they list holes by address, sometimes only as an 'unused hole' line

So make it all a coherent, readable, well organized description.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: corbet@lwn.net
Cc: linux-doc@vger.kernel.org
Cc: thgarnie@google.com
Link: http://lkml.kernel.org/r/20181006084327.27467-3-bhe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/x86_64/mm.txt | 84 ++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index 5432a96d31ff..b4bc95c9790e 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -1,55 +1,55 @@
 
 Virtual memory map with 4 level page tables:
 
-0000000000000000 - 00007fffffffffff (=47 bits) user space, different per mm
-hole caused by [47:63] sign extension
-ffff800000000000 - ffff87ffffffffff (=43 bits) guard hole, reserved for hypervisor
-ffff880000000000 - ffffc7ffffffffff (=64 TB) direct mapping of all phys. memory
-ffffc80000000000 - ffffc8ffffffffff (=40 bits) hole
-ffffc90000000000 - ffffe8ffffffffff (=45 bits) vmalloc/ioremap space
-ffffe90000000000 - ffffe9ffffffffff (=40 bits) hole
-ffffea0000000000 - ffffeaffffffffff (=40 bits) virtual memory map (1TB)
-... unused hole ...
-ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
-... unused hole ...
+0000000000000000 - 00007fffffffffff (=47 bits,   128 TB) user space, different per mm
+				    hole caused by [47:63] sign extension
+ffff800000000000 - ffff87ffffffffff (=43 bits,     8 TB) guard hole, reserved for hypervisor
+ffff880000000000 - ffffc7ffffffffff (=46 bits,    64 TB) direct mapping of all phys. memory (page_offset_base)
+ffffc80000000000 - ffffc8ffffffffff (=40 bits,     1 TB) unused hole
+ffffc90000000000 - ffffe8ffffffffff (=45 bits,    32 TB) vmalloc/ioremap space (vmalloc_base)
+ffffe90000000000 - ffffe9ffffffffff (=40 bits,     1 TB) unused hole
+ffffea0000000000 - ffffeaffffffffff (=40 bits,     1 TB) virtual memory map (vmemmap_base)
+ffffeb0000000000 - ffffebffffffffff (=40 bits,     1 TB) unused hole
+ffffec0000000000 - fffffbffffffffff (=44 bits,    16 TB) kasan shadow memory
+fffffc0000000000 - fffffdffffffffff (=41 bits,     2 TB) unused hole
 				    vaddr_end for KASLR
-fffffe0000000000 - fffffe7fffffffff (=39 bits) cpu_entry_area mapping
-fffffe8000000000 - fffffeffffffffff (=39 bits) LDT remap for PTI
-ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
-... unused hole ...
-ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
-... unused hole ...
-ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
-ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
+fffffe0000000000 - fffffe7fffffffff (=39 bits,   512 GB) cpu_entry_area mapping
+fffffe8000000000 - fffffeffffffffff (=39 bits,   512 GB) LDT remap for PTI
+ffffff0000000000 - ffffff7fffffffff (=39 bits,   512 GB) %esp fixup stacks
+ffffff8000000000 - fffffffeefffffff (~39 bits,  ~507 GB) unused hole
+ffffffef00000000 - fffffffeffffffff (=36 bits,    64 GB) EFI region mapping space
+ffffffff00000000 - ffffffff7fffffff (=31 bits,     2 GB) unused hole
+ffffffff80000000 - ffffffff9fffffff (=29 bits,   512 MB) kernel text mapping, from phys 0
+ffffffffa0000000 - fffffffffeffffff (~31 bits,  1520 MB) module mapping space
 [fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
-ffffffffff600000 - ffffffffff600fff (=4 kB) legacy vsyscall ABI
-ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole
+ffffffffff600000 - ffffffffff600fff (             =4 kB) legacy vsyscall ABI
+ffffffffffe00000 - ffffffffffffffff (             =2 MB) unused hole
 
 Virtual memory map with 5 level page tables:
 
-0000000000000000 - 00ffffffffffffff (=56 bits) user space, different per mm
-hole caused by [56:63] sign extension
-ff00000000000000 - ff0fffffffffffff (=52 bits) guard hole, reserved for hypervisor
-ff10000000000000 - ff8fffffffffffff (=55 bits) direct mapping of all phys. memory
-ff90000000000000 - ff9fffffffffffff (=52 bits) LDT remap for PTI
-ffa0000000000000 - ffd1ffffffffffff (=54 bits) vmalloc/ioremap space (12800 TB)
-ffd2000000000000 - ffd3ffffffffffff (=49 bits) hole
-ffd4000000000000 - ffd5ffffffffffff (=49 bits) virtual memory map (512TB)
-... unused hole ...
-ffdf000000000000 - fffffc0000000000 (=53 bits) kasan shadow memory (8PB)
-... unused hole ...
+0000000000000000 - 00ffffffffffffff (=56 bits,    64 PB) user space, different per mm
+				    hole caused by [56:63] sign extension
+ff00000000000000 - ff0fffffffffffff (=52 bits,     4 PB) guard hole, reserved for hypervisor
+ff10000000000000 - ff8fffffffffffff (=55 bits,    32 PB) direct mapping of all phys. memory (page_offset_base)
+ff90000000000000 - ff9fffffffffffff (=52 bits,     4 PB) LDT remap for PTI
+ffa0000000000000 - ffd1ffffffffffff (=53 bits, 12800 TB) vmalloc/ioremap space (vmalloc_base)
+ffd2000000000000 - ffd3ffffffffffff (=49 bits,   512 TB) unused hole
+ffd4000000000000 - ffd5ffffffffffff (=49 bits,   512 TB) virtual memory map (vmemmap_base)
+ffd6000000000000 - ffdeffffffffffff (~51 bits,  2304 TB) unused hole
+ffdf000000000000 - fffffdffffffffff (~53 bits,    ~8 PB) kasan shadow memory
+fffffc0000000000 - fffffdffffffffff (=41 bits,     2 TB) unused hole
 				    vaddr_end for KASLR
-fffffe0000000000 - fffffe7fffffffff (=39 bits) cpu_entry_area mapping
-... unused hole ...
-ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
-... unused hole ...
-ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
-... unused hole ...
-ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
-ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
+fffffe0000000000 - fffffe7fffffffff (=39 bits,   512 GB) cpu_entry_area mapping
+fffffe8000000000 - fffffeffffffffff (=39 bits,   512 GB) unused hole
+ffffff0000000000 - ffffff7fffffffff (=39 bits,   512 GB) %esp fixup stacks
+ffffff8000000000 - ffffffeeffffffff (~39 bits,   444 GB) unused hole
+ffffffef00000000 - fffffffeffffffff (=36 bits,    64 GB) EFI region mapping space
+ffffffff00000000 - ffffffff7fffffff (31 bits,      2 GB) unused hole
+ffffffff80000000 - ffffffff9fffffff (=29 bits,   512 MB) kernel text mapping, from phys 0
+ffffffffa0000000 - fffffffffeffffff (~31 bits,  1520 MB) module mapping space
 [fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
-ffffffffff600000 - ffffffffff600fff (=4 kB) legacy vsyscall ABI
-ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole
+ffffffffff600000 - ffffffffff600fff (             =4 kB) legacy vsyscall ABI
+ffffffffffe00000 - ffffffffffffffff (             =2 MB) unused hole
 
 Architecture defines a 64-bit virtual address. Implementations can support
 less. Currently supported are 48- and 57-bit virtual addresses. Bits 63
