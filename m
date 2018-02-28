Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790534-2-11033439589045453671
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
    t=1519790534; b=nMEUtPUGuPlWnTj3BFVQNX9FyEhF2z5BlUW++A8QLvDt/fi
    utZ4p+9trGLrq1BWPu0id/hk7rNWou/0A8Tmack4Fqr2nWWGM7DTZK9xB12zY394
    LvEQL5JvfXmMci2VdC0cDb1ysT9UepkCXMKJBBV3Rnf7IQUMpyh0o9yq+AAxOtrG
    XzzEw8XKtmrV6h42UgzyW4/nSuCf3ywopYuWKL7aMuOtzTfyEwjcs8efXls+MSlx
    Ae4jhDasKFlbZo+aT0ZWdyQyno9Sg/r4ZfV8kpMG2cVjuf0UZ5A1RDl26oi5bTlF
    I06H+q7w/0c+3TduolRFqgiGJe5npvFg6XYy9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790534;
    bh=dHNDx9kw7MHipWQb550NFtLt7C6FAMAdmYc8+9G2iPE=; b=m2dylP1zd7zb
    7wYRlCDlcBk9J/hZsrnsbqyg00XZvDW4zAFdN7RrJ1eeRG9pOuacAulEVcikRkIE
    YClEZ/Hq9b6Zj/22QE4INNAKm8Dk/+cWUZFCwAIxzALnrADVC7StmNSogolvqKUl
    r8l3ZzLPgf4IIdnBAO+yqoBs5zm0VN+6NGf6FXiW0BueEG370+BnFpjJ07ccNc5u
    P8pQRsa37YIwLQXEO9k1wPlE6GVYU1IF7UESusOmGD9/qlCzNAL0IVqOwB9MyhXK
    tvWmAfwRRLuzmO41ct5vglbPcfCU5dl9Fc0UTwRwRpW3iEPb+k8Wh8XME5MHKWTQ
    RXnSAFy3AA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=h1S8wsae x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L4nEm7CR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=h1S8wsae x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L4nEm7CR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeB1EAI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:00:08 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36762 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbeB1EAG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 23:00:06 -0500
X-Google-Smtp-Source: AH8x226R0HDxtLi6JPqOw4eV1yPJLsUE4g6zFxXsD/R3h/pydHsMcCt/VdIIVLsfOfGvZa+73NoV9g==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 21/29] arm64: capabilities: Handle duplicate entries for a capability
Date: Wed, 28 Feb 2018 11:56:43 +0800
Message-Id: <1519790211-16582-22-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 67948af41f2e upstream.

Sometimes a single capability could be listed multiple times with
differing matches(), e.g, CPU errata for different MIDR versions.
This breaks verify_local_cpu_feature() and this_cpu_has_cap() as
we stop checking for a capability on a CPU with the first
entry in the given table, which is not sufficient. Make sure we
run the checks for all entries of the same capability. We do
this by fixing __this_cpu_has_cap() to run through all the
entries in the given table for a match and reuse it for
verify_local_cpu_feature().

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	arch/arm64/kernel/cpufeature.c
---
 arch/arm64/kernel/cpufeature.c | 44 ++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4e5dff1..6200b81 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -969,6 +969,26 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 			cap_set_elf_hwcap(hwcaps);
 }
 
+/*
+ * Check if the current CPU has a given feature capability.
+ * Should be called from non-preemptible context.
+ */
+static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
+			       unsigned int cap)
+{
+	const struct arm64_cpu_capabilities *caps;
+
+	if (WARN_ON(preemptible()))
+		return false;
+
+	for (caps = cap_array; caps->desc; caps++)
+		if (caps->capability == cap &&
+		    caps->matches &&
+		    caps->matches(caps, SCOPE_LOCAL_CPU))
+			return true;
+	return false;
+}
+
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
@@ -1037,8 +1057,9 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 }
 
 static void
-verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
+verify_local_cpu_features(const struct arm64_cpu_capabilities *caps_list)
 {
+	const struct arm64_cpu_capabilities *caps = caps_list;
 	for (; caps->matches; caps++) {
 		if (!cpus_have_cap(caps->capability))
 			continue;
@@ -1046,7 +1067,7 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
 		 * If the new CPU misses an advertised feature, we cannot proceed
 		 * further, park the cpu.
 		 */
-		if (!caps->matches(caps, SCOPE_LOCAL_CPU)) {
+		if (!__this_cpu_has_cap(caps_list, caps->capability)) {
 			pr_crit("CPU%d: missing feature: %s\n",
 					smp_processor_id(), caps->desc);
 			cpu_die_early();
@@ -1099,25 +1120,6 @@ static void __init setup_feature_capabilities(void)
 	enable_cpu_capabilities(arm64_features);
 }
 
-/*
- * Check if the current CPU has a given feature capability.
- * Should be called from non-preemptible context.
- */
-static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
-			       unsigned int cap)
-{
-	const struct arm64_cpu_capabilities *caps;
-
-	if (WARN_ON(preemptible()))
-		return false;
-
-	for (caps = cap_array; caps->desc; caps++)
-		if (caps->capability == cap && caps->matches)
-			return caps->matches(caps, SCOPE_LOCAL_CPU);
-
-	return false;
-}
-
 extern const struct arm64_cpu_capabilities arm64_errata[];
 
 bool this_cpu_has_cap(unsigned int cap)
-- 
2.7.4
