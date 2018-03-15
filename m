Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELsCJzZf9AKptOufdqC45nQdyMzkIw36XZngfZjBSB4/lVzoX2PmI9CNT47YlC1DUiCeUvWL
ARC-Seal: i=1; a=rsa-sha256; t=1521117953; cv=none;
        d=google.com; s=arc-20160816;
        b=elsEqtXaF5bMClwGUZrSfJUSTmqgHq0cF3cCrgOSqJO/y2M0a0lN/ycxrF5JgcIVI+
         G2vPZQPnuzUyAUr17p3WtW6uM4ApeBFshWQ6y2PJt897zGMyki0zTeGHzSKun85Ug3ZL
         Q7uNo7S0flWqpzHiCzwo+iRG/zfhTKdyMthBw6j+xqxXCLq9nXTfF9Bo4DHUPBbZCuGs
         UilJT57wjpo6OmHGWSLYEDANbVCeK1+iOlpNc8jB3S9440XuzzkNBYXd3z1c/riyIbRW
         gRP5iwx9f0lnZ405gMrTl2f7XGGjsgvdtwfehVnHMRZJtque2XpyffxfzVXRLpqUSUa9
         QFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=bpKHGdohq3xWPT9EsRYWPI6dZg8BWoFRa1FKZuzimFs=;
        b=KszcMdLgOqMImG5a5gRxyhSxv7C526H28SG79R++0gY2WjcuTtoC3BpNh4PM6LFW9s
         LlJs24ep8ZjxrAk26ZU3I9zHvz+0EPg+XD3LLhupkmlyuy8oGHYY1Jj7e9/Fip3WAZXF
         0JZpxI169JFohjya1NEjmXErx0h4eHJ16hPadRW3NXTvkzEJGbwZodOcKv5/QfcOBX4F
         uUbofKAEHsXRqNWy+4nOW/O20Q/7ywdQr3SzvP/yaVU29XF39S8/M7XBGmKb9v6zyl9r
         FG0gi9Enk4jaufn2IGS+L9IuBwZnj6JKfawUudqwe4DuNSBIzn+DmBHoRJgjuwbW2O2s
         9OlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WlCxiRB8;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=H8GQyqyW;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WlCxiRB8;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=H8GQyqyW;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2B1860FEF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	arnd@arndb.de
Cc: mark.rutland@arm.com,
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
Subject: [PATCH v2 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
Date: Thu, 15 Mar 2018 18:15:06 +0530
Message-Id: <1521117906-20107-5-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007779013667778?=
X-GMAIL-MSGID: =?utf-8?q?1595007779013667778?=
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
index 6f21a65..a1b8073 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -936,10 +936,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 
-	/* ioremap_page_range doesn't honour BBM */
-	if (pud_present(READ_ONCE(*pudp)))
-		return 0;
-
 	BUG_ON(phys & ~PUD_MASK);
 	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
@@ -950,10 +946,6 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
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
