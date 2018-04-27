Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839849-2-14815211582618773338
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839848; b=BlrLv5LKXO2M0s4ug4dWNwsk0Do2Ju0LBpufaMKYvYRGMGn2iD
    whPpdMM9bqDKGYgP862dGalru/wtsT/6CbT2pQbUrj1L0zaaZPs8wTvoV4Ffeudw
    em/dnA27VZ1UJrktDEtVT1e0KmkxgtF+J9Di8mhPdI6Ai6W+PvTW9QCpSdosUAVA
    +yRiwkcwB90b2CG7zwvXpOsT7xjKokwhm4nyzvsCVyB1CIwni6JsZOI42NptNuYj
    dBa5IXghaWL48fyNfrwZJ/zUvU0YnA4u/5xMFU7NmWdWeiRbd6n7GNkJsOXm6GBN
    vsPke5RYJM8i2NY61LeV7dhImW+nmXrsh+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839848; bh=tA+VxDMUqqLTVn/qxkpG+f7qeAACcZ
    RJSPamu9Ta65M=; b=eAyhzMe/zyd17a5mZ+EzJKsdGz2e15+sM/avEZYB7E/b5z
    5dLpRwhnNBP4v/SoIILWWAOPvuT9VWrr0JrwUcDsMKXeMPR/BuXc1YYGzCYAYUcq
    SJnK0m36FRKK4Kv0Q34g/zRCJea1CEfEqgh1JgvMmrO7G72D11pxyjLt+Nv1F9vO
    5Mf8g8jbKx1k/359qE+sFXNGfr/KBtisxLQuYWPtC4wSzWC7h6Ho82lcyLuBwMmW
    qHVWpDGJ/VOpvik3n6aLAsDJMld4FVcYpxw0aKQv5CsCY6CQL3i/g/8GVdvm/Dwh
    DN2l1foTRJ7yNJky5uGzWuQlA+LUGUY74Z1xlsRQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfOUAukEU8k/1Px0LrlqGDTHue4TTkkicqhoRPoKmkzodHr7EPWGFDpuQVgY1MS6VSisY7O2oVADAnFISNxqC1k+59shY/oq5gJT8jgZ+rvc/s1KYi2pO
    znfzJb866gzCjdkeGyyc4irHz8IhS9hiksRw6DkPTpHiVJa32PLfS6+Q0MMCC3gASYpHf5rnVpcBpgIIhOlUVAGBIRn+EbPt8ReThxHGQQwWXnP4/wdCuu3d
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=FLezYk6KdQednlvyLcUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934667AbeD0OJ1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934654AbeD0OJZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B6C21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ziqian SUN <zsun@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 79/80] s390/uprobes: implement arch_uretprobe_is_alive()
Date: Fri, 27 Apr 2018 15:59:12 +0200
Message-Id: <20180427135737.036266984@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit 783c3b53b9506db3e05daacfe34e0287eebb09d8 upstream.

Implement s390 specific arch_uretprobe_is_alive() to avoid SIGSEGVs
observed with uretprobes in combination with setjmp/longjmp.

See commit 2dea1d9c38e4 ("powerpc/uprobes: Implement
arch_uretprobe_is_alive()") for more details.

With this implemented all test cases referenced in the above commit
pass.

Reported-by: Ziqian SUN <zsun@redhat.com>
Cc: <stable@vger.kernel.org> # v4.3+
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/uprobes.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/s390/kernel/uprobes.c
+++ b/arch/s390/kernel/uprobes.c
@@ -150,6 +150,15 @@ unsigned long arch_uretprobe_hijack_retu
 	return orig;
 }
 
+bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
+			     struct pt_regs *regs)
+{
+	if (ctx == RP_CHECK_CHAIN_CALL)
+		return user_stack_pointer(regs) <= ret->stack;
+	else
+		return user_stack_pointer(regs) < ret->stack;
+}
+
 /* Instruction Emulation */
 
 static void adjust_psw_addr(psw_t *psw, unsigned long len)
