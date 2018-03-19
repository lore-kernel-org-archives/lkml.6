Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521484206; cv=none;
        d=google.com; s=arc-20160816;
        b=Dfwfb3a85wHLTJbQrm9VvBKlIyA/lOFylY2opvrkpvEikgckuTrFgkveOcOm1OThTu
         cTPs7H+syXknlRSrm9mUm/1tnUoQIgCSBCk7qSR2iBLiYEVySssaOyTny7AfJFbOMsI7
         m5JRI3/0pRAGNRvq1P32KYIrxoInx0/5NZu5pEwD63nnrsy7PbcJGUukEJHuGSca3BC5
         iS4F8j0IJcieywI5lXUD1sgRd6ggvVqOlxgehJSyPG+Xnt9AFH35DPh9XG0ncADLU9vz
         aIs30fNg6IJOx/g7nYZ50xFPWq8ODn+4kbRB1qLUZ+qYb1Bb1weeW6jk5nzLDrOjW12Q
         apLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=tr8ysEBRO3Lv5JhQA9o3HfcntMweOhgB8TPOE9ONj5c=;
        b=J3Uf3AlmqhA/ehXTBQqKlcmtoU54NeJ2g88ExnVDoe8FFiHRrddP0o8pHkNH4LI927
         QOEuGUkj8wJvJp04CihIHpdZnUUNneCVTEq7IVNNxebbgGbgmjnXVeimb8/LJEpo3Rz5
         SBzM6Q58QQFNpCa9DeUpQOBPVZfQRogUXe3TkAREi5hj6e5gxC9wLWYGSz8NtgCUCoKd
         0Z6+bJjP0Bvkev+1VsTkkn10V6aG6XYcb9xSr+ABal4C4r7kW1pdVqFUQZj+2eFKkbK7
         Q4bDBSHosrc57wv/ShNz71Eh6hLGJ8mBTmX8N+4nYPYBdodkl7QVUgSG+smvePEFvCxc
         DP5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GFewDhXw;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GFewDhXw;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu0lwYhrAW6h1aRjpMbM/tLoNxAa1iRLawYrtho9RvHLkY/qsO8PBcRss3AqyMM3nB08rT8EA==
Subject: Re: [PATCH v2 0/7] KASan for arm
To: Abbott Liu <liuwenliang@huawei.com>, linux@armlinux.org.uk,
 aryabinin@virtuozzo.com, marc.zyngier@arm.com, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 afzal.mohd.ma@gmail.com, alexander.levin@verizon.com
Cc: glider@google.com, dvyukov@google.com, christoffer.dall@linaro.org,
 linux@rasmusvillemoes.dk, mawilcox@microsoft.com, pombredanne@nexb.com,
 ard.biesheuvel@linaro.org, vladimir.murzin@arm.com,
 nicolas.pitre@linaro.org, tglx@linutronix.de, thgarnie@google.com,
 dhowells@redhat.com, keescook@chromium.org, arnd@arndb.de,
 geert@linux-m68k.org, tixy@linaro.org, mark.rutland@arm.com,
 james.morse@arm.com, zhichao.huang@linaro.org, jinb.park7@gmail.com,
 labbott@redhat.com, philip@cog.systems, grygorii.strashko@linaro.org,
 catalin.marinas@arm.com, opendmb@gmail.com, kirill.shutemov@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org
