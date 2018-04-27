Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524811311-2-8637612127325879974
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524811310; b=JUiIoeyPcuEreAI8Pg0vWvPnmDZAnlYxOTZ/GjOEYTMZgvYOGC
    9jXwkKUPONfnAn8CWq2nnrVpJXNZK/TlTvVIDR/q3MsozMV/8euVPGNYCd2+cTLY
    1r2UqpOzyM/NDNWxV70jJ/RM9XA4TJ77loHb/m01IrveaVCdoh9rxR0pPKzMC/Tt
    BeNjyvRu6GYsxavtHVdv5X/b6aGFugv7e5HuCtB/cFTqKcaOzJ7YL+roz7suPhDO
    01ouKzSKL1zEQ24Z0tg8Dd5dPwp0PyMGZ+Gd6P/u5S6jT9OGGMP6wAQq7DW3Fyak
    EmI3bKnDZmlKn2qSHg4osy5ISDhAKUVZ/wSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524811310;
    bh=Emk5t4COnT75B63F3shf1+n2HqWxYVt/mMYcb0hLjCg=; b=mrbC78M9jCLt
    KloToYQiwh1ygKVoJcKr99wuiVkcTWkLZUtIcAJ9aqoDNWtOZFu6jPwJzYMMrrEN
    wNTlEhrMaTykxZiXJGZsk78dCubJskcdtrF9TscEyhGvNValYE3N9LqgJ3OMaRob
    NU44l54IeqsWD1HHGcy33xhXiKQMZFNxSiteV6wUu2zoPc6aJfKwJogXBeeAoyn1
    9N2vJ/Sc0EC/B+aGbNEpTElWhcHFNy5DKaC2sLI4ap4+mchIzxNa8XMy91qjBzjZ
    EzvY7ECqqGr2qeHTAtkshLf7XpIQVyTYR+fzexuVnbfFmSDBaSw+0vdlH61iIdV0
    XuHqHldBDA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfKQYibL009crFILBer2O4Fji2ACnacVcpyM04mrbJ+EJWeB7VXxzys6x+4UlEtfMOg9m8Il2OsDZTwP4SoKJmhsxpEaR7+e3a9Q1BS5E5kbMb417qdHI
    qs0Rpc6yHfqUBcTmRMxp0e/ta0yaseJ2EfniuushNK7DNQp8mD28TJo2XFAqZTF3et+p9Fv3BCfGgZLXgwTZeO3RuEN4/UkquYDXTmmeN7lwg1/VYrzqqNoT
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=34FZtt5sH-iwMvU2J7IA:9 a=fMUUyhbYWDDmsi4t:21
    a=xPkGj4zQBENzrIrD:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757373AbeD0Glg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeD0Glf (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:41:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B80A2168C
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
Subject: [PATCH v3 3/7] kprobes: Show address of kprobes if kallsyms does
Date: Fri, 27 Apr 2018 15:41:10 +0900
Message-Id: <152481126987.22588.9245868234845928726.stgit@devbox>
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

Show probed address in debugfs kprobe list file as same
as kallsyms does. This information is used for checking
kprobes are placed in the expected address. So it should
be able to compared with address in kallsyms.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e7d7e3e8598a..94af7c99cf81 100644
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
