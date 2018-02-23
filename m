Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415784-2-8205063909589374541
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415784; b=jriK6jGT9svOgr5tAvZiP1Vlku9ywNPTplJ5EW7nsyS2/Wj
    sWUHcP2Fbjtpm1weBcsiDaghH+6EMhTzyNSh+5T4g4FQr4ymY6TU6PggW0obrp10
    NLoUtcAF7NYBfgWH1zovQERyvGH/p7W0LZxhH4cty0mZCz8Rei+43av2gAOOnvpu
    SAG8SrrQpfwWT5wEtcdjO6cLo1bG39yrOyupntx9+lSssFCInd+y2l8FgkIa0BH7
    tyFWqzZq/PWhu24PJQOidqZEXfdep9w7mA/qDJmMEmxAt1dwANlVO/4fEw2psI3b
    rvfn9zRjGbmOXWq61TaYMrmxphhT7JGa/2ffKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415784; bh=CvKpxu+6vo2skOSS0zqQZYDKcF
    uAVh2VM5O9WZo8o18=; b=tmWbevSlfvwqoldSPReqNJ8H2ISYmNVHaEHVp56XCp
    xzXF0K9xodYggfnGsgCnEIs+WQdADBglGpO98X7O1KxCE67lQKwMmrmUgJTi1wJg
    dcrWU3CxWP5TharivgRMK3eCEjyzRRr509YmPxv5ZiM30MfF0UhtdzjxlvL8pPBw
    jlyjaBhJDkLk2GmXGnDIkqEfKUOMi8on06ziNB8SIBS2E6TrVyf3g6zwfdOn2s93
    UtyLALub/xw9baXPTpC8aWZmcC09yCnDIdkftcykwJc3NgFYnNfpGIbqCBjksUUw
    BRwmVLQ7I7RGbqiMWaUGyxi/KUTqJxGpCmVbwqHMQM2Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeBWSow (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:44:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933660AbeBWSou (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 060/145] m68k: add missing SOFTIRQENTRY_TEXT linker section
Date: Fri, 23 Feb 2018 19:26:06 +0100
Message-Id: <20180223170732.556947141@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Ungerer <gerg@linux-m68k.org>


[ Upstream commit 969de0988b77e5a57aac2f7270191a3c50540c52 ]

Commit be7635e7287e ("arch, ftrace: for KASAN put hard/soft IRQ entries
into separate sections") added a new linker section, SOFTIRQENTRY_TEXT,
to the linker scripts for most architectures. It didn't add it to any of
the linker scripts for the m68k architecture. This was not really a problem
because it is only defined if either of CONFIG_FUNCTION_GRAPH_TRACER or
CONFIG_KASAN are enabled - which can never be true for m68k.

However commit 229a71860547 ("irq: Make the irqentry text section
unconditional") means that SOFTIRQENTRY_TEXT is now always defined. So on
m68k we now end up with a separate ELF section for .softirqentry.text
instead of it being part of the .text section. On some m68k targets in some
configurations this can also cause a fatal link error:

  LD      vmlinux
/usr/local/bin/../m68k-uclinux/bin/ld.real: section .softirqentry.text loaded at [0000000010de10c0,0000000010de12dd] overlaps section .rodata loaded at [0000000010de10c0,0000000010e0fd67]

To fix add in the missing SOFTIRQENTRY_TEXT section into the m68k linker
scripts. I noticed that m68k is also missing the IRQENTRY_TEXT section,
so this patch also adds an entry for that too.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/m68k/kernel/vmlinux-nommu.lds |    2 ++
 arch/m68k/kernel/vmlinux-std.lds   |    2 ++
 arch/m68k/kernel/vmlinux-sun3.lds  |    2 ++
 3 files changed, 6 insertions(+)

--- a/arch/m68k/kernel/vmlinux-nommu.lds
+++ b/arch/m68k/kernel/vmlinux-nommu.lds
@@ -44,6 +44,8 @@ SECTIONS {
 	.text : {
 		HEAD_TEXT
 		TEXT_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -15,6 +15,8 @@ SECTIONS
   .text : {
 	HEAD_TEXT
 	TEXT_TEXT
+	IRQENTRY_TEXT
+	SOFTIRQENTRY_TEXT
 	SCHED_TEXT
 	CPUIDLE_TEXT
 	LOCK_TEXT
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -15,6 +15,8 @@ SECTIONS
   .text : {
 	HEAD_TEXT
 	TEXT_TEXT
+	IRQENTRY_TEXT
+	SOFTIRQENTRY_TEXT
 	SCHED_TEXT
 	CPUIDLE_TEXT
 	LOCK_TEXT
