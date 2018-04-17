Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1970493-1523974029-2-12022707265829022491
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523974028; b=q8aCGq/58q0rBM89TPC8IJa4wqj6jTy3wALqr7pR6yeU7vxGgE
    O+4qV0QCCkbxQM9KMaBW3BTB6pHkKVinzFSp69RPUcyIBWnXvRSE3kgjraMgTvOj
    Y/zMkRCoKfKHC4fO7l923q0BNzHzyPQW45olBvY9AQxXWBAW4tTyZyC7oMm6JFsX
    OB/0oNXMI5cTCMxqM41IEW7RGRsB93+b31VxZT11+/TKGrCBIXC514OU29nIaKeI
    jZ5ZdQsKCsq3ozjhTJgsgCTrFhEUCwXCogaliNIlTIs9Fw/lEvqRyFkJKpwCKgeJ
    ARq7h+2i0ovKYGWk26YSuZCB+H8bYGxr1BWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523974028; bh=Xl28G5eNLRzc4vqH44TM1kyqM9Lybd
    koHqvqZOBECZo=; b=pHLHzI8ky4KcyOC7zV6Yfbx2zuL67E/JXUvfURI0595uH1
    4D2uNcFZXCYv1VkP4rGDHp6ZJc9sTIzelrHkMKpgZ8R2D4BRN/KK9322nvsn1D4o
    WfY68ziorAix8bERDIJ0Z38jT6JbIGsGGmuNm18c6SdjcsFt9yiyzug4qZhKoREn
    6oMRaj7/BVS//zjg9xNtScoo98bYqqB9PSkcrMAZRxHBsfKwQE0Wm/Ff8yCW4i/r
    /z25dClgbadTi9m9KYayZ6aZP0J0qnyC+/5+faV8wv0bInUOmKf/UC9cLY2czoZv
    Bq/fs567f0IcITX+EBlwTnG7t7ARRFI79fqzQu8A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPu+moS3A93JioMopHSky4GriL4eps0XDxAWBvzqrYAg1h3QGlqzGzJ7XZO7yrzYbCBPN1uki6evryFj0mgbogwOPpZftylVDNElPo3i4ZGrbw/oISWv
    ndanYbDlkPUsTWjoJP3QwIU+6WwFTHKuuFv+wQm3XpydvzK3k4Xc49lh7RFUv5fm8PRgCXkq7NiKHDYagrdg6rpcMwuRyHA1w3YCl/RWbS43PIHWCylp+CPP
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=bNj8a4Z-HAieuLBluAwA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeDQOHH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 10:07:07 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:39635 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeDQOHH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 10:07:07 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/3] MIPS: uaccess: Add micromips clobbers to bzero invocation
Date: Tue, 17 Apr 2018 15:06:11 +0100
Message-ID: <1523973972-25633-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523973972-25633-1-git-send-email-matt.redfearn@mips.com>
References: <1523973972-25633-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523973990-452060-18537-58458-1
X-BESS-VER: 2018.4.1-r1804121648
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192082
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The micromips implementation of bzero additionally clobbers registers t7
& t8. Specify this in the clobbers list when invoking bzero.

Reported-by: James Hogan <jhogan@kernel.org>
Fixes: 26c5e07d1478 ("MIPS: microMIPS: Optimise 'memset' core library function.")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/include/asm/uaccess.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index b71306947290..06629011a434 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -654,6 +654,13 @@ __clear_user(void __user *addr, __kernel_size_t size)
 {
 	__kernel_size_t res;
 
+#ifdef CONFIG_CPU_MICROMIPS
+/* micromips memset / bzero also clobbers t7 & t8 */
+#define bzero_clobbers "$4", "$5", "$6", __UA_t0, __UA_t1, "$15", "$24", "$31"
+#else
+#define bzero_clobbers "$4", "$5", "$6", __UA_t0, __UA_t1, "$31"
+#endif /* CONFIG_CPU_MICROMIPS */
+
 	if (eva_kernel_access()) {
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
@@ -663,7 +670,7 @@ __clear_user(void __user *addr, __kernel_size_t size)
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	} else {
 		might_fault();
 		__asm__ __volatile__(
@@ -674,7 +681,7 @@ __clear_user(void __user *addr, __kernel_size_t size)
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	}
 
 	return res;
-- 
2.7.4
