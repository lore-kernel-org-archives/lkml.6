Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824389-2-9945318936107544409
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
    t=1520824389; b=EkK2pphOfZjrx9yVOqeahS1JC0V5XtoUX8C+i0CQNTUUgZx
    j5buZ8x6KY4r9PLix52cimFg5HEBEce6IIwOd/WFkrHdoqrZ5bOXzQgFCnqij01u
    hpQPeewwsP13aSrDIYK2gefCZH7JnFf1mFqzwJ6kcFVEyyTzAHerwBaITuCRHkz8
    A2RsiiUJPb8PKalzoPV4XlMHLl9T5w74EWl0YJlw1noAcLikExLj+d0Dd84l8N/a
    OlWOQfkpIkwjesBihIYzUMhrfPTeiWV85wx0etLDbNbZIqldNE5ABzL1lWHQXxiR
    BfMzMCgf7YVTaAavQr7MMOSnfMZTAmDd6iOGNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824389; bh=RkZHAx7/mNC7pZoVXbQ
    aK/7JYW3Fn9aQvfkrLAvnwDA=; b=UcDsJy0KgJHJUnlaeHSoUTzcyTZoL4xqPUT
    MP7EZHghXwRmFIRLGNJxnM5EbYqlmfwjXHVr6s39QmedsInEXLkCU2OMp30G/DYp
    9LtbHnSsoy76ZKH66qyVEizyfLW1j/NMGYlaVrvN6PQZF/neHpS73XobrpEJtwcI
    56Jd7cnIY09cZzNLZ6qhAzDAeumkBhIeFapKfzeP4m3jPJoFDBjRTMH9Z1IoNv2m
    sY4eNDd0AVyfIzfO8ITTRqRIl8ZFfRmO7nrJXSZgq02BklIgQEhWj1UV1fP54Ssy
    jO5YYdah93hSUPaaiZUYYL0KHVzCjk8dR0m+nUGuZkl+dS/bI0A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbeCLDMf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:12:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41577 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932802AbeCLDHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:52 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andrew Honig" <ahonig@google.com>,
        "Jim Mattson" <jmattson@google.com>, kvm@vger.kernel.org,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Dan Williams" <dan.j.williams@intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.361057584@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 62/76] x86/kvm: Update spectre-v1 mitigation
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

From: Dan Williams <dan.j.williams@intel.com>

commit 085331dfc6bbe3501fb936e657331ca943827600 upstream.

Commit 75f139aaf896 "KVM: x86: Add memory barrier on vmcs field lookup"
added a raw 'asm("lfence");' to prevent a bounds check bypass of
'vmcs_field_to_offset_table'.

The lfence can be avoided in this path by using the array_index_nospec()
helper designed for these types of fixes.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Honig <ahonig@google.com>
Cc: kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Link: https://lkml.kernel.org/r/151744959670.6342.3001723920950249067.stgit@dwillia2-desk3.amr.corp.intel.com
[bwh: Backported to 3.16:
 - Replace max_vmcs_field with the local size variable
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/tboot.h>
 #include <linux/hrtimer.h>
+#include <linux/nospec.h>
 #include "kvm_cache_regs.h"
 #include "x86.h"
 
@@ -695,23 +696,21 @@ static const unsigned short vmcs_field_t
 	FIELD(HOST_RSP, host_rsp),
 	FIELD(HOST_RIP, host_rip),
 };
-static const int max_vmcs_field = ARRAY_SIZE(vmcs_field_to_offset_table);
 
 static inline short vmcs_field_to_offset(unsigned long field)
 {
-	if (field >= max_vmcs_field)
-		return -1;
+	const size_t size = ARRAY_SIZE(vmcs_field_to_offset_table);
+	unsigned short offset;
 
-	/*
-	 * FIXME: Mitigation for CVE-2017-5753.  To be replaced with a
-	 * generic mechanism.
-	 */
-	asm("lfence");
-
-	if (vmcs_field_to_offset_table[field] == 0)
+	BUILD_BUG_ON(size > SHRT_MAX);
+	if (field >= size)
 		return -1;
 
-	return vmcs_field_to_offset_table[field];
+	field = array_index_nospec(field, size);
+	offset = vmcs_field_to_offset_table[field];
+	if (offset == 0)
+		return -1;
+	return offset;
 }
 
 static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
