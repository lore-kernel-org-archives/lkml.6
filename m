Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELvgpnMj4q4JPNUea/uDZAt0jpjIsyElhqZSCuaCL5mwfTQw4UzlptvLzcFA6NFiInTrfDAD
ARC-Seal: i=1; a=rsa-sha256; t=1521017351; cv=none;
        d=google.com; s=arc-20160816;
        b=FIvwv8koTWNkJAuTRKHlfMSnpnm1XyR6r0Rbd+l7dqtsk0tBC6QthcPmOLNxwtg3IR
         c63gHYNH4zQntbQm1weB5DnVTiqH3hZWNa3BI+ajZit6L3Yc/ZexgacBQeU2fWA6IC8j
         +rLS6CS971zPnkRun1juBWRTrD5IUNvjgXUTjf8psDl7XMVSHJdhF9uLXiadCPnn2gmG
         RcODUXtre9k5Lnhs/LMslhJJqZ2AQoZSw84nOPXVcLAoC3LDXXS5urnbw2PSyOSsS8i1
         i+sJgEzraEk3KcKlqQXkt1SP7Ccl+ERPQRpDymW4ei7YDT+fya7oxn0kbktZXRSmislp
         EIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=+TVdfKGRmp7qtPHpFgWe45ByWnnPmkoff+bIy3YtaTc=;
        b=iMot5j4eFBwHyztxksqobX0btzsIm41evMJd9IBKXNEovyecxu+iJLxPmvwvChDzCv
         WCZWjP8lYFv8S3qYQmVDOkNfZeUjGnq0BSQ5DBLyGWcdkNy54uHJFJc0Fb9Hk7Su2kuY
         xlASIMjby6gLkASoXVKx32LzinavGOcv1TdnBhSxRI0dj1RDsv8DX4Q0X7U0eLV1mES9
         MKXrz9iI/TGNqu9XUSr2fObXR8mtK0EiAPUL04/mszfieu94wfJvqtnANJUzCn6wHzsO
         25IIOgIQB3xbp2tpkcAvYPU3XF6uKkJ23kfAi9L2ebm4aW5EyK7WnDqoUppfoRZbKzs5
         ysTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FCd5/yKA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PtSomUgD;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FCd5/yKA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PtSomUgD;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D215060F90
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
Subject: [PATCH v1 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
Date: Wed, 14 Mar 2018 14:18:25 +0530
Message-Id: <1521017305-28518-5-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902291066991790?=
X-GMAIL-MSGID: =?utf-8?q?1594902291066991790?=
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
index c0df264..19116c6 100644
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
 	if (pud_val(*pud) && !pud_huge(*pud))
 		free_page((unsigned long)__va(pud_val(*pud)));
@@ -952,10 +948,6 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 
-	/* ioremap_page_range doesn't honour BBM */
-	if (pmd_present(READ_ONCE(*pmdp)))
-		return 0;
-
 	BUG_ON(phys & ~PMD_MASK);
 	if (pmd_val(*pmd) && !pmd_huge(*pmd))
 		free_page((unsigned long)__va(pmd_val(*pmd)));
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
