Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909323-2-583688679516492483
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
    t=1519909322; b=IoMuVWOxypooYJgqoM9PmsmNdItPqbXvLlA8dGVpVkhh0+m
    TeZctKiw7S1qo9lvr7tWe2zLKuH896jv6uN/o1sRsgC24+nNjn2EDnL9GrTiHBg8
    ypU7F5IfyTZcYrejrf4jmNpNIHsoVbbuIO+/0Z2+OKV1/2o6aBrdzz7fksi4IAB1
    CNNhloa+p6cRHt/tNV8E61qGDKVcx+FgXVpJ1oWEe1Tw8TDY8eoliZYNoD4kSBUi
    wnndb2NDnJkip7+VldcnXKjMjWMsH+bgs0keZsV/48KzreVHtNv1glbkcfQAF3Q7
    Nj3SO4GK4GgZGv5YmL9SJTi4uRNX+9/HM3xnrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909322;
    bh=xjpJ8k7CKNbvTvoCWi2+8tjs1SrG8L5eeUCBFmDTG3o=; b=eJsywULthrMj
    tBYIHqaQpzRp+owLbZGbRSbz9xIkBcSCBVCCBu2qRu8M5b7mp0BvbExVUglNf21S
    1f0ThLnA/mFdxrSlIz6pbURDe0tjNnPaSJJpEjGLBD/5e+6ajn9tXPUcAG5yhMMq
    vv5vle0/IvYqdupXn7CDbminJhI/uygmE0Rc1auLWdB71jaxCOdPvpM14TmlB0hR
    d3uSD37lRiQszkRdn2rXkep+VesteMyW9w9oSa2svJilFQC+R2txDHsFSqH63ynD
    foKgxSlhdp2avHrr5BeR+bnO8/65OR1DIpm2PxEdMfNHajsVeuKboOXrOaeJHsCF
    51zBFyFT+w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ULhcJObd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OAvZvRpc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ULhcJObd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OAvZvRpc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030850AbeCANBA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:01:00 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43078 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030312AbeCANA6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 08:00:58 -0500
X-Google-Smtp-Source: AG47ELtk5UIblqE4EjZZZmblxyUl0egcP/ETuZdAP2NsG4qBYpoepQrn4DXTcsQu6PMQDGoCf3OtFA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 42/45] arm/arm64: smccc: Make function identifiers an unsigned quantity
Date: Thu,  1 Mar 2018 20:54:19 +0800
Message-Id: <1519908862-11425-43-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit ded4c39e93f3 upstream.

Function identifiers are a 32bit, unsigned quantity. But we never
tell so to the compiler, resulting in the following:

 4ac:   b26187e0        mov     x0, #0xffffffff80000001

We thus rely on the firmware narrowing it for us, which is not
always a reasonable expectation.

Cc: stable@vger.kernel.org
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 include/linux/arm-smccc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index e1ef944..dd44d84 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -14,14 +14,16 @@
 #ifndef __LINUX_ARM_SMCCC_H
 #define __LINUX_ARM_SMCCC_H
 
+#include <uapi/linux/const.h>
+
 /*
  * This file provides common defines for ARM SMC Calling Convention as
  * specified in
  * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
  */
 
-#define ARM_SMCCC_STD_CALL		0
-#define ARM_SMCCC_FAST_CALL		1
+#define ARM_SMCCC_STD_CALL	        _AC(0,U)
+#define ARM_SMCCC_FAST_CALL	        _AC(1,U)
 #define ARM_SMCCC_TYPE_SHIFT		31
 
 #define ARM_SMCCC_SMC_32		0
-- 
2.7.4
