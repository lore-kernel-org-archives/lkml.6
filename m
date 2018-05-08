Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525800085; cv=none;
        d=google.com; s=arc-20160816;
        b=KU2XINRonDuXMmLRZSVQFPUlzehuryZYGX6CQA9smIrO9lIPIUIqCWd296dow/K0NG
         t8caG4JEX0plXhxjnJOxkmIHZ44NLt6Y6+m2XGRwi/K7e4dqXdW7AB6//vsde/aXEyM2
         O6t4rji+SHXBXhGXMFWPix7WJXTXR1i+H2acfvev3SYlhNDuBBPDauI9BoN69Jize8MZ
         tDE7Lbr+5YK3rwpIOMNy0ocSguc6B1/gGS+rL8pkK6lILvNSrDq1hKkLeKkcHrAUSV4u
         +KnJtR9Eh7JD/lxUpTzS9EH6qnlWgQWoeOh/DYzgDEdq/dJwEsVI0SakTWp2K3hWz/2Q
         PRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ICExutSsxMNmOeqM56Yn6CuSUfLXBAripkLnfwN846o=;
        b=Na0TDCPC8xtIu2WvXbsbhnfvBxI8OEQK62f7aTwR0f7EQo3Blrif9wSJWKqA07Zpzg
         A+mCFPgOtJapWYoJNTISogIrLRhuTa/sRC4cI0JRx4PlH7KQERj1zZRd3uK6RE7Wr9TO
         aH+fTV0AGGU6PyaOOU3QLU3YbEBI7bBltlxRyP3WnaZyeiyf7rAc7gSzXa9GKsB6ERUW
         QfKicJcdKAj9/PF0G/iNem5/oqb4gPPF4CEp0kV+SgEtqmP2Is4OsSm/YpymMDSbHdqg
         q6kl7PaCF7Mf79Dd5ZVkdcDissWOEP/BhUXVcjVG1SitTWnuB3hg8Yn9ZX5cDg6sIx/x
         JKNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=myWlVihh;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=myWlVihh;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZrvQ4RihxXsnVSNXvLckZjD5lH9GUaNW656fTUhjAji7v3XOkQKmJJQ9ikwECUJ0+h6f157zA==
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
Subject: [PATCH v1 07/16] khwasan, arm64: fix up fault handling logic
Date: Tue,  8 May 2018 19:20:53 +0200
Message-Id: <a8771c5ec3469b68fbb510bda74aac4e42e49cab.1525798754.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525798753.git.andreyknvl@google.com>
References: <cover.1525798753.git.andreyknvl@google.com>
In-Reply-To: <cover.1525798753.git.andreyknvl@google.com>
References: <cover.1525798753.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917350253870751?=
X-GMAIL-MSGID: =?utf-8?q?1599917350253870751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

show_pte in arm64 fault handling relies on the fact that the top byte of
a kernel pointer is 0xff, which isn't always the case with KHWASAN enabled.
Reset the top byte.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4165485e8b6e..e834fe76f5d2 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -32,6 +32,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/kasan.h>
 
 #include <asm/bug.h>
 #include <asm/cmpxchg.h>
@@ -134,6 +135,8 @@ void show_pte(unsigned long addr)
 	pgd_t *pgdp;
 	pgd_t pgd;
 
+	addr = (unsigned long)khwasan_reset_tag((void *)addr);
+
 	if (addr < TASK_SIZE) {
 		/* TTBR0 */
 		mm = current->active_mm;
-- 
2.17.0.441.gb46fe60e1d-goog
