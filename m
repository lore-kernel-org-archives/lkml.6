Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387443-1519634044-2-17142144032370509704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519634044; b=cw7fg8vq+jdl549Au/6Gif+pwBMNTaxuvmZ3NvGrL1gej/u
    qahL5VcPgVWg5fP151prsiPlcYnBibASKCgj0vTxduaEy78PODP2bmFRWs1TS0Ox
    Mt1kLKAOXzTYTFUMoaL1jl7ICNZHq5lKPFpSyve09aBFIWu3tyZimkrsO648utcT
    zgi6dCk0Zj5tlZAn2Kd55wVM97m1lc5jFrG0zYE5FE+BYIpgdukCqn+NISy9LOt4
    PcYPVFBRogKE21HEYqRan11u8ZTiESvESi1tpaZZW0DkkZ4C/M4zIpwJAxCmmIOK
    Qf/5RU0yVO4lT/lz3CNw2VWzdaBGMSH0ZRQTKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519634044;
    bh=XfV6Yv3SjvB5RVvJ7haGkLOWLK58ZxDQcMshzGS5NdQ=; b=Cg5GdiKYxRwU
    Wx8iij1Zse5zZVORafoKuwgurKmstPsJiigkHKlTFe1u1VVKarEYJZh/+IF+WGy2
    lTHzTezmeUir5toCCJ/gsIZA0A14s0bQXlIB7XT/ZouqgUFqPDFjyDxRt9QOEe+F
    ILxBLpcCPjUVkaMZJ2xXrqJaImork4WyS+6wWwt1uukOyO4BnhelK5DPny0gq9Ds
    TOD8K064d9SmusXGXnQjupLAQ4kjLea6hM8cqGccrVzZJIvyKr0OR+fy4HS12dXq
    34CL7ktS/Ixlk32I+RWmed3TZvxdA1qNuQRfCNeOu5ZpZGG/RpxXOuN0nbUN6+fk
    m5yROtQDwQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GUnDuslp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Z6DXOyTM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GUnDuslp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Z6DXOyTM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeBZId7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:33:59 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46578 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbeBZIXT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:23:19 -0500
X-Google-Smtp-Source: AH8x2268NzAetSUpA0ot47O8YLJiHqyCJ0/DrSnxNvRlT5UzI+fGUtw6VuPS5lFsPgGcUNNHBM4wTA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Cc: James Morse <james.morse@arm.com>
Subject: [PATCH 18/52] arm64: cpufeature: __this_cpu_has_cap() shouldn't stop early
Date: Mon, 26 Feb 2018 16:19:52 +0800
Message-Id: <1519633227-29832-19-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Morse <james.morse@arm.com>

commit edf298cfce47 upstream.
Alex Shi rewrite this commit on func this_cpu_has_cap(). The following commit
log is still meaningful.

    this_cpu_has_cap() tests caps->desc not caps->matches, so it stops
    walking the list when it finds a 'silent' feature, instead of
    walking to the end of the list.

    Prior to v4.6's 644c2ae198412 ("arm64: cpufeature: Test 'matches' pointer
    to find the end of the list") we always tested desc to find the end of
    a capability list. This was changed for dubious things like PAN_NOT_UAO.
    v4.7's e3661b128e53e ("arm64: Allow a capability to be checked on
    single CPU") added this_cpu_has_cap() using the old desc style test.

    CC: Suzuki K Poulose <suzuki.poulose@arm.com>
    Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
    Acked-by: Marc Zyngier <marc.zyngier@arm.com>
    Signed-off-by: James Morse <james.morse@arm.com>
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>

Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/futex.h | 1 +
 arch/arm64/kernel/cpufeature.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 1943cf6..718140a 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -20,6 +20,7 @@
 
 #include <linux/futex.h>
 #include <linux/uaccess.h>
+#include <linux/compiler.h>
 
 #include <asm/errno.h>
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3a129d4..fcb67e0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1063,8 +1063,8 @@ bool this_cpu_has_cap(unsigned int cap)
 	if (WARN_ON(preemptible()))
 		return false;
 
-	for (caps = arm64_features; caps->desc; caps++)
-		if (caps->capability == cap && caps->matches)
+	for (caps = arm64_features; caps->matches; caps++)
+		if (caps->capability == cap)
 			return caps->matches(caps, SCOPE_LOCAL_CPU);
 
 	return false;
-- 
2.7.4
