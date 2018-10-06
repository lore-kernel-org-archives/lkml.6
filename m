Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE77BC65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729CA2089D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdMNPal9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729CA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeJFVmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 17:42:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39268 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeJFVl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 17:41:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id 61-v6so15552040wrb.6;
        Sat, 06 Oct 2018 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mm7fTVk1tOFRTpHY0Ps/sG6Rqm4uaDksxAY77Oqs6go=;
        b=cdMNPal9/yUfb5FsiY/kZfrOMbrvFUA7dL+JIltbJU13pF/M1uRcw6AGLElLn1k9NF
         TSZDjEjsLHVwH9tD1FJR+O07G7Wi9rEffbRU4A5hWJ/kZ3R2cy888tKinkAUAoEVQltp
         TAGQ2ZP+GRioZ0QRRd+ShAbj4vrhUY8n4ucqw3vqDXtTWryQd5x4n38CEHNp9tXvD+gB
         8/nC1GtCEkNYv493uTEHb/WUuZw4xbw8mOLQLrALv7HT9ZXxGakuaXSMLWsXoE+n2iCz
         jDn9JEhSoJ6xnANQRSW0mOlkPeO6N/5MT1Ks0gagDooXjVBIFweuITrG6vKdKE6oayhG
         AOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mm7fTVk1tOFRTpHY0Ps/sG6Rqm4uaDksxAY77Oqs6go=;
        b=B57TbYpmy4L0CjuDWeHTdYHhWQQ+92xM6ZogPgvmLpN+N5Tb8DbQvUjKhZfjS20RYO
         VCMyyr7ZTnN3OWCXNrPmuziJiU8uJWADRNyFS/HQsHhzhpnofwl335gLodxk0xeGL97U
         ZlrLecNYzOBt+L1982Jm9x/ziR748HOxvY3ZrjQ7tU5/dedIUjfdvA7+yoEJlkAzyH4G
         Rla1dhaOJgRDkuJJx3UsvUOlGzMZt49mFs81d0efVSu7BR4aD2KbDRjnCnPZxPDrCAeL
         EVdT2L/xrM+ZLHnEjHOnGe3JYi508nQGzsaOQtexJkVRswCsmtakd8SuwLTZ6A3fwSEK
         8maw==
X-Gm-Message-State: ABuFfog0o6WVlptC5Xa/RylUoF/R6M1qIYrsKO18dhAtwCQ0TkS2euXI
        lIIVEilQJqwzA7tS3QP9TL4=
X-Google-Smtp-Source: ACcGV63yS1mw0DWJe/S1xXygOGl/F6eQ1qW3F8Ja99QGtk1NMxVKe1KEmU1zLtrmMK4mD5zUiOOEpQ==
X-Received: by 2002:adf:a387:: with SMTP id l7-v6mr12402166wrb.1.1538836704858;
        Sat, 06 Oct 2018 07:38:24 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 67-v6sm4292550wmd.1.2018.10.06.07.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 07:38:23 -0700 (PDT)
Date:   Sat, 6 Oct 2018 16:38:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, thgarnie@google.com,
        corbet@lwn.net, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/3 v2] x86/mm/doc: Enhance the x86-64 virtual memory layout
 descriptions
Message-ID: <20181006143821.GA72401@gmail.com>
References: <20181006084327.27467-1-bhe@redhat.com>
 <20181006122259.GB418@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006122259.GB418@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Find a new iteration below, fixed the bug, prettified the table some more.

Thanks,

	Ingo

=========>
After the cleanups from Baoquan He, make it even more readable:

 - Remove the 'bits' area size column: it's pretty pointless and was even
   wrong for some of the entries. Given that MB, GB, TB, PT are 10, 20,
   30 and 40 bits, a "8 TB" size description makes it obvious that it's
   43 bits.

 - Introduce an "offset" column:

    --------------------------------------------------------------------------------
    start addr       | offset     | end addr         |  size   | VM area description
    -----------------|------------|------------------|---------|--------------------
    ...
    ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapping of all physical memory (page_offset_base),
                                                                 this is what limits max physical memory supported.

   The -120 TB notation makes it obvious where this particular virtual memory
   region starts: 120 TB down from the top of the 64-bit virtual memory space.
   Especially the layout of the kernel mappings is a *lot* more obvious when
   written this way, plus it's much easier to compare it with the size column
   and understand/check/validate and modify the kernel's layout in the future.

 - Mark the part from where the 47-bit and 56-bit kernel layouts are 100% identical,
   this starts at the -512 GB offset and the EFI region.

 - Re-shuffle the size desciptions to be continous blocks of sizes, instead of the
   often mixed size. I.e. write "0.5 TB" instead of "512 GB" if we are still in
   the TB-granular region of the map.

 - Make the 47-bit and 56-bit descriptions use the *exact* same layout and wording,
   and only differ where there's a material difference. This makes it easy to compare
   the two tables side by side by switching between two terminal tabs.

 - Plus enhance a lot of other stylistic/typographical details: make the tables
   explicitly tabular, add headers, enhance certain entries, etc. etc.

