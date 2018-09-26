Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D872154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D872154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeI0GOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:14:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeI0GOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:14:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17B4988305;
        Wed, 26 Sep 2018 23:58:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60F3A6D7E1;
        Wed, 26 Sep 2018 23:58:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, thgarnie@google.com,
        corbet@lwn.net, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/3] x86/mm/doc: Clean up the memory region layout descriptions
Date:   Thu, 27 Sep 2018 07:58:22 +0800
Message-Id: <20180926235823.3567-3-bhe@redhat.com>
In-Reply-To: <20180926235823.3567-1-bhe@redhat.com>
References: <20180926235823.3567-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 26 Sep 2018 23:58:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Documentation/x86/x86_64/mm.txt, the style of descritions about
memory region layout is a little confusing:

 - mix size in TB with 'bits'
 - sometimes mention a size in the description and sometimes not
 - sometimes list holes by address, sometimes only as an 'unused hole' line

So fix them to make them in consistent style.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/x86/x86_64/mm.txt | 76 ++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index 5432a96d31ff..fc1da95e629d 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -1,52 +1,52 @@
 
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
+0000000000000000 - 00007fffffffffff (=47 bits, 128 TB) user space, different per mm
+				    hole caused by [47:63] sign extension
+ffff800000000000 - ffff87ffffffffff (=43 bits, 8 TB) guard hole, reserved for hypervisor
+ffff880000000000 - ffffc7ffffffffff (=46 bits, 64 TB) direct mapping of all phys. memory (page_offset_base)
+ffffc80000000000 - ffffc8ffffffffff (=40 bits, 1 TB) unused hole
+ffffc90000000000 - ffffe8ffffffffff (=45 bits, 32 TB) vmalloc/ioremap space (vmalloc_base)
+ffffe90000000000 - ffffe9ffffffffff (=40 bits, 1 TB) unused hole
+ffffea0000000000 - ffffeaffffffffff (=40 bits, 1 TB) virtual memory map (vmemmap_base)
+ffffeb0000000000 - ffffebffffffffff (=40 bits, 1 TB) unused hole
+ffffec0000000000 - fffffbffffffffff (=44 bits, 16 TB) kasan shadow memory
+fffffc0000000000 - fffffdffffffffff (=41 bits, 2 TB) unused hole
 				    vaddr_end for KASLR
-fffffe0000000000 - fffffe7fffffffff (=39 bits) cpu_entry_area mapping
-fffffe8000000000 - fffffeffffffffff (=39 bits) LDT remap for PTI
-ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
-... unused hole ...
-ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
-... unused hole ...
-ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
-ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
+fffffe0000000000 - fffffe7fffffffff (=39 bits, 512 GB) cpu_entry_area mapping
+fffffe8000000000 - fffffeffffffffff (=39 bits, 512 GB) LDT remap for PTI
+ffffff0000000000 - ffffff7fffffffff (=39 bits, 512 GB) %esp fixup stacks
+ffffff8000000000 - fffffffeefffffff (~39 bits, ~507 GB) unused hole
+ffffffef00000000 - fffffffeffffffff (=36 bits, 64 GB) EFI region mapping space
+ffffffff00000000 - ffffffff7fffffff (=31 bits, 2 GB) unused hole
+ffffffff80000000 - ffffffff9fffffff (=29 bits, 512 MB)  kernel text mapping, from phys 0
+ffffffffa0000000 - fffffffffeffffff (~31 bits, 1520 MB) module mapping space
 [fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
 ffffffffff600000 - ffffffffff600fff (=4 kB) legacy vsyscall ABI
 ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole
 
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
+0000000000000000 - 00ffffffffffffff (=56 bits, 64 PB) user space, different per mm
+				    hole caused by [56:63] sign extension
+ff00000000000000 - ff0fffffffffffff (=52 bits, 4 PB) guard hole, reserved for hypervisor
+ff10000000000000 - ff8fffffffffffff (=55 bits, 32 PB) direct mapping of all phys. memory (page_offset_base)
+ff90000000000000 - ff9fffffffffffff (=52 bits, 4 PB) LDT remap for PTI
+ffa0000000000000 - ffd1ffffffffffff (=53 bits, 12800 TB) vmalloc/ioremap space (vmalloc_base)
+ffd2000000000000 - ffd3ffffffffffff (=49 bits, 512 TB) unused hole
+ffd4000000000000 - ffd5ffffffffffff (=49 bits, 512 TB) virtual memory map (vmemmap_base)
+ffd6000000000000 - ffdeffffffffffff (~51 bits, 2304 TB) unused hole
+ffdf000000000000 - fffffdffffffffff (~53 bits, ~8 PB) kasan shadow memory
+fffffc0000000000 - fffffdffffffffff (=41 bits, 2 TB) unused hole
 				    vaddr_end for KASLR
-fffffe0000000000 - fffffe7fffffffff (=39 bits) cpu_entry_area mapping
-... unused hole ...
-ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
-... unused hole ...
-ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
-... unused hole ...
-ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
-ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
+fffffe0000000000 - fffffe7fffffffff (=39 bits, 512 GB) cpu_entry_area mapping
+fffffe8000000000 - fffffeffffffffff (=39 bits, 512 GB) unused hole
+ffffff0000000000 - ffffff7fffffffff (=39 bits, 512 GB) %esp fixup stacks
+ffffff8000000000 - ffffffeeffffffff (~39 bits,  444 GB) unused hole
+ffffffef00000000 - fffffffeffffffff (=36 bits, 64 GB) EFI region mapping space
+ffffffff00000000 - ffffffff7fffffff (31 bits, 2 GB)  unused hole
+ffffffff80000000 - ffffffff9fffffff (=29 bits, 512 MB)  kernel text mapping, from phys 0
+ffffffffa0000000 - fffffffffeffffff (~31 bits, 1520 MB) module mapping space
 [fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
 ffffffffff600000 - ffffffffff600fff (=4 kB) legacy vsyscall ABI
 ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole
-- 
2.13.6

