Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790521-2-3295405419827395925
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
    t=1519790521; b=h4r9THKGedxojkO7z4NYweu5/V1/B2MkMwWyrc0amWQPjop
    cB3nvHW1zgWvbisd3ZEHVfNv0zCkkCjad+SldXwU3upcKA6V4lDRpt4WRHi7S+sJ
    LkPI9NVX6w+wG0jAckY1GTyafTHQjIbMK+byu2YgXRGfdF86revoPaKg6qE/ynr4
    Pa7Kf0SMRXZXbjHvpi4b5hR4udI2dXC5GOqKQ8wPWcW2XPyaEYgWY97VvyRqIoUZ
    tnvrHDVF1xx2FORn1b5KSxbh+HjZuJ1iEoKe2OfZheg+9JJEOOKB4YaZmOMyElfY
    n4xskVJsvpWKFt3RDVcYRYv2Pk7xKDeyWnZ8Aag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790521;
    bh=PoybqqZSHPpCwyXKEdU/iRxK/k+IGVxzQYoov7ys+2E=; b=QqOfU0aOd1Ao
    iWuvJ3kArEogF/ISquLzmywVdzZRc/g7U6ReaxGUmuyQp4SvyP3i1mff/dp09eqv
    ifhydetnJ5fZb0UUcVuP+L5Pp29pj5Perk8nE6UeI3v3qpk+jxT/ym3ZgpkXJndy
    YIElTVjVYyDwONnFfUIcdNntoicT6c/mI31mZjDgID1hgMYQsvbScthgRNpEbiAk
    avq9tNOiZQkpjttIbO+Z8fCXL1QXxcUou7fF0dKJC+AOrcX0acMxilP1zAQsIokA
    aQeQKJqZmuTJE3V3yqLtAvaVvvI3Pi72q8KppfrzlYUPZaLe1t8fl5uLLS62C7Ha
    M0bd3+5Hzg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=V2xzAr5l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m3Drit5k;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=V2xzAr5l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m3Drit5k;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeB1EAV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:00:21 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44075 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeB1EAT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 23:00:19 -0500
X-Google-Smtp-Source: AH8x225D90VN+zl0PaeJjUnCZftqo0VnRdNiLcxKUzeQOzCZsvGL27EkX6LZYBSC9EfuvXfld/VnnA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Jayachandran C <jnair@caviumnetworks.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 23/29] arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
Date: Wed, 28 Feb 2018 11:56:45 +0800
Message-Id: <1519790211-16582-24-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jayachandran C <jnair@caviumnetworks.com>

commit 0d90718871fe upstream.

Add the older Broadcom ID as well as the new Cavium ID for ThunderX2
CPUs.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no falkor support in arch/arm64/include/asm/cputype.h
---
 arch/arm64/include/asm/cputype.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 0843b3f..9ee3038 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -84,6 +84,7 @@
 
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 #define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
+#define CAVIUM_CPU_PART_THUNDERX2	0x0AF
 
 #define BRCM_CPU_PART_VULCAN		0x516
 
@@ -94,6 +95,8 @@
 #define MIDR_CORTEX_A75 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A75)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
+#define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
+#define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
 
 #ifndef __ASSEMBLY__
 
-- 
2.7.4
