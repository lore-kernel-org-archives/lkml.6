Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406188-5-708556859932098472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406188; b=GUaruMHFT1WJVT2ekh0uDAlEOLUPGsAb7WWFqm9+i+e9c/nt1j
    My0b9/Vyr33SkEBX0baYjGrP0nw1Vw/KapkIa2yl2620lVuEgZFYD82S3sFvzgRr
    gXqF9Widaqc3jxQfwPjw2rQjXU1wQn5f6zS1i4fRJY8Ftqk/Wg+H2BvpCCU5IRo4
    uS/SOjvY+FLYyvx9Im3Fy+VWnZPH/EF3Yfgy7Z62Tg0JAB2SsUhXrTcr+GJaqEE+
    GTAAQYFTv0SCNifUhbd6G7GlfnqJuBvjKdLaarCp31X+mFpsDFNnw0b7eVmu93mG
    hBY43neHe5oSW4NteqpYGpza8Er7KkpEyPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406188; bh=uf5q2woBnpjzT/lcoXxaMCJaAz8UrI
    qy5Up7/6brDvo=; b=HS3tm0/zXd584r4BD8WsPgdLteSV7LCSD94cbEPRH1UTQN
    2d9yGWaOUTiRY+hrexofeQ1z7ggesWJ34Ge/aSu9THfpqD9ko/kXtx/zfqQ1dnEl
    ojes6j09JdI2LCr0+DkRhpOfL2tDMLUxxnKwjlvaOuLNBczl/XmhN8K4DNn8awYQ
    NMHMRb+TYZQf0cPo10sPSHNtQw+kDQWsfT4M/63tsV8runTrhXQ6QLg11wfB6Wp1
    bzaQNqYQdw/Ug1bUpYeJd1TWBl9N8vqsBB1ojROdgopsMJJp2o61xlYfpPefaC2p
    SUWkQfDVMEaujgVkI8qzTRPCVvXVlTDiZerfl3Cw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBMdEtXdRGX6Oq2gVR15hNzn0yH0bT7e63/YAAYL9+ntXQvNujY7ChMEzJBSwzl65bUwHKeSjsU4jOQpDiMtkkWipyiYt9MybNLqVq4H2BLWByGKYQiR
    qHMOXcSLAj4gLaCnQ1cJUnpKT79KXmE2JgU/0q4KTaHElXjF19WJ+1w5zTYBOv3uZv+wsHpdT03zsKgMO0caI72m0sYq6HtGqyH7Huh/MvN7SbyVgexyzmwk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=gPJu0pBYAAAA:8 a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8 a=ag1SF4gXAAAA:8
    a=v_jtEpIa6UGkYHxOe2wA:9 a=QEXdDO2ut3YA:10 a=AlIIF0cMT2hfDT4axODj:22
    a=AjGcO6oz07-iQ99wixmX:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755955AbeDVOJp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:09:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53294 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756152AbeDVOJk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:09:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.14 141/164] MIPS: uaccess: Add micromips clobbers to bzero invocation
Date: Sun, 22 Apr 2018 15:53:28 +0200
Message-Id: <20180422135141.222343620@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit b3d7e55c3f886493235bfee08e1e5a4a27cbcce8 upstream.

The micromips implementation of bzero additionally clobbers registers t7
& t8. Specify this in the clobbers list when invoking bzero.

Fixes: 26c5e07d1478 ("MIPS: microMIPS: Optimise 'memset' core library function.")
Reported-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.10+
Patchwork: https://patchwork.linux-mips.org/patch/19110/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/uaccess.h |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -654,6 +654,13 @@ __clear_user(void __user *addr, __kernel
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
@@ -663,7 +670,7 @@ __clear_user(void __user *addr, __kernel
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	} else {
 		might_fault();
 		__asm__ __volatile__(
@@ -674,7 +681,7 @@ __clear_user(void __user *addr, __kernel
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	}
 
 	return res;
