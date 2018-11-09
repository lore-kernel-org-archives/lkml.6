Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F321C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B7620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKVD1wcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B7620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeKJGVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:21:47 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:47224 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbeKJGVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:21:45 -0500
Received: by mail-vk1-f201.google.com with SMTP id e3so683545vkd.14
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BV7rhakurU1AWkPC5l+AZsWY8HTPaGn55zHW5QZMdW4=;
        b=uKVD1wcNQGFPfemLDd88boZY+8v5esaYoAvtG6qmN78/9qKOE0AZLh+FPIYQH4/Y8m
         sBEbFD8xxfbryrXV1/rQGS8/9tq9NZag2fpfHFxwlsm9s1SUOoFVJ9LFQXotFH2/fsZw
         Ah2nIn89RlGU+SqpzsuvUE0bho2WaCcj1NXwuvXTUHQ0+7U6pEdxTZVaHY33BHVDYYGj
         Bn00w7q9DBhtj6bbvLjMOfJbyJEWWF98hDAXpThE9ZsEbkk3mHbOoRDBJuHzab1qVdqb
         Ltm7xWNmgTI7lzYmJ4hWNRbJTzXaoU+IiuGBgzFN/UFbKVChgKeEbb90pGeIfsyLNBE7
         AddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BV7rhakurU1AWkPC5l+AZsWY8HTPaGn55zHW5QZMdW4=;
        b=PIQiLRfqy3uxCwmggmq3F6e+kGxr/JtiXS6lc/6xkU5f7U40S17HHDF4/eCliWLLxW
         mDwiZmg2XrC9rbd+Y8enDu+s2V6T1GKO1OP9BjWSp+zxK/TMu7CMyGRRvBnZOjn0I0UQ
         haG0YKOO4s34nIXBPPpkMvA71rdc7e9NPn2vwpVbHbKAoYNodL1pYWwVJWjfZsLTZ0Df
         CubHe8NoBTM+uRULp+8yO639jA/ev1aVi6A7g+YZ9OKa/tKxz9L2HncwCP0jF3744U+y
         +i5R9eIqctF22dVNp8TzuVF/fDs7S11grsgAf7phFjf1C67viYg06A2XcYUbidoMtzns
         /VTQ==
X-Gm-Message-State: AGRZ1gInrRdzjZ/Df26naIezMKYONoTH3WQaQLcCr95k5UZmTwKmWdPe
        9dADUPDiocLl0mmNauOMSu6e62rv
X-Google-Smtp-Source: AJdET5dbQ+P6qIQlP79fD8VtNEBYDxa83xp81N1BJmzclE5Naz+tEJU+aIT3XYxO03rUY8yu4nln49At
X-Received: by 2002:a1f:cc2:: with SMTP id 185mr8595140vkm.5.1541795970837;
 Fri, 09 Nov 2018 12:39:30 -0800 (PST)
Date:   Fri,  9 Nov 2018 15:39:20 -0500
In-Reply-To: <20181109203921.178363-1-brho@google.com>
Message-Id: <20181109203921.178363-2-brho@google.com>
Mime-Version: 1.0
References: <20181109203921.178363-1-brho@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 1/2] mm: make dev_pagemap_mapping_shift() externally visible
From:   Barret Rhoden <brho@google.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu.c.zhang@intel.com, yi.z.zhang@intel.com,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM has a use case for determining the size of a dax mapping.  The KVM
code has easy access to the address and the mm; hence the change in
parameters.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 include/linux/mm.h  |  3 +++
 mm/memory-failure.c | 38 +++-----------------------------------
 mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de93a363..51215d695753 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -935,6 +935,9 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 }
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
+unsigned long dev_pagemap_mapping_shift(unsigned long address,
+					struct mm_struct *mm);
+
 static inline void get_page(struct page *page)
 {
 	page = compound_head(page);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0cd3de3550f0..c3f2c6a8607e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -265,40 +265,6 @@ void shake_page(struct page *p, int access)
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
-static unsigned long dev_pagemap_mapping_shift(struct page *page,
-		struct vm_area_struct *vma)
-{
-	unsigned long address = vma_address(page, vma);
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset(vma->vm_mm, address);
-	if (!pgd_present(*pgd))
-		return 0;
-	p4d = p4d_offset(pgd, address);
-	if (!p4d_present(*p4d))
-		return 0;
-	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
-		return 0;
-	if (pud_devmap(*pud))
-		return PUD_SHIFT;
-	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
-		return 0;
-	if (pmd_devmap(*pmd))
-		return PMD_SHIFT;
-	pte = pte_offset_map(pmd, address);
-	if (!pte_present(*pte))
-		return 0;
-	if (pte_devmap(*pte))
-		return PAGE_SHIFT;
-	return 0;
-}
-
 /*
  * Failure handling: if we can't find or can't kill a process there's
  * not much we can do.	We just print a message and ignore otherwise.
@@ -329,7 +295,9 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	tk->addr = page_address_in_vma(p, vma);
 	tk->addr_valid = 1;
 	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
+		tk->size_shift =
+			dev_pagemap_mapping_shift(vma_address(page, vma),
+						  vma->vm_mm);
 	else
 		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
 
diff --git a/mm/util.c b/mm/util.c
index 8bf08b5b5760..61bc9bab931d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -780,3 +780,37 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 out:
 	return res;
 }
+
+unsigned long dev_pagemap_mapping_shift(unsigned long address,
+					struct mm_struct *mm)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd))
+		return 0;
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		return 0;
+	pud = pud_offset(p4d, address);
+	if (!pud_present(*pud))
+		return 0;
+	if (pud_devmap(*pud))
+		return PUD_SHIFT;
+	pmd = pmd_offset(pud, address);
+	if (!pmd_present(*pmd))
+		return 0;
+	if (pmd_devmap(*pmd))
+		return PMD_SHIFT;
+	pte = pte_offset_map(pmd, address);
+	if (!pte_present(*pte))
+		return 0;
+	if (pte_devmap(*pte))
+		return PAGE_SHIFT;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pagemap_mapping_shift);
-- 
2.19.1.930.g4563a0d9d0-goog

