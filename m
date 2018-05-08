Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525800083; cv=none;
        d=google.com; s=arc-20160816;
        b=FbCpSTznz9gIDkeAtByYqTdl3lv4PDvTlIwsdf7QIHXCNHuFZiJrX0Jrmzm2tKxc7n
         5A/2jiQIPSlbU9LIi8qVfjbaoU+dC9kttSuhQFPXiz4vnoBIyAww10CypZ+dFLGHBizE
         Cgwbc28cohDAX3fHPVuOj86te2wHOj1+rpw0IHEJfWhLm2aMxUJezhQVwI9bABAp3WRv
         BM8CcqNaZpNsblJYabBO8LNm8TgcOnF9U2Q7vTm9QKsONw7LMzc9SMwjXb4t4JcLxX42
         vyrELu+Uz7nZbhvRCSL+yDcm69xqonhd9+xC3BhtCtUme20imHldxsFoNg2h9zh9PN0h
         6wEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QmNrLV2ouq37rJeTa4aJrb/A4HzlLl64fsXLaFH/79U=;
        b=Oz634Y7hKfSUebwAlv9nJQX3+5hJA9P72HzXJVnvDzvrVzPAMDN/FbyZCQLb2CqXbl
         fRAaTlN3dCc48Q/ZtQQHDqCo9ZmE2LWATjliLTJ0igg7wHFEFnYQ7dSLRguwiG54IqqY
         1wd9ZnSN8Tn8yReSeEivr8CfsHSI7ePqnAvmAcnvL9mzeNiXcPIGC5QhalqveuN03Zm4
         4s23nGqFxXxTZG/qzdAD/cDuj8ez7GqomXQIwWG7f0RjvLpnDK6MYYnj8O6/DiC4zO2Z
         7UznmnfP+bF4PPAOvI+EtfZ+KH8GV3Q7Vfny1cdoUYfBtT6DxMZAC1VzS7ll76cZlvKR
         qCYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=qcgIx79D;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=qcgIx79D;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZrE0Zvje53ekCiQ5091B1wopM1Hl9R4HO51zbca6GFvC0pbfWGM3M9JPHV9QhEjxLxu4c/plA==
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
Subject: [PATCH v1 06/16] khwasan, arm64: untag virt address in __kimg_to_phys
Date: Tue,  8 May 2018 19:20:52 +0200
Message-Id: <82d6efa1879a9ab0f0c35d7251284f403c3ac82a.1525798754.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525798753.git.andreyknvl@google.com>
References: <cover.1525798753.git.andreyknvl@google.com>
In-Reply-To: <cover.1525798753.git.andreyknvl@google.com>
References: <cover.1525798753.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917347782001628?=
X-GMAIL-MSGID: =?utf-8?q?1599917347782001628?=
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
2.17.0.441.gb46fe60e1d-goog
