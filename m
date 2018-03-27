Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174029-2-1182258358165595982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174028; b=AtoOoXTBWbAYETzWeEGrsQVcZJ/Q6DQU20oM8+1KtMfFR+P
    3dYwPyAIiPgjXtcnGEkMl6AwdYx1haQgPcVxk1/D9y0/HaJdUtcxVaDFX+Z8rhVL
    CAq1+EmWhd5nhri+SmL0dZlYd9d+bW8doF+L5fsnAil8MAFM6hHdz1RltqdC/ZvV
    eSih+q39SADRdLKOYcxilujGOunY0Yh8c/KrOqf3/i/1jQxxgAY+6DY9MiW4O3jG
    rxQ6hzpX+rVaoRmMqshyJxM+MefyzU3FBOqR8Nu+ZMAsQgJoeWQrKV7AcN0mVM4C
    rMZzQWJ1mdNhYcyZ6mKwmN2tJUllyYGWvJTEXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174028; bh=wLSsoiBu+dloPJFCOTGUeLmw4C
    +QkAtk9+xWdH/IRiA=; b=cvnSTDK31FOziyXDX2DLNqRuaZGohouEkZCTkcAjJM
    0kxNWBt/5R7kI//tLhr0dpQuZQZRH5vjlVv2CJKNFZE+5RApejUKjYclStHfBPbs
    vl7Q6DmheKpdWmhZCXl5PejTnO6eo+++c9ZJd0dmXmZlmxUldrUKqU0seQBzO1dm
    iuL7ESrE5qVW95JkUPszDJEG97w97nVYNNm73zkLzxy3XgwVOqQjHvy+Ue8veJNt
    sSzSo8NQMI0JeJgrpBqZMD9kzasFEwBkbuOFwM/YNJh6AUuYL7NhYTmbPPZ/E+8L
    LSEjdw6SUyQDlpOA0u6H/pgKgJZHCAKWexshjSOGnvBw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHvJp8gw7f0QDGPoOQUlcdFJGJRSEKzfVb9Kt+GiqhS6gCl6g5j5QJT8EHKiQeKhfkavi22OE5NMu9pH1MIkQOeI3zYcD+dWaeeZ0PC+UWf6V3jTR7OH
    rsQHuaZbvLRkax9Ds2gUSlm7kxcNMui7uYeP36lcRBbyj5iMFPSXvSsLN+FrJ4qObuiL/NpTPWCyS6YfNYxgSOtO/mSzAJn6XqBfPIMYxCqcm71N4ZM/iw0Q
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
    a=meVymXHHAAAA:8 a=ag1SF4gXAAAA:8 a=BQV-mDjgt7FdTzdlJ3EA:9
    a=XwGrd_6rT4727E-e:21 a=wWYx5_dX2Ockn3iS:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=2JgSa4NbpEOStq-L5dxp:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeC0Q3g (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:29:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41392 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbeC0Q3e (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.4 28/43] tracing: probeevent: Fix to support minus offset from symbol
Date: Tue, 27 Mar 2018 18:27:32 +0200
Message-Id: <20180327162718.002283527@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit c5d343b6b7badd1f5fe0873eff2e8d63a193e732 upstream.

In Documentation/trace/kprobetrace.txt, it says

 @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)

However, the parser doesn't parse minus offset correctly, since
commit 2fba0c8867af ("tracing/kprobes: Fix probe offset to be
unsigned") drops minus ("-") offset support for kprobe probe
address usage.

This fixes the traceprobe_split_symbol_offset() to parse minus
offset again with checking the offset range, and add a minus
offset check in kprobe probe address usage.

Link: http://lkml.kernel.org/r/152129028983.31874.13419301530285775521.stgit@devbox

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 2fba0c8867af ("tracing/kprobes: Fix probe offset to be unsigned")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_kprobe.c |    4 ++--
 kernel/trace/trace_probe.c  |    8 +++-----
 kernel/trace/trace_probe.h  |    2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -599,7 +599,7 @@ static int create_trace_kprobe(int argc,
 	bool is_return = false, is_delete = false;
 	char *symbol = NULL, *event = NULL, *group = NULL;
 	char *arg;
-	unsigned long offset = 0;
+	long offset = 0;
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
 
@@ -667,7 +667,7 @@ static int create_trace_kprobe(int argc,
 		symbol = argv[1];
 		/* TODO: support .init module functions */
 		ret = traceprobe_split_symbol_offset(symbol, &offset);
-		if (ret) {
+		if (ret || offset < 0 || offset > UINT_MAX) {
 			pr_info("Failed to parse either an address or a symbol.\n");
 			return ret;
 		}
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -293,7 +293,7 @@ static fetch_func_t get_fetch_size_funct
 }
 
 /* Split symbol and offset. */
-int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
+int traceprobe_split_symbol_offset(char *symbol, long *offset)
 {
 	char *tmp;
 	int ret;
@@ -301,13 +301,11 @@ int traceprobe_split_symbol_offset(char
 	if (!offset)
 		return -EINVAL;
 
-	tmp = strchr(symbol, '+');
+	tmp = strpbrk(symbol, "+-");
 	if (tmp) {
-		/* skip sign because kstrtoul doesn't accept '+' */
-		ret = kstrtoul(tmp + 1, 0, offset);
+		ret = kstrtol(tmp, 0, offset);
 		if (ret)
 			return ret;
-
 		*tmp = '\0';
 	} else
 		*offset = 0;
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -335,7 +335,7 @@ extern int traceprobe_conflict_field_nam
 extern void traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
-extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
+extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 
 extern ssize_t traceprobe_probes_write(struct file *file,
 		const char __user *buffer, size_t count, loff_t *ppos,
