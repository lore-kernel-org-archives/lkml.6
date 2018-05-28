Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133372-1527491464-2-1248493623687040513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527491464; b=QHunE59jdODzZfgIAoGFDk536SNvDoHxYUO4bPaYu6a0a9gl1b
    9EqOkcegpzkQzOBRxIqy0ZHhz8/EV+dLkUc/r1VPcDLap8+RqkmxpIyCSuYl4LOn
    j3V+MF2VGvLQGUSQZDYurhw29S1sc8a3dKtPgujYHdceVYdwEyEn2kFd8pI5f/DZ
    cZtjhJwN7sTAjqJJXO11WCBzzCkxRaQ4JF8g58DGWlwlvXSnD7RDFn/UoGkRQbOD
    74sNR2748qvBjtuuOsSnFOunZz1zgC6w1ie/E6DexgIYZaQk3LPUCm3xRrOBtIof
    /wLk41yujx1OKtfFM7Bn5wNux5hO4HS2Khjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527491464;
    bh=RHAJdhbk46cKHr78TeL2FiY0Ta1Rdqgbmm6YjTQzaQY=; b=fvUOXsO4mGuK
    pspeWAIUCHyE9hoDbjjm/kdAoQYJDMZGzf1jUKkMvAmxENh6DAdVj/HizucyjAMJ
    4zT1pvHcQslwAxhrsDvG1aaCWZyUJC14Z4L3haNsG5teb9drjVehhIjnZNm6ehY+
    0m3YWA6P2J+3XTt8trBPRV83LyNXmoeMyqEtVNpY7w/XPxs0LcMqyomZRbOYJcbz
    sa0XWlUPQ2+SVSJ8b5EH5LF7S5KxEEi1Rne7+plaBbrPbpUqF37zpHScwpIBHlQJ
    9WUyPWKNkJ7mOMzzT4qTr2QdPxi6Mm4Xf9yzy06hPyb2A0er8BMaZ7fB9z2qfk7T
    S3kyjb025Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=XhEMu2cb header.a=rsa-sha256
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
      header.i=@kernel.org header.b=XhEMu2cb header.a=rsa-sha256
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
X-CM-Envelope: MS4wfBHS3easmgrS1uYUV0mXXrVhcG8miyLlUYLeN5iTUnoKE9Hk0lpeTxPwzxL1eru5rF+GLWMmNrsEW8BHXzN1dKrITvw6lPjn5ecIMYbOFkd2v2k4wm4r
    j43YxJJob63hep/Gz8STRsnuZKXE7i5873bLSx4RqD9VJtFOc6rTMX9W8GuslMjjWha02BN3PrnbIApydu9JqdaHpfBTJH+HG5KX0xdbp+w1Xyp5hSA2AL2R
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=fsWX9E5i64TX0yKf0BUA:9 a=kP1bVHu8wsDASddq:21
    a=Al1hW8igzTq-ASAm:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeE1HLC (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753756AbeE1HLC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:11:02 -0400
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
Subject: [PATCH -tip v4 22/27] sh: kprobes: Don't call the ->break_handler() in SH kprobes code
Date: Mon, 28 May 2018 16:10:36 +0900
Message-Id: <152749143600.15132.3715538903929976134.stgit@devbox>
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

Don't call the ->break_handler() from the SH kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/sh/kernel/kprobes.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 2b5e58873b96..4fafe0cd12c6 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -248,11 +248,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 			prepare_singlestep(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
-		} else {
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs)) {
-				goto ss_probe;
-			}
 		}
 		goto no_kprobe;
 	}
@@ -281,7 +276,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 		/* handler has already set things up, so skip ss setup */
 		return 1;
 
-ss_probe:
 	prepare_singlestep(p, regs);
 	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
@@ -508,14 +502,8 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 				if (post_kprobe_handler(args->regs))
 					ret = NOTIFY_STOP;
 			} else {
-				if (kprobe_handler(args->regs)) {
+				if (kprobe_handler(args->regs))
 					ret = NOTIFY_STOP;
-				} else {
-					p = __this_cpu_read(current_kprobe);
-					if (p->break_handler &&
-					    p->break_handler(p, args->regs))
-						ret = NOTIFY_STOP;
-				}
 			}
 		}
 	}
