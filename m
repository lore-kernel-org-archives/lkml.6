Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790548-2-14374679526753634247
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
    t=1519790548; b=sL15mWKaYdUsa9N9Z07dPGqtC2EHxn/mLWGnOwOMvaJwvQd
    a6USbcfthoenv6dejLOSKnCoy7jc+xOF67WT7jDFn8L0kkqMmgeGjb1/zZYgjNDg
    qwsSh9z6AFdMQtmuU59h/A5aF5ctWKye+5DmRs6vnXmJtLFQHX5LmwPjSZj3lRtc
    gjXxqknzrSnlKSnlspYrssy7g/dQ1RvBXLnmED69tSH0s3KFE42Ku6zNn5F4lwl0
    SgFthWj2y5NbPbRPxwNFFL2eDYJppXFVZaoba8MDsN7DHWigmf+sUm/1lGT8/J65
    tQq/BUnUcFg37ylWUk9WBXy4XmS70CjvfV21w8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790548;
    bh=Y7Yb5ubO8PqpEAZQ4vm3NWKhm2ulQzVizy5/nfrU5Tc=; b=bfMz8exaqBuq
    ehyExpaBCLyuNpzYK4s1I47Kbpep2r8G16M1TXIWuGpxSg/FCIWzliIGkktBEojI
    ov68BnkQ5zS3Q8jM/jSHf0O6zxOmZz06VHsIzM71/L/SzoTigEcdPWtc5UMWfjy7
    Fvz/LqF554JeNTQSTOv3UrxTVun5exYfIofZx3CDk+Oqe27JdAT0Aafhmjj1Pqv2
    pI7uU90WhA7j2jdPzVWnPlKtyB+IKTq1Yo503fDTsh6itglZsyNHXiVPb2ckF5A9
    SZdhwzhPkCstV5KTOvCBYgDJDlC2nRe0tuD7MKt+bl6trv7x5oTx/kWONWz/vbqk
    Qrqxv4/f6A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kQsGIn/P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SclpqiFZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kQsGIn/P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SclpqiFZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeB1D7z (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:59:55 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38550 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932151AbeB1D7w (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:59:52 -0500
X-Google-Smtp-Source: AG47ELsZ1xGyJgrii3u04/5DfAt+X2LqSV7t0Tbjmx55cpCI4Ib2+NLngcLT1ptsmJoyb9DqBIdTdA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 19/29] arm64: Take into account ID_AA64PFR0_EL1.CSV3
Date: Wed, 28 Feb 2018 11:56:41 +0800
Message-Id: <1519790211-16582-20-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 179a56f6f9fb upstream.

For non-KASLR kernels where the KPTI behaviour has not been overridden
on the command line we can use ID_AA64PFR0_EL1.CSV3 to determine whether
or not we should unmap the kernel whilst running at EL0.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	skip cpu features like SVE etc.
	and use 5 paramaters function ARM64_FTR_BITS()
	replace read_sanitised_ftr_reg with old name read_system_reg
	arch/arm64/include/asm/sysreg.h
	arch/arm64/kernel/cpufeature.c
---
 arch/arm64/include/asm/sysreg.h | 1 +
 arch/arm64/kernel/cpufeature.c  | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7393cc7..7cb7f7c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -117,6 +117,7 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64pfr0 */
+#define ID_AA64PFR0_CSV3_SHIFT		60
 #define ID_AA64PFR0_GIC_SHIFT		24
 #define ID_AA64PFR0_ASIMD_SHIFT		20
 #define ID_AA64PFR0_FP_SHIFT		16
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 74b168c..3ec6517 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -98,6 +98,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
 	/* Linux doesn't care about the EL3 */
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, ID_AA64PFR0_EL3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_EL2_SHIFT, 4, 0),
@@ -752,6 +753,8 @@ static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	u64 pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
+
 	/* Forced on command line? */
 	if (__kpti_forced) {
 		pr_info_once("kernel page table isolation forced %s by command line option\n",
@@ -763,7 +766,9 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
-	return false;
+	/* Defer to CPU feature registers */
+	return !cpuid_feature_extract_unsigned_field(pfr0,
+						     ID_AA64PFR0_CSV3_SHIFT);
 }
 
 static int __init parse_kpti(char *str)
@@ -865,6 +870,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	},
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	{
+		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
 		.def_scope = SCOPE_SYSTEM,
 		.matches = unmap_kernel_at_el0,
-- 
2.7.4
