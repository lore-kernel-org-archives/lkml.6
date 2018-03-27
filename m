Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx48sGEMWFZ/X7oDsYI7o/sDgzXIAqVpXj/aIOaFK3zRpwp3EtISQ+pSfs1lQ5RokFq+lItnC
ARC-Seal: i=1; a=rsa-sha256; t=1522157147; cv=none;
        d=google.com; s=arc-20160816;
        b=vBZL8gT9/fQxILdbe6DiYHqyj2huuHyeKdI/VLu9eZgqmJtRLGPgQDDqFVOGxM6qNn
         LO90dfMoh5+/MMyvzh5mbr1T2mlIVOVZTPB2WqOOEUE2ozwvqNTRsyCFnggz5fg/PWMg
         mqQl78ywFkvcNViDWIIP2csopDy8+vj+0Zr9DJABzv3c3oV2TNV0fMM+1IUrsHIkFbJ8
         1cQ7t+UXAe/viBzJ9cwU5299NWx7ZWwoqUA+UxKZ2QAxU/5BSRuUmKOLNKwg5ko/Jnnx
         ITVGqZxH9ieXSflHbZQEVdqiMXlnweQNLIMEXV0Rmj8sNz127Rx1zPtrnBOVvFeO1r30
         M9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=n1vwegt+6DRasrRycibIpsNS68VxdYal5myjEW3lt40=;
        b=fs9B16hodxlNG7izekD+H2fWabIAm5YugpUTEtMXUYdGjgxsfdwJwmTorLGHexaX9L
         Ij82AsOV3CvKw+yYJf9lbt2eHhoiCSD99DWuY7l6pwI4K99aSZTYdtZIhTGlsoKSmfm0
         IBYzVrsDLCLMV2/ia6NpKkJwHBEzbhhLh3rMK7FeAXN1kGHwcO33QFYiR64qLvJgEEJZ
         SX60tUme4kHKgHZ4ypoXq4+KeG1kh4/cWAp0dUmAIAd8MLd1gVAhZD407X1fTcixFcFT
         sGfAIOsmGb+dcnFaVFV7Qee1uyKsMEW/N228E4L+/u3sRZrvt2Ki5s+ABw6Lglo8K/XT
         x0Hg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=O3Ud7HjW;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G89N4Jbl;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=O3Ud7HjW;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G89N4Jbl;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BAE460F6B
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
Subject: [PATCH v5 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
Date: Tue, 27 Mar 2018 18:55:00 +0530
Message-Id: <1522157100-16879-5-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522157100-16879-1-git-send-email-cpandya@codeaurora.org>
References: <1522157100-16879-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596097453325344623?=
X-GMAIL-MSGID: =?utf-8?q?1596097453325344623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit 15122ee2c515a ("arm64: Enforce BBM for huge
IO/VMAP mappings") is a temporary work-around until the
issues with CONFIG_HAVE_ARCH_HUGE_VMAP gets fixed.

Revert this change as we have fixes for the issue.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
No change in v5

 arch/arm64/mm/mmu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3552c7a..11a24a1 100644
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
