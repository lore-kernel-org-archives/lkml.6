Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127773-5-2770430308090436545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127773; b=XN0P88PkyKQusPzWpFvf8GvHHcvtfNhKoUEbpCyoAvxbT2cu1n
    cy0R3eZpMfCctB6kQ4r4mSGFvKVfqlVlq+NtqurwTQazLnmRECYR5JnPnAwUjmEW
    ObCbMAdCjQLlTcnjSBBujkUA3/V5/lMDxXP4BC4W9Kg/fzoTwdTCkPH6IKuuHf9m
    2FzAqA0ViYJZW9goC/7h9H0tdsy9WK3N/L/eFhLvgQ+AtE7chQQRYqMnmab0dhin
    z8RRAnhoUp7rUgmsGnX0Ry0/13Vss6EpMzUibi6clr0F1CJedDlJ9Zqr5vubfh9U
    QbW+hIYTL8cEQAPF+ul3rTami8dvhOdryZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127773;
    bh=rI6skCWB1g6rVsRNnjg2iRcNg1Xm1HlVP94JuJBwdqU=; b=C4BU73Wsdn0p
    bwTj67wz3CbEJ6+h/hGgpORMwILwJM80fkQMYjSnl4y2FelJGHbxLdriC7Iyw0pd
    g5vFJwA7tYrVisGwdGxLQmM5Xkp+A+MapLPWjj255KXXK5WC+NpDdGEX5nh68Nis
    bTZ//BrkPkp6uYet7fofgKwwfnHd87CnYfgedaGmYjH2/DwVI96FFyQmMOkBpcEC
    vNBQgmA0MwgiGE9sAH29jvTRr3Ozjw5vR02IyCjZbTnQefvIZ6gJGS5ata/gt9w7
    HTrGbXNOqec5dl2mHfa5xI7pmhxxeQ9gBDCmKM2xRnYaHfc4cowrzYjE6Lf9mU35
    Wsx2nLFx9w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jtKXq23G header.a=rsa-sha256
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
      header.i=@kernel.org header.b=jtKXq23G header.a=rsa-sha256
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
X-CM-Envelope: MS4wfGRex7glrN+Zh19yQwIdw9VjK/ZNni7yESFh2ZJpw5mclGN409LbpQfymzRhl7jJOXzZRS6gtK9qI0C68E2j/Fn1/6ASnLnu9Yq6vhDqRail33KdcGa5
    T9y8V8oGGqNykFQIHR8YP2TAe+Vyj3a8qwfC40iJBEn5Xxr4abLzHmGCPsIKcz+7Gh+1FlDYQzypLz3vWmexwpoYeGoyFy9Klr/2lm+vWbY3+rpnYdjRUzSy
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=JfrnYn6hAAAA:8 a=898NzwsOgPeVx9klafUA:9
    a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Lf5xNeLK5dgiOs8hzIjU:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbeFDP4L (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeFDP4K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:56:10 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [RFC PATCH -tip v5 15/27] ARC: kprobes: Don't call the ->break_handler() in ARC kprobes code
Date: Tue,  5 Jun 2018 00:55:46 +0900
Message-Id: <152812774641.10068.11144829855901255813.stgit@devbox>
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

Don't call the ->break_handler() from the ARC kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/kernel/kprobes.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 7811a6bbe8f0..465365696c91 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -234,13 +234,6 @@ int __kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
 		}
 
 		return 1;
-	} else if (kprobe_running()) {
-		p = __this_cpu_read(current_kprobe);
-		if (p->break_handler && p->break_handler(p, regs)) {
-			setup_singlestep(p, regs);
-			kcb->kprobe_status = KPROBE_HIT_SS;
-			return 1;
-		}
 	}
 
 	/* no_kprobe: */
