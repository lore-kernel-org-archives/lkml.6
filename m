Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790494-2-5384203759281512287
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
    t=1519790493; b=hIGs8FcTKrY06atAX1GaSUqLGRZGSUEMRu1rN3iV+KHEPpF
    X6PA/zaXdSz3+n8aehjhs3fAXR24zE0eFB5P+3iOohl0aKZe3ddZiIBG3tc4r+4j
    j+hTgUrT4fxxSpI5C59u/NdQJSNuDvAxWqXkUvM0/m/+kJxwdo/2R+Sj9zbRhVJF
    nR74K3y8kElB+8nuMydHY/dvv9CMfS2q+EVBGNhTgZ3PhaPpVxwkR6qLmzkK9Gmq
    WdcmmNBIkfrHSTstSY+XoqbI9mFakvOokgDue+tk65G9pihhiLpx2rAIVepW0L4i
    EXtR3JSUtDjMFzxZwN25jaDGDaKg3doF5/gNBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790493;
    bh=mDAP47eyIT68Z920skzZ0tbKXBprTWayJOiSVpV8SAg=; b=JcbAluqIsjhF
    vb/gUxcbo9ElYMtiuvwebpg3Tg9S2xmWkbsc7XAWN3Pz6siSkGriGn0NsaHDCQ7T
    H/QGwMHQ7m5wsSEY7RtQLICe7eC6c0axkMopI6PHWwgKMuH7ykr3GCX61j5OUcsI
    VLZz1qv0zS7ZdJs5yDHazSvZcywzyFNsY/M46yqS6FA6RZ27bERfzwcMbHiupOzO
    /NQe4pnKJZK3vqWHO1NGkszWh1jSKjvkNKMTLNIJo2vgImgzIgYZXGYCdsrR+41y
    XNRQCAmUdHj0Ez/Uki1TMgGuWpc/nTyQ08QmUkwEGeceNBoUeWejjdu1HC88LSup
    rzDdI+Jtgg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Js+guy+h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pAc4UbZy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Js+guy+h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pAc4UbZy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeB1EBD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:01:03 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40559 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeB1EBA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 23:01:00 -0500
X-Google-Smtp-Source: AG47ELsai7Nf1tExOWWvKsw0MaO0k+BvcrDItw4VyHLGSJBuZOfmWeijCtj4D6hRsZtnEK4nuMwLPg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 28/29] arm64: entry: Reword comment about post_ttbr_update_workaround
Date: Wed, 28 Feb 2018 11:56:50 +0800
Message-Id: <1519790211-16582-29-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit f167211a93ac upstream.

We don't fully understand the Cavium ThunderX erratum, but it appears
that mapping the kernel as nG can lead to horrible consequences such as
attempting to execute userspace from kernel context. Since kpti isn't
enabled for these CPUs anyway, simplify the comment justifying the lack
of post_ttbr_update_workaround in the exception trampoline.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/entry.S | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c00921e..8d50b28 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -883,16 +883,9 @@ __ni_sys_trace:
 	orr	\tmp, \tmp, #USER_ASID_FLAG
 	msr	ttbr1_el1, \tmp
 	/*
-	 * We avoid running the post_ttbr_update_workaround here because the
-	 * user and kernel ASIDs don't have conflicting mappings, so any
-	 * "blessing" as described in:
-	 *
-	 *   http://lkml.kernel.org/r/56BB848A.6060603@caviumnetworks.com
-	 *
-	 * will not hurt correctness. Whilst this may partially defeat the
-	 * point of using split ASIDs in the first place, it avoids
-	 * the hit of invalidating the entire I-cache on every return to
-	 * userspace.
+	 * We avoid running the post_ttbr_update_workaround here because
+	 * it's only needed by Cavium ThunderX, which requires KPTI to be
+	 * disabled.
 	 */
 	.endm
 
-- 
2.7.4
