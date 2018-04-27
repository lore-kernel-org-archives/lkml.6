Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3869068-1524811421-2-11541037796688477277
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
    1524811420; b=fVpCmfWdU6fiNEuIPHSTEweYaWlAozqrj2JNcbSFG/P8FiHtL1
    QeCCTs6x/9GWbvBi1PzCPZmv6xVU+TSw1Iw+aqEbucZnqmDcQoyI6BNEA/2dheQG
    jYen4KtnawYnwZ/75fRVakotYup7dVlEk+A0TAMhT0mP6vkkCmUmJQzdslci/07U
    CAqXFWaEQqOYXevLwpcmJ5kGHdnLex+OIuqNDYsSXcBfGHcLZCwDRZ1wvkE8LrcH
    eALgSnmgRptWIlwLt8jvxneh4b0LBZQZF0R7I9zFJQfYhs8IhjGaBwfja8HHJl/G
    0NbjfB4EZDXasZbvQLTYcsMmHWzGGwKu4jGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524811420;
    bh=S4kOOUFOvfU41S6KLIDsvZCXQzxeu7aJtCJnGTr0qtY=; b=JXDcIKvWypx4
    P+t7k2HcNlJXcgYRDY0lUGPbTvlv64zOao0LUovBSpWtCP8Uuo56ocy1IHwh31e7
    B4nVoKvbK13s2ZiiYY00PI35pGoECvK7ve4TusAjcqr0ZsJG+WcB8NK9+avMsZVF
    P/8Ir+DPm/v45p/H2ygdxgSLG+0iz1ECwZ2/zpVRMnm7Nj8MFTqjQM4ODX7WA7hP
    TPb5vgZE6r0Iy3MTgGNqyKREVIwBRHoxEkiyBvKsOavdJJ+NiueQ/ViNbhk1jyk+
    oD6YFsQSV+a8wuu4xiNH5XZKwV8PxQis9I0c1OE4ftEfYc7gDxJWfeocAFEQDdsf
    ZR2jKfUZoQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfC381sEYugxkmogvGy1Ll157IGM3kj6DSMzohYDIAufXMExo2YQX4f2tIwFIYTSY3ojSIQHM4ywZapncXfrC5IORQQkYaGGAoSSI7JQe8GsEhk4UPQLB
    dSRATc8TQOtMcOjefo0jedGlgUgCoCBr39RHDcWhPzDoWxJOTaWjf2wBN8jKwzWjdfNHf+wlsU3ME1WyBpuO/Wo/M7t/BZvZTrEA1ZurmUkt82bzzr4POi3o
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=kimOT7yt1_a6A--e_mAA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757462AbeD0Gni (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeD0Gnh (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:43:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7D42168C
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
Subject: [PATCH v3 7/7] kprobes/arm64: Fix %p uses in error messages
Date: Fri, 27 Apr 2018 15:43:12 +0900
Message-Id: <152481139202.22588.7904972616986820097.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152481117776.22588.1210388093668905564.stgit@devbox>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
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
