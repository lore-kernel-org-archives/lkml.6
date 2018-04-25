Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653677-2-1256630321788869420
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653677; b=p2MCbPfvVohq+wzEpKMyLJN79ijFcqqR/LjqTG+eb7fOeN4e6m
    BoQad3WlwMeteRPuqr9ZSzEjgYwlX/HH5+elY62A8uwdMXCnruYW3xaVl2f3P+bm
    cHh+/bw2GFslw9OkFqkPKmmkhfWlLyWNve0fi9WR9xMVV2XGtDhXlfWigChjPnoQ
    XL0x0YrpDqCzJDsWRMATiniB6leDztJANXHPCnpu88LAoRwWpZl6OjxPlxbD48Qt
    UT+vKRNp5zFwaqlqbTcGU7D4alwoLW0sv5tBhSl3Qv/MxVe/Uw2UlB8UMxbLNAzo
    H+360174Rj4FCDssCwlBg+80LkhZ0OaxQumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653677; bh=4Y1lUJ7ZQzxcF07V/BJ7p5MQQkMpcU
    PZatKRuwFg55g=; b=uBxg+ubRAXHw0MHL5PDRxHagx4FGju00haDLx5rfNz+IEy
    U8z3TyiEesVU6cGYROZlZypr1k0RJSUEk51kWCTFhyXi0bZ8HPF79fYujGO+T37Y
    cFcWY850l6busdbZQieLKLuRv+POlJehRgJ8734Qxz6g2d5fsHA31GTR3gf3inAj
    r12yKdCm1KjnemFqs1BwSkfGkGIKWL8Zd+6CY7L1PIbTZdgHGyjXhs89l5ZoCCTx
    5NfjyFvuSVDCYXxH7EO3n6oX2y7ekvvIJvHXgqJQi+D0rqp5oSbe3RXO6hgfEZNl
    iPlckN4F6PnNnL6eG8l47EqbqWoGLtOyrhndM/EA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL1R38sAI7yWc/mbRBIEspMw2oI9Y/J2KGdK2gtydPudJlqxx9KQQfELUfQPkYJ8GZphCpTBnju6eZfsPAoBmsU6SMccKHIAnMTf4LrmUZmWzDJO3jn/
    Q98N2KPkb+LuSswbEdJACJZzgf8rA/hGRKIKxRhiXiCl75ObObN7/hXOLOOywogIvthMXEgwxEVayhl7iZdC1c6g4yN2Yn+q3VKpPHF3mKScItiTAUF6gdX+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=54dDKcjAEQ2g3t4xt5AA:9 a=B8zDiICV2jeWFBWE:21 a=PuGvs8A1Ffo1GKfB:21
    a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDYKyb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:54:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbeDYKn1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nitin Gupta <nitin.m.gupta@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 114/183] sparc64: update pmdp_invalidate() to return old pmd value
Date: Wed, 25 Apr 2018 12:35:34 +0200
Message-Id: <20180425103247.027009733@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nitin Gupta <nitin.m.gupta@oracle.com>


[ Upstream commit a8e654f01cb725d0bfd741ebca1bf4c9337969cc ]

It's required to avoid losing dirty and accessed bits.

[akpm@linux-foundation.org: add a `do' to the do-while loop]
Link: http://lkml.kernel.org/r/20171213105756.69879-9-kirill.shutemov@linux.intel.com
Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: David Miller <davem@davemloft.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/include/asm/pgtable_64.h |    2 +-
 arch/sparc/mm/tlb.c                 |   23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -980,7 +980,7 @@ void update_mmu_cache_pmd(struct vm_area
 			  pmd_t *pmd);
 
 #define __HAVE_ARCH_PMDP_INVALIDATE
-extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -219,17 +219,28 @@ void set_pmd_at(struct mm_struct *mm, un
 	}
 }
 
+static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t old;
+
+	do {
+		old = *pmdp;
+	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);
+
+	return old;
+}
+
 /*
  * This routine is only called when splitting a THP
  */
-void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_t entry = *pmdp;
-
-	pmd_val(entry) &= ~_PAGE_VALID;
+	pmd_t old, entry;
 
-	set_pmd_at(vma->vm_mm, address, pmdp, entry);
+	entry = __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
+	old = pmdp_establish(vma, address, pmdp, entry);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 
 	/*
@@ -240,6 +251,8 @@ void pmdp_invalidate(struct vm_area_stru
 	if ((pmd_val(entry) & _PAGE_PMD_HUGE) &&
 	    !is_huge_zero_page(pmd_page(entry)))
 		(vma->vm_mm)->context.thp_pte_count--;
+
+	return old;
 }
 
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
