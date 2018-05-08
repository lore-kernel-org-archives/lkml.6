Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525800078; cv=none;
        d=google.com; s=arc-20160816;
        b=Zl1yxTLHaLz9474V3ieP2glh2G6YaMVNfZ3Sn+/GHSdShn89K3opvmc3Q54jeQZUEP
         SS3cmO7HtUrFeDCsNucTmYxjBjifGPisv1wuDzjdSaahaPMU2UQgNGWPYs0Y/GVtg+XY
         91aCplqQ0tymaKiRwg/6uPJVL6g83yOXNsQD5yqcjqLQ0HSGcseriXMh+T0yYUx8SQcH
         fXrEjmqYB/U5HxejT16IHkSflVb9WGQOaV4UHXr2V6XBECG6LWaQTfUw3ISYjcF8lLQ/
         crE1g3Hjhk0ubjavqTgs07/HZCv0NpQqWV+w34CQcqA/y35PGs8hAi+uBn23UCt46EUL
         rzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=nG9MjoijhhOHYsuAcrJlXTo6xE/CO1spvQUB9l7KgZ8=;
        b=tSVpqH8I496XzOSz83l2RfLTt4hqn8mspZycm93RNZO8mjfPvPTrq5XmEr/e1XtzJk
         yq62wOIPUIe5T0zs/tSt2KxsEIhSNZ2APpIM9ZXmKXYeWelb7rTiDzrWwTu12AtnzWwV
         BWXGn8iZLeUs2MP2nTS9A1tRKA9nxqxeeKfatdxusKtfcnSiTuL9mQWO66hjbaKFFsFY
         YzKymhjrTKOojedYRRm+ld4BrLoNkPBYlzRB8lEBq0Yx9eFtsqVGoZ7NPU+6KjMt6Wz6
         fUE5T2HSOc0imwQKk57c5IdZnw4xce8Zq4FZiWPGuhTHCpWUDovgl1+BwIVZpkLV6dtv
         LKfA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Owu32bhJ;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Owu32bhJ;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZrJU/QKo3xy/3TYI8JfPerBgokBVFF7GdMQY9+WQLmZh61xobD0PC1Cgwkk+tMTC3ql4z1KBQ==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Christopher Li <sparse@chrisli.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>,
	Andrey Konovalov <andreyknvl@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <dave.martin@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	James Morse <james.morse@arm.com>,
	Michael Weiser <michael.weiser@gmx.de>,
	Julien Thierry <julien.thierry@arm.com>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paul Lawrence <paullawrence@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Souptick Joarder <jrdr.linux@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Laura Abbott <labbott@redhat.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pintu Agarwal <pintu.ping@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Anshuman Khandual <khandual@linux.vnet.ibm.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
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
	Mark Brand <markbrand@google.com>,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v1 04/16] khwasan, arm64: adjust shadow size for CONFIG_KASAN_HW
Date: Tue,  8 May 2018 19:20:50 +0200
Message-Id: <3dc2407877072a1f14154928a7ba542b4f5a9c05.1525798754.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525798753.git.andreyknvl@google.com>
References: <cover.1525798753.git.andreyknvl@google.com>
In-Reply-To: <cover.1525798753.git.andreyknvl@google.com>
References: <cover.1525798753.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917342862871242?=
X-GMAIL-MSGID: =?utf-8?q?1599917342862871242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

KWHASAN uses 1 shadow byte for 16 bytes of kernel memory, so it requires
1/16th of the kernel virtual address space for the shadow memory.

This commit sets KASAN_SHADOW_SCALE_SHIFT to 4 when KHWASAN is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Makefile             |  2 +-
 arch/arm64/include/asm/memory.h | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 87f7d2f9f17c..99c9649c57b1 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -99,7 +99,7 @@ endif
 # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
 # in 32-bit arithmetic
-KASAN_SHADOW_SCALE_SHIFT := 3
+KASAN_SHADOW_SCALE_SHIFT := $(if $(CONFIG_KASAN_HW), 4, 3)
 KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
 	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
 	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 49d99214f43c..6d084431b7f7 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -74,12 +74,17 @@
 #define KERNEL_END        _end
 
 /*
- * KASAN requires 1/8th of the kernel virtual address space for the shadow
- * region. KASAN can bloat the stack significantly, so double the (minimum)
- * stack size when KASAN is in use.
+ * KASAN and KHWASAN require 1/8th and 1/16th of the kernel virtual address
+ * space for the shadow region respectively. They can bloat the stack
+ * significantly, so double the (minimum) stack size when they are in use.
  */
-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_GENERIC
 #define KASAN_SHADOW_SCALE_SHIFT 3
+#endif
+#ifdef CONFIG_KASAN_HW
+#define KASAN_SHADOW_SCALE_SHIFT 4
+#endif
+#ifdef CONFIG_KASAN
 #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #define KASAN_THREAD_SHIFT	1
 #else
-- 
2.17.0.441.gb46fe60e1d-goog
