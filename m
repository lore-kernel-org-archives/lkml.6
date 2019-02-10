Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8245CC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4195020874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549790028;
	bh=g6oFDwySwFM63VVb3y6wnbAQK533rrhiUad1S+9ZJak=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QarKhzVMqcfmxwnV/0LtPzvY4+TtPegfs2D93S7Fz5Kk5uvJldBq2ivZVWw/JASa1
	 DoftwPkekZ3txakRQeBXFM5MPl9odnu8TsU5SkOBSASM48+sPVFQO7lcALCiPZ+wOO
	 PBFoSLu8S718YrNjyWSRrg96aa6nAmqWXg1swqVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfBJJNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:13:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53056 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfBJJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 04:13:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so11467030wml.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5O+a2KfTRU0Sj1rvpILNopyLXltN83X0L3eFzCIk8YI=;
        b=NfzxG+d4zCOTdhvdavABdqC1W/3QlwSrkE3Lcf87M7bSg1vnZI6zXeeAaDE1OnfznM
         QY/ymHgpi0beHIgiJxfKIQIbinJTIDtguS6bcN+3OBpTK4FlZNchGVbpY+YMvV05fe7A
         ZuEOCYKmgI+Bd6KFemfTQ7im8WntjJOAYwZI8hNV2ZKH1QlbJ9JTkpNtY+4FUA2NxA8w
         bsG3qJkmSBbUqGPNgc3R9Ql6MaVRVtY4ux87EBxJ+MscBalzbssspRr+zVtUGBvhLcKi
         nvm9Gnr0AZyvyxUF6wqPYKZBG+Mk+PZ+pCVswXCYufA4SkXB05tba2l94nCbXNmKD/Ao
         igHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=5O+a2KfTRU0Sj1rvpILNopyLXltN83X0L3eFzCIk8YI=;
        b=dadXi2QJqrg0VizYTRqNr3UC1+Qfhvhblab519JbF78s+9QxuOqfdDTG56YthQETYV
         RBZQiQtUmYN5UsBVbd0LPN8YOZEfbO2sFt88E/ygoTIApSK6zmw05kih9jB8eWBiNgSE
         sOkQDWdDPhwKKESeDBcK+33ezJKOb6R+E7/E9JPzDlJGapYsPfYdRamdmQF7C7LgaLxL
         hJH19OR0X3ETIU62nTuBnyJZor7RC9MwsEn0K5VT3b+FGNrWZRFp1pTyyZvWIXYrJhR2
         KN5X6eyF2fRLNccQD886qMls5+a0XVZflemF4zAu9EDZ5vjY9NnEnyaRBitIRC9z0eUZ
         4GNA==
X-Gm-Message-State: AHQUAub0YxtsFXcqC2pUvWm7vO7XFF74aktow1kQf1uf0h71p/D2e0mF
        tV/Cb5hBsrdVhxMUJwOMBlAtDJt6
X-Google-Smtp-Source: AHgI3IZd6RnE6lrw0nMfrlTI2S680MS7lHSKfn6ntxkmyDFr47giUTBnywVcUDPnBSDeioFsmOc/wA==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr1127527wrx.243.1549790023311;
        Sun, 10 Feb 2019 01:13:43 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s3sm7446590wmj.23.2019.02.10.01.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 01:13:42 -0800 (PST)
Date:   Sun, 10 Feb 2019 10:13:40 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190210091340.GA53627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 20e55bc17dd01f13cec0eb17e76e9511b23963ef x86/mm: Make set_pmd_at() paravirt aware

A handful of fixes:

 - Fix an MCE corner case bug/crash found via MCE injection testing

 - Fix 5-level paging boot crash

 - Fix MCE recovery cache invalidation bug

 - Fix regression on Xen guests caused by a recent PMD level mremap 
   speedup optimization

 Thanks,

	Ingo

------------------>
Juergen Gross (1):
      x86/mm: Make set_pmd_at() paravirt aware

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Do not corrupt EDX on EFER.LME=1 setting

Peter Zijlstra (1):
      x86/mm/cpa: Fix set_mce_nospec()

