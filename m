Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479114-2-15470049379036191388
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479113; b=LwYfUyqDODvnZOgKsV/By9QpoiS0p8RAX6L+JB8D4R3TNONWkd
    6tZ9Asxkij14s+Cl5/pR3lJivYjhHxra9maqQiIpYUEfoFXtsG+nc7xWI0eBPLzz
    c1fg3DxrS/x/gPcEq+IlGxvoImyog2kU5q+/IlJkxCLBLo2ADTy0k1+RWxgKCeEP
    R0qCtdVQIt3+AjnCjmrfqiQp4tYBQO7kAZ/OHeS/iCyvtE3Yb2ZaKJDBXrhn6THp
    bWH0muwsxniktXDq6Df6uOOdqTRJoNY9tk3WjgDrE4PG6Vqs2iOdwhq++6rCuQM0
    4D2t1XE7ERsKRbMlHCYnZhRLaObL0tQ2mCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479113; bh=wWh3KWwyXqz3yCRvbxwQoeIFGe/Iot
    RgrkLgBqLyyL4=; b=gkeB+gEOweLlpy0Dm88ly6jubRnzuE3sgvCL5wp501b8YD
    03i7l9levW9Lf2oUV6g/+VkE+UW1psTN38RE5lUtfuH7HPxZGpOy/MZOztRYQGeF
    z6oWnKZsh1PCKoaQy+TFY4UlQg9ZsUuMBX1CJevQTdsUIsofTx574eNot9YYIjW9
    Eanv59Iln1CerWjEu7SNm0009cinCPqFTP2zijuXd5bUT0/5vjV8hO6Eok4Es9SV
    a7MpwuCZ/9Qy0114dupwRvVBrc/OSOZOEYe1GRDRo+fz4gleZt7W7kmsVTP1gwaY
    Zx4+EieRT+G4FoYAnl8R/ozDe2hvjSDTaIYifitg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfChWsg3iYVI0LPfCZUK0ViQOzsel/LeD7Vk34Ha23f951uPZuX67+T1F5j94wvObMJiOZ9UZjl3Z/OHX8EsngJ6mB0D4fPjEnSKynxCD7MvCyLgjpbwx
    WWeLOyxCQpXlZ5Ohw5Hc2GTdFQ+XOXazJ40H+HmSnNJUvY6KSMWVhxNJ9Hb/r96iUUtGKDlAbXwhKWbl1vPAjqIZbt+uGkY527YAZ7Gvr6QHsXuy3SqUJqId
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=MrQScLItsYD3kZXr6aUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756902AbeDKUiP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:38:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbeDKSsS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 110/190] perf trace: Add mmap alias for s390
Date: Wed, 11 Apr 2018 20:35:56 +0200
Message-Id: <20180411183557.202775890@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit 54265664c15a68905d8d67d19205e9a767636434 ]

The s390 architecture maps sys_mmap (nr 90) into sys_old_mmap.  For this
reason perf trace can't find the proper syscall event to get args format
from and displays it wrongly as 'continued'.

To fix that fill the "alias" field with "old_mmap" for trace's mmap record
to get the correct translation.

Before:
     0.042 ( 0.011 ms): vest/43052 fstat(statbuf: 0x3ffff89fd90                ) = 0
     0.042 ( 0.028 ms): vest/43052  ... [continued]: mmap()) = 0x3fffd6e2000
     0.072 ( 0.025 ms): vest/43052 read(buf: 0x3fffd6e2000, count: 4096        ) = 6

After:
     0.045 ( 0.011 ms): fstat(statbuf: 0x3ffff8a0930                           ) = 0
     0.057 ( 0.018 ms): mmap(arg: 0x3ffff8a0858                                ) = 0x3fffd14a000
     0.076 ( 0.025 ms): read(buf: 0x3fffd14a000, count: 4096                   ) = 6

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170531113557.19175-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-trace.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1152,6 +1152,10 @@ static struct syscall_fmt {
 	{ .name	    = "mlockall",   .errmsg = true,
 	  .arg_scnprintf = { [0] = SCA_HEX, /* addr */ }, },
 	{ .name	    = "mmap",	    .hexret = true,
+/* The standard mmap maps to old_mmap on s390x */
+#if defined(__s390x__)
+	.alias = "old_mmap",
+#endif
 	  .arg_scnprintf = { [0] = SCA_HEX,	  /* addr */
 			     [2] = SCA_MMAP_PROT, /* prot */
 			     [3] = SCA_MMAP_FLAGS, /* flags */