References: <20180318125342.4278-1-liuwenliang@huawei.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d55fbd7f-3441-61b0-9169-841aefdc8021@gmail.com>
Date: Mon, 19 Mar 2018 11:29:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318125342.4278-1-liuwenliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281327886471398?=
X-GMAIL-MSGID: =?utf-8?q?1595391823364486294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/18/2018 05:53 AM, Abbott Liu wrote:
> Changelog:
> v2 - v1
> - Fixed some compiling error which happens on changing kernel compression
>   mode to lzma/xz/lzo/lz4.
>   ---Reported by: Florian Fainelli <f.fainelli@gmail.com>,
> 	     Russell King - ARM Linux <linux@armlinux.org.uk>
> - Fixed a compiling error cause by some older arm instruction set(armv4t)
>   don't suppory movw/movt which is reported by kbuild.
> - Changed the pte flag from _L_PTE_DEFAULT | L_PTE_DIRTY | L_PTE_XN to
>   pgprot_val(PAGE_KERNEL).
>   ---Reported by: Russell King - ARM Linux <linux@armlinux.org.uk>
> - Moved Enable KASan patch as the last one.
>   ---Reported by: Florian Fainelli <f.fainelli@gmail.com>,
>      Russell King - ARM Linux <linux@armlinux.org.uk>
> - Moved the definitions of cp15 registers from 
>   arch/arm/include/asm/kvm_hyp.h to arch/arm/include/asm/cp15.h.
>   ---Asked by: Mark Rutland <mark.rutland@arm.com>
> - Merge the following commits into the commit
>   Define the virtual space of KASan's shadow region:
>   1) Define the virtual space of KASan's shadow region;
>   2) Avoid cleaning the KASan shadow area's mapping table;
>   3) Add KASan layout;
> - Merge the following commits into the commit
>   Initialize the mapping of KASan shadow memory:
>   1) Initialize the mapping of KASan shadow memory;
>   2) Add support arm LPAE;
>   3) Don't need to map the shadow of KASan's shadow memory;
>      ---Reported by: Russell King - ARM Linux <linux@armlinux.org.uk>
>   4) Change mapping of kasan_zero_page int readonly.
> 
> Hi,all:
>    These patches add arch specific code for kernel address sanitizer
> (see Documentation/kasan.txt).
> 
>    1/8 of kernel addresses reserved for shadow memory. There was no
> big enough hole for this, so virtual addresses for shadow were
> stolen from user space.
> 
>    At early boot stage the whole shadow region populated with just
> one physical page (kasan_zero_page). Later, this page reused
> as readonly zero shadow for some memory that KASan currently
> don't track (vmalloc).
> 
>   After mapping the physical memory, pages for shadow memory are
> allocated and mapped.
>   
>   KASan's stack instrumentation significantly increases stack's
> consumption, so CONFIG_KASAN doubles THREAD_SIZE.
> 
>   Functions like memset/memmove/memcpy do a lot of memory accesses.
> If bad pointer passed to one of these function it is important
> to catch this. Compiler's instrumentation cannot do this since
> these functions are written in assembly.
> 
>   KASan replaces memory functions with manually instrumented variants.
> Original functions declared as weak symbols so strong definitions
> in mm/kasan/kasan.c could replace them. Original functions have aliases
> with '__' prefix in name, so we could call non-instrumented variant
> if needed.
> 
>   Some files built without kasan instrumentation (e.g. mm/slub.c).
> Original mem* function replaced (via #define) with prefixed variants
> to disable memory access checks for such files.
> 
>   On arm LPAE architecture,  the mapping table of KASan shadow memory(if
> PAGE_OFFSET is 0xc0000000, the KASan shadow memory's virtual space is
> 0xb6e000000~0xbf000000) can't be filled in do_translation_fault function,
> because kasan instrumentation maybe cause do_translation_fault function
> accessing KASan shadow memory. The accessing of KASan shadow memory in
> do_translation_fault function maybe cause dead circle. So the mapping table
> of KASan shadow memory need be copyed in pgd_alloc function.
> 
> 
> Most of the code comes from:
> https://github.com/aryabinin/linux/commit/0b54f17e70ff50a902c4af05bb92716eb95acefe
> 
> These patches are tested on vexpress-ca15, vexpress-ca9

BTW, it looks like you have some section mismatches:

WARNING: vmlinux.o(.meminit.text+0x40): Section mismatch in reference
from the function kasan_pte_populate() to the function
.init.text:kasan_alloc_block.constprop.5()
The function __meminit kasan_pte_populate() references
a function __init kasan_alloc_block.constprop.5().
If kasan_alloc_block.constprop.5 is only used by kasan_pte_populate then
annotate kasan_alloc_block.constprop.5 with a matching annotation.

WARNING: vmlinux.o(.meminit.text+0x144): Section mismatch in reference
from the function kasan_pmd_populate() to the function
.init.text:kasan_alloc_block.constprop.5()
The function __meminit kasan_pmd_populate() references
a function __init kasan_alloc_block.constprop.5().
If kasan_alloc_block.constprop.5 is only used by kasan_pmd_populate then
annotate kasan_alloc_block.constprop.5 with a matching annotation.

WARNING: vmlinux.o(.meminit.text+0x1a4): Section mismatch in reference
from the function kasan_pud_populate() to the function
.init.text:kasan_alloc_block.constprop.5()
The function __meminit kasan_pud_populate() references
a function __init kasan_alloc_block.constprop.5().
If kasan_alloc_block.constprop.5 is only used by kasan_pud_populate then
annotate kasan_alloc_block.constprop.5 with a matching annotation.


> 
> 
> 
> Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
> Tested-by: Abbott Liu <liuwenliang@huawei.com>
> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
> 
> Abbott Liu (3):
>   2 1-byte checks more safer for memory_is_poisoned_16
>   Add TTBR operator for kasan_init
>   Define the virtual space of KASan's shadow region
> 
> Andrey Ryabinin (4):
>   Disable instrumentation for some code
>   Replace memory function for kasan
>   Initialize the mapping of KASan shadow memory
>   Enable KASan for arm
> 
>  arch/arm/Kconfig                      |   1 +
>  arch/arm/boot/compressed/Makefile     |   1 +
>  arch/arm/boot/compressed/decompress.c |   2 +
>  arch/arm/boot/compressed/libfdt_env.h |   2 +
>  arch/arm/include/asm/cp15.h           | 104 ++++++++++++
>  arch/arm/include/asm/kasan.h          |  23 +++
>  arch/arm/include/asm/kasan_def.h      |  52 ++++++
>  arch/arm/include/asm/kvm_hyp.h        |  52 ------
>  arch/arm/include/asm/memory.h         |   5 +
>  arch/arm/include/asm/pgalloc.h        |   7 +-
>  arch/arm/include/asm/string.h         |  17 ++
>  arch/arm/include/asm/thread_info.h    |   4 +
>  arch/arm/kernel/entry-armv.S          |   5 +-
>  arch/arm/kernel/entry-common.S        |   6 +-
>  arch/arm/kernel/head-common.S         |   7 +-
>  arch/arm/kernel/setup.c               |   2 +
>  arch/arm/kernel/unwind.c              |   3 +-
>  arch/arm/kvm/hyp/cp15-sr.c            |  12 +-
>  arch/arm/kvm/hyp/switch.c             |   6 +-
>  arch/arm/lib/memcpy.S                 |   3 +
>  arch/arm/lib/memmove.S                |   5 +-
>  arch/arm/lib/memset.S                 |   3 +
>  arch/arm/mm/Makefile                  |   3 +
>  arch/arm/mm/init.c                    |   6 +
>  arch/arm/mm/kasan_init.c              | 290 ++++++++++++++++++++++++++++++++++
>  arch/arm/mm/mmu.c                     |   7 +-
>  arch/arm/mm/pgd.c                     |  14 ++
>  arch/arm/vdso/Makefile                |   2 +
>  mm/kasan/kasan.c                      |  24 ++-
>  29 files changed, 588 insertions(+), 80 deletions(-)
>  create mode 100644 arch/arm/include/asm/kasan.h
>  create mode 100644 arch/arm/include/asm/kasan_def.h
>  create mode 100644 arch/arm/mm/kasan_init.c
> 


-- 
Florian
