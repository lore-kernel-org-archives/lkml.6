Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174144-2-611711050647815221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174143; b=djyY5virziJVEEhxGzJLkT/CiFQGVHGLvaRDbdkAK4KtCP5
    WePLgHBWGOkAbIHyhWD7qdsZ5mA/ALczXHPvDkfdnZ+lAJVT+xHJmszC2DeH5sGl
    Pv4g9zXdZOnaUL67C/jczjvECYoRITcIzv9FyTCgEy3qMIn5NzsdFK169TFX2u0x
    nSq1wmi0VGJ11f5OM5itmBGtkx3BO4PiCs568dfVOaCQHbhhlHMmRUMxUIaXwx5t
    6ssZmUQ0od+1SIcY8iSmV8d96uzSXYyCrWX4zpKDPymCQPYmJRWkJYZUT1gtkUNf
    5ASBAxSd63U1xySZn7fniP1SI4BopOW+ZORhVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174143; bh=CG7pll//BKYcUDhtn3mK1MFYnO
    sDz0PC3Lb5ioJXVsU=; b=eg1yPYW1BXXt0R3j2Gf2+G7NvAysrsGelWt2/H325f
    DlWzBckXOYxy4NGjkVVgCIMgl9MUGZxkjFzOSNtNEplqXNStWOR/Kqh719lbK5r/
    6y+6YUSNK8cXfvv52fZ/f8hbrsII7gpb4yrpz5/WmUwyHQVdcmwVWdIvcuxJ+w/b
    eoMKPUKjEbMY9J/UuA0uKtCA6H42Agy/m+fV8OrMU4iZdme54uvdjcXGfmwE37y7
    kbQqcOQ+Flfp19XJLNIOoMQHgtYbS2L4IYm/JTDGnnWYMjVa3ODUrV5UXNJgpp8c
    uSSk5KnXrt6CrrcgTAwZ0bM77wmlsz/VcEFB9u0YRHng==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfCHXFaUKnIMxzveHXlCV86CK7CIZkdo+ckx/sIjkk/COnTomARkCcOXSjscuvDQSDafBy3v9zvg4Hsu3EITzz7tTHoCHfRP8KJDZP61eqRrk586KiL3N
    BKAZ1zao7ORteUrwqohJ1ekdyGQaD2rnB180aZfWu6goj8TEt0gnEiP9jzCljNdNF734zfc/Y4GODavt3Fk/VJXP5Tw5q75NeoFhfmLTUDWtbHB5kUt1OLug
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=MvuuwTCpAAAA:8 a=VwQbUJbxAAAA:8 a=BTeA3XvPAAAA:8 a=iox4zFpeAAAA:8
    a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8
    a=ag1SF4gXAAAA:8 a=bucy1RvTIGb1ssWSWJsA:9 a=QEXdDO2ut3YA:10
    a=dVHiktpip_riXrfdqayU:22 a=AjGcO6oz07-iQ99wixmX:22 a=tafbbOV3vt1XuEhzTjGK:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeC0Q3O (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:29:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41196 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbeC0Q3L (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        Lei Li <lious.lilei@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 21/43] x86/mm: implement free pmd/pte page interfaces
Date: Tue, 27 Mar 2018 18:27:25 +0200
Message-Id: <20180327162717.639376176@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshi Kani <toshi.kani@hpe.com>

commit 28ee90fe6048fa7b7ceaeb8831c0e4e454a4cf89 upstream.

Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
clear a given pud/pmd entry and free up lower level page table(s).

The address range associated with the pud/pmd entry must have been
purged by INVLPG.

Link: http://lkml.kernel.org/r/20180314180155.19492-3-toshi.kani@hpe.com
Fixes: e61ce6ade404e ("mm: change ioremap to set up huge I/O mappings")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Reported-by: Lei Li <lious.lilei@hisilicon.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/pgtable.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -676,7 +676,22 @@ int pmd_clear_huge(pmd_t *pmd)
  */
 int pud_free_pmd_page(pud_t *pud)
 {
-	return pud_none(*pud);
+	pmd_t *pmd;
+	int i;
+
+	if (pud_none(*pud))
+		return 1;
+
+	pmd = (pmd_t *)pud_page_vaddr(*pud);
+
+	for (i = 0; i < PTRS_PER_PMD; i++)
+		if (!pmd_free_pte_page(&pmd[i]))
+			return 0;
+
+	pud_clear(pud);
+	free_page((unsigned long)pmd);
+
+	return 1;
 }
 
 /**
@@ -688,6 +703,15 @@ int pud_free_pmd_page(pud_t *pud)
  */
 int pmd_free_pte_page(pmd_t *pmd)
 {
-	return pmd_none(*pmd);
+	pte_t *pte;
+
+	if (pmd_none(*pmd))
+		return 1;
+
+	pte = (pte_t *)pmd_page_vaddr(*pmd);
+	pmd_clear(pmd);
+	free_page((unsigned long)pte);
+
+	return 1;
 }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
