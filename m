Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1472C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5EB251AF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="SZFuT5Ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5EB251AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936355AbeF2Vqz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:46:55 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37524 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936061AbeF2Vqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:46:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so7790800lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VBsLPWyJedtlQDuiOrYBBclo6766cnKZPG6tyPbOAXo=;
        b=SZFuT5WsD3mdYoh0fQZncZmTppYa7azPr9ySgIFqSSftrWcyFd/+Qcer8kB0qB72Qf
         SBo2zt3vLXJl/IEiAr2v92RgJsyJAtcRSOooCPVUvn542XRPEGxG4VKayPElgwI9jKYb
         nrOCN9t6qWqMUUV8E0Qci8Rd1t3xh0rUqeIkLm75X1PN3WYqbQ4jVTYTriOwyDGzuOJZ
         Co63fGWWoeL1014gPoStKfxWJFJAYjVGUcxUUhsomXIheTbKzHuED3ykDLFX9WjvAwuo
         DpXCPZ84RWdVX3Vxpk/Q43jkwf5MqWpvv4SIlH8TGl9JqN1ECeD9s0kz/eRTWRiIpBBJ
         CUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VBsLPWyJedtlQDuiOrYBBclo6766cnKZPG6tyPbOAXo=;
        b=hIWnkHllQDvIAVuegQWWse/PcdFfzXmQkI47G2YCwQ2MUpMFxv5MZKLCv7ztH66Q/O
         S68RciHCFrjHJR25Hng5XkkhsYuRyhC3FHg6kuQs992/rvdSYs8hNaJ5SabBgoy9iak+
         msp1wB0I9ZJoHMOPrknCxHwfn9iEHBeYkuzxmUxfMrcp8vyLkCG/+IbsYogay5KyofpP
         BfFu5ahJDFBil3rhJ4NF5qGpnv2FQKFqUFHfBiL1A17IyUOA/nxGerdfLPxmOR5VgO7T
         ZVU1PjNPFTrRrtw9LQdJds+OhEG+bjiAB+MYJaV4r9apUSTQt9TmbwpWgz3ecoTd4aNw
         fVEw==
X-Gm-Message-State: APt69E2NpCO6IYBWZfjnRme0mRmlySOYsBiDM2Bg2todYP75+1p2C2Jv
        rdrAmmfG5xdf2vAZZqnfbGRyOQ==
X-Google-Smtp-Source: AAOMgpdQIFVyguz2wOQqvdMwGVeMxGCzlc8eogBdjhDZiOzsPBKLCcXGGRKq9tgZuKFRzKez1ItumQ==
X-Received: by 2002:a19:1a52:: with SMTP id a79-v6mr11206134lfa.43.1530308810680;
        Fri, 29 Jun 2018 14:46:50 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (mm-38-94-44-37.mgts.dynamic.pppoe.byfly.by. [37.44.94.38])
        by smtp.gmail.com with ESMTPSA id h66-v6sm1668224ljf.65.2018.06.29.14.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 14:46:49 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5A72C30003C; Sat, 30 Jun 2018 00:46:48 +0300 (+03)
Date:   Sat, 30 Jun 2018 00:46:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
Message-ID: <20180629214647.mkgpni6hxj7aore4@kshutemo-mobl1>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:01:46PM -0700, Linus Torvalds wrote:
> On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
> >
> > I have more information regarding this BUG. Line 700 of page-flags.h is the
> > macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded
> > the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), page)
> > in routine __ClearPageTable(), which is called from pgtable_page_dtor() in
> > include/linux/mm.h. I also added a printk call to PageTable() that logs
> > page->page_type. The routine was called twice. The first had page_type of
> > 0xfffffbff, which would have been expected for a . The second call had
> > 0xffffffff, which led to the BUG.
> 
> So it looks to me like the tear-down of the page tables first found a
> page that is indeed a page table, and cleared the page table bit
> (well, it set it - the bits are reversed).
> 
> Then it took an exception (that "interrupt: 700") and that causes
> do_exit() again, and it tries to free the same page table - and now
> it's no longer marked as a page table, because it already went through
> the __ClearPageTable() dance once.
> 
> So on the second path through, it catches that "the bit already said
> it wasn't a page table" and does the BUG.
> 
> But the real question is what the problem was the *first* time around.

+Aneesh.

Looks like pgtable_page_dtor() gets called in __pte_free_tlb() path twice.
Once in __pte_free_tlb() itself and the second time in pgtable_free().

Would this help?

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 6a6673907e45..e7a2f0e6b695 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -137,7 +137,6 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
-	pgtable_page_dtor(table);
 	pgtable_free_tlb(tlb, page_address(table), 0);
 }
 #endif /* _ASM_POWERPC_BOOK3S_32_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 1707781d2f20..30a13b80fd58 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -139,7 +139,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
 	tlb_flush_pgtable(tlb, address);
-	pgtable_page_dtor(table);
 	pgtable_free_tlb(tlb, page_address(table), 0);
 }
 #endif /* _ASM_POWERPC_PGALLOC_32_H */
-- 
 Kirill A. Shutemov
