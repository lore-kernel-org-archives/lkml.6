Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524235628; cv=none;
        d=google.com; s=arc-20160816;
        b=uV2gbWGL+HIu9yd2YSKiPLubxujORuiHHpWO3DuywC5tSRJ6ZxK/VF9qTnFoXrF3FE
         vV2i01cZqkOzavaGwUwr1T8hzipB5FQwAUbXOxSfoDrIe7ILvfGxDfcehYDaikS24DE7
         zX2LR+fdKhjKSxMKsI2scImSsE2KDg/yfxp9YBhAmpBxFI7DLAfyPy7mfdw96U9B40mE
         hzXJ6g3Ea0xhYnuhWJPAJFJGzIV/yp4bBiDqt6Lr9/E10IgPpzuQzVkb6/IVPaoUrEqc
         WaYcErnGyBEI5lpJOFmuCF6Hldbk4BLnAFJmIJr9REkgET6a6jMYYh4YEUyEI191c35Q
         7mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=PLGai3QDUPqCGJ1KlHeKqpQ2ua2JrjDqw97J4/zXzP4=;
        b=nPRnGHG4GHQj0zVsuQuFhSdoy/2pFY8aDDqXo3sYR3wjjNuaJ2AGbf7Kvb0e7zEm36
         0kGUUxXQwbpQ8WYOA+1edcHksNGJPIr3/j5QzWsUnG2SsO2iLmc5XcxxVQySDp02+48M
         xloJ7y9iF5Rm8i3MtLgQzT1SAhh7jEeIqpUz8kcKMKeiWlXKddqJvMJwW6n4KY6SmMtK
         56zXk1HoJgkS2xQwXg39F+HhB0DuBxwi7Xg90hmoDobp/CI6uFLAPYJ5KlTUaPI0okYi
         3XQ3rCy0ORSx0iUFJQ6d5eNe47+A+59Xbkk6xsxu4KdXTbygEDlGXhvNV8dPWrtziElI
         Ym6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DPQgA+jH;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DPQgA+jH;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/fHSXE61OAZLy3b3ZXypHWfop6wb21e4FDzU+YpiZYQwYxo1ofAmhZpJg+F5mYvVLnKqIICw==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
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
Subject: [RFC PATCH v3 05/15] khwasan, arm64: untag virt address in __kimg_to_phys
Date: Fri, 20 Apr 2018 16:46:43 +0200
Message-Id: <6f8133fa9e0c4adb15bb36a540cd7f923d000f3c.1524235387.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <cover.1524235387.git.andreyknvl@google.com>
References: <cover.1524235387.git.andreyknvl@google.com>
In-Reply-To: <cover.1524235387.git.andreyknvl@google.com>
References: <cover.1524235387.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598276898526264936?=
X-GMAIL-MSGID: =?utf-8?q?1598276898526264936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

__kimg_to_phys (which is used by virt_to_phys) assumes that the top byte
of the address is 0xff, which isn't always the case with KHWASAN enabled.
The solution is to reset the tag in __kimg_to_phys.

__lm_to_phys doesn't require any fixups, as it zeroes out the top byte
with the current implementation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 6d084431b7f7..f206273469b5 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -92,6 +92,12 @@
 #define KASAN_THREAD_SHIFT	0
 #endif
 
+#ifdef CONFIG_KASAN_HW
+#define KASAN_TAG_SHIFTED(tag)		((unsigned long)(tag) << 56)
+#define KASAN_SET_TAG(addr, tag)	(((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
+						KASAN_TAG_SHIFTED(tag))
+#endif
+
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
 
 /*
@@ -225,7 +231,12 @@ static inline unsigned long kaslr_offset(void)
 #define __is_lm_address(addr)	(!!((addr) & BIT(VA_BITS - 1)))
 
 #define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
+
+#ifdef CONFIG_KASAN_HW
+#define __kimg_to_phys(addr)	(KASAN_SET_TAG((addr), 0xff) - kimage_voffset)
+#else
 #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
+#endif
 
 #define __virt_to_phys_nodebug(x) ({					\
 	phys_addr_t __x = (phys_addr_t)(x);				\
-- 
2.17.0.484.g0c8726318c-goog
