Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521828371; cv=none;
        d=google.com; s=arc-20160816;
        b=Sjf7r4c0/NRWH8OFuPkGoLhVpQncGlKWqKOSOFFGurIrXtq4kN+OYs32iTDNY+2InS
         SHib5OAlmYRJrT72afb4oU/7VArff1IJ8X23H8eycZak8ppUeTp2tJTFjNVte1/onuOL
         rhD45hxCRktDRMn0wUx7Ylu57T7V7Xna/0hD7hf3HPLmn0ja/3KVPi9nyo/mfOTnwnG8
         2Sz0yOe7WcN7HBuaN5BVNh+8BLmBKmFzaHBsVyGoZo9qo7vfn9RZeY6fD8+tyJrm43dV
         VkWzj6Iokbcd3UCyLiMh7Jn+ZwGGeYDfoW5wSzxHnE1Kapx+OT7AuHAJtD5nHQImakI3
         zMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ZqyK3M6d8G1iLL6ihHv3V278/cE4UIR/+6hH/+0b1fg=;
        b=leh0VnM0Y5avc4synEhYnBgmyf1WU9/JzImfxsl7vp9OCqGR6StPBAZkIuES2nJan9
         5aTU7mVRxM/I6x+Oo/5Ge3jiPHhhDzqTUSCGsM5f6gpS9UWEYzmlVtA8y/51Oc104BCa
         GvOIiqHAD/u0uqrxKYQNkWPv/y6s7CMNjhewmVbIBtIMC8luYaTC+7F50U68Fg534bZq
         W38cwSUjzs0PTIwG7IPAVPZKX0QsophyTZeZpRkdRno4oBLdClk8gLD42zcAK5oY0KDL
         O6N4Syu2FbpvJ1vzcByCMb9mgcJnwSE9yMOsmdiEB6a5NScs8wE307S40EL4aYe+2yz3
         M5Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QlYD5Z/V;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QlYD5Z/V;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELs1rhttWLCIc7fmS8q6Ex/DFVcWm+Gi+20xcvm4ssmpCRg+CUseKNlzfi9iZYM/bjtY1lK2Cw==
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
Subject: [RFC PATCH v2 06/15] khwasan, arm64: untag virt address in __kimg_to_phys
Date: Fri, 23 Mar 2018 19:05:42 +0100
Message-Id: <81963b1be20e0d661aa626d18d245be653bdc150.1521828274.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752706157567518?=
X-GMAIL-MSGID: =?utf-8?q?1595752706157567518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

__kimg_to_phys (which is used by virt_to_phys) assumes that the top byte
of the address is 0xff, which isn't always the case with KHWASAN enabled.
The solution is to reset the tag in __kimg_to_phys.

__lm_to_phys doesn't require any fixups, as it zeroes out the top byte
with the current implementation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index febd54ff3354..c13b89257352 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -98,6 +98,10 @@
 #define KASAN_THREAD_SHIFT	0
 #endif
 
+#ifdef CONFIG_KASAN_TAGS
+#define KASAN_PTR_TAG_MASK	(UL(0xff) << 56)
+#endif
+
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
 
 /*
@@ -231,7 +235,12 @@ static inline unsigned long kaslr_offset(void)
 #define __is_lm_address(addr)	(!!((addr) & BIT(VA_BITS - 1)))
 
 #define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
+
+#ifdef CONFIG_KASAN_TAGS
+#define __kimg_to_phys(addr)	(((addr) | KASAN_PTR_TAG_MASK) - kimage_voffset)
+#else
 #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
+#endif
 
 #define __virt_to_phys_nodebug(x) ({					\
 	phys_addr_t __x = (phys_addr_t)(x);				\
-- 
2.17.0.rc0.231.g781580f067-goog
