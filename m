Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EA9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBD42243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnaaG0Km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBD42243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbeKOIuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:50:10 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:40955 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbeKOIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:50:08 -0500
Received: by mail-yb1-f202.google.com with SMTP id i15-v6so13688318ybp.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Swrg/Ql+aoXKDVqM4rUHKdjFWS7RdD4POWqk40vnoJ0=;
        b=jnaaG0KmPOtIngqfLHs7bFlfg63KFl/U07rJ2rlJdTOgtRPOkzSQrjiKwuWtic29wg
         Adla+90Mfzw6DYeictWdIx/CtriY3V2yAC3N/4sDyJ1z5kQaboGKHOlDEDJmvVI9usSq
         Wu90dimuVYQSWXVklUzKdX5gxRhFKmSGS646EGQMALfcaaJelGmUfaPGKjDC7Q4WTZur
         wqYCHPrF6S+DrYv9fpg7DBSrDW6zW7/kYR+0xTyiy2iD1Sh8eZO46z6E8JbR+NHD0iX4
         AYw+y0vHCs4rGmJNpZhwOyqKF0OHSJbMsEZrAQslEd7SEvArL27n2/+OkcRxQuHZjtVn
         grfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Swrg/Ql+aoXKDVqM4rUHKdjFWS7RdD4POWqk40vnoJ0=;
        b=AXPRqrDMT+9B4x2FWJLfbFoFoxe5u36dRfl3y5vK5roldveMzvJtWUayyaoLIazzFs
         h7Oe+TpRf/ksN384q0e9mnJnVWmg2I4G+4L5r712KALRIi1ZYFg6vdvyvdT0KkrZsabl
         8gGSjsos+zcOE4DxvHYExTOtGhYr0Y1/sDaSdfsMT37bdyN/KJHBkLnPEZkP433fag0X
         kPPPFmDPGunvkfsZ9rD+dHdSgHr0ybFDYYHg645rod59/7Hb1OQO4ZTvKlDpeTM1d6ZD
         B9O2xTv2tsUpv9GtXhtqSRQyQKwMqBHSdQwiHXDJVK6TLqqqSp3fy0hPO0jGwhaNmCcd
         DnvQ==
X-Gm-Message-State: AGRZ1gLv80VevsNJjm38PFqio/IpNJrO87DghfiWNWkBqhQQsvoJ6/TC
        tGV42LkefGpEVnJbzMJ5C3NqKpH7
X-Google-Smtp-Source: AJdET5cydhrPOQA/wDgBNBMiRvM6xC5Bw1OO7w1/3WOMNTH68+Tk7ymaB2i9Hz2qGH2RLHvnvDmsz8w5
X-Received: by 2002:a25:3a03:: with SMTP id h3-v6mr1580605yba.77.1542232383861;
 Wed, 14 Nov 2018 13:53:03 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:51:53 -0500
In-Reply-To: <20181114215155.259978-1-brho@google.com>
Message-Id: <20181114215155.259978-2-brho@google.com>
Mime-Version: 1.0
References: <20181109203921.178363-1-brho@google.com> <20181114215155.259978-1-brho@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v2 1/3] mm: make dev_pagemap_mapping_shift() externally visible
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
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM has a use case for determining the size of a dax mapping.  The KVM
code has easy access to the address and the mm; hence the change in
parameters.

Signed-off-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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
2.19.1.1215.g8438c0b245-goog

