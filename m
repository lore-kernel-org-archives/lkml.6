Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521828375; cv=none;
        d=google.com; s=arc-20160816;
        b=Opmn/AJZ+6q65ZikJg2FNrcv9Hbt1MMQ4QPQ0ZKcsNI5+lh4TmaOQuVCTWhza7LAod
         7PS0LB8XpLR1RX7YoqbIxsfD6WZXxffLUH8RJowCsh/rwVpGSGx1lvK5K6YZyTq5q8DE
         L8+jnw+TZt3p/1kdKeieW3U4q4FCRdR9qbSoIROqtmX0mRlUHwzonPUAuHFHROGwrGFh
         SqSIo67rOZq5IW3zrW3dzKqeMuREcrtv2Ma3sEfdFwun9KRIwoE3mwQHMHroGvSiRBQT
         htSxaN6PZy1vzFeZBoSIyVNwJqYdnRv35PP8Mn9fO95v2ApCBGs5qzHx9UHoXPzP3pT8
         3ESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:references:in-reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6BtXobja4fQHYXJlMw3HciOwemLQXCiE51lWpka8YKY=;
        b=yj6+iNsWiUxkvPwFiAuocQz93NS+6HLVgl0nRD/IPqsI/5BGKmBajfBRPBhBs57uHh
         j74zEKnggC1xlbuYzk8isAsm2tYWC82C2KiMBEYUW9DZraooVgTxSiIuY48I0/ggVEIR
         CPPrby5Qxl4Uh0Slyx5pbI48arSF3x0WtbhO8TuMRQNSQXgYAEsZXAjpqLxQLeaZGekb
         8+FkznRYGn4NEIUP73bUCfrYxGm6rRl8Mo7kqL07ASsvy/6Cl74TKOlIAwCWSXF3rcVZ
         /eRYkzCKv//SDMjY0rJtNOS/xlRIbWwmoOPhlooxxAOxSb2lfpLP2nssuP5/Xji1qFyQ
         Sx+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=veEqWfVI;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=veEqWfVI;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELsm7UrETsMAA87WtiKHZXl4D1kRzAKWyp/go34vzeYu8eYyt3tukD/8x+mD1tGKMXVz8yU8CQ==
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
Subject: [RFC PATCH v2 08/15] khwasan: add tag related helper functions
Date: Fri, 23 Mar 2018 19:05:44 +0100
Message-Id: <b79947167d09478d3f61d2ec8de37322c0e1fe92.1521828274.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
MIME-Version: 1.0
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752710383893280?=
X-GMAIL-MSGID: =?utf-8?q?1595752710383893280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a few helper functions, that are meant to be used to
work with tags embedded in the top byte of kernel pointers: to set, to
get or to reset (set to 0xff) the top byte.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/kasan_init.c |  2 ++
 include/linux/kasan.h      | 23 +++++++++++++++++
 mm/kasan/kasan.h           | 29 ++++++++++++++++++++++
 mm/kasan/khwasan.c         | 51 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d4bceba60010..7fd9aee88069 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -247,6 +247,8 @@ void __init kasan_init(void)
 	memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
+	khwasan_init();
+
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 700734dff218..a2869464a8be 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -155,6 +155,29 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 
 #define KASAN_SHADOW_INIT 0xFF
 
+void khwasan_init(void);
+
+void *khwasan_set_tag(const void *addr, u8 tag);
+u8 khwasan_get_tag(const void *addr);
+void *khwasan_reset_tag(const void *ptr);
+
+#else /* CONFIG_KASAN_TAGS */
+
+static inline void khwasan_init(void) { }
+
+static inline void *khwasan_set_tag(const void *addr, u8 tag)
+{
+	return (void *)addr;
+}
+static inline u8 khwasan_get_tag(const void *addr)
+{
+	return 0xFF;
+}
+static inline void *khwasan_reset_tag(const void *ptr)
+{
+	return (void *)ptr;
+}
+
 #endif /* CONFIG_KASAN_TAGS */
 
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 2be31754278e..c715b44c4780 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -113,6 +113,35 @@ void kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip);
 
+#define KHWASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
+#define KHWASAN_TAG_INVALID	0xFE /* redzone or free memory tag */
+#define KHWASAN_TAG_MAX		0xFD /* maximum value for random tags */
+
+#define KHWASAN_TAG_SHIFT 56
+#define KHWASAN_TAG_MASK (0xFFUL << KHWASAN_TAG_SHIFT)
+
+static inline void *set_tag(const void *addr, u8 tag)
+{
+	u64 a = (u64)addr;
+
+	a &= ~KHWASAN_TAG_MASK;
+	a |= ((u64)tag << KHWASAN_TAG_SHIFT);
+
+	return (void *)a;
+}
+
+static inline u8 get_tag(const void *addr)
+{
+	return (u8)((u64)addr >> KHWASAN_TAG_SHIFT);
+}
+
+static inline void *reset_tag(const void *addr)
+{
+	return set_tag(addr, KHWASAN_TAG_KERNEL);
+}
+
+void khwasan_report_invalid_free(void *object, unsigned long ip);
+
 #if defined(CONFIG_SLAB) || defined(CONFIG_SLUB)
 void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache);
 void quarantine_reduce(void);
diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
index 24d75245e9d0..da4b17997c71 100644
--- a/mm/kasan/khwasan.c
+++ b/mm/kasan/khwasan.c
@@ -39,6 +39,57 @@
 #include "kasan.h"
 #include "../slab.h"
 
+int khwasan_enabled;
+
+static DEFINE_PER_CPU(u32, prng_state);
+
+void khwasan_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		per_cpu(prng_state, cpu) = get_random_u32();
+	}
+	WRITE_ONCE(khwasan_enabled, 1);
+}
+
+/*
+ * If a preemption happens between this_cpu_read and this_cpu_write, the only
+ * side effect is that we'll give a few allocated in different contexts objects
+ * the same tag. Since KHWASAN is meant to be used a probabilistic bug-detection
+ * debug feature, this doesn’t have significant negative impact.
+ *
+ * Ideally the tags use strong randomness to prevent any attempts to predict
+ * them during explicit exploit attempts. But strong randomness is expensive,
+ * and we did an intentional trade-off to use a PRNG. This non-atomic RMW
+ * sequence has in fact positive effect, since interrupts that randomly skew
+ * PRNG at unpredictable points do only good.
+ */
+static inline u8 khwasan_random_tag(void)
+{
+	u32 state = this_cpu_read(prng_state);
+
+	state = 1664525 * state + 1013904223;
+	this_cpu_write(prng_state, state);
+
+	return (u8)state % (KHWASAN_TAG_MAX + 1);
+}
+
+void *khwasan_set_tag(const void *addr, u8 tag)
+{
+	return set_tag(addr, tag);
+}
+
+u8 khwasan_get_tag(const void *addr)
+{
+	return get_tag(addr);
+}
+
+void *khwasan_reset_tag(const void *addr)
+{
+	return reset_tag(addr);
+}
+
 void kasan_unpoison_shadow(const void *address, size_t size)
 {
 }
-- 
2.17.0.rc0.231.g781580f067-goog
