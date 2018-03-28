Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+YqsCbcWHS7H1KYzZ0fO/R9k2T4GfMevBB10aFBwUJsYhjdmIDxvLgZOwqg2VqIwc/HKeg
ARC-Seal: i=1; a=rsa-sha256; t=1522240327; cv=none;
        d=google.com; s=arc-20160816;
        b=MIAZHLgRhurwTCMnRxUWomfBKwPLIeJmGiwsYjOfgzztasNaJMUP1AVxy0TNb9oChh
         YPepaW5O0K+KRVIyNVAkTGVSasB4XPhbjNMrdFzwn+rtVFYax8ILVaxlPREA3g/HbFi1
         Fp9k8JT9bsfeFtTDae+S4amiYtI87wWFkdVfWTSK1j6FwM3XYKsPv51b9/da78WMocRT
         Cbnj8MzSinfRYmjI0xxObzZBQDwFCLTinISe9wUt/6e+ArKdtjosvEitJhgBL49rQAr0
         vWcC/bApRfpmRjEawzXcp7483v1bZMke9KIy6W91DjWMb2jZlQ8Q7Wc07IboDDnKak/Z
         fvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=u2r8QUXuWgESiiNQgZ8q+LKQNcJ7J2hG7+CNhfcAYRY=;
        b=sEhd7omBSQzuOWwSzg2G0Uvs3cxcp43sEBRbwla//X9q/fFkmEYwS+T9qbSeLPf+gd
         kK3qG9I60NTNvnm8TrhjfsJWQwlRbF4j37TpL6UqwOw68N7lyrFoK3XLJfyxO9Orq36t
         CZwh41bDzQwOBXw0BcC0FvsdwL7BufUFp/PwW3/zX8Ua3DXpqWvZNv4ABSuh9KufctPd
         9G2ABwDa/aSM/zW5mEMy773i1WQPR4QZIAAGXzjdugjVd4WtGOcQlLDDEqYPoOuQDd41
         QfiA4bJHo499fescUZjaTY48ndHPpk34w1cfLSad2SzhomKJQIcY+V/TLvRcN2/9ew/i
         H+RA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZvNV7gWu;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ix0B4MvW;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZvNV7gWu;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ix0B4MvW;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA0F26110D
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
Subject: [PATCH v7 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
Date: Wed, 28 Mar 2018 18:01:22 +0530
Message-Id: <1522240282-12104-5-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522240282-12104-1-git-send-email-cpandya@codeaurora.org>
References: <1522240282-12104-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596178856142532375?=
X-GMAIL-MSGID: =?utf-8?q?1596184673930335586?=
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
