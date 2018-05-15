Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3322034-1526420497-2-6045536464281866779
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526420497; b=TKAZTq8pMakEgcGKCdfosX1MiWMJz/4r/DrtnSce+xpoAIsWE1
    8vfxhX45Crn9OM1qCR1KgWNlLFarlJXgwml56IVun83JbUoC+G4NAVxR4OTgYO/X
    f8MmLCijR98eq89e8NJcKxO8IXRLXVC98J990UV9qYwDhrOQ7v1diz1FNfjfg4Fq
    pd4lFmnwcYYUSxuhSZYy5KWk6QkGJuSeE3Kg6NRx4reyp8hS4gqIYcyliEgtNpXp
    IkLb3xrZ77jgrihQ8qqb2wzVXVYwrf5+pqVuzg4ESChQJlyUvnKoEueNT2okwmo8
    TWj7kWIM2TWuX6x7W1xDnIcqfhskpI4UgAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526420497; bh=
    vAYomrBaZpFCkduE/qt5BTwZT2JNh7Y9a+ci7lxNNsU=; b=JJc5khIxXdqZC1RH
    ctUuaLaU4qr7LlIbIrDtRjfdEacoEEfqXgiYN5sy0KsSLdiHj1wsF3pTCPGLhZF/
    zJzMvKh5DsB4bN4CqRd1rMifvLThs9RWfUUCTCLFRYdmfJkiVf5PgTrmIJny2MsT
    Pa2zC0+DyI4z0b6kg9NNiuVirg/n7EEp2lrCJslra8dv5+5kM/oD1VJ059UGG7qb
    XI5yv7j4AaHRdTrKmFgSkjK1x9BYbASMlaItS9B7wLO/U75weL00z0OfiJNaRZ8Z
    sdc0+Or/xTzzXjfA0lTMCgg8ynYsrOblf6SukTP9jM1UMZanK/Y880U6s2w65RLD
    8T0gfg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM+vB9GOyogcyjIIb1ynt41v72jpbCKEYbcam8sAk7w6NKtikgHQpJ4bDKwFl3ZqFuaJw0KKviCH7xy0vvRxvk9QkqjGnZDZOrAQnWClUi/eXThHKrlb
    kood7qoJcH6i7ql/A4MM9blBko/yRmzv6IWyjAx3f6RFng36JCgvCjGEvfMGt1DlKXQdDQar9zCl8Eky2GJhRaBPvVtDqXc+LgCCo1SgIa78bSC+cSpmdGkj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=tA7aZXjiAAAA:8
    a=MvuuwTCpAAAA:8 a=Z4Rwk6OoAAAA:8 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=VwQbUJbxAAAA:8 a=hCsESo4FuRblPrCuPTwA:9
    a=kIIFJ0VLUOy1gFZzwZHL:22 a=dVHiktpip_riXrfdqayU:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeEOVku (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 17:40:50 -0400
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:3418 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeEOVks (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 17:40:48 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc: cpandya@codeaurora.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>,
        Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/3] x86/mm: disable ioremap free page handling on x86-PAE
Date: Tue, 15 May 2018 15:39:29 -0600
Message-Id: <20180515213931.23885-2-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180515213931.23885-1-toshi.kani@hpe.com>
References: <20180515213931.23885-1-toshi.kani@hpe.com>
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
index ffc8c13c50e4..08cdd7c13619 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -715,6 +715,7 @@ int pmd_clear_huge(pmd_t *pmd)
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
  * @pud: Pointer to a PUD.
@@ -762,4 +763,22 @@ int pmd_free_pte_page(pmd_t *pmd)
 
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
