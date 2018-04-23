Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+83376eclmoSqJIVuQJmIaNAadfD95FE/EquhIjh4ShjY6EkkOwd/ue5E+VNd9I5QS5HCC
ARC-Seal: i=1; a=rsa-sha256; t=1524498475; cv=none;
        d=google.com; s=arc-20160816;
        b=fDuVvrhks0bNYL5TrSmYmau7Pxn2F11PtqY7aL0jeM8vJw4YIJ8yZR+/1COoY9zEMj
         YYN6s4jrESIrt2WgHgZcpwAqA8jqC6IiziDf+0KZtfyICo1S1E+oilaOyaHmnkQF0+DH
         aT4hwODP2K65ygBZOlycqQM7cZtVnXZHB2cvSBQiMlkSUYi3KTNDJbwLmcWl6fQoT2Oc
         vwqxDikECQrM9Btf/1/9x+E0Qsqoxwv3UACL1uih1NeXfwhuk/MZDy2RHH959qls+xIb
         jTPi6/Hh+dWgVnWcegquCzDShJOFOgh5GyY1luYAwuEHdlGvigYvEr3OZoY2IWD5U8Zq
         Kg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ztOkeM8hpJ8qxoWjXo6JBy8pkFONtOwKqJDg4PtNm40=;
        b=pPwJ3wX2ydO2E8ce1RLm2KCEBiXUjnCUlm+dU2HtYLkGZKm+A5sZVFBDz0kD2VOnDU
         JYG6sFKC30OuPxnI+BPofijglMg1ksX3GAFl+u4waLULDD1svecnUozFge+K6f0/vCTB
         9jmM3c8ZL3Ne5FbpLIJUIf9JI8Gy2NKeokllzfxofzor0Ws5c6YQ7rtAqefYLTmaaE96
         BWD6NnLRP6Qal8HY+6m3NiVFzGWoPTd8g/+MgGyG1A8nERGRjt/AG0RW9ox3xMoVzmtu
         8mCzNPuxMY9NTNwi2N8X4Y2P8UpBJ+FsX8NA9GqkOtux4HX1KVakIqs0VY+3PuwR7ANK
         DeDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=FNo0UvZV;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=FNo0UvZV;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 19/37] x86/pgtable: Move pti_set_user_pgtbl() to pgtable.h
Date: Mon, 23 Apr 2018 17:47:22 +0200
Message-Id: <1524498460-25530-20-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552513267437779?=
X-GMAIL-MSGID: =?utf-8?q?1598552513267437779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

There it is also usable from 32 bit code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable.h    | 23 +++++++++++++++++++++++
 arch/x86/include/asm/pgtable_64.h | 21 ---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 3055c77..557ddf8 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -635,8 +635,31 @@ static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
 
 pmd_t *populate_extra_pmd(unsigned long vaddr);
 pte_t *populate_extra_pte(unsigned long vaddr);
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
+
+/*
+ * Take a PGD location (pgdp) and a pgd value that needs to be set there.
+ * Populates the user and returns the resulting PGD that must be set in
+ * the kernel copy of the page tables.
+ */
+static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return pgd;
+	return __pti_set_user_pgtbl(pgdp, pgd);
+}
+#else   /* CONFIG_PAGE_TABLE_ISOLATION */
+static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
+{
+	return pgd;
+}
+#endif  /* CONFIG_PAGE_TABLE_ISOLATION */
+
 #endif	/* __ASSEMBLY__ */
 
+
 #ifdef CONFIG_X86_32
 # include <asm/pgtable_32.h>
 #else
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 9934115..6dd2eb6 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -146,27 +146,6 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 	return (ptr & ~PAGE_MASK) < (PAGE_SIZE / 2);
 }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
-
-/*
- * Take a PGD location (pgdp) and a pgd value that needs to be set there.
- * Populates the user and returns the resulting PGD that must be set in
- * the kernel copy of the page tables.
- */
-static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
-{
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return pgd;
-	return __pti_set_user_pgtbl(pgdp, pgd);
-}
-#else
-static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
-{
-	return pgd;
-}
-#endif
-
 static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
-- 
2.7.4
