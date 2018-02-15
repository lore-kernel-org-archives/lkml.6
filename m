Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708677-2-14390411216760112011
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708676; b=DH9S/uuJtTpahh7u4pA+ufo8hv05kb2+Gs8/ooet+yoN4p8
    3ZgJCjIrutTXhWIU/YaWH7hjMl3SH9Z/3b8G3tE4/RyTM1TJ30FrqBj0QrdoG0Bc
    K1NE+9rwwAOZO2bLxFOXsLRNGRwxn4hSeJWZ3ejodFradc/RvQpZo73b3rzqy8Te
    zBzmtxsGK9jUZHxIRkZI0F6RNYaA6dJH4yXd/HeM5EtTQRLJjSRR9CpwKshnD0FC
    K8OtIRRfpCRLmtntBLT0oNm68KRUewz27JG/FZ8uLpcAcTWVkR4VwB7uZHImj2et
    i3M92csCv5RWWzPcsOGflkd0C/eQIyrBwxdEN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708676; bh=PEifYB8Oc5K5mxds1Y4Xd1TL57
    x69Pwexi0T1yCR8L4=; b=DVeQ7U154UMK7TPCLcqpsFS+xLUgVME2j8u4JC3V7F
    5WSwkrns8t1LWK/G+VSL7i6/xh51Q58KdXG46X4qMGtIDJX2Ceo4OlAshHeLrzxr
    HppSKRJX/cgrAL5JlLMqClidFyLNSu7iq/uv6oLqr1KkNh//+RDVpKf698E8dUFw
    FovTVVxL9nu8cI0Q0oMQ3mWjIHVGPwFKeKX0mTtsAasJfuFs9Sba+EWUK+yh+/tE
    CDmmqC5PJsbb387yquePJqBYo9uQAoEtdzR+OGSw2+wubPgQq0989E1i4FuxLa0/
    4Oa8gXFQ4d4tk1h2OCXmg0SbjjFzTQ/LzCqN7gNkrPOg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164355AbeBOPbN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:31:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164354AbeBOPbM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:31:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 037/195] [Variant 3/Meltdown] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
Date: Thu, 15 Feb 2018 16:15:28 +0100
Message-Id: <20180215151707.595146959@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <sboyd@codeaurora.org>


Commit bb48711800e6 upstream.

The Kryo CPUs are also affected by the Falkor 1003 errata, so
we need to do the same workaround on Kryo CPUs. The MIDR is
slightly more complicated here, where the PART number is not
always the same when looking at all the bits from 15 to 4. Drop
the lower 8 bits and just look at the top 4 to see if it's '2'
and then consider those as Kryo CPUs. This covers all the
combinations without having to list them all out.

Fixes: 38fd94b0275c ("arm64: Work around Falkor erratum 1003")
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arm64/silicon-errata.txt |    2 +-
 arch/arm64/include/asm/cputype.h       |    2 ++
 arch/arm64/kernel/cpu_errata.c         |   21 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -71,7 +71,7 @@ stable kernels.
 | Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
 | Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
 |                |                 |                 |                             |
-| Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
+| Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
 | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
 | Qualcomm Tech. | Falkor v{1,2}   | E1041           | QCOM_FALKOR_ERRATUM_1041    |
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -92,6 +92,7 @@
 
 #define QCOM_CPU_PART_FALKOR_V1		0x800
 #define QCOM_CPU_PART_FALKOR		0xC00
+#define QCOM_CPU_PART_KRYO		0x200
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
@@ -101,6 +102,7 @@
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
 #define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
+#define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 
 #ifndef __ASSEMBLY__
 
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -30,6 +30,20 @@ is_affected_midr_range(const struct arm6
 				       entry->midr_range_max);
 }
 
+static bool __maybe_unused
+is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	u32 model;
+
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	model = read_cpuid_id();
+	model &= MIDR_IMPLEMENTOR_MASK | (0xf00 << MIDR_PARTNUM_SHIFT) |
+		 MIDR_ARCHITECTURE_MASK;
+
+	return model == entry->midr_model;
+}
+
 static bool
 has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 				int scope)
@@ -169,6 +183,13 @@ const struct arm64_cpu_capabilities arm6
 			   MIDR_CPU_VAR_REV(0, 0),
 			   MIDR_CPU_VAR_REV(0, 0)),
 	},
+	{
+		.desc = "Qualcomm Technologies Kryo erratum 1003",
+		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
+		.def_scope = SCOPE_LOCAL_CPU,
+		.midr_model = MIDR_QCOM_KRYO,
+		.matches = is_kryo_midr,
+	},
 #endif
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1009
 	{
