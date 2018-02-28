Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835393-2-2420099867399128850
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835392; b=Sx9HGVYMQTUsI9bEp8rTUXNBP+ZpGp+ilix6C/7Cn8uju5s
    4yRMFtbTsUaiVX+4yEaazylFFBqaJLeFi3MM657JQqOCcGto0y+ojp71JQuUkqRZ
    UXR/y8QzVSSJOJWcjjWjsRlhhmrdPpvjhgxVMNC20Ang5yTxbu/2rNKS9kbgJlQK
    bxgifCvB0vVsoPJJNJda2tU9cVCcoPejLCrkKFNm0knTtxLh8MbpDMOYcpGEw9AS
    N0IDs0BCAdxdDsOehPlzcG7KXnuVFuPmH/ij50IBtLmTMCb2vV1VDlkVBkrNqPJf
    qDXUenXkx93YGnfwlB2CX6roTWfj2BPnpLj4CcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835392; bh=jUfbw+bu+FRLpbJiCFY
    oE14G97uMllcwdJaVQ4iOuVc=; b=ldS3Up5q8WxqudihjKlhhsJd39e7o/s5/og
    TQMRZOu/ctOKA7HBL38cVFEs219dhgwizEwkfPTjYez4+YD/9b4yB65GUxPoseXN
    TvHUZ2roNDM+ejWpnn+12SlrjLjFjbUAT9PACkJIWg0ieUAQso1dyX7eTu3zfYo6
    hSXidEw200/+hRJUp5vZvrIfjpWPC4TfrQiaRhFv4388bCioVEGcMBBgQe/Pg7sg
    hEMt8OtnG8BTYC6GvqKCkAs8aX0L1aEmvQFyrNb03chK55oGJCLjbpcuxw/uMPbm
    vyjCzc6BFU5whebLviwfkUNRrc7m/4e6bUFPgiIbefHOLSFVlDw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934803AbeB1QPU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:15:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35166 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934778AbeB1QPQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.603528692@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 096/254] MIPS: Respect the FCSR exception mask for
 `si_code'
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit ed2d72c1eb3643b7c109bdf387563d9b9a30c279 upstream.

Respect the FCSR exception mask when interpreting the IEEE 754 exception
condition to report with SIGFPE in `si_code', so as not to use one that
has been masked where a different one set in parallel caused the FPE
hardware exception to trigger.  As per the IEEE Std 754 the Inexact
exception can happen together with Overflow or Underflow.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9703/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/traps.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -12,6 +12,7 @@
  * Copyright (C) 2000, 2001, 2012 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2014, Imagination Technologies Ltd.
  */
+#include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/context_tracking.h>
@@ -785,7 +786,15 @@ asmlinkage void do_fpe(struct pt_regs *r
 		process_fpemu_return(sig, fault_addr);
 
 		goto out;
-	} else if (fcr31 & FPU_CSR_INV_X)
+	}
+
+	/*
+	 * Inexact can happen together with Overflow or Underflow.
+	 * Respect the mask to deliver the correct exception.
+	 */
+	fcr31 &= (fcr31 & FPU_CSR_ALL_E) <<
+		 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E));
+	if (fcr31 & FPU_CSR_INV_X)
 		info.si_code = FPE_FLTINV;
 	else if (fcr31 & FPU_CSR_DIV_X)
 		info.si_code = FPE_FLTDIV;
