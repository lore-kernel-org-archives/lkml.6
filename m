Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127948-2-3471674643670073209
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127947; b=kqln4+eI4mBn6900vSmsj94TbchfW7jDlvEKcgLKUbleubq0va
    YEwTRFQ9giLOU3oHZvMvro4Gbs5Jb4QkPStyLQlqaU/t+M/oGKvifOqmeBEAyNfL
    RZKk7ithj7R5ljKufyR41ACimn4gUoBMAyvVvogoaA9kaesyJGVjRmsOjE+o91lT
    zTydRg92E/DGEJR4kXWlKXbgVv+EZ9MTAauS91dCvyH332LKrn/XIQXUgcMvyqxm
    5yU+DYKhU2NvHGEhrcjgt5yqKiUK348asoT+KAzuyKcruzIwnxYDHZB86Fgq5l0m
    isS8Z77/YPVFhjerD711eiRSoGz/YLfuFgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127947;
    bh=RkvFr5r77cfQ39FWTIIpJuJnFNLYaz5oBrGyUMYxZeg=; b=Ryuk0aG+S6pw
    T8PKf/P2+x9dWoKIt16b4g1kutJ+OY+SQ3Z1ANgYBAAAB2gY3EKVD8+Nsf0joAt7
    2e6Asq0YnPAddyar/bj8INWIeShYFi9rufAoycdcnY+gT6pzzSBSS3JdxMMfYa7w
    wTu0qGb9or2oY2uFm38y+QpHWj5VAPUYgwOGiR0SmUqaCWYmNxpqS3QrPmqy8Zoe
    zw3cWDasSYUKEYcG+g/vLfd/kmD8/s718XuzIC3OOWHplC2/wzA/IE6skQZOOkBL
    WjfoRN20kU72Tflqban0J4pEHcw/Acyq7P5BWmDq5S/On5PQCxJxEKab38niECNs
    utUgy4NmnA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=s1l8olsa header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=s1l8olsa header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFlIqUdcaOlOwHnnR+le9nLtTmTXMaxfTJ2iwtudLYNZxHNjJrha/M9xnw+85xOPjiLgY/03jh/dtjhP4MHQlkSz+YlNJ5w3H/YpTPOh1P2FysRRT8dj
    mDHEfb9OKdezZVJBuvIikOdKKX92vIELepmVM0kZxGj7+PNhhRlgPwxThfEZv/4yBGOXB9sUtCbVqXN56aYUxNsu3aCq+kbjWk1RxeyNfafrgkcp5QK31Izc
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=OCyeOLjGn72K7w1p9ZsA:9
    a=vdFsMECsAYZcatlO:21 a=7C4baYcY2Rihdeh-:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeFDP7G (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbeFDP7F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:59:05 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [RFC PATCH -tip v5 21/27] s390/kprobes: Don't call the ->break_handler() in s390 kprobes code
Date: Tue,  5 Jun 2018 00:58:41 +0900
Message-Id: <152812792088.10068.655430820863308741.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Don't call the ->break_handler() from the s390 kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/kprobes.c |   20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 0967de19f53d..3e34018960b5 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -332,26 +332,6 @@ static int kprobe_handler(struct pt_regs *regs)
 		}
 		enable_singlestep(kcb, regs, (unsigned long) p->ainsn.insn);
 		return 1;
-	} else if (kprobe_running()) {
-		p = __this_cpu_read(current_kprobe);
-		if (p->break_handler && p->break_handler(p, regs)) {
-			/*
-			 * Continuation after the jprobe completed and
-			 * caused the jprobe_return trap. The jprobe
-			 * break_handler "returns" to the original
-			 * function that still has the kprobe breakpoint
-			 * installed. We continue with single stepping.
-			 */
-			kcb->kprobe_status = KPROBE_HIT_SS;
-			enable_singlestep(kcb, regs,
-					  (unsigned long) p->ainsn.insn);
-			return 1;
-		} /* else:
-		   * No kprobe at this address and the current kprobe
-		   * has no break handler (no jprobe!). The kernel just
-		   * exploded, let the standard trap handler pick up the
-		   * pieces.
-		   */
 	} /* else:
 	   * No kprobe at this address and no active kprobe. The trap has
 	   * not been caused by a kprobe breakpoint. The race of breakpoint
