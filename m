Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELsgdY0gw7jAOs/DjxpuphBVlsBMLrAggtcTQ4j0m/4Nwh1JMp4dkWyj04hN/gPMNLGsKtVc
ARC-Seal: i=1; a=rsa-sha256; t=1521463300; cv=none;
        d=google.com; s=arc-20160816;
        b=uHb9VukXONNfEOh8c0jFe/I/IALuDubwsE2odNrt3iy8U/JQhpyrUb+8AwHQRGPxXv
         /5RBKiKHJ+Beg/ExVgV1kw+Lnzf7v3tp9Q3XL8Z0EeCMB3MhP2jpLeFt5qTAVXmXVNn/
         AUiJMAAsgDwLdYAbC73JhmWWfEBWF/QIsLbt+qhbWpDpxKqHtzLtwq0td3pFvmeSnCpa
         EYl4l3aNNnHsrFjQ2A6uD/Xnhq/KYyMbPqnGUEXazEYXhrKrzmD9PmUYqguZiOwSz0eP
         iZexe0MJ0uPESzHdDB/yXLEe6aJYoHcfOzAZt0YnqjaHve1RcvWpTd7piHNfzJCyrbJF
         8Wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=7nSf7oknGm/epL63Ldhm1CAaIXJab0fI4VB+j7ZzDjg=;
        b=LLQIUYP3N9c1a9QmxwF9TMXJ+CaHo627sfnpWxlGpDJefL0lrxFObu4dnu5aDflDr1
         pnZA0ba+yQKl+CaXlaxnkj5hN0Ndv/QOO/ugFy3jXqRdvuMPCIP15Nm+FBGA5TUrOqc5
         y5Ly/38lvCESr4xIwpaDkt3f1Ru1JJVLaMrFGE+wbiAdLvSPHvKcsKyg1InNzPnKmqs8
         Hwoy8Pf8zJRcVFAAgXOXnui9RVXRZIGjDTDrtem1QPulFC8vWceIN0HzssGee35jKRiV
         qC4c2tS+yfcrRJ+KHnTncpi2qRiGIpxXMffC+uWzbUeKu7t1Z6QmIWYTsVhy1fMcp8if
         y1dg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=aZpIHoEJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hAm0re8G;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=aZpIHoEJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hAm0re8G;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9058560C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com
Cc: arnd@arndb.de,
	ard.biesheuvel@linaro.org,
	marc.zyngier@arm.com,
	james.morse@arm.com,
	kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	akpm@linux-foundation.org,
	toshi.kani@hpe.com,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v3 3/3] Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
Date: Mon, 19 Mar 2018 18:10:56 +0530
Message-Id: <1521463256-19858-4-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595369900688771074?=
X-GMAIL-MSGID: =?utf-8?q?1595369900688771074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit 15122ee2c515a ("arm64: Enforce BBM for huge
IO/VMAP mappings") is a temporary work-around until the
issues with CONFIG_HAVE_ARCH_HUGE_VMAP gets fixed.

Revert this change as we have fixes for the issue.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c70f139..a29a684 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -935,10 +935,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 
-	/* ioremap_page_range doesn't honour BBM */
-	if (pud_present(READ_ONCE(*pudp)))
-		return 0;
-
 	BUG_ON(phys & ~PUD_MASK);
 	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
@@ -949,10 +945,6 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 
-	/* ioremap_page_range doesn't honour BBM */
-	if (pmd_present(READ_ONCE(*pmdp)))
-		return 0;
-
 	BUG_ON(phys & ~PMD_MASK);
 	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
