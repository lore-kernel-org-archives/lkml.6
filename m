Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521828378; cv=none;
        d=google.com; s=arc-20160816;
        b=bjthdQRLmksAjhtwUpOUVTGBB0Fug9bmN9gRhFGvD22NTs+SGus+tyTUqkSkKrCUL0
         8hI6rFvn705k+e84G2C/nmh/bbZ9orXp5KrhlsM/mYW2YOXf4CS73AaFAoLjmDi5AaIW
         tR3wSVqNPw/1UZWo4QgNHasoCVPepuIiOeLD/APZYdFhX0mUJatLpaWMjqGPwiw2kgOZ
         3H7t4tFCzU61e9mqGXfhO+UnJsFq4lkxPypd9+xPZ0siUiO3whReh7cQH3qkoWLLR67H
         vaz85BZG8lV0MS0K+6Hf0CZ7cvjNV094LeuG3h+l2LC2iKwH4l8mYimjCgfnWe2/LYLj
         wUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=h7UAM4u0ltxxy6L178zyCoaH+JXfuyTZuKiCHYRMeXU=;
        b=waAxpVsrqv43odkId6FRqpfRjQvVVAzC8jujAM8UpOXFARFaZJx2sf+Ro1B1UDEa/J
         spgIWcaN16Vl4xH4WWP2EcvaWMDd1xECaihJWHYTvX44zkPrFSm3jjiQvy5qV8nRu1l8
         j+jZoGVCgExuDyGKhuNfnEZI4UbAnhFij/jjGkNxrWwDdWiSN/za0Z9SkqigHb5C64oI
         332K7aRCqeO6Um3GQGxyS4k1NEsKeqrro4ZZScmhzngg4hlU9Mme9KDT4aD5JgiVyVr+
         voPNePl99uWE1zWBJEeGnlpsaVLPPzuF1vOKseJonPdQuOM0cwEwTtcfttu8K/FImrDE
         fUrw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Fs4ONDnJ;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Fs4ONDnJ;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELsuAzh6p7g7ra2+h+UClcAzKG/37YUeQ/5K9N+hkqo0hMa6Hv2Ylc89BIENdayTIbOX5w6V0Q==
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
Subject: [RFC PATCH v2 10/15] khwasan, arm64: enable top byte ignore for the kernel
Date: Fri, 23 Mar 2018 19:05:46 +0100
Message-Id: <1dcf5f0ef52a08581f453e05101cd2193575249c.1521828274.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752713986341704?=
X-GMAIL-MSGID: =?utf-8?q?1595752713986341704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

KHWASAN uses the Top Byte Ignore feature of arm64 CPUs to store a pointer
tag in the top byte of each pointer. This commit enables the TCR_TBI1 bit,
which enables Top Byte Ignore for the kernel, when KHWASAN is used.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/mm/proc.S                   | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index cdfe3e657a9e..ae6b6405eacc 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -289,6 +289,7 @@
 #define TCR_A1			(UL(1) << 22)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
+#define TCR_TBI1		(UL(1) << 38)
 #define TCR_HA			(UL(1) << 39)
 #define TCR_HD			(UL(1) << 40)
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c0af47617299..d64ce2ea40ec 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -41,6 +41,12 @@
 /* PTWs cacheable, inner/outer WBWA */
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
+#ifdef CONFIG_KASAN_TAGS
+#define KASAN_TCR_FLAGS TCR_TBI1
+#else
+#define KASAN_TCR_FLAGS 0
+#endif
+
 #define MAIR(attr, mt)	((attr) << ((mt) * 8))
 
 /*
@@ -432,7 +438,8 @@ ENTRY(__cpu_setup)
 	 * both user and kernel.
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
-			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0 | TCR_A1
+			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0 | TCR_A1 | \
+			KASAN_TCR_FLAGS
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
-- 
2.17.0.rc0.231.g781580f067-goog
