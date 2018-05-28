Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527491322-2-17630323976155922924
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527491321; b=lpXHEC5qGjGKNjqPOihuHLUdw6eyzEm8Zl5/jAXsajCLIbGm3c
    djzZRrZZ//rDNoKN5EtyaK8cfflwtndXWNRgAm6+7Jk6WWJ8EpQb3dGs6V+qQWdD
    XIoaasQQ3H4H6f/x1mM7ZgSaxq7kshJuUMh1XL6eub9lM3eQmmKFQ2VKelWIeh5k
    +xmrMWHlx7cDdBAt0rY61zZvUbLnFvgYMsrUwwmfnEqbtzueYgSX4FLcXwxMk+/d
    Y8cbweeVasxFCvrpImJ7vU1qnS2D5kgtvZax2YMM+Tbd0OiynMDX6cwwaIAdBJrV
    Mv67c0PXIgsODlBktBah5a19nxLuO97hBykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527491321;
    bh=bOSiJlEymdmFB1LwybizxY3sBFvLaE1r1uhVDg2kOfU=; b=UAoR7DPWmOkF
    U1QgkE4yvhHHtrJGpIObLm0UMF/wPjHrwbfcLZtVAeR3WG95prjgtdxXzwqO1TAL
    lo1A9ed4J7aJZ4OkPhG5XWtT35FUr0xD2OpWr90wbi+VEInIGG5F7ISNPQ4Kbbsd
    7iizKrsi7YXKx80VFu9/Bx43Ho4m3guSXG6Fz/zvEBr12Im4Ou6bOjWE+pqjFs8y
    9OefO6I5UMWUUxQ7x5doyQcOkqPucvI0nKd5gejBJZYCXjOxt8hny32Kx0X09+t8
    iMOUar7yFwfqdFujOqW3KhSl5WqTSbD5E4tjl9Gu9ItCnxWOknqjoByPNJXzWj1I
    dvWioCVb2A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Vs8ocMA7 header.a=rsa-sha256
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Vs8ocMA7 header.a=rsa-sha256
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
X-CM-Envelope: MS4wfMFnaJDeorkxsDD0idBUTREkP9Ig4EQCgJNenMPOfyzKD50FPbItPCvE+YDiNzBLupcr1VSQzMBngWbsQOBUsmim6fSl4CcaIqT2o002DRclDbzh7aUA
    ahgAptfCJnNEk+DOu4dJEUj6NUmJtwF9V6OaUh9ldMUUkyKmO96cQ3mVvC6muVhz6qUpLsqHJXvLkG+9Zk69I9uEKHio21hYwvOcPU0+ZS7Ya/J31sHLhmeJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=I0i2l-to6hpxGGMJ4sMA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753743AbeE1HIj (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753639AbeE1HI0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:08:26 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arch@vger.kernel.org
Subject: [PATCH -tip v4 17/27] arm64: kprobes: Don't call the ->break_handler() in arm kprobes code
Date: Mon, 28 May 2018 16:08:00 +0900
Message-Id: <152749128042.15132.2835369804724511290.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152749074878.15132.16693721906742461289.stgit@devbox>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
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
