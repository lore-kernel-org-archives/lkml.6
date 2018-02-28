Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3238909-1519790686-2-17045211876496530037
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790685; b=L9b6qY7KzW8WJYsU42QU1hGTxXN0fpN6I3TdRoL6jqfHQHv
    330CaDjc+DZ7RDmRR88RBYs1M4d+DPOLiSgctsen3pmi/sp73HWGZz8cYwhJU2Hh
    E525Bpn0oizyv1JlaFK8D/muLw8NNWYzopumlTfje0kezcuTuh1VMXKH+mGjRETt
    UQbWLCsXHM+4ZnlQf/dyN/aTuh2DPIVVSdZorqbNveWXgmmV8PTEGuL9v1ZCn+x+
    ZwQeavGUx753JXRQYyXi/nTJfuXk+4uIsQtexET7YXQDgfhVxUnZIqaG2IouNGEo
    5QP8kqOkze2rpAL/+p+RnqYUs5LDi/UimxXAvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790685;
    bh=fBaV2So5mLi7XEyJz2SzruPt01XLduxFQhFmGwjPC28=; b=CPTMYfpqEIrl
    WroW6q0szUwwCx2ggF9rr1wu4pttfrNK4jpfi1lqzewwAVbeFNbFixunAO3dvSYI
    UzfgEfsWYqoSE6v1ZFdSLaRzh2sgA8IZFYRI+Nx1zxwQrIWiY6Xv/F2JpsfKOHCZ
    U5aUibsDRnsFR3XKbUJP3W893WDIO+QKIAt1KmU8g3H7ea1jWvkulIDmh/cytZBw
    B249RziuiwUU4wmuF3vemt1M0a8kEgxn7DbB4tAb1j9kwd5pJAFpwq0MuF9cTMy/
    pFuqAlMOaiWdasiOfclanSJYRuto7b9egm2kOgbD8VoDCxK9hU1bg1USV1ZCQNZq
    /dEl8xo2fw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=LtkiNWUt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YXJ1Y0Uk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=LtkiNWUt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YXJ1Y0Uk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeB1D6B (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:58:01 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35019 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeB1D56 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:57:58 -0500
X-Google-Smtp-Source: AH8x227NNwt59P8zNFltxcKEDfIxLuFyVjMkn1WYR1Yh89ilf5IOVtnz1MLHzpwnHzQvYwaA911tww==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 04/29] arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
Date: Wed, 28 Feb 2018 11:56:26 +0800
Message-Id: <1519790211-16582-5-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit fc0e1299da54 upstream.

In order for code such as TLB invalidation to operate efficiently when
the decision to map the kernel at EL0 is determined at runtime, this
patch introduces a helper function, arm64_kernel_unmapped_at_el0, to
determine whether or not the kernel is mapped whilst running in userspace.

Currently, this just reports the value of CONFIG_UNMAP_KERNEL_AT_EL0,
but will later be hooked up to a fake CPU capability using a static key.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/mmu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 49924e5..279e75b 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -18,6 +18,8 @@
 
 #define USER_ASID_FLAG	(UL(1) << 48)
 
+#ifndef __ASSEMBLY__
+
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
@@ -30,6 +32,11 @@ typedef struct {
  */
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
+static inline bool arm64_kernel_unmapped_at_el0(void)
+{
+	return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0);
+}
+
 extern void paging_init(void);
 extern void bootmem_init(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
@@ -39,4 +46,5 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       pgprot_t prot, bool allow_block_mappings);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 
+#endif	/* !__ASSEMBLY__ */
 #endif
-- 
2.7.4
