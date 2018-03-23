Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521828377; cv=none;
        d=google.com; s=arc-20160816;
        b=Q+996TS9G3sUYfMhrnK7f3j0TCIvmbjeKkJVK2IQQLTtXM8EX/GiOXHpm3NfCvwLtD
         fG+U6amD9wWNwiVgE+PfMnUJhnhmL+5gbUb2A4sx9ma5CNCJ2ztOHsNt51FeGUm1EcKP
         UgfOPNjUkE9RJYNQC1OGbutSHpiaMq/KhijCBnN0XIXf8yuHAZ64KezKD87u+Ha81aLR
         F87hQ5AOQsi7qYMXc/mpWw+GMTznThQH+SwR17tRMxM4H/TXCXuQFqhZ17L3/hPwdKXM
         Z8NZnPutAwUOP4EdfWNPECPAvVhWBZzOa/vUfj371Viu6DLfqsfNtiTsCMTE4eFI1AMA
         aFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ZiMM6b3IAluxvTLpuPTIUl4Abp6RYYb+GC3OuYDsEf4=;
        b=AYYf0Zrzr7U6jabT4Nuxm1es7KFgj4EXt10gYskp6uh6OPoiscucfoLU+W9gtdExkM
         sNppL2uSlvqnKfSakZ5pKwMd4CfiGgr1I+YL5iFtrjI90D3SiisIIfzcBUKfGF9atx9u
         VYkuOl5pWQBMIHE+mcLWI5bYkICRrxa31S/bZ7Tx3opIKgGqMGg/grEJT4NpLhvUuvuy
         lUg1grhhJ0OpuYk+WV3BjBup8vmCp/By8MsR8EqafLPyZYAjzXPKtCdK28EZlQY3AQXU
         KcX/2pOBbFlvozu51CUfh7sv4xXPM8z2FwoMlkJrDBd5Yh16TCSmvrwPadBUoujjSq9t
         bwaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=k7fwifgG;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=k7fwifgG;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELvk9WhE5WUEMVsoqSg0h9QkUAircjB14UrBaNcb8W9MNavr6K0BZGR+BDkU3ySdQuhtOdtWJQ==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Christopher Li <sparse@chrisli.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>,
	"GitAuthor : Andrey Konovalov" <andreyknvl@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Michael Weiser <michael.weiser@gmx.de>,
	James Morse <james.morse@arm.com>,
	Julien Thierry <julien.thierry@arm.com>,
	Steve Capper <steve.capper@arm.com>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Stephen Boyd <stephen.boyd@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Paul Lawrence <paullawrence@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Kees Cook <keescook@google.com>,
	Jann Horn <jannh@google.com>,
	Mark Brand <markbrand@google.com>
Subject: [RFC PATCH v2 09/15] khwasan, kvm: untag pointers in kern_hyp_va
Date: Fri, 23 Mar 2018 19:05:45 +0100
Message-Id: <0e4b9cc6f99e2aabc8df77773c3d7e9649a6f2b7.1521828274.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752712377804881?=
X-GMAIL-MSGID: =?utf-8?q?1595752712377804881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

kern_hyp_va that converts kernel VA into a HYP VA relies on the top byte
of kernel pointers being 0xff. Untag pointers passed to it with KHWASAN
enabled.

Also fix create_hyp_mappings() and create_hyp_io_mappings(), to use the
untagged kernel pointers for address computations.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  8 ++++++++
 virt/kvm/arm/mmu.c               | 20 +++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 7faed6e48b46..5149ff83b4c4 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -97,6 +97,9 @@
  * Should be completely invisible on any viable CPU.
  */
 .macro kern_hyp_va	reg
+#ifdef CONFIG_KASAN_TAGS
+	orr	\reg, \reg, #KASAN_PTR_TAG_MASK
+#endif
 alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
 	and     \reg, \reg, #HYP_PAGE_OFFSET_HIGH_MASK
 alternative_else_nop_endif
@@ -115,6 +118,11 @@ alternative_else_nop_endif
 
 static inline unsigned long __kern_hyp_va(unsigned long v)
 {
+#ifdef CONFIG_KASAN_TAGS
+	asm volatile("orr %0, %0, %1"
+		     : "+r" (v)
+		     : "i" (KASAN_PTR_TAG_MASK));
+#endif
 	asm volatile(ALTERNATIVE("and %0, %0, %1",
 				 "nop",
 				 ARM64_HAS_VIRT_HOST_EXTN)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index b960acdd0c05..3dba9b60e0a0 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/hugetlb.h>
 #include <linux/sched/signal.h>
+#include <linux/kasan.h>
 #include <trace/events/kvm.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
@@ -683,9 +684,13 @@ static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
 int create_hyp_mappings(void *from, void *to, pgprot_t prot)
 {
 	phys_addr_t phys_addr;
-	unsigned long virt_addr;
-	unsigned long start = kern_hyp_va((unsigned long)from);
-	unsigned long end = kern_hyp_va((unsigned long)to);
+	unsigned long virt_addr, start, end;
+
+	from = khwasan_reset_tag(from);
+	to = khwasan_reset_tag(to);
+
+	start = kern_hyp_va((unsigned long)from);
+	end = kern_hyp_va((unsigned long)to);
 
 	if (is_kernel_in_hyp_mode())
 		return 0;
@@ -719,8 +724,13 @@ int create_hyp_mappings(void *from, void *to, pgprot_t prot)
  */
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t phys_addr)
 {
-	unsigned long start = kern_hyp_va((unsigned long)from);
-	unsigned long end = kern_hyp_va((unsigned long)to);
+	unsigned long start, end;
+
+	from = khwasan_reset_tag(from);
+	to = khwasan_reset_tag(to);
+
+	start = kern_hyp_va((unsigned long)from);
+	end = kern_hyp_va((unsigned long)to);
 
 	if (is_kernel_in_hyp_mode())
 		return 0;
-- 
2.17.0.rc0.231.g781580f067-goog
