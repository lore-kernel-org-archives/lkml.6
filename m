Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2152363-1523979665-2-9347466660699057409
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
    1523979664; b=mXalzR26p0cHTEu95A9+Y5gJ7PpPDQ2g+x803SZbwvHsPI1m5j
    q+9A7isXSWbzBSYEEt1VV8q6AjiOb9EepInsb2P99TiD5/yBp8vwSVi/20tZRXqo
    //CiDt8+BKAvO0dVirkK0Zl1XvacUWQe7hHJSXti/Zx45B8A9YbjuhMWc1lKNJRr
    1jBWZIhN3jWhZ8XmdvVgOMB3WhX76ZJvmCb9E/ibQMJokOUx0iVrtP3LgXZAXHxN
    u7hLG7CSHVsdjgB/OOVPKouP8OWGBLl4XUjyCqT7SFoe/UKmQU58oj+8LYVdQZhe
    /llE7Bql8F4vo21HXCnM7QOKhH62dI6s+mWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523979664; bh=vmcb480exWK5RTC/EZ5jVXinJJF6ss
    pmVUxkQNMyC7I=; b=TOQk8vjlBBN0LQbjhywlW830zaj6sqjbWgNv80PUXxeu3r
    rFbggOrN/+i0V9/K6/8Ux7/hoNfTZvyxWqRqUDrZBvI0i6g32R8fkzBLtEjn+ZIy
    a0nuZrNCm5pTcfPVYTIqow8maTQTUWsMsa3m4nkOy1Iy9Vtqaq/Eg+N9q5HWINbp
    +rTX9hAkCKbeTGOMEwSQEAm0yK+rAu9hocePNq/R2BzuD7qL4KTm9cdg9YyeWLQ7
    7DuGuAfz67Plt0JlOzpWV31xBAjZ9xyrS/i1oE2FrEAKVP4iiy9WMIuuT8yYXVYS
    EFS9ar1HVM7f9mhkiDHFexIlWqXE7EAaL+B6Xa9A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfFqz/FidIzUn7AGnM8FwXV1FTzuXyyn9NnPGtQPaMjzgCMCgvzPsJeM0xSbwLvIfo8iT89WK54OozuZSpiWXa/oKz5I1rLJ3vI8ZiJZj2O6HLElaxU3c
    8Q9WKa+MaN6O/zdy3QLIsxbeFySXVgRtUegjGfSK3grYIZjRnCE1XzlrP28twlavLIJEP6dvwcZnk0TASB7bm9MtSDEnGMrOw+IuajP/xdd5J7PeHEUo5B5M
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=bNj8a4Z-HAieuLBluAwA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeDQPlC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 11:41:02 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:41722 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbeDQPlB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 11:41:01 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 2/4] MIPS: uaccess: Add micromips clobbers to bzero invocation
Date: Tue, 17 Apr 2018 16:40:01 +0100
Message-ID: <1523979603-492-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
References: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523979613-637140-28836-247121-1
X-BESS-VER: 2018.4-r1804121647
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192083
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

Changes in v2: None

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
