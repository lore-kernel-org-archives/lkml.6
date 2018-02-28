Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519839375-2-12776780593134639373
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
    t=1519839374; b=AOdBxkXwxwZhOeu6TviDGGwuFmj1VMcDNbW927auFMNoV6D
    r0pnl7AWuoMPJXn3Q/hH27j1pNuOU+1I/xDA3NGCiL3mB0zRNvdoAlhE6qYjc1Up
    skWihw+U38u9puWporNAywXnRs91a+MEVC4/qW8eaT5WxGu2hvhURNupw7l4dG+x
    p5uZX41XvjHfHDeLqLXqKgnn2PrP9uPBPTeUyTFTBZPoiIG/aAx4j8Tb8jCy3bar
    z3eJYPhkrlhDbtjrcaayJR1hg33ibir1nyOZGU4+eYmRgjuWcJHbA7h7tItwJ/g5
    WLQDD5mfu0+BIe+W9r/kQ6EuwiszUhovbVSZEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839374; bh=ygDsb55qtay8R6gjKuZ
    L12j4P0dYDKoSOjgQ2OyHWF4=; b=JjfeF7xn8qSc10QA7NoJHp4d8QVm8zME8wx
    3nYKvlqwf7hWLvcYnmy2LlLY5RqW87vVvzFubhaneJqWguil4WVEzQZbqve0HHGC
    TlG0c9oNxSkMM2r4zc2PsCMHAExShhekod6ztWW+lSEwYG0GbnmSTcIYmB/GEbFC
    LjN1dCMMosJXjwhkmFmTSa08GYHrkxeVoo+K01di0ZYL1nf/IewpLdqJ41wRJxLQ
    IU73jd3H9s109K1WfvN1hxgrvOngihtjUKgRWWb8NSBaSaPlI94LKazYFBG1tdtr
    1F4bMCcTFeo+xTKCZybHCxRTPU6lJMlyEOHdoSHLlhVeMrVnElA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932552AbeB1Rfp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:35:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33212 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932563AbeB1PWO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jim Mattson" <jmattson@google.com>,
        "Andrew Honig" <ahonig@google.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.126039201@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 097/140] KVM: x86: Add memory barrier on vmcs field lookup
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Honig <ahonig@google.com>

commit 75f139aaf896d6fdeec2e468ddfa4b2fe469bf40 upstream.

This adds a memory barrier when performing a lookup into
the vmcs_field_to_offset_table.  This is related to
CVE-2017-5753.

Signed-off-by: Andrew Honig <ahonig@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -573,8 +573,18 @@ static const int max_vmcs_field = ARRAY_
 
 static inline short vmcs_field_to_offset(unsigned long field)
 {
-	if (field >= max_vmcs_field || vmcs_field_to_offset_table[field] == 0)
+	if (field >= max_vmcs_field)
 		return -1;
+
+	/*
+	 * FIXME: Mitigation for CVE-2017-5753.  To be replaced with a
+	 * generic mechanism.
+	 */
+	asm("lfence");
+
+	if (vmcs_field_to_offset_table[field] == 0)
+		return -1;
+
 	return vmcs_field_to_offset_table[field];
 }
 
