Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127802-2-2721370968620624522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127802; b=XxlGi1F09Vvf9SeWUAWe0UiEwksuzVwcBNaERltBVx7VCkUqiu
    rM2U4Uw4o95k4h48atETFpdB5kQ8GxbcFyr0fCdZiw/ln2vrBvoHgRGtt+RQmxzj
    5hyPAK60iuIu5GjDYp6Mby7smly70U+w06PpHc+hccRmqb2HQvEtuF8+jInaT7ET
    /jVMMzyqJdsiuDqkFOzXshGZLgLEx0oq8zHkOebJVh25AROqTaGXA0D5uSjg13cY
    pYeOtXyPO63qW/HdpZ7zqPjWO+KWmMSIvrIna664OGWSHpxJWL+UIXiuneC3Pcea
    HKzSfqylqaGoyaNcuIkkursGMM5p4s6Lr3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127802;
    bh=F2r1r4aK8ZkQFjtmsngJI0v1vzepe1ygTrQJvQCjVvA=; b=m2z5mxvRWIhR
    O/mobJon8Qgzhs7G+rfPYIENqowyp1BGtiuiaWs7BrPLA5q5zkRqHOMuMycn2CsR
    sTjxP9oafU4HiQzxQYImwcgzUSWEHcgKNMxNXc+Oehh3p8Yk6dT9cWDwFzxemHjG
    WO/2vUmmCZb8sJk8CvmzHVlZOFfzV+r/04ENlMctWCEOgcZbtKu5Dt97iCtnnEIy
    /BpYImF8WqjQTEanwuCZTLavoYOZu98+Ucoz4NzEkrDbOj55PVMUo25gLMWvXsOV
    HSZZQjv0jTa9xxmYCW8lniTpgLvr1uyNWfoU2HMwqg+6eSW3XriGQxFuTbpjcps0
    5pFywBLJrA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=yudmMOa4 header.a=rsa-sha256
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=yudmMOa4 header.a=rsa-sha256
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
X-CM-Envelope: MS4wfPjaBESPEhgz3KwrVaz7kkyhBOp4Wr4o2ZsIK3ZyeFLtPRIAoKvZLPmvdliR7nxsOz4Ojx+M2wLOF06js15qluLJ5dnKuzDaOtKDySE9dwVAKWGY/qQ7
    v8xtLYIH/o32TBBejwARm/UfKwDhDAR8CY6I/WubKw+1BBF31Xw9k7dTHRHKsw+nJEuoRuGCN/9SwVLCOYXJj1Zo3X9ORSIgEGAS5CXQ1GQrphmkQq7NP4Pg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=JfrnYn6hAAAA:8 a=IgVQE_B8wD7BZVWpnREA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeFDP4k (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbeFDP4j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:56:39 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH -tip v5 16/27] ARM: kprobes: Don't call the ->break_handler() in arm kprobes code
Date: Tue,  5 Jun 2018 00:56:15 +0900
Message-Id: <152812777535.10068.15797989424722649597.stgit@devbox>
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

Don't call the ->break_handler() from the arm kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/probes/kprobes/core.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 23562111c511..3192350f389d 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -315,17 +315,6 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 				reset_current_kprobe();
 			}
 		}
-	} else if (cur) {
-		/* We probably hit a jprobe.  Call its break handler. */
-		if (cur->break_handler && cur->break_handler(cur, regs)) {
-			kcb->kprobe_status = KPROBE_HIT_SS;
-			singlestep(cur, regs, kcb);
-			if (cur->post_handler) {
-				kcb->kprobe_status = KPROBE_HIT_SSDONE;
-				cur->post_handler(cur, regs, 0);
-			}
-		}
-		reset_current_kprobe();
 	} else {
 		/*
 		 * The probe was removed and a race is in progress.
