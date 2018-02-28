Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218881-1519790539-2-9446667697380849799
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
    t=1519790539; b=XhwGzW+sAf2OVtRUNZccGtCvcn7qJVtYzqf3Ul/Tx0VSCnd
    xIR74anOz9WWpfPhKMTysdhHT4zd6fKr737EyvlE0b8VJbE01D35VcF+4iUisNoh
    yeUaV7ntOyZcTm3xl17K/Sj7PnZDAx4liIxNHC6dCYXy2x31muq4Fk//SFznMNdk
    fls0Wt22JkFGsEzGQNbbPQX65bVKWT1rUD1geimvZvZ8sIdJZbxOrJXgVFbXgF49
    LdAXMgpLu8SkUsMYYCclCWMno85ubDW4RTxQjOkbucYbYkJkdcdGM0KyCaj81qpp
    crF0xd1UeYk2gIsCl5O2shHk6Jns5o0HUrmlWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790539;
    bh=OMOLk3BE6r9QGQmIu+rjUcCTZUD9wK3TDcxdkw1PHjk=; b=nt7SuZsOfQTy
    ISRactBCz3StvrqdqzXQcNdYbUDxuxmCT40Stmjh85WP0tHk+vWht+X0XhQuiwn3
    GnmIMRFl33rutnB0jDU2JRdGubLvyc6oWPwSnCEwgZ6wLp1pYV2FF21dYXxY+pdN
    WxIQmRqk3miYRaE7r0g1KM5JNQ6ryWBGbtEjg/v3rOGguNXj/+NpHmFfuh6+pi8N
    xaXyetBDZBOFe/i1KIRE0bjLbRbwqjJJyy+f+IZTfRzSkYKgobTTEx5d/EJV2mCV
    3nQMNdYrmg1Y0BQuYrrNy7z/dZl6dGrBIpks32HYShw5dwvQUN63EkwjhbUSlnZm
    WQDL7ax8EA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ZujYVB5w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aejjTBQ2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ZujYVB5w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aejjTBQ2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbeB1EAD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:00:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43170 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeB1D77 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:59:59 -0500
X-Google-Smtp-Source: AH8x224vJ7ofKuDglESlz3Sysd+V+ZdBUN30WfGZm0cUVTRpDGAz9QEalGXTY8mDyeaqUz3lfDQybA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 20/29] arm64: Allow checking of a CPU-local erratum
Date: Wed, 28 Feb 2018 11:56:42 +0800
Message-Id: <1519790211-16582-21-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 8f4137588261d7504f4aa022dc9d1a1fd1940e8e upstream.

this_cpu_has_cap() only checks the feature array, and not the errata
one. In order to be able to check for a CPU-local erratum, allow it
to inspect the latter as well.

This is consistent with cpus_have_cap()'s behaviour, which includes
errata already.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3ec6517..4e5dff1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1103,20 +1103,29 @@ static void __init setup_feature_capabilities(void)
  * Check if the current CPU has a given feature capability.
  * Should be called from non-preemptible context.
  */
-bool this_cpu_has_cap(unsigned int cap)
+static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
+			       unsigned int cap)
 {
 	const struct arm64_cpu_capabilities *caps;
 
 	if (WARN_ON(preemptible()))
 		return false;
 
-	for (caps = arm64_features; caps->desc; caps++)
+	for (caps = cap_array; caps->desc; caps++)
 		if (caps->capability == cap && caps->matches)
 			return caps->matches(caps, SCOPE_LOCAL_CPU);
 
 	return false;
 }
 
+extern const struct arm64_cpu_capabilities arm64_errata[];
+
+bool this_cpu_has_cap(unsigned int cap)
+{
+	return (__this_cpu_has_cap(arm64_features, cap) ||
+		__this_cpu_has_cap(arm64_errata, cap));
+}
+
 void __init setup_cpu_features(void)
 {
 	u32 cwg;
-- 
2.7.4
