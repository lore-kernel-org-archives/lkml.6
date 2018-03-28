Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx48g/CoIaK2TFoyzIp6/9va1A66h51Zwu+nXOeA0jhI8thNOZsyWG6WAKDTbyBpkgh8qb6sG
ARC-Seal: i=1; a=rsa-sha256; t=1522234779; cv=none;
        d=google.com; s=arc-20160816;
        b=V2bnB/iSgzGVrvEwM/cwAlpDn/AOjLgP1h6nStWyFOuDqetAhIGCS3PbfQ9wY4ByLp
         qwjU/sqjZjakelEqL2jtjZD5L0tDuM5KKPFiGgZrcIJ9o0OYoV55/xdthyOZoVowGXDv
         XyBVjPuSnhPvM6rpU9IZ9NTiw8PWTfgn2i2kAxiPdLv2nesAmYhdgahkOqkfWuzOdF+D
         hY8b144mR82/GLrDFaoXJG0QE/CkPRZFQE+fmjGIg9MSNS3jxhmdMANJeVG+Hyz4PuXG
         ghyMVFpwx+6fzKR/teZcWOoLjzN0smPR4ab88nPD1aoh2nkn0l1i8JwSV5BuVLqJmMuU
         xUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=eVPzFtzti5J7FxYmIMYrWRkVhy3wLfAGwnJQ9DlJSDM=;
        b=lHWYA1HPQNK1frjvLGKauhiDFhtevVq2OQom6eUMnbSwyd4h1cs094I1WUVW9FSskQ
         4xaAUppfd2Zzgwg4+4sancM0P+T5/MA/wEUzYgcV48sdvU+LEjzLC16XNzj23OcDCGF4
         gjvvS0Q/LxHzW1EcWzgzF+RvtzMG0BX46oViCHmGxSfGkhUMeN/r+BMHehAzKo1mHTj8
         DpICGAQymNSrMaLdD57vMEtnZgkzAmQPVSwPyNjf46dnYMURjL51tVu7Sh2EvRmoPbnn
         XKtUVoPS/ztFpSdZaC6T3GGK2+S540KR0Oq0ouUoYqz3/7l9JtIs4aJVP4jBjNvp+NI1
         tq1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Dq96Vkns;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eDIChwzA;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Dq96Vkns;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eDIChwzA;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC0B960F5C
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
Subject: [PATCH v6 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
Date: Wed, 28 Mar 2018 16:28:51 +0530
Message-Id: <1522234731-27397-5-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
References: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596178856142532375?=
X-GMAIL-MSGID: =?utf-8?q?1596178856142532375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit 15122ee2c515a ("arm64: Enforce BBM for huge
IO/VMAP mappings") is a temporary work-around until the
issues with CONFIG_HAVE_ARCH_HUGE_VMAP gets fixed.

Revert this change as we have fixes for the issue.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
From: V1-> V6:
 - No change

 arch/arm64/mm/mmu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f84b747..601f22f 100644
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
