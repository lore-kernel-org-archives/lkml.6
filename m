Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209064-1524730325-2-14942759868951510238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524730325; b=GVhUsK7C2/8lyhJCzDVAdfzyAVpHJ0KQz7vs6BQy2/AYF81fLI
    ieidFzuGXAJa9r4Zm/vMnV6LP/RMSlrOMr7yf5ZwTwejfx7W5Qckb1TkBV2afbKx
    R+0SMYWBZonFQ6NDbfNGjpj38sqUzM2HZCmmhycpFyJ3dScBj4Z+Ljn2ssi9wf02
    DvadVdJjGqmx9bgFmhMjNILsi6lKmvdmmxT4IBEnxZ30EKMMOn9TPyHXOnFrxhNd
    S6BV+IL94vkiNflrhj6E8enRkVeNErPJTfrs4CxDsNIqqPzEiHjvHIFphBCz7m2W
    VF6R7yXGFI8BCF0XcxDqyWYWJlEXXNMYLX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524730325;
    bh=S4kOOUFOvfU41S6KLIDsvZCXQzxeu7aJtCJnGTr0qtY=; b=WO1mP/Ea5Hr6
    TB5ikqHwRqq5Nu50Eg3x4reGPWySWeoCbPGZsRVQOx3lSYt01KYJmAj16fNdj9ab
    FH3PZNrYiAQ+gccOKK/4vih3yzzuZ7iZA6B31H8cQ2NALt/T+jhcj6mOqusuTIxT
    ie7Pg6W/AW8KP5pcNrPjySZYRzVgbJxRKRVjW2eaJy7zaqLz2DXsmdy+RLgBBbBs
    AULaWCiFU3FaQSbnP7l7p1KWgrc5Wjo1bCzIYIFf0M1tOI5LOkWjwHMjcurT9Z2F
    pQ2MLItgWSIkUkT9I3cDkIo8GSkO/Pm5MQn2m/HSv/fGd2EYEl+bAgTt32peO0/s
    URbR8LmVRQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNl4a+BegU7ZHe253t98YoCsdIDFAfvGR8DAr8BzBOS1AP1XQGMo5GcCtCXXwgIiNSXE9pMiUrn11ACB6r7vS76l62l7kvwvyBpkG+52bSc0ywFW/zWv
    MEhetFScSfkJdXVQjI9Uf8hBtM98riIHHFkuNvZ58JVIXcrgrofV4ELe+UWXqxqDWuCa2XMQ9OEuzsCbZtlIaIw+0Ptg3LPSw/hsRN7+Twq/TwntqVEPaiFq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=kimOT7yt1_a6A--e_mAA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754249AbeDZIMD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754128AbeDZIMB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:12:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3F921781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH -tip v2 7/7] kprobes/arm64: Fix %p uses in error messages
Date: Thu, 26 Apr 2018 17:11:35 +0900
Message-Id: <152473029530.8819.16999245501020107222.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152473007907.8819.10449983839199591406.stgit@devbox>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix %p uses in error messages by removing it because
those are redundant or meaningless.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/probes/kprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d849d9804011..34f78d07a068 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -275,7 +275,7 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
 		break;
 	case KPROBE_HIT_SS:
 	case KPROBE_REENTER:
-		pr_warn("Unrecoverable kprobe detected at %p.\n", p->addr);
+		pr_warn("Unrecoverable kprobe detected.\n");
 		dump_kprobe(p);
 		BUG();
 		break;
@@ -521,7 +521,7 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 		    (struct pt_regs *)kcb->jprobe_saved_regs.sp;
 		pr_err("current sp %lx does not match saved sp %lx\n",
 		       orig_sp, stack_addr);
-		pr_err("Saved registers for jprobe %p\n", jp);
+		pr_err("Saved registers for jprobe\n");
 		__show_regs(saved_regs);
 		pr_err("Current registers\n");
 		__show_regs(regs);
