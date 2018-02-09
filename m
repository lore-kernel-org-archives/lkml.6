Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185438-2-17943150252428678760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185437; b=LhZG7hken9T7uWiqw/v2pmBNKfNNTmceOIrtmfc77JmyGxD
    qHQNNGt/DULqcqCmLeMsPoAn0v4D6GjN1tkVGOLKjg/+hQzqSBLdaG7vWtWE7sdh
    IMWIJGksR2DXVhvNTnsxLmSzKH13uh0UEOf1dig2vfWGIO5ONoIZBMQFV7EJ1Df1
    1JcGJrJgC/BiOJDU/Foq1qPkLnVBLbuNHSPEGX/XqqZAGXqMtQ4ZmzFeOH9sxhYV
    iYV8mNrRTyBP6ViP6bEkuFGAMY6CAmC994KCc3O38mZyN+lUnwIl+MxsxlWgw253
    6t4kQnen6KpNHupq4JpGU0yXsRvuSVfZpXE5J9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185437; bh=vNjtYVvthOXemUI0e14bnhrQnF
    6YnD5wRUPhGjWPnzU=; b=oG3viXSGprysJEIU+ACJKkD2pD3r3sQLlqKrTZgxXs
    rVfBPTm/Cf9NYVdSqSm5HIE5vf0o+aatmV253NLtLWZZkoMwzINrnPsyrlb0czF6
    YoKEZ7wXoVU6c1aMivRhSUSGfnbSd33kto3Xtp2XVZcvlJW068t58grFusPHqUoX
    UiQLmLrEfhY7yvjkC/OCNdl0Xpr7DFxpp6YgarIqukcoLqUejhLwerTNs4EiWrkA
    GiHlgtknn5Wd6C0GEnFL9NqUHDQ515broLF4zol2CPnuVYpzeYcLw5N9JUIEfOTf
    XpAF9T/mfAocMpcl5Om8HtPLxuL775INkjnz5U2KTY3A==
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
        id S1752848AbeBINmP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49722 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeBINmO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, dave.hansen@intel.com, karahmed@amazon.de,
        arjan@linux.intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, bp@alien8.de, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com, gregkh@linux-foundation.org
Subject: [PATCH 4.9 42/92] x86/msr: Add definitions for new speculation control MSRs
Date: Fri,  9 Feb 2018 14:39:11 +0100
Message-Id: <20180209133934.175269214@linuxfoundation.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

(cherry picked from commit 1e340c60d0dd3ae07b5bedc16a0469c14b9f3410)

Add MSR and bit definitions for SPEC_CTRL, PRED_CMD and ARCH_CAPABILITIES.

See Intel's 336996-Speculative-Execution-Side-Channel-Mitigations.pdf

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-5-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -37,6 +37,13 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 
 /* Intel MSRs. Some also available on other CPUs */
+#define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
+#define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
+#define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
+
+#define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
+#define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
+
 #define MSR_IA32_PERFCTR0		0x000000c1
 #define MSR_IA32_PERFCTR1		0x000000c2
 #define MSR_FSB_FREQ			0x000000cd
@@ -50,6 +57,11 @@
 #define SNB_C3_AUTO_UNDEMOTE		(1UL << 28)
 
 #define MSR_MTRRcap			0x000000fe
+
+#define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
+#define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
+#define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
+
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
 