Tony Luck (1):
      x86/MCE: Initialize mce.bank in the case of a fatal error in mce_no_way_out()


 arch/x86/boot/compressed/head_64.S |  2 ++
 arch/x86/include/asm/pgtable.h     |  2 +-
 arch/x86/kernel/cpu/mce/core.c     |  1 +
 arch/x86/mm/pageattr.c             | 50 +++++++++++++++++++-------------------
 4 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f105ae8651c9..f62e347862cc 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -602,10 +602,12 @@ ENTRY(trampoline_32bit_src)
 3:
 	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
 	pushl	%ecx
+	pushl	%edx
 	movl	$MSR_EFER, %ecx
 	rdmsr
 	btsl	$_EFER_LME, %eax
 	wrmsr
+	popl	%edx
 	popl	%ecx
 
 	/* Enable PAE and LA57 (if required) paging modes */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 40616e805292..2779ace16d23 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1065,7 +1065,7 @@ static inline void native_set_pte_at(struct mm_struct *mm, unsigned long addr,
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd)
 {
-	native_set_pmd(pmdp, pmd);
+	set_pmd(pmdp, pmd);
 }
 
 static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 672c7225cb1b..6ce290c506d9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -784,6 +784,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			quirk_no_way_out(i, m, regs);
 
 		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
+			m->bank = i;
 			mce_read_aux(m, i);
 			*msg = tmp;
 			return 1;
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 4f8972311a77..14e6119838a6 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -230,6 +230,29 @@ static bool __cpa_pfn_in_highmap(unsigned long pfn)
 
 #endif
 
+/*
+ * See set_mce_nospec().
+ *
+ * Machine check recovery code needs to change cache mode of poisoned pages to
+ * UC to avoid speculative access logging another error. But passing the
+ * address of the 1:1 mapping to set_memory_uc() is a fine way to encourage a
+ * speculative access. So we cheat and flip the top bit of the address. This
+ * works fine for the code that updates the page tables. But at the end of the
+ * process we need to flush the TLB and cache and the non-canonical address
+ * causes a #GP fault when used by the INVLPG and CLFLUSH instructions.
+ *
+ * But in the common case we already have a canonical address. This code
+ * will fix the top bit if needed and is a no-op otherwise.
+ */
+static inline unsigned long fix_addr(unsigned long addr)
+{
+#ifdef CONFIG_X86_64
+	return (long)(addr << 1) >> 1;
+#else
+	return addr;
+#endif
+}
+
 static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
 {
 	if (cpa->flags & CPA_PAGES_ARRAY) {
@@ -313,7 +336,7 @@ void __cpa_flush_tlb(void *data)
 	unsigned int i;
 
 	for (i = 0; i < cpa->numpages; i++)
-		__flush_tlb_one_kernel(__cpa_addr(cpa, i));
+		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
 }
 
 static void cpa_flush(struct cpa_data *data, int cache)
@@ -347,7 +370,7 @@ static void cpa_flush(struct cpa_data *data, int cache)
 		 * Only flush present addresses:
 		 */
 		if (pte && (pte_val(*pte) & _PAGE_PRESENT))
-			clflush_cache_range_opt((void *)addr, PAGE_SIZE);
+			clflush_cache_range_opt((void *)fix_addr(addr), PAGE_SIZE);
 	}
 	mb();
 }
@@ -1627,29 +1650,6 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 	return ret;
 }
 
-/*
- * Machine check recovery code needs to change cache mode of poisoned
- * pages to UC to avoid speculative access logging another error. But
- * passing the address of the 1:1 mapping to set_memory_uc() is a fine
- * way to encourage a speculative access. So we cheat and flip the top
- * bit of the address. This works fine for the code that updates the
- * page tables. But at the end of the process we need to flush the cache
- * and the non-canonical address causes a #GP fault when used by the
- * CLFLUSH instruction.
- *
- * But in the common case we already have a canonical address. This code
- * will fix the top bit if needed and is a no-op otherwise.
- */
-static inline unsigned long make_addr_canonical_again(unsigned long addr)
-{
-#ifdef CONFIG_X86_64
-	return (long)(addr << 1) >> 1;
-#else
-	return addr;
-#endif
-}
-
-
 static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 				    pgprot_t mask_set, pgprot_t mask_clr,
 				    int force_split, int in_flag,
