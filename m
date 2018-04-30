Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AB8JxZoqEqaj4UMNzI5usROumWy3bmEGlrHfRmCJD01mF5TGm0PGcIsMPZ5B1m6b5AdtsUZph07M
ARC-Seal: i=1; a=rsa-sha256; t=1525074152; cv=none;
        d=google.com; s=arc-20160816;
        b=iYw5CFCD2JgzUB2y6l6pveoOzxWW1MUoB6Rtnt91PYh1m5BjekXUS1v13GOBmVUG52
         ov+iNi1Qs/0QLAMZppzlrmcUTvVEK9WCU2ZjJYcXTNsCd+hmkuLPK9Z3rswgW8RryInw
         P/S9KbHucai6aTARPADd/Oxp/jXajrzUGammoGAlsVmMUg+e7WAhfCDJ58oFGbMlhx91
         GvektTozKWmvgzkpUKSD5fY90GEhevyAxVyYq9h+PzSqkXLPsT5AJAwdS6E6IZPTOw5L
         g4HuaZn02jFf0EXFmP8AiMovEhbEeIgtCImSkyW06DczwqR8VCTeaat1jjyHlK6XAxYS
         ZWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=u2r8QUXuWgESiiNQgZ8q+LKQNcJ7J2hG7+CNhfcAYRY=;
        b=mVwE4wP2rcfUbUEWLG1dcKvk9iOWNCYVyh0BoJAkPUpbTX36IJ6HtqRIEQD9+oGySZ
         DE62QyIk7j1/QRvLwfUfBOXCU+q5TFJo8PY38nkpiG+yfpXnK29B6/P90kRlVoec3rIf
         n/wop6lDH6i1Dnr1IjR8wG3/gFPGvJJ34AHlQ4DFZzM5cl0Ig0tA3XtPk5SOfLKD/QS7
         NqB/7pMW5XEsLBfeapg4Noh8hLViCBWCWh7/n0DOXEchbtuyoZ2jSE1UYzooMELL+2Z/
         qZVlehV7la8N3WSE3oBhu+z6PqDOf8b+sXK1OyQQzUU3k7OqAyswQ5/z/tpYgrvoHgEr
         mN/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=EszFPipp;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GBpo7HJL;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=EszFPipp;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GBpo7HJL;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2422A61133
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philip Elcan <pelcan@codeaurora.org>,
	James Morse <james.morse@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v9 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
Date: Mon, 30 Apr 2018 13:11:34 +0530
Message-Id: <1525074094-25839-5-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599156154517450059?=
X-GMAIL-MSGID: =?utf-8?q?1599156154517450059?=
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
