Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133372-1527491246-2-402693604800675943
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527491246; b=megC+XwIG+dLlXXfoZMOxDlgudyUHEJe3tsisfPAFKv1mTtB9a
    ez8eRA2Kli+pUoECSlE8iZQTbueFMh9Dnoa9zxbQXn7ck+gJh7lvq3Wod1ZuqnJk
    euGoUj7sMussBygj//OR0CtCGJz0gWhbi0EZohdIYlzDGQXyPskuo+M/Cudvx/Cz
    jl+N8ThfGfANwqqHjfEpUupmDlV4E3/0NqndM9TuE3xmPW65TZViQiTxytVbyBSZ
    Rx0kyttVBqV6p6w18qNpFBFJ9nxSjmChDntbZPulp7H/8KFYXc/uQ0c5FtI/MvLT
    TH0tdPv9/iGobqcnorM4fp7xZEsJrF+SgkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527491246;
    bh=WNi/dcAL/HKd1UH39j44zya3jL9UXFKhUb3bkGTV7xk=; b=kmvgPeKH16cn
    xjG8Nh/qfrf2g0QpYMaYdKOMgDx+FCjqCgcRSCyOXcK8Hz2W4dbUpRUCCKfmWzSB
    /FYpAakq+tKFWNxj5qZvWr0rw6WD87LaRaNGJxeHjCYn+VbWjw0wDmK4UCR0BvyO
    K/kMT37H+8ficgySL2W+wKVgrl5wNtGwgBV+P5zZ5j/jTPrt4kkLLv18BLtlrclq
    FhxOz1oZEMucEcxdXy3Xrr6AD0CTi3PdWhQPt/BFPfLgDamf9oAzqFvmZmdvKH63
    eXtOL9eajl65XVqaxks4OtbIj9TnEnDHuiACHgR31RcCGnajhD1Wcwgb6qz+wXB2
    JzBh6P8paQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=JcU0aZjE header.a=rsa-sha256
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
      header.i=@kernel.org header.b=JcU0aZjE header.a=rsa-sha256
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
X-CM-Envelope: MS4wfJXz42cz9jxO4pi88U/eb6s/+Aj0hIJSQtSelcKm4s9LXCQ7rrIqthHKAYq2QqK4zu0qIJsMjPXZ6Lk3Ia/AVtiM+RvDnGcpY2aqx+S8mDqWAuDTWmOP
    b31Ypx6lUwFv2839OCJutGROV00musEJHa8p4Q2AnaDhw2HrV03p60wdnzoD84ME2hXxGoVvNTHJbdl4sW7gwdjTm+rP7QTbHqoiL2dTR5/ZlXKSGhsYq2gQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=898NzwsOgPeVx9klafUA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753657AbeE1HHZ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753302AbeE1HHY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:07:24 -0400
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
Subject: [PATCH -tip v4 15/27] ARC: kprobes: Don't call the ->break_handler() in ARC kprobes code
Date: Mon, 28 May 2018 16:06:58 +0900
Message-Id: <152749121806.15132.2649298571566781993.stgit@devbox>
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

Don't call the ->break_handler() from the ARC kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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
