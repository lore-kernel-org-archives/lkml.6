Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127831-2-2460857040788097197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127831; b=cFqMrdEhVoNcHcV9nc7VxA9pkA6IWiZhkcmFgMCBbaeAByH3IE
    6lVHG2WrHwQ+ZLkpxlB/EBh12WeptlzIB5Yk/pWHsd5daTz22twj6UShMIOU3U0S
    bgJouBCWx/kzFuz0gZmJl97rxxtlJ2dPhnydix7UZ1mlPGyyyjV2hwhEGcIu1ciX
    wwxsL9ve7WRq4DPcacgFpUPELmRKUkNeCdCvdg3jlMT4oIns0gRq/fVFBgY1HB2+
    0Fmt6ZMA5w/0m/IQnGnFERZySL5Dxhyf4hGRPRRz3KMCNc2w7m5VJT1XA+4HEG2p
    5ZCOVGC2waD09/ZOZEj1nUdtTy41IjahJ+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127831;
    bh=feQRP59n6SXw9esk+3nY4qsEpy0ZjHHxAdrXzBY3hgI=; b=Oamgxw1L6xES
    X/bu+FFAbSZeK1wYtRJyZ9B3N4L9T5ufhbiMIbNosOLot+14DoedncG2iC8NlEa7
    vAKLJ75yagwW+bmi8uuCxansYdk0OUyORT+dhE6Aghk5odrAKzrhHPwgMZnAljNt
    TCuTxB7hFD6PwyhR5U7YLFhnZj0V+rYWqS7YeoopmAAkDiKnyYXkbulcNvSHpjui
    cYioJzqPk8HDQ+HC071ABf/KgHWa6ok/f96fkFjpqmLpmPPOTOUyrRP6J+tjwlOd
    9czQcv8ufWtRr7RHdWvmL1fIUzZYbkkxNhUgIVJs7Got4v2bUpLhPeJYqK65cA0Z
    AQj8vB9YDw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=W7hbTLhs header.a=rsa-sha256
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=W7hbTLhs header.a=rsa-sha256
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
X-CM-Envelope: MS4wfD1mIeyxSMhgcyL735wdlKfV1qXNbvvA45vExxU8valHkwyGyj2Ly3TyAvDDTwPJ+oqnY3ZWk8LUK0x4d8+yEgi1tqqTaPEMHVB+v3+XVtGnB9NJzajT
    gfZmWfph/ZgS2EaV1VQcPd9Z1+6oH5rbJz1/MM++mYcfjAWIdE9uNELpGzE1cdaVUF+pOF83+68DUWQwlC7wEe6nbGKuEh9D0L2DwT3nmjQCawBjMibDAz/M
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=O5uhvjbnwQScSC78hjUA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeFDP5J (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbeFDP5I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:57:08 -0400
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH -tip v5 17/27] arm64: kprobes: Don't call the ->break_handler() in arm kprobes code
Date: Tue,  5 Jun 2018 00:56:44 +0900
Message-Id: <152812780433.10068.4191004481518140821.stgit@devbox>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/probes/kprobes.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 3ca2351109a6..076c3c0775a6 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -408,14 +408,6 @@ static void __kprobes kprobe_handler(struct pt_regs *regs)
 				return;
 			}
 		}
-	} else if ((le32_to_cpu(*(kprobe_opcode_t *) addr) ==
-	    BRK64_OPCODE_KPROBES) && cur_kprobe) {
-		/* We probably hit a jprobe.  Call its break handler. */
-		if (cur_kprobe->break_handler  &&
-		     cur_kprobe->break_handler(cur_kprobe, regs)) {
-			setup_singlestep(cur_kprobe, regs, kcb, 0);
-			return;
-		}
 	}
 	/*
 	 * The breakpoint instruction was removed right
