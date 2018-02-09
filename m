Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185226-2-5296830864744688961
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185225; b=Lzv6iwWic/ydOUYy0htEDa3CblGSr+hHc0C6jv/R8I2YnA8
    tzKzeqIEObMBsogoLlCrYw0TJ/7+lXIVJ+2PyfNWbvB6u8PW0okEUWHGAMt3Fy8S
    w88WNgDLyothszGj/gpZBeajs7Awj/gpKCr5vHLm+VeWrm883pLUwTFeckK8eM7E
    oZdxNcHEZ437O6MEaNP4dK1Eb521U8jROZwgwWn2VKVJ6WypC1DmPACdo0WT0b2Q
    Bl+wkgnJzPNTHtDcW9jmp+mVWhmNNsuGeaYLQ0TbGqnaYi5wz0YeZ4hZAJMmsjuD
    y6BJSZtlei9HOQF4qWHh6rqZ/ZvhVpyiJ2STLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185225; bh=X6Iqx/o18I4BQYrkZlFGlBPo7h
    /bmn2CKPDCRT2XD0E=; b=fPvyipmLM74yuUmm/A9vQiVT0YM+H+mI9FrUzK37tp
    lUOyKBNr2MSAsLhXp+oT8KWt1W2b13J2w252LBs2mek+DuOaauux8EJpMXwNenrW
    5vBkt3uSzxS92jHM3V/ioEiBXVRk/Y8erRfqrgcVq75qCCie+pTuQCRIln2gnhv2
    XtaDQRUnOowmez8lZX1TRnx7H1i5reccsRRrGS/bUlqKMjDJbaH5GIQg+t/7qRLV
    zz8ndmwWEr1jTbfQdSif9qWsKA+RUjdxP+O2j69tiu6DeGvoX0K/3/hPF6zfiKGm
    OVX88b59lUBRvWVckCP1GvnmXdxgYCExhWNIld+pooSA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbeBINmr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753044AbeBINmp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, riel@redhat.com,
        ak@linux.intel.com, peterz@infradead.org,
        David Woodhouse <dwmw2@infradead.org>, jikos@kernel.org,
        luto@amacapital.net, dave.hansen@intel.com,
        torvalds@linux-foundation.org, keescook@google.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        tim.c.chen@linux.intel.com, pjt@google.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        gregkh@linux-foundation.org
Subject: [PATCH 4.9 47/92] x86/nospec: Fix header guards names
Date: Fri,  9 Feb 2018 14:39:16 +0100
Message-Id: <20180209133934.558739883@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

(cherry picked from commit 7a32fc51ca938e67974cbb9db31e1a43f98345a9)

... to adhere to the _ASM_X86_ naming scheme.

No functional change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-3-bp@alien8.de
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#ifndef __NOSPEC_BRANCH_H__
-#define __NOSPEC_BRANCH_H__
+#ifndef _ASM_X86_NOSPEC_BRANCH_H_
+#define _ASM_X86_NOSPEC_BRANCH_H_
 
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
@@ -232,4 +232,4 @@ static inline void indirect_branch_predi
 }
 
 #endif /* __ASSEMBLY__ */
-#endif /* __NOSPEC_BRANCH_H__ */
+#endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
