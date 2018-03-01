Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909683-2-2442542489708961649
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909683; b=rWf7qGmBktNXuirImEN/Ra5gMyxEB0vsgOa3S9FiVF2ZHDE
    CMv7EfAjcUlDitjZY9YSNVCnI1N+0qBh7QaD+lFmHC3/MlChfOnZDMAg7UCB6eIj
    lf//xMrMZA9Xz0vChuciPKBfwnYTAZFlM4YE0lIeAEh8j2BSUICBWB9NPAkkd6tB
    IIEq6R2MRTfjMD2roBTMktdvfSd7AqeZgEXwA50bg9eFaBzu3/I0FA9oqjKz97Bt
    xIC4c7zyfzwOZD+umLCxzpTU8yNoICbdJX91nzzjl/Y+rBq2nhA2epjH24FTDkHt
    DBW10jcRqHKpEn5zB6Pxw9q847djfIu8tQI8fWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909683;
    bh=nelMizWy+r+xl1PA+JMazlupbHfphoojSqCggA1RmD0=; b=HL6cWxqlHLzo
    H74yWR4PUKOZwKa2x5MQ4xBI8Gsxz391yB/Z6m8I+TdGdDnxliHNrQIWK1wlOqNK
    qMTm0Yb/AiTL4BvTYJ8ZLV1JZcYn9zZ6VmU/4kOMooIbXWym9cFb6dLRzpF4WW0g
    yrHsHwAPezxp0e+Z8GfLYgEWTvBHML/VrHZ7TNRiUpQ8qUnvG5JRHYrYCqkhPT5P
    rY3KCSKd88t6BZfjsr9uPaeKlTnCsrUVnR2y4k2TBSO9DGqC9Twa3OyGmsh/sI7w
    azdiHsT+NcKZai9ULqL1lfBGugVfW++XzMPJAseOcXtHwTYJokJqcr99l7B1+m0q
    DJKZrVDCeA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=e66C1+HX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Kvv+jNMz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=e66C1+HX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Kvv+jNMz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030575AbeCAMzf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:55:35 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37271 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030549AbeCAMzc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:55:32 -0500
X-Google-Smtp-Source: AG47ELuKD7Llr/XORPs2mfIfUEgrAOTpufWqOtqwZfIVj/m6WYO5W7T84jnmC1IiEFnUd5P3mR2G9w==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 03/45] arm64: barrier: Add CSDB macros to control data-value prediction
Date: Thu,  1 Mar 2018 20:53:40 +0800
Message-Id: <1519908862-11425-4-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 669474e772b9 upstream.

For CPUs capable of data value prediction, CSDB waits for any outstanding
predictions to architecturally resolve before allowing speculative execution
to continue. Provide macros to expose it to the arch code.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 7 +++++++
 arch/arm64/include/asm/barrier.h   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 851290d..8760300 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -87,6 +87,13 @@
 	.endm
 
 /*
+ * Value prediction barrier
+ */
+	.macro	csdb
+	hint	#20
+	.endm
+
+/*
  * NOP sequence
  */
 	.macro	nops, num
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 0fe7e43..c68fdc5 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -31,6 +31,8 @@
 #define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
+#define csdb()		asm volatile("hint #20" : : : "memory")
+
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
 #define wmb()		dsb(st)
-- 
2.7.4
