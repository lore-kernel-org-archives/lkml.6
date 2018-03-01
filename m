Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909119-2-8954263256632784390
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
    t=1519909118; b=LnDpGiW9D/5FzPzHZQbAeOmHZPOYCGuwn8Ujr5CkwxI0D93
    BtwcyFlPylRu69oLHWAjRLBnykWXUB1PbFwiFlHEaHluACK+mCz5F7+F3232J08F
    M7PgymTsfiQM9MqE0umeTw0v7ZnOFTXM++kRi4ZsaVRY8PQ7N+eGZpgAAUZ8erge
    AghbFjwVOnOiSVGWbu9TUzLlnKKPburuyWaSb/2R2UvDODLWtQ1ySnqJRYvpGPDD
    zJDVhTuMbOwcQj2p+benk92VMlzwhzSbuJZq0CZq3/pakLf/5EvmeSUQWNxYg3IE
    hNwf7BeSw+6OccaSKEEDZIALDQ3sRra21OzYxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909118;
    bh=kRECNLAGvLdU50wl/x4bZ8haUF1zIORex5wijx37hoU=; b=rK4XuNB+/x4X
    mOLZQfWu9iRbc56pbbIboUdLYnzhyACbvfsS4KdaYa9+SVKL8leQUL1J+VLVo/VE
    eNPZcAjjxYM5MZe6lU8GRVne7d+JMqsHccZXlyFFwkrNCUeDGihn65BMomzjOufM
    s917QgQ8RIjl98fKwIiioBjV+cFTRMaWp3z8gsY5uWuDGZC4i527d5GCrKH3+xMW
    kZInn/dpvDQBVqByADudBJpw5QlvvcLkCq3CbwW1nKzpTmQlpstu6VXyfTHDfqJ+
    9SC2YAXXX9B1yo2QrP0VrPf/AEkbwem12xQzRRHAawk2FfkHYy1x9FbsRje8rrok
    HLAlraRr6A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=UAGp3y1C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qpwylOoS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=UAGp3y1C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qpwylOoS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030871AbeCAM5f (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:57:35 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43856 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030658AbeCAM5e (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:57:34 -0500
X-Google-Smtp-Source: AG47ELsCPnYL+XCl7pU6hYArBj9T9s1wxd595zYUXytvisUPEYNo+/X4/9+gJ7VvoOVMY80zo44tww==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 18/45] arm64: cpufeature: __this_cpu_has_cap() shouldn't stop early
Date: Thu,  1 Mar 2018 20:53:55 +0800
Message-Id: <1519908862-11425-19-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
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
