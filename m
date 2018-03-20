Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELviQqY6kCHibLke4BDlXclzN5rrGgMWu4KAfA03GvlFqi0kgi42KGAvOEWjtsWimc48CGio
ARC-Seal: i=1; a=rsa-sha256; t=1521546383; cv=none;
        d=google.com; s=arc-20160816;
        b=U2eM7KMQanOTcwOZPPWOa3xUHyDMN6g90ZLlk4V44jvCmmOcyVL1P/3/5t/ztm+6x0
         vGsvHZpOq58y44YKBW+TO8KG6af/y6pBI806X4xg49UI8SOa4AjmXVYc/bpRhOjb9bMP
         JGeZxZocCkx3mj52whX5DTUqVraGdamflbISwFtUqGa5KTQ2oxLe3jhgOCPBoxe2XOpa
         oIg/02z5INlzqB77DB7gD4pCpWef8LcaZutXsK0eA6XQnry3/JC0PGPdBqxaEVBjEniI
         tLIpVF8WlxfpPvsEhoXb+jd6UM07o52iT1NRcvrmUZ6LHBJE2vT6b7xmdOabmhyjCKbt
         CmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/KvwQRJCYjelE1K4zfT6GlaJBtchU7L+GcAY0Ih9g5Y=;
        b=h1NZtIpRLiV2bMh3Rq5KWRZrenZU4BVuPlTOu6tNofAEnK3yJCesUyyTKUz2hvXIHg
         xx1pQOclxBpoo6aXMYT4MLxYtIIHL2nDNkgm35rjPuNeJ38GaKqGw2dn9H92F7zlxWqi
         PIa7JCZGn2y9uEv5KEmQyn9ajdmhaMMJuV/Q62dhClYrZiAHawSktZ7ER7susXJVJqT3
         i/5C52thRB9C0OI+b2L8QKCkNwCT95bTYIuWw/PlC3xgQ86G6AzSv8dubI8OvLY6rQKP
         xHZkBF10iLOLIWnVF/lpplloELO/4xhAeC+tH/5Y5XAb3Z1LbiV9Dn2NkaM+FEZKlaDQ
         pcTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Xm5KMqep;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WVm7FogW;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Xm5KMqep;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WVm7FogW;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 713F860F6B
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
Subject: [PATCH v4 3/3] Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
Date: Tue, 20 Mar 2018 17:15:14 +0530
Message-Id: <1521546314-31753-4-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
References: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595457020115340577?=
X-GMAIL-MSGID: =?utf-8?q?1595457020115340577?=
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
index 7be3106..1238717 100644
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
