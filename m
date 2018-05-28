Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133372-1527491589-2-4853363998278143946
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527491589; b=G+gc5uRdMgsCN1JaAH3eogATWuSGw9UCAAG8XNHD0nRG9y6/Gv
    MOMUtB8J7tJqDnAQoEe7yzAbOUkUygfSutZTRVWc+e/ByKyI+fc+6sgyv1ymPFI+
    EavpX/gldR7OXAlHp0VBIrJpuN5UOMSrLtLQbirtwjOIqRjeDKxbR4Nf1mYeIYYT
    E4I4lgR2kXAZBoCW54A6cwEUmGXM6qb7l9Ev7b8r53Y6O0R3jBq9xStSX/g+gh/d
    3MNu3H/z36Z80ru1b6v8ehPSY0Ut+IyqkP1r1UOdney18DysCyzkoRsoYZmtj/AL
    RUAsbRsZdt/X/VQ8t1mOF1f64yvaEkgbyzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527491589;
    bh=mmlh+E1MV8VnWGOwdUW9+JOccUp5zraRZxeGRT23m0Q=; b=hsQ2iss1W+FM
    eyYs09hCoHeEgB+gxWHKp8d1Ft0bGKCuBNcJEq2n33DJK1yvxqJAjSNTvCFyk1Tc
    AN5bNOfP4QZWBPjX9uswmsWc5RjZwohIuR502VMWzQucaE0YvMpI+KDgbaVm8axO
    tEnRnJ7Tn0p471DsT6xt/uik2TZjsU+Ld0i95x6zY4FyAThjkmYsCzODNWTtbqFa
    EQo3wj8Evn7Beeyr8At6XlGJSmTT8s3xIZjYl6nU/1+HYOgJaCw5tjsM0jG7tHcl
    7aiAWmde+VQDnJS9H3cJWMUozKH4c2QP6rvekIX23F6YQqCjlwKnbZRxEeB5zSFt
    +ZCFecz4eQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=QnGJsGcY header.a=rsa-sha256
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
      header.i=@kernel.org header.b=QnGJsGcY header.a=rsa-sha256
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
X-CM-Envelope: MS4wfCjSZfd1P/hJJn/FItlSjlBAIUIyysTwy4OrOpEhrWbyNyR93bW88Dn4xfuC0ZiOM1pgzE1QELWF7LVr6Q7pBWkAP6QWgTk6qVbrtouVnDc8WFgpkIg+
    xcNKLOTk2h8a4+OVFuAaCNh6pJeAPbejDGO9jbFwcfvSSl2a8lFPka4igsMf1J9FzgdXJYQrja16fpgaCsalNuxFa0JlpHejc88E2+tUg2macwmLdPdhGSRr
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=gCol6u2zAc9TF8PHovMA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbeE1HNH (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753820AbeE1HNG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:13:06 -0400
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
Subject: [PATCH -tip v4 26/27] Documentation: kprobes: Add how to change the execution path
Date: Mon, 28 May 2018 16:12:40 +0900
Message-Id: <152749156011.15132.15417205958490100087.stgit@devbox>
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

Add a section that explaining how to change the execution
path with kprobes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/kprobes.txt |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 3e9e99ea751b..8a98eed1521b 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -80,6 +80,26 @@ After the instruction is single-stepped, Kprobes executes the
 "post_handler," if any, that is associated with the kprobe.
 Execution then continues with the instruction following the probepoint.
 
+Changing Execution Path
+-----------------------
+
+Since the kprobes can probe into a running kernel code, it can change
+the register set, including instruction pointer. This operation
+requires maximum attention, such as keeping the stack frame, recovering
+execution path etc. Since it is operated on running kernel and need deep
+knowladge of the archtecture and concurrent computing, you can easily
+shot your foot.
+
+If you change the instruction pointer (and set up other related
+registers) in pre_handler, you must return !0 so that the kprobes
+stops single stepping and just returns to given address.
+This also means post_handler should not be called anymore.
+
+Note that this operation may be harder on some architectures which
+use TOC (Table of Contents) for function call, since you have to
+setup new TOC for your function in your module, and recover old
+one after back from it.
+
 Return Probes
 -------------
 
