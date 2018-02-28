Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218881-1519790603-2-8853615697210128918
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790602; b=If2DYNkeFWnWbKvwxaGlhsmPa4T0zNzswcUGDDuvVVBPtub
    g3Cj1+XfjfyHXL4V2H+n8QS4E9I3+MGijHq5a7pBQpPa7Qrf9Efjmy8mFQTP5NYl
    5cjg7wnuFYiyrVRih5zPHN4A3LjyAP73ycGQu7EHWi1HiN1mKWWwdSl+15InWERw
    WkXXRWxr9KlX0JSLXBf4Oi0U8kCBTo0uR+uu3Lj5IkJ4pmR++ZdupV9eEZj9y9Cl
    xPTo8nEsp6fG44f+WjWUZpb/DCJiqKdDLMPBgHEUFBCM8D38vJ8MseUon6sHqw6f
    UqDoWO7EAsUvWFU7s1LEuhpbALfS8wBupMeYwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790602;
    bh=tyMA723Y2s+lrou1aTVC8Ls8RrTZ3RWM2Sb0Xk16jlw=; b=mh+QlUECc0a5
    blEbt9ikFIrKFILoELFD60ZFNVVav9awlWVxbroyO/H0UHWA8zw1VpT9sjgYywwe
    UCauirSWxVoEw2lxvlSs7N48KYEv5ZP/hg3lf87LdmxUIB6nYlT4ixAaNeUtPM4/
    Ncx5KZOdIl8dqAvhpv10Y0PE6frc4OutSUxokNg2ZSYRuWgjQs1TVqTZ5Gy3/QmR
    hjJHZGdvza3tuGIxwb3iIpEQvsKhzWkvzGya0o81To66LIT++uLqLeF0rab8G26V
    o3TCuyLY6w8bmecvss2OjQpTHBvRtON/ZaFagI6wptTeXi6N8RsdaahT36wTqMDW
    RJ4B4XlDRA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=bucoZaPh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RQHgW9gd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=bucoZaPh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RQHgW9gd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932117AbeB1D70 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:59:26 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42745 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932112AbeB1D7X (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:59:23 -0500
X-Google-Smtp-Source: AH8x224PsbGskRSBwrMX55A0RutJDGSRDAjXCiImvD7fakEzt0UVksZR+km+KDkfJEK6Qmb1gdbGBw==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 15/29] arm64: kaslr: Put kernel vectors address in separate data page
Date: Wed, 28 Feb 2018 11:56:37 +0800
Message-Id: <1519790211-16582-16-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 6c27c4082f4f upstream.

The literal pool entry for identifying the vectors base is the only piece
of information in the trampoline page that identifies the true location
of the kernel.

This patch moves it into a page-aligned region of the .rodata section
and maps this adjacent to the trampoline text via an additional fixmap
entry, which protects against any accidental leakage of the trampoline
contents.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	remove ARM64_WORKAROUND_QCOM_FALKOR_E1003 fix
	in arch/arm64/kernel/entry.S
---
 arch/arm64/include/asm/fixmap.h |  1 +
 arch/arm64/kernel/entry.S       | 13 +++++++++++++
 arch/arm64/kernel/vmlinux.lds.S |  5 ++++-
 arch/arm64/mm/mmu.c             | 10 +++++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 7b1d88c..d8e5805 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -53,6 +53,7 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	FIX_ENTRY_TRAMP_DATA,
 	FIX_ENTRY_TRAMP_TEXT,
 #define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 54f35cc..996c605 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -903,7 +903,12 @@ __ni_sys_trace:
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
 	tramp_map_kernel	x30
+#ifdef CONFIG_RANDOMIZE_BASE
+	adr	x30, tramp_vectors + PAGE_SIZE
+	ldr	x30, [x30]
+#else
 	ldr	x30, =vectors
+#endif
 	prfm	plil1strm, [x30, #(1b - tramp_vectors)]
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
@@ -946,6 +951,14 @@ END(tramp_exit_compat)
 
 	.ltorg
 	.popsection				// .entry.tramp.text
+#ifdef CONFIG_RANDOMIZE_BASE
+	.pushsection ".rodata", "a"
+	.align PAGE_SHIFT
+	.globl	__entry_tramp_data_start
+__entry_tramp_data_start:
+	.quad	vectors
+	.popsection				// .rodata
+#endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 /*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 466a43a..6a58455 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -252,7 +252,10 @@ ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
 	<= SZ_4K, "Hibernate exit text too big or misaligned")
 #endif
-
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == PAGE_SIZE,
+	"Entry trampoline text too big")
+#endif
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 84945c9..10db4bf 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -435,8 +435,16 @@ static int __init map_entry_trampoline(void)
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
 			     prot, pgd_pgtable_alloc, 0);
 
-	/* ...as well as the kernel page table */
+	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+		extern char __entry_tramp_data_start[];
+
+		__set_fixmap(FIX_ENTRY_TRAMP_DATA,
+			     __pa_symbol(__entry_tramp_data_start),
+			     PAGE_KERNEL_RO);
+	}
+
 	return 0;
 }
 core_initcall(map_entry_trampoline);
-- 
2.7.4
