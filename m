Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414041-2-16453792339287520051
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414040; b=w0vjlxGjPpDpF84RPatkUFkScafmm0CN4sqRuOY8EoSJVv/
    a5EsZ3fAaoPZ0UpKEAw4YRZcf5MDjlJaOZqWl3UMxMPh8b2OuaE8oAZrXC5CT0sS
    yvpIpGszbLaj7bKH7y5DZ+M6H2ajV9usX9lhJM+UavP80f8tb357pVNYDCDnd/lg
    E2lN3tOlRM48HB8XEOS7ZqILTblP6ubMwNPHxD9Rl+nZxAFPldNYBGvpvydQlJSX
    9BcBs775hCJyjTPCizBt/4WfAQUs4kSBw7i4KtpaEuGquknJBWOqATOMD5qMVqEw
    diGtCVmi9s8M7/JimVKb5jW2EZ9oNU7kuyj39Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414040; bh=oOUQdi4O2v5EfnNvNkiKcqI2qd
    f/fGJtqoE/aBjE0WE=; b=QSZWColvc4ihjKPC10JeTLJE4Sc54+lTcPrU+9/UG6
    dWbVxQEJZEj5jsJPXsqrr3jSGb8FU7X+56FyX1YUorkTIHCduXYw7DkjWbV+ESh9
    WCq26p7t7FbVSLqJZ3jY0wKqqITRaPvTBhD5jiO0nG05xOtv8a1y7vcd6Rl5xVLT
    81Yd3llPj4vMbHFxQC8j96fnMQ6900lLZnVQACQBRcbSGHTqVyuxeZV+XsYPDUao
    wTf+wrwKzedRWLlzrWX6WbN+Jk76KP3XuqPMo0jrSGQGsjCBUUs4BBOMPuDNLcZ0
    6KulVW/uwNrL1x7wCbMBLD2KqcjRedIlEZLrJZGuIQrg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935134AbeBWSw3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935132AbeBWSw0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Donald Stence <dstence@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 070/159] perf annotate: Do not truncate instruction names at 6 chars
Date: Fri, 23 Feb 2018 19:26:18 +0100
Message-Id: <20180223170752.113033421@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>


[ Upstream commit 05d0e62d9fa0f1002cf82009ef31b36174da5472 ]

There are many instructions, esp on PowerPC, whose mnemonics are longer
than 6 characters. Using precision limit causes truncation of such
mnemonics.

Fix this by removing precision limit. Note that, 'width' is still 6, so
alignment won't get affected for length <= 6.

Before:

   li     r11,-1
   xscvdp vs1,vs1
   add.   r10,r10,r11

After:

  li     r11,-1
  xscvdpsxds vs1,vs1
  add.   r10,r10,r11

Reported-by: Donald Stence <dstence@us.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/20171114032540.4564-1-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/annotate.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -166,7 +166,7 @@ static void ins__delete(struct ins_opera
 static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
 			      struct ins_operands *ops)
 {
-	return scnprintf(bf, size, "%-6.6s %s", ins->name, ops->raw);
+	return scnprintf(bf, size, "%-6s %s", ins->name, ops->raw);
 }
 
 int ins__scnprintf(struct ins *ins, char *bf, size_t size,
@@ -231,12 +231,12 @@ static int call__scnprintf(struct ins *i
 			   struct ins_operands *ops)
 {
 	if (ops->target.name)
-		return scnprintf(bf, size, "%-6.6s %s", ins->name, ops->target.name);
+		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.name);
 
 	if (ops->target.addr == 0)
 		return ins__raw_scnprintf(ins, bf, size, ops);
 
-	return scnprintf(bf, size, "%-6.6s *%" PRIx64, ins->name, ops->target.addr);
+	return scnprintf(bf, size, "%-6s *%" PRIx64, ins->name, ops->target.addr);
 }
 
 static struct ins_ops call_ops = {
@@ -300,7 +300,7 @@ static int jump__scnprintf(struct ins *i
 			c++;
 	}
 
-	return scnprintf(bf, size, "%-6.6s %.*s%" PRIx64,
+	return scnprintf(bf, size, "%-6s %.*s%" PRIx64,
 			 ins->name, c ? c - ops->raw : 0, ops->raw,
 			 ops->target.offset);
 }
@@ -373,7 +373,7 @@ static int lock__scnprintf(struct ins *i
 	if (ops->locked.ins.ops == NULL)
 		return ins__raw_scnprintf(ins, bf, size, ops);
 
-	printed = scnprintf(bf, size, "%-6.6s ", ins->name);
+	printed = scnprintf(bf, size, "%-6s ", ins->name);
 	return printed + ins__scnprintf(&ops->locked.ins, bf + printed,
 					size - printed, ops->locked.ops);
 }
@@ -449,7 +449,7 @@ out_free_source:
 static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
-	return scnprintf(bf, size, "%-6.6s %s,%s", ins->name,
+	return scnprintf(bf, size, "%-6s %s,%s", ins->name,
 			 ops->source.name ?: ops->source.raw,
 			 ops->target.name ?: ops->target.raw);
 }
@@ -489,7 +489,7 @@ static int dec__parse(struct arch *arch
 static int dec__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
-	return scnprintf(bf, size, "%-6.6s %s", ins->name,
+	return scnprintf(bf, size, "%-6s %s", ins->name,
 			 ops->target.name ?: ops->target.raw);
 }
 
@@ -501,7 +501,7 @@ static struct ins_ops dec_ops = {
 static int nop__scnprintf(struct ins *ins __maybe_unused, char *bf, size_t size,
 			  struct ins_operands *ops __maybe_unused)
 {
-	return scnprintf(bf, size, "%-6.6s", "nop");
+	return scnprintf(bf, size, "%-6s", "nop");
 }
 
 static struct ins_ops nop_ops = {
@@ -925,7 +925,7 @@ void disasm_line__free(struct disasm_lin
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw)
 {
 	if (raw || !dl->ins.ops)
-		return scnprintf(bf, size, "%-6.6s %s", dl->ins.name, dl->ops.raw);
+		return scnprintf(bf, size, "%-6s %s", dl->ins.name, dl->ops.raw);
 
 	return ins__scnprintf(&dl->ins, bf, size, &dl->ops);
 }
