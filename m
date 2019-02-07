Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DD8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0BD2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wTXwOLox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfBGR5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:57:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44254 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGR5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ebJSCtBJYxqTB25lfOZd5rVt3X49y6Cba8ZLNIDHrHw=; b=wTXwOLoxAVwFmYqTvV8GkAQZL
        QOvl1ge+6uGkiO4BURgAkDyCUZX+yHN34VpuEOnIfxoFWQu9QA670eakRiy+QLwnODCla4YlXLTnJ
        NL+Tnwnn1JgZRpc8nLzu/c1YZBuPHy17Ke7KkxfP9npIMQL6i1FmzrrYNA6rDWbj/UUWl5dGj+ThZ
        QVV0yLa10G/Y/6joP7KNHFVtsGgb7C92UrhvkDMj1LgFSwkSK8RRKNqSO1Nt6+1Q7Amr08kAyCdZI
        b9pcM+f10m8ac+FtoAKGyF8YvPOM9XzC7xK+xmBMdOM8QSS7jY1plAYFa5kAOclaL53qn3xNUJKdb
        t+/FBObRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grnvP-0006Lz-TH; Thu, 07 Feb 2019 17:57:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7DDE21436C82; Thu,  7 Feb 2019 18:57:20 +0100 (CET)
Date:   Thu, 7 Feb 2019 18:57:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [GIT PULL] x86/mm changes for v4.21
Message-ID: <20190207175720.GE32511@hirez.programming.kicks-ass.net>
References: <20181224231106.GA27438@gmail.com>
 <20190207001737.GA32096@agluck-desk>
 <20190207101846.GB32511@hirez.programming.kicks-ass.net>
 <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com>
 <20190207140131.GB32477@hirez.programming.kicks-ass.net>
 <20190207173600.GA15682@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207173600.GA15682@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:36:00AM -0800, Luck, Tony wrote:
> On Thu, Feb 07, 2019 at 03:01:31PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 07, 2019 at 11:50:52AM +0000, Linus Torvalds wrote:
> > > If you re-generate the canonical address in __cpa_addr(), now we'll
> > > actually have the real virtual address around for a lot of code-paths
> > > (pte lookup etc), which was what people wanted to avoid in the first
> > > place.
> > 
> > Note that it's an 'unsigned long' address, not an actual pointer, and
> > (afaict) non of the code paths use it as a pointer. This _should_ avoid
> > the CPU from following said pointer and doing a deref on it.
> 
> The type doesn't matter. You want to avoid having the
> true value in the register as long as possible. Ideal
> spot would be the instruction before the TLB is flushed.
> 
> The speculative issue is that any branch you encounter
> while you have the address in a register may be mispredicted.
> You might also get a bogus hit in the branch target cache
> and speculatively jump into the weeds. While there you
> could find an instruction that loads using that register, and
> even though it is speculative and the instruction won't
> retire, a machine check log will be created in a bank (no
> machine check is signalled).
> 
> Once the TLB is updated, you are safe. A speculative
> access to an uncached address will not load or log anything.

Something like so then? AFAICT CLFLUSH will also #GP if feed it crap.


diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 4f8972311a77..d3ae92ad72a6 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -230,6 +230,28 @@ static bool __cpa_pfn_in_highmap(unsigned long pfn)
 
 #endif
 
+/*
+ * Machine check recovery code needs to change cache mode of poisoned
+ * pages to UC to avoid speculative access logging another error. But
+ * passing the address of the 1:1 mapping to set_memory_uc() is a fine
+ * way to encourage a speculative access. So we cheat and flip the top
+ * bit of the address. This works fine for the code that updates the
+ * page tables. But at the end of the process we need to flush the cache
+ * and the non-canonical address causes a #GP fault when used by the
+ * CLFLUSH instruction.
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
@@ -313,7 +335,7 @@ void __cpa_flush_tlb(void *data)
 	unsigned int i;
 
 	for (i = 0; i < cpa->numpages; i++)
-		__flush_tlb_one_kernel(__cpa_addr(cpa, i));
+		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
 }
 
 static void cpa_flush(struct cpa_data *data, int cache)
@@ -347,7 +369,7 @@ static void cpa_flush(struct cpa_data *data, int cache)
 		 * Only flush present addresses:
 		 */
 		if (pte && (pte_val(*pte) & _PAGE_PRESENT))
-			clflush_cache_range_opt((void *)addr, PAGE_SIZE);
+			clflush_cache_range_opt((void *)fix_addr(addr), PAGE_SIZE);
 	}
 	mb();
 }
@@ -1627,29 +1649,6 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
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
