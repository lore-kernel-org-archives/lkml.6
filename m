Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824151-2-7395698803918606831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824150; b=A0XdcMRR90lWbDhWcP/2zO002iIq2vjfGpdmLNWO6efcX4Y
    3bNrxNKsOrSZ0G+xIXE7xo2XAl4SUimAzu3s6TyDZN/O6oV0dhHyAofPE9VO+LOg
    NFpO7AB8TOWy8inhttZ7ZFn2eKVExuAS3kJtnYrfn5Xr9yCkHyloOrDZqgOEakMf
    /z0oX4khY3QFaFJptaoVmPSnU+eXpBBEKYBrrL/wir87nMj2YfIK2qHfLXEtSXre
    RxNwHJd63SZFr8wGHPivCO8kKqyUbUFTSpLbyVn+hAwdJhE8N05F4X0dammZDc3f
    CvgeL8/t+zqrNQ8e+uD+HzJ5ovZsTMmUxe9Oy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824150; bh=/PCVuikvsN+/wWhaGVR
    hVP9TRne/5BqpZ1IJMQd4oH8=; b=IWvt/a+4mhUc3ZEoR3htL8cBzshDX8opsGt
    UkYyECSDTpqhs1iLMA5JGWd/SFvOmdCU4UvjRsNNgodgu6Ow/455G/tyO2x4qcO3
    8OEF3hqELy2rZEghNghAbDNH9VJ8c7pegIaYEA0vzP01TvHpIXzHSnkPsR6+UMr8
    rdiQFAruNdiSl9E8jokmHqB/6W++6KMQnRWxvbDpayRAKYkzdWCXCXVb0Zkwslf6
    CFb56uzbsmfr3Yq+VW59iOEJynn7P39TOX573ShcCIohktilbeNUOKxXBQ2zJZwI
    gtINPvY9/GReIE8WsN+5PWRR+E2VEdA/uxFwN1f7uA1si+ejkzA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S932815AbeCLDJH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:09:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41611 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932811AbeCLDHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:52 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, ak@linux.intel.com,
        torvalds@linux-foundation.org, tim.c.chen@linux.intel.com,
        bp@alien8.de, arjan@linux.intel.com, dave.hansen@intel.com,
        "David Woodhouse" <dwmw@amazon.co.uk>, karahmed@amazon.de,
        "Thomas Gleixner" <tglx@linutronix.de>, peterz@infradead.org,
        pbonzini@redhat.com, gregkh@linux-foundation.org
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.392599267@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 66/76] x86/cpufeatures: Clean up Spectre v2 related
 CPUID flags
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 2961298efe1ea1b6fc0d7ee8b76018fa6c0bcef2 upstream.

We want to expose the hardware features simply in /proc/cpuinfo as "ibrs",
"ibpb" and "stibp". Since AMD has separate CPUID bits for those, use them
as the user-visible bits.

When the Intel SPEC_CTRL bit is set which indicates both IBRS and IBPB
capability, set those (AMD) bits accordingly. Likewise if the Intel STIBP
bit is set, set the AMD STIBP that's used for the generic hardware
capability.

Hide the rest from /proc/cpuinfo by putting "" in the comments. Including
RETPOLINE and RETPOLINE_AMD which shouldn't be visible there. There are
patches to make the sysfs vulnerabilities information non-readable by
non-root, and the same should apply to all information about which
mitigations are actually in use. Those *shouldn't* appear in /proc/cpuinfo.

The feature bit for whether IBPB is actually used, which is needed for
ALTERNATIVEs, is renamed to X86_FEATURE_USE_IBPB.

Originally-by: Borislav Petkov <bp@suse.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1517070274-12128-2-git-send-email-dwmw@amazon.co.uk
[bwh: For 3.16, just apply the part that hides fake CPU feature bits]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -187,10 +187,10 @@
 #define X86_FEATURE_HW_PSTATE	(7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK (7*32+ 9) /* AMD ProcFeedbackInterface */
 #define X86_FEATURE_INVPCID_SINGLE (7*32+10) /* Effectively INVPCID && CR4.PCIDE=1 */
-#define X86_FEATURE_RSB_CTXSW	(7*32+11) /* Fill RSB on context switches */
+#define X86_FEATURE_RSB_CTXSW	(7*32+11) /* "" Fill RSB on context switches */
 
-#define X86_FEATURE_RETPOLINE	(7*32+29) /* Generic Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* AMD Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE	(7*32+29) /* "" Generic Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
 #define X86_FEATURE_KAISER	(7*32+31) /* "" CONFIG_PAGE_TABLE_ISOLATION w/o nokaiser */
 
