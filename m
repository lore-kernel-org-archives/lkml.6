Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3970764-1526044377-2-4573859304143760806
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526044376; b=SEouJUUQ9Y1CLFwt88EEE8dREq8XhEBBGTcxQCzrtEpd3StBto
    X7E47PZNskePsCluO0yzmLNgB5TTLgk45peZ7yMCnTELbq2lxLJVEj5AEO0jqMOk
    sxYj4ZOYzjIdMMz1FojGc+JHuVm5WJNXnNxUmRReWxmoLNdDh2Ww1SNKV2moF6YW
    Us0/xf31Dw9KknehZTgsUBuIUalokd9CvFxzfR+0TIE77rt1g1Uw0HTvX2RDMiOa
    jxaOoq44RbvNwoY6arjX+J3CDWyXEcco28aMEmhqxOtNFBawTArthHje/RMBXCbc
    7hYj6bt+gqEzYuT3ZoIAgA9NC60+bj+cWTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526044376;
    bh=8JDlwNYWcPH8qeEVxvOWN/RKDhlMW/p8bYlYCXzQwss=; b=LY7cekJ026I/
    J5aaczHK6TDtauIZryflgRQcDojRC+WFGFlh+J4Lx6kg/VHTRWhJhBLYovbPPXGv
    8hN/Ncvg1e/IjtFIHMT9LFZCSXBBzhw0SunO9thX9A7CDVtBamdiHi0YVKzltgLt
    asLlCy6tFqtYTWsiWTILqv363El5ldb4kwmkuQxUFY5QiMZVPfsZHNH3yKNYOZ4s
    +jSnM8RCQ13UyHmYIn9x0Zz3Pd6MSWrheXXJC3bs7q3DBSlkkjYz4mVwMi7+aJLR
    8oszCQQfgkaCLlFfmZ2T8HIXOs3zJUt9EmOQSAgFF9nSNaL9O0vTVnKO3jZC9HMl
    +hTNCHraGQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFR22Jafann5BF1/ZJFpAmocj8Uvi+ABgk9KF4Rofp2qE3oxOm4MyQ+ILOP9N1q+5YLm+eUaphAItaCgrriwuem3VJSF1AL5MnBv/oLhPnxNeIa0JVuI
    BU0aOsoTIftzSQWmv7aC30am8Ct54KxHbR6abr0FHQPB0R6Iiqt10DND2YdVgMzNMa3Aj9lQniXNyvNkTbJWzT60GSPW/WkQDyDcDttW6WzYYxH6WrCSwxsv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=meVymXHHAAAA:8 a=yJb95oN3TFZ3iZilJaAA:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeEKNM2 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 11 May 2018 09:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753030AbeEKNM1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 09:12:27 -0400
Date: Fri, 11 May 2018 09:12:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Juergen Gross <jgross@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jingjie Jiang <jingjie.jiang@oracle.com>,
        Mukesh Rathor <mukesh.rathor@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] tracing/x86/xen: Remove zero data size trace events
 trace_xen_mmu_flush_tlb{_all}
Message-ID: <20180511091224.51ee352f@gandalf.local.home>
In-Reply-To: <54c0a807-87e3-866f-aaa8-de383d567d50@suse.com>
References: <20180509144605.5a220327@gandalf.local.home>
        <54c0a807-87e3-866f-aaa8-de383d567d50@suse.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 11 May 2018 06:14:07 +0200
Juergen Gross <jgross@suse.com> wrote:

> Any reason not sending this patch to the Xen maintainers?

Nope, I guess I should have run the patch through "get_maintainer.pl".

> 
> I can take it through the Xen tree. :-)

Thanks!


> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Note, I'm going to be adding the below patch for 4.18 (or 5.0) which
will cause the build to break in case there's any more instances of
this.

-- Steve

>From 8f8125877582345dd68f865f76442dda9204c0c1 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Thu, 10 May 2018 12:40:21 -0400
Subject: [PATCH] tracing: Prevent further users of zero size static arrays in
 trace events

A zero size static array has special meaning in the ftrace infrastructure.
Trace events are for recording data in the trace buffers that is normally
difficult to obtain via probes or function tracing. There is no reason for
any trace event to declare a zero size static array.

If one does, BUILD_BUG_ON() will trigger and prevent the kernel from
compiling.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index bfda803b0a09..4ecdfe2e3580 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -422,6 +422,7 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 	do {								\
 		char *type_str = #type"["__stringify(len)"]";		\
 		BUILD_BUG_ON(len > MAX_FILTER_STR_VAL);			\
+		BUILD_BUG_ON(len <= 0);					\
 		ret = trace_define_field(event_call, type_str, #item,	\
 				 offsetof(typeof(field), item),		\
 				 sizeof(field.item),			\
-- 
2.13.6
