Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1897398-1524918991-2-14249778275118171079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES endaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524918991; b=T+52uJhwqZHjfyxEBAUA9H5lnoJ7Zt7PknJbPUaKxEYevHc6Vy
    YPkoV6wFplfd6voBKFl0TUZyqrLJEBpkhu59atfjxNGVVW8epmNZzWVl8h7M1jfG
    rQN1KyLnwvSRlVpR4tb/d+O9Xuzi5R83rtstVz68ka7JHPzayTc1BT6mhJtqIXZC
    fsxavEPseEt0yE72Dz71K2iIOyF8HxXDrmv21iKJMUMDJIdBXjGkjiKXzcWIRQFG
    Y7ks6sjjAqllQWGIUs1YgUcz+PsOcftBu3PsPrdayrqKf8esNBjDZKmQ3D4zPpRU
    xoLu2xcaPRSNoYlk4vLuL+83Lf0KYY+YbJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524918991;
    bh=h93u/kyKK5XZO7JCa6KMFOlJldSxW7zOhUSOc/QPWHM=; b=D2u2cF7BV1XT
    nz7OgEicbd6dM9Bsm4QVagI5qSpWoTK0gdA+KPsS9Bye/PQx/Z/XKIfyI3cZ8ghV
    Glmdc3eTuaZ+8UEuPP/EzS7JpVL/1c8prfeLy6YnTW03m14UKkPDWDSsc7Hr+0J9
    BPXQDfMElYiaIpGzcg9zcqmVlt1oNmaLOJkm1X1hFI78TOAHsyGMJ5ARnia2PhrQ
    t5q3rd/XH8QC7F7E8N96jBhNlFl33ws+7AdZoZvkhpoMxGfTGAOQDxImTbsmrQ4/
    l8uGsYqR6+8t3lLKNrkphjnzXW9gCLTu+b51pZ7YHsdTqL3g/SKYsQSeZy450CSV
    A289tIU18Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNrrXB06rl9uPV80TXWBwE+vLM74MkDMqeEU+RXbYW8M+YOLM9jkJlIUct/NjiPAfs0jLUZigWI9+rFGk4PMim4f/fEe4omF9lRSaBjsp47l1o9ghCil
    3ybOibmkbSTcxCuiBXIhl5KKwSnY4T0NMr9GA0DWx9cIqi319I/F0KOXcjpyc0YfrpSUdFRxVkfUPPYdBCtHibAarT/tcqf8zE1t0cnhyWodT0XFIvmLOmM4
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=34FZtt5sH-iwMvU2J7IA:9 a=nm6pSCFoU0YFQwcD:21
    a=yzljLsBj805Cs1C5:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933486AbeD1Mg2 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 08:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933484AbeD1Mg2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 08:36:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CFD21A96
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
Subject: [PATCH v4 3/7] kprobes: Show address of kprobes if kallsyms does
Date: Sat, 28 Apr 2018 21:36:02 +0900
Message-Id: <152491896256.9916.1583733714492565296.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152491886943.9916.18051658590418236184.stgit@devbox>
References: <152491886943.9916.18051658590418236184.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Show probed address in debugfs kprobe list file as same
as kallsyms does. This information is used for checking
kprobes are placed in the expected address. So it should
be able to compared with address in kallsyms.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/kprobes.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6ec1b5e024bf..548903deaee5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2326,6 +2326,7 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
 		const char *sym, int offset, char *modname, struct kprobe *pp)
 {
 	char *kprobe_type;
+	void *addr = p->addr;
 
 	if (p->pre_handler == pre_handler_kretprobe)
 		kprobe_type = "r";
@@ -2334,13 +2335,16 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
 	else
 		kprobe_type = "k";
 
+	if (!kallsyms_show_value())
+		addr = NULL;
+
 	if (sym)
-		seq_printf(pi, "%p  %s  %s+0x%x  %s ",
-			p->addr, kprobe_type, sym, offset,
+		seq_printf(pi, "%px  %s  %s+0x%x  %s ",
+			addr, kprobe_type, sym, offset,
 			(modname ? modname : " "));
-	else
-		seq_printf(pi, "%p  %s  %p ",
-			p->addr, kprobe_type, p->addr);
+	else	/* try to use %pS */
+		seq_printf(pi, "%px  %s  %pS ",
+			addr, kprobe_type, p->addr);
 
 	if (!pp)
 		pp = p;
