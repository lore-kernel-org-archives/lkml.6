Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/LmNHkrHBZ5WH2+d1ZzImkX0T1Agd8FPUNq13DcrOqgeCzzFg750NaO0WA3eY21yZiqs91
ARC-Seal: i=1; a=rsa-sha256; t=1522742552; cv=none;
        d=google.com; s=arc-20160816;
        b=RH+YQmQRPnI+JkRF2jzNaAqkWms0RkoZemqT2jJF+cFLh1mGq63pMzkC4x0dzBTyNw
         kceQ6ZVh6ew8U+HslmccnyjfHcFmon1g98JcD+7SGwUx864WZ0NFAzdFgzNfUZbNSbhv
         TwJFRG9LteT0i6aGG0eyQB8vehlqWQsI/Nxi2euQhQUf7pkTtQezdHmtk6bm1Qsp3y6R
         fg+SRbUN87KsVafO7Co7SxNJ4FkxjkajmvVgFsH1HCBTXQNEYQ1YTV19ZRaisu843n8R
         EaDQ5R7fl5C8LEoVaQrXWOhBHQ8hKxBxij5dYnC7RIx6QtzOr7GzctlPP2m9LBK0t69O
         DR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=u2r8QUXuWgESiiNQgZ8q+LKQNcJ7J2hG7+CNhfcAYRY=;
        b=FjW/+QgfbKAFzCFfRNRAjf6ARBBPeGoRTv8aL4xtsdwpLPUiEN6wsSwd3/o+5Hj3Kn
         UugC8mUU/Re+IvdG6xECao4qe//fpzyAe33sLdmSPZTTJ8FrdzuyMf7xn51tE1FzagqP
         Bj82FPtZzkUmmKBwN9XT1sRMc1kThzTHyWOIavs5+uCUfegHJKiJheCr/Yb2Y2ju9uNA
         Ht4+XpYUFEy3+py3TExzCBvMa6XBhR4/JkZFqHr7rDfeZHDJwK3SEDTsoZVWsXJU9DL1
         gYoDW+Mdl5SImLil3jlvE0vuGKBuZ9VnXb0pf5AUlDuI+F4fHXW9VseHJdpg5LeBRUl3
         fqJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NukxegOv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZGkAKI29;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NukxegOv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZGkAKI29;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABF5C60C55
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	toshi.kani@hpe.com
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
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v8 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
Date: Tue,  3 Apr 2018 13:30:46 +0530
Message-Id: <1522742446-5084-5-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711294688226022?=
X-GMAIL-MSGID: =?utf-8?q?1596711294688226022?=
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
index 0f651db..170009b 100644
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
