Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520825132-2-59287954241328692
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825132; b=dWtyyEM4uLLNrzVvTIfqWJZmGWkaoI14KbO5P9Nr3ttoowL
    f4oTlwxXieOEbJOtrhSxpA971k/ZP2AOHOJnJHrbzu03OaQkQSgZaLGtMbgUu3HR
    mg4Wb/dL1ImtaniAPxaIcJPi4OSzNA7sgploTjsL3wQdXyVEzh3MGdamunmnPovj
    7vrgVbhSuYx9yEmSW4ksmF9KUsNrlchnuR0lqKi7uA4QfAgUry4yNuXeE6OSDNeA
    vTSZCjhxH2cGX8qvG2z+Xr5ZfciIHvTfkKRfyWe7e+/h1R6oSVu9XBBCgybTNXvP
    +6RN/nW3it0Lx2uQcmw0FS4cNqNtShD3CPGChpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825132; bh=V7lMRqYnPH+nmkxKVIZ
    UqIC25hVTtdDb3iP56x9HNVY=; b=CSchCK+kwSGKs9tNHQZA9qedgG9j6s7iLUh
    nIJ3AvIL3DLy65n7Ozztohtkg4Fb1TeaDFWETgnbTg4uJu/zQA2Z2PkEJ9HPeERt
    M9InrwfIBSvBcox3D4Fp0otaiXCtAt4QDD2+0wOvn41pPX/RJr8oEPhvGClFWbuw
    4Z2XxpnzjC3tfAnwzAcFM/l5gzQZnvEUPN61VQaKZ3LOmdSgCwZCRCu80IxVzJzc
    rsRKxgf4yCSf3siogeBYb5X5s0fH9rihqg7/cM8mtYegqCtdg9SwtpKnwyaX77vs
    +T5Ikd/jNMO//wKslsyHD4ZypkGQog7nDusXXpTXnXd9WRk3Lng==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932958AbeCLDZa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:25:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41212 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932677AbeCLDHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:43 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "H. Peter Anvin" <hpa@linux.intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.307189709@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 029/104] x86, alternative: Add header guards to
 <asm/alternative-asm.h>
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "H. Peter Anvin" <hpa@linux.intel.com>

commit 76f30759f690db21ca567a20665ed2679ad3235b upstream.

Add header guards to protect <asm/alternative-asm.h> against multiple
inclusion.

Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
Link: http://lkml.kernel.org/r/1348256595-29119-6-git-send-email-hpa@linux.intel.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/alternative-asm.h | 5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -1,3 +1,6 @@
+#ifndef _ASM_X86_ALTERNATIVE_ASM_H
+#define _ASM_X86_ALTERNATIVE_ASM_H
+
 #ifdef __ASSEMBLY__
 
 #include <asm/asm.h>
@@ -65,3 +68,5 @@
 .endm
 
 #endif  /*  __ASSEMBLY__  */
+
+#endif /* _ASM_X86_ALTERNATIVE_ASM_H */