Note that there are some apparent errors in the tables as well, but I'll fix
them in a separate patch to make it easier to review/validate.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
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
Cc: linux-kernel@vger.kernel.org
Cc: thgarnie@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/x86_64/mm.txt | 171 ++++++++++++++++++++++++++++------------
 1 file changed, 120 insertions(+), 51 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index b4bc95c9790e..702898633b00 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -1,55 +1,124 @@
+====================================================
+Complete virtual memory map with 4-level page tables
+====================================================
 
-Virtual memory map with 4 level page tables:
-
-0000000000000000 - 00007fffffffffff (=47 bits,   128 TB) user space, different per mm
-				    hole caused by [47:63] sign extension
-ffff800000000000 - ffff87ffffffffff (=43 bits,     8 TB) guard hole, reserved for hypervisor
-ffff880000000000 - ffffc7ffffffffff (=46 bits,    64 TB) direct mapping of all phys. memory (page_offset_base)
-ffffc80000000000 - ffffc8ffffffffff (=40 bits,     1 TB) unused hole
-ffffc90000000000 - ffffe8ffffffffff (=45 bits,    32 TB) vmalloc/ioremap space (vmalloc_base)
-ffffe90000000000 - ffffe9ffffffffff (=40 bits,     1 TB) unused hole
-ffffea0000000000 - ffffeaffffffffff (=40 bits,     1 TB) virtual memory map (vmemmap_base)
-ffffeb0000000000 - ffffebffffffffff (=40 bits,     1 TB) unused hole
-ffffec0000000000 - fffffbffffffffff (=44 bits,    16 TB) kasan shadow memory
-fffffc0000000000 - fffffdffffffffff (=41 bits,     2 TB) unused hole
-				    vaddr_end for KASLR
-fffffe0000000000 - fffffe7fffffffff (=39 bits,   512 GB) cpu_entry_area mapping
-fffffe8000000000 - fffffeffffffffff (=39 bits,   512 GB) LDT remap for PTI
-ffffff0000000000 - ffffff7fffffffff (=39 bits,   512 GB) %esp fixup stacks
-ffffff8000000000 - fffffffeefffffff (~39 bits,  ~507 GB) unused hole
-ffffffef00000000 - fffffffeffffffff (=36 bits,    64 GB) EFI region mapping space
-ffffffff00000000 - ffffffff7fffffff (=31 bits,     2 GB) unused hole
-ffffffff80000000 - ffffffff9fffffff (=29 bits,   512 MB) kernel text mapping, from phys 0
-ffffffffa0000000 - fffffffffeffffff (~31 bits,  1520 MB) module mapping space
-[fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
-ffffffffff600000 - ffffffffff600fff (             =4 kB) legacy vsyscall ABI
-ffffffffffe00000 - ffffffffffffffff (             =2 MB) unused hole
-
-Virtual memory map with 5 level page tables:
-
-0000000000000000 - 00ffffffffffffff (=56 bits,    64 PB) user space, different per mm
-				    hole caused by [56:63] sign extension
-ff00000000000000 - ff0fffffffffffff (=52 bits,     4 PB) guard hole, reserved for hypervisor
-ff10000000000000 - ff8fffffffffffff (=55 bits,    32 PB) direct mapping of all phys. memory (page_offset_base)
-ff90000000000000 - ff9fffffffffffff (=52 bits,     4 PB) LDT remap for PTI
-ffa0000000000000 - ffd1ffffffffffff (=53 bits, 12800 TB) vmalloc/ioremap space (vmalloc_base)
-ffd2000000000000 - ffd3ffffffffffff (=49 bits,   512 TB) unused hole
-ffd4000000000000 - ffd5ffffffffffff (=49 bits,   512 TB) virtual memory map (vmemmap_base)
-ffd6000000000000 - ffdeffffffffffff (~51 bits,  2304 TB) unused hole
-ffdf000000000000 - fffffdffffffffff (~53 bits,    ~8 PB) kasan shadow memory
-fffffc0000000000 - fffffdffffffffff (=41 bits,     2 TB) unused hole
-				    vaddr_end for KASLR
-fffffe0000000000 - fffffe7fffffffff (=39 bits,   512 GB) cpu_entry_area mapping
-fffffe8000000000 - fffffeffffffffff (=39 bits,   512 GB) unused hole
-ffffff0000000000 - ffffff7fffffffff (=39 bits,   512 GB) %esp fixup stacks
-ffffff8000000000 - ffffffeeffffffff (~39 bits,   444 GB) unused hole
-ffffffef00000000 - fffffffeffffffff (=36 bits,    64 GB) EFI region mapping space
-ffffffff00000000 - ffffffff7fffffff (31 bits,      2 GB) unused hole
-ffffffff80000000 - ffffffff9fffffff (=29 bits,   512 MB) kernel text mapping, from phys 0
-ffffffffa0000000 - fffffffffeffffff (~31 bits,  1520 MB) module mapping space
-[fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
-ffffffffff600000 - ffffffffff600fff (             =4 kB) legacy vsyscall ABI
-ffffffffffe00000 - ffffffffffffffff (             =2 MB) unused hole
+Notes:
+
+ - Negative addresses such as "-23 TB" are absolute addresses in bytes, counted down
+   from the top of the 64-bit address space. It's easier to understand the layout
+   when seen both in absolute addresses and in distance-from-top notation.
+
+   For example 0xffffe90000000000 == -23 TB, it's 23 TB lower than the top of the
+   64-bit address space (ffffffffffffffff).
+
+   Note that as we get closer to the top of the address space, the notation changes
+   from TB to GB and then MB/KB.
+
+ - "16M TB" might look weird at first sight, but it's an easier to visualize size
+   notation than "16 EB", which few will recognize at first sight as 16 exabytes.
+   It also shows it nicely how incredibly large 64-bit address space is.
+
+========================================================================================================================
+    Start addr    |   Offset   |     End addr     |  Size   | VM area description
+========================================================================================================================
+                  |            |                  |         |
+ 0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm
+__________________|____________|__________________|_________|___________________________________________________________
+                  |            |                  |         |
+ 0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
+                  |            |                  |         |     virtual memory addresses up to the -128 TB
+                  |            |                  |         |     starting offset of kernel mappings.
+__________________|____________|__________________|_________|___________________________________________________________
+                                                            |
+                                                            | Kernel-space virtual memory, shared between all processes:
+____________________________________________________________|___________________________________________________________
+                  |            |                  |         |
+ ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
+ ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
+ ffffc80000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused hole
+ ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
+ ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
+ ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
+ ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole
+ ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
+ fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
+                  |            |                  |         | vaddr_end for KASLR
+ fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
+ fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | LDT remap for PTI
+ ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
+__________________|____________|__________________|_________|____________________________________________________________
+                                                            |
+                                                            | Identical layout to the 47-bit one from here on:
+____________________________________________________________|____________________________________________________________
+                  |            |                  |         |
+ ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
+ ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
+ ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
+ ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
+ ffffffff80000000 |-2048    MB |                  |         |
+ ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
+ ffffffffff000000 |  -16    MB |                  |         |
+    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset
+ ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
+ ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
+__________________|____________|__________________|_________|___________________________________________________________
+
+
+====================================================
+Complete virtual memory map with 5-level page tables
+====================================================
+
+Notes:
+
+ - With 56-bit addresses, user-space memory gets expanded by a factor of 512x,
+   from 0.125 PB to 64 PB. All kernel mappings shift down to the -64 PT starting
+   offset and many of the regions expand to support the much larger physical
+   memory supported.
+
+========================================================================================================================
+    Start addr    |   Offset   |     End addr     |  Size   | VM area description
+========================================================================================================================
+                  |            |                  |         |
+ 0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm
+__________________|____________|__________________|_________|___________________________________________________________
+                  |            |                  |         |
+ 0000800000000000 |  +64    PB | ffff7fffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
+                  |            |                  |         |     virtual memory addresses up to the -128 TB
+                  |            |                  |         |     starting offset of kernel mappings.
+__________________|____________|__________________|_________|___________________________________________________________
+                                                            |
+                                                            | Kernel-space virtual memory, shared between all processes:
+____________________________________________________________|___________________________________________________________
+                  |            |                  |         |
+ ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor
+ ff10000000000000 |  -60    PB | ff8fffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)
+ ff90000000000000 |  -28    PB | ff9fffffffffffff |    4 PB | LDT remap for PTI
+ ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)
+ ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
+ ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
+ ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
+ ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory
+ fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
+                  |            |                  |         | vaddr_end for KASLR
+ fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
+ fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
+ ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
+__________________|____________|__________________|_________|____________________________________________________________
+                                                            |
+                                                            | Identical layout to the 47-bit one from here on:
+____________________________________________________________|____________________________________________________________
+                  |            |                  |         |
+ ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
+ ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
+ ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
+ ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
+ ffffffff80000000 |-2048    MB |                  |         |
+ ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
+ ffffffffff000000 |  -16    MB |                  |         |
+    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset
+ ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
+ ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
+__________________|____________|__________________|_________|___________________________________________________________
 
 Architecture defines a 64-bit virtual address. Implementations can support
 less. Currently supported are 48- and 57-bit virtual addresses. Bits 63
