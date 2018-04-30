Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732904-1525111242-2-9429212107162329781
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525111242; b=UGj+mqH3RW6ndONKUX+vG0k5FRBWJisz2951Sr/PN1hVLW57hX
    J900ofZGf8EfVnLroVNU6z8q8/2YmhMmVqVSmurqbNUmYXJ0+lBwtBS/iJ3SdCDP
    QxHMSCBFsH4Z4SyETQvvJh/qrweZBuyY3Ov99+XJiksVuaF9DXiRDg+f7KMt4Znu
    pZiydnxd5QRAiC35lp3HCR4orFr9Ca8PFP/Pm0ExOEMoOk82D6yd2p8ojWgynyDm
    DXBFtg9Q+SNvHYZB5jOUhzksxuEy01T19XUBJ8oefkEk+ICu8pWCRzorr3asxa5u
    uO4bpXbzt1+MLp5/2+mZ9LtFt0fcPT4aM5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525111242; bh=
    JACx8uszIeyr4Q+P6VWxvRtd34v4ySj8+HGX/htHoU4=; b=JT3QadfuiA/eRpf+
    kk7gA7Y6D3gM9w49387GAvDWEUKWEZSWFC2dhloxaErK68UCNbldb1qvA1EU8Rey
    v8ulUDW2TJmqPHcfl/Ghauj/PSkMjpKfT88/W9iTzUfv79R4E+GoWzblT+VVxQiV
    PhPKuQFQMoU55F+vUUEdkUqF13Wslwu8/yQSRCt55O1iW6XdzBMph9zK8wa/26/h
    5z51ZGQF+YD9SHrfnAg54i/vSRsedM90ty9Di7j4DjUeqWi0uLK+P47xM3G4jAXW
    D9zQPoRxxPsT56Ei+OBEbJJuXiqVCFHstJRaMQGL04wDpHJaXMstQE0ryqSAH0LR
    OssZmQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNVYVEMLxwXPTnTuhpuWHx5TgCp7eGyfVKF7aJmJjGH/ALcCq/uhBLv+Y60u0dduN74b8fXsuwfFvzw4NvfzuF1ommwYMfIWeHY4IrYDP7rFopbm+bKn
    7U6gDkPQ9VTQlWuXK4+LkzaAFL81wHO2p0P/F6FdXg4txNt2IjCgiSVxfhkRGqPE/lgukwLC5lhJcUn0lSnia7xG9ply2EeaGMZhEYIHG3i0pWMEX3Bqeua8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=tA7aZXjiAAAA:8
    a=MvuuwTCpAAAA:8 a=Z4Rwk6OoAAAA:8 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=VwQbUJbxAAAA:8 a=hCsESo4FuRblPrCuPTwA:9
    a=kIIFJ0VLUOy1gFZzwZHL:22 a=dVHiktpip_riXrfdqayU:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754341AbeD3SAa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 14:00:30 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:56104 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbeD3SA1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 14:00:27 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc: cpandya@codeaurora.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>,
        Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org
Subject: [PATCH 3/3] x86/mm: disable ioremap free page handling on x86-PAE
Date: Mon, 30 Apr 2018 11:59:25 -0600
Message-Id: <20180430175925.2657-4-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180430175925.2657-1-toshi.kani@hpe.com>
References: <20180430175925.2657-1-toshi.kani@hpe.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ioremap() supports pmd mappings on x86-PAE.  However, kernel's pmd
tables are not shared among processes on x86-PAE.  Therefore, any
update to sync'd pmd entries need re-syncing.  Freeing a pte page
also leads to a vmalloc fault and hits the BUG_ON in vmalloc_sync_one().

Disable free page handling on x86-PAE.  pud_free_pmd_page() and
pmd_free_pte_page() simply return 0 if a given pud/pmd entry is present.
This assures that ioremap() does not update sync'd pmd entries at the
cost of falling back to pte mappings.

Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
Reported-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: <stable@vger.kernel.org>
---
 arch/x86/mm/pgtable.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 816fd41ee854..809115150d8b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -715,6 +715,7 @@ int pmd_clear_huge(pmd_t *pmd)
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
  * @pud: Pointer to a PUD.
@@ -784,4 +785,22 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 	return 1;
 }
+
+#else /* !CONFIG_X86_64 */
+
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
+{
+	return pud_none(*pud);
+}
+
+/*
+ * Disable free page handling on x86-PAE. This assures that ioremap()
+ * does not update sync'd pmd entries. See vmalloc_sync_one().
+ */
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
+{
+	return pmd_none(*pmd);
+}
+
+#endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
