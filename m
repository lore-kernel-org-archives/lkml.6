Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4FDC65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C39206B2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+3DpRRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C39206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeJFT0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 15:26:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38284 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeJFT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 15:26:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id a13-v6so16074974wrt.5;
        Sat, 06 Oct 2018 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iWMex/fU6Z2PRjwPc2xzrYX5NUfPUVzqj+ccd3ejQLk=;
        b=X+3DpRRjegu2t5JRojolVJHHbvmzHJ89hQer/8IzF3qSkyrV4PZwPn5Se5NnbLCJSm
         RKlwP3xb47fsXPb61Zem5CFVQPzu0KjUsksogSIihlwtTUc8Mtp4Hp2crq8uYEvlAMgk
         5HJSuWN+ys47+mj7ZHCTjZl4Xt07Qc36At7p7dbr4ILoWngcyLyNxDdGwFz08bWbaU+n
         50354Y8wZPwFdwzgTqHAlnJuYLlK5ZNHRPNCfa9k6ofF+QMO1ReKukr2I/YHTvNQ2BTT
         ODhzbJitHHMMqs4NEl2BJJ7ROCkQanGUHW8A/yCFmr+/7REDGH9naEqewQiM4KSlKjsG
         WFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iWMex/fU6Z2PRjwPc2xzrYX5NUfPUVzqj+ccd3ejQLk=;
        b=HvMCCZxa0IjDhxoAtY7pTmLVQ0Rnu1ZTHqOiSHwPmUrmWJIc9sT5Ol07/KJi0fbnvt
         Dv7mI/yQlM2gXd+crGOFfMD70qPGZBUDe6EiO/bo1qfNF6pYpxPt/EBRqTPRWdDHG77X
         8EfJdRAeYPjOYXInmtmAnc+aVX+oe6cCpUxMKE9BuFXx6xgmB//lvuL8X9wWM3Fn8hCA
         IcDxRfcFVqC0xsuJzS05x3NYiEKHJwzAtSxzT6rjg1Op+1NwLktUHS2t0yGjUvzsCbOf
         w/uAiEuzojJH+mnqEjj5oEHXLtsxhyFL1t6keF3XJZx2r6aC5iYUxm0990bD8Aae13GE
         qwiQ==
X-Gm-Message-State: ABuFfohT6lOAdv3otI5a+ez7N/OaMZuOoEv1fW1juSfI20Q2nKszFMup
        /AB3ERLGT5NngqfR/nleLbE=
X-Google-Smtp-Source: ACcGV61Tv/qBrputObWO5vnhCCDgLbrgOCsKVOacgwmn99fnsIx/me0uVT02bLzxm6QTMWTRuzRwKQ==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr11555469wrx.146.1538828582497;
        Sat, 06 Oct 2018 05:23:02 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q200-v6sm7103587wmd.2.2018.10.06.05.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 05:23:01 -0700 (PDT)
Date:   Sat, 6 Oct 2018 14:22:59 +0200
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
Subject: [PATCH 4/3] x86/mm/doc: Enhance the x86-64 virtual memory layout
 descriptions
Message-ID: <20181006122259.GB418@gmail.com>
References: <20181006084327.27467-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006084327.27467-1-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 Documentation/x86/x86_64/mm.txt |  172 ++++++++++++++++++++++++++++------------
 kernel/sched/core.c             |    6 +
 2 files changed, 128 insertions(+), 50 deletions(-)

Index: tip/Documentation/x86/x86_64/mm.txt
===================================================================
--- tip.orig/Documentation/x86/x86_64/mm.txt
+++ tip/Documentation/x86/x86_64/mm.txt
@@ -1,55 +1,127 @@
 
-Virtual memory map with 4 level page tables:
+========================================================
+| Complete virtual memory map with 4-level page tables |
+========================================================
 
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
+--------------------------------------------------------------------------------
+start addr       | offset     | end addr         |  size   | VM area description
+-----------------|------------|------------------|---------|--------------------
+0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm
+                                                           |
+0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
+                                                                 virtual memory addresses up to the -128 TB
+                                                                 starting offset of kernel mappings.
+                                                           |
+                                                           |----------------------------------------------------
+                                                           | kernel-space virtual memory, shared between all processes:
+                                                           |
+ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
+ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapping of all physical memory (page_offset_base),
+                                                             this is what limits max physical memory supported.
+ffffc80000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused hole
+ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
+ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
+ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
+ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole
+ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
+fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
+                                                             vaddr_end for KASLR
+
+fffffe0000000000 |   -2    TB | fffffe7fffffffff |  512 GB | cpu_entry_area mapping
+fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  512 GB | LDT remap for PTI
+ffffff0000000000 |   -1    TB | ffffff7fffffffff |  512 GB | %esp fixup stacks
+
+# Identical layout to the 56-bit one from here on:
+
+ffffff8000000000 | -512    GB | fffffffeefffffff | ~507 GB | ... unused hole
+ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
+ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
+ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
+ffffffff80000000 |-2048    MB
+
+ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
+ffffffffff000000 |  -16    MB
+
+   FIXADDR_START | ~-11    MB | ffffffffff5fffff |         | kernel-internal fixmap range with variable size,
+                                                             typical size is around ~0.5 MB
+
+ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
+ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
+----------------------------------------------------------------------------
+
+
+========================================================
+| Complete virtual memory map with 5-level page tables |
+========================================================
+
+Notes:
+
+ - With 56-bit addresses, user-space memory gets expanded by a factor of 512x,
+   from 0.125 PB to 64 PB. All kernel mappings shift down to the -64 PT starting
+   offset and many of the regions expand to support the much larger physical
+   memory supported.
+
+--------------------------------------------------------------------------------
+start addr       | offset     | end addr         |  size   | VM area description
+-----------------|------------|------------------|---------|--------------------
+0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm
+                                                           |
+0000800000000000 |  +64    PB | ffff7fffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
+                                                                 virtual memory addresses up to the -128 TB
+                                                                 starting offset of kernel mappings.
+                                                           |
+                                                           |----------------------------------------------------
+                                                           | kernel-space virtual memory, shared between all processes:
+                                                           |
+ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor
+ff10000000000000 |  -60    PB | ff8fffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base),
+                                                             this is what limits max physical memory supported.
+ff90000000000000 |  -28    PB | ff9fffffffffffff |    4 PB | LDT remap for PTI
+ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)
+ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
+ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
+ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
+ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory
+fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
+                                                             vaddr_end for KASLR
+
+fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
+fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
+ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
+ffffff8000000000 |   -0.5  TB | ffffffeeffffffff |  444 GB | ... unused hole
+
+# Identical layout to the 47-bit one from here on:
+
+ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
+ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
+ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
+ffffffff80000000 |-2048    MB
+
+ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
+ffffffffff000000 |  -16    MB
+
+   FIXADDR_START | ~-11    MB | ffffffffff5fffff |         | kernel-internal fixmap range with variable size,
+                                                             typical size is around ~0.5 MB
+
+ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
+ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
+----------------------------------------------------------------------------
 
 Architecture defines a 64-bit virtual address. Implementations can support
 less. Currently supported are 48- and 57-bit virtual addresses. Bits 63

