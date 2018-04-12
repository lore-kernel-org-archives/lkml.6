Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-750850-1523533402-2-16492267912493247126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523533401; b=hUIkfGMmeDBM2Y4r8Q91vQMUL+U6i+iK/6PO+fNSYIMJk1pD7R
    pc3VZtbqUWXdWMzXJzg8QzrV2OeSCkb23+/NCI39/pah3rTt3ueoggqtGuGyq7sW
    uuNlHld745gSuqjc5WcZrRbuOyM0LCgd9oCjIEQc3vFg3O3Yl37li0RpeXvP9LuF
    1PAuX8euYNQ8/c02iUFiLrFB0qE0G22XPYTc160Z97qjIpoah09PQE/fnGTLdWMO
    f1hJwHP+SqZhTBsF1FAuoguj4tCArhzktCylcPWhyYzNALoexGqaY2G2j23KxQ2M
    STRzTlPtaHKGuMHba47fbU3wjf55dFj8GIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:reply-to:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type
    :sender:list-id; s=fm2; t=1523533401; bh=jtYx51JGwmHFwqSAHWIxY1L
    uW7+cVr2ptzLNZLewWi8=; b=uQSxpxfVZwLke9yXIfTQVFPKG5Dy8Fg0H6/XBFP
    uCGJt/jpMzr9Yd8V/AVEnCpwdy3/ba9vWHUqZZ1tjKnE0xpqcAZvmwUZHEcSvxBD
    wSveBntJvnJhfCutmoo2KvZnjWr583BgaAfc8sTOVw8pRmyEX6eYHodMAG+qFPY8
    6QH4AXa3ErfTxMDcsuG+brUEeICLCCpa89RAjgrkZWupr1RmQwy5UU7Vh9XMlGyx
    qKRdpunsJYeTDTXzbqOeygkwBzCSwWZlsrCHEDunlujw5ORvZTm2hx37zyMxkpQD
    ttJsD70pibd1b6SAYM1yHUscSDM5JtoB3Lqq13tldUM0fUw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nq9+DTZT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Eo/R/4w1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nq9+DTZT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Eo/R/4w1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGnOWuNd8dHRNbzjRE3fIG8XF8SkgemlQ7NVGeNpVZioqeqmXa7RJ6xH3NbquqwOc+dfDoKxmVDW02PiMf2MH/rR5Fkr2RTDGhJolZew4ACLBBXs2BB9
    PGtCoTIrM9tvFLa+mzz0yaCgNXbKmdxO15MgTlDW178UCtibScFG45Po17aVbSZIlsMB+rzjueqXTGmw5nFEB1kVFfP7EPftr2Xn5iVkbKxm1mkF/GobNkDu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=HxJQQrNo-dsA:10 a=IkcTkHD0fZMA:10
    a=x7bEGLp0ZPQA:10 a=ZvkwkgPurpcA:10 a=Kd1tUaAdevIA:10 a=7d_E57ReAAAA:8
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
    a=GcyzOjIWAAAA:8 a=egJPCYv6-C9Zjjimd-MA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=jhqOcbufqs7Y1TYCrUUU:22 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
    a=hQL3dl6oAZ8NdCsdz28n:22 a=0aluAjwT0AJoM8wfvWTS:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbeDLLnS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 07:43:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38674 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeDLLnR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 07:43:17 -0400
X-Google-Smtp-Source: AIpwx4/LmewfVXTR7qwUVT5iUCBEX8A0k7gYxNiAC3rfj+V5BRYBbKuvY+OQlcJpVhqRWVIQEgdMGcmWMwcn7NFvUUg=
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <20180212195549.11485-1-mathieu.desnoyers@efficios.com>
References: <20180212195549.11485-1-mathieu.desnoyers@efficios.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Thu, 12 Apr 2018 13:42:55 +0200
Message-ID: <CAKgNAkiGXL6Th4DGS_OD0MuwCtM6f7_nAehOVcbpU=u5L9atKA@mail.gmail.com>
Subject: Re: [PATCH manpages] membarrier.2: New membarrier commands introduced
 in 4.16
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Maged Michael <maged.michael@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Watson <davejwatson@fb.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Hackmann <ghackmann@google.com>,
        Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Mathieu,

On 12 February 2018 at 20:55, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Document the following membarrier commands introduced in 4.16:
> - MEMBARRIER_CMD_GLOBAL_EXPEDITED (the old enum label
>   MEMBARRIER_CMD_SHARED is now an alias to preserve header backward
>   compatibility),
> - MEMBARRIER_CMD_GLOBAL_EXPEDITED,
> - MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
> - MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
> - MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Michael Kerrisk <mtk.manpages@gmail.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> ---
>  man2/membarrier.2 | 73 ++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 62 insertions(+), 11 deletions(-)
>
> diff --git a/man2/membarrier.2 b/man2/membarrier.2
> index c47bc875a..e878301ca 100644
> --- a/man2/membarrier.2
> +++ b/man2/membarrier.2
> @@ -80,7 +80,7 @@ This command is always supported (on kernels where
>  .BR membarrier ()
>  is provided).
>  .TP
> -.B MEMBARRIER_CMD_SHARED
> +.B MEMBARRIER_CMD_GLOBAL " (since Linux 4.16)"
>  Ensure that all threads from all processes on the system pass through a
>  state where all memory accesses to user-space addresses match program
>  order between entry to and return from the
> @@ -88,7 +88,30 @@ order between entry to and return from the
>  system call.
>  All threads on the system are targeted by this command.
>  .TP
> -.BR MEMBARRIER_CMD_PRIVATE_EXPEDITED " (since Linux 4.14)"
> +.B MEMBARRIER_CMD_GLOBAL_EXPEDITED " (since Linux 4.16)"
> +Execute a memory barrier on all running threads of all processes which
> +previously registered with
> +.BR MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED .
> +Upon return from system call, the caller thread is ensured that all
> +running threads have passed through a state where all memory accesses to
> +user-space addresses match program order between entry to and return
> +from the system call (non-running threads are de facto in such a state).
> +This only covers threads from processes which registered with
> +.BR MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED .
> +Given that registration is about the intent to receive the barriers, it
> +is valid to invoke
> +.BR MEMBARRIER_CMD_GLOBAL_EXPEDITED
> +from a non-registered process.
> +.IP
> +The "expedited" commands complete faster than the non-expedited ones;
> +they never block, but have the downside of causing extra overhead.
> +.TP
> +.B MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED " (since Linux 4.16)"
> +Register the process intent to receive
> +.BR MEMBARRIER_CMD_GLOBAL_EXPEDITED
> +memory barriers.
> +.TP
> +.B MEMBARRIER_CMD_PRIVATE_EXPEDITED " (since Linux 4.14)"
>  Execute a memory barrier on each running thread belonging to the same
>  process as the current thread.
>  Upon return from system call, the calling
> @@ -103,9 +126,29 @@ they never block, but have the downside of causing extra overhead.
>  A process needs to register its intent to use the private
>  expedited command prior to using it.
>  .TP
> -.BR MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED " (since Linux 4.14)"
> +.B MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED " (since Linux 4.14)"
>  Register the process's intent to use
> -.BR MEMBARRIER_CMD_PRIVATE_EXPEDITED .
> +.B MEMBARRIER_CMD_PRIVATE_EXPEDITED .
> +.TP
> +.B MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE " (since Linux 4.16)"
> +In addition to provide memory ordering guarantees described in
> +.BR MEMBARRIER_CMD_PRIVATE_EXPEDITED ,
> +ensure the caller thread, upon return from system call, that all its
> +running threads siblings have executed a core serializing instruction.
> +This only covers threads from the same process as the caller thread.
> +The "expedited" commands complete faster than the non-expedited ones,
> +they never block, but have the downside of causing extra overhead. A
> +process needs to register its intent to use the private expedited sync
> +core command prior to using it.
> +.TP
> +.B MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE " (since Linux 4.16)"
> +Register the process intent to use
> +.BR MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE .
> +.TP
> +.B MEMBARRIER_CMD_SHARED
> + Alias to
> +.BR MEMBARRIER_CMD_GLOBAL .
> +Provided for header backward compatibility.
>  .PP
>  The
>  .I flags
> @@ -137,10 +180,14 @@ The pair ordering is detailed as (O: ordered, X: not ordered):
>  On success, the
>  .B MEMBARRIER_CMD_QUERY
>  operation returns a bit mask of supported commands, and the
> -.B MEMBARRIER_CMD_SHARED ,
> +.B MEMBARRIER_CMD_GLOBAL ,
> +.B MEMBARRIER_CMD_GLOBAL_EXPEDITED ,
> +.B MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED ,
>  .B MEMBARRIER_CMD_PRIVATE_EXPEDITED ,
> -and
>  .B MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED ,
> +.B MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE ,
> +and
> +.B MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE
>  operations return zero.
>  On error, \-1 is returned,
>  and
> @@ -163,10 +210,14 @@ set to 0, error handling is required only for the first call to
>  is invalid, or
>  .I flags
>  is nonzero, or the
> -.BR MEMBARRIER_CMD_SHARED
> +.BR MEMBARRIER_CMD_GLOBAL
>  command is disabled because the
>  .I nohz_full
> -CPU parameter has been set.
> +CPU parameter has been set, or the
> +.BR MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE
> +and
> +.BR MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE
> +commands are not implemented by the architecture.
>  .TP
>  .B ENOSYS
>  The
> @@ -294,9 +345,9 @@ init_membarrier(void)
>          return \-1;
>      }
>
> -    if (!(ret & MEMBARRIER_CMD_SHARED)) {
> +    if (!(ret & MEMBARRIER_CMD_GLOBAL)) {
>          fprintf(stderr,
> -            "membarrier does not support MEMBARRIER_CMD_SHARED\\n");
> +            "membarrier does not support MEMBARRIER_CMD_GLOBAL\\n");
>          return \-1;
>      }
>
> @@ -315,7 +366,7 @@ static void
>  slow_path(int *read_a)
>  {
>      b = 1;
> -    membarrier(MEMBARRIER_CMD_SHARED, 0);
> +    membarrier(MEMBARRIER_CMD_GLOBAL, 0);
>      *read_a = a;
>  }

I have applied the above patch, and done quite a bit of tweaking, and
pushed the results to the git repo.

I would be grateful if you would read the entire manual page as it
currently stands, to see if anything needs improving. I isolated some
of the more significant changes into a simple patch, shown below, and
especially I'd like your confirmation that all of those changes are
okay.

Cheers,

Michael

diff --git a/man2/membarrier.2 b/man2/membarrier.2
index b3a94f95f..81d573dd5 100644
--- a/man2/membarrier.2
+++ b/man2/membarrier.2
@@ -92,16 +92,18 @@ All threads on the system are targeted by this command.
 Execute a memory barrier on all running threads of all processes that
 previously registered with
 .BR MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED .
-Upon return from the system call, the calling thread is ensured that all
+Upon return from the system call, the calling thread has a guarantee that all
 running threads have passed through a state where all memory accesses to
 user-space addresses match program order between entry to and return
 from the system call (non-running threads are de facto in such a state).
-This covers only threads from processes which registered with
+This guarantee is provided only for the threads of processes that
+previously registered with
 .BR MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED .
 Given that registration is about the intent to receive the barriers, it
 is valid to invoke
 .BR MEMBARRIER_CMD_GLOBAL_EXPEDITED
-from a non-registered process.
+from a process that has not employed
+.BR MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED .
 .IP
 The "expedited" commands complete faster than the non-expedited ones;
 they never block, but have the downside of causing extra overhead.
@@ -113,17 +115,18 @@ memory barriers.
 .TP
 .BR MEMBARRIER_CMD_PRIVATE_EXPEDITED " (since Linux 4.14)"
 Execute a memory barrier on each running thread belonging to the same
-process as the current thread.
-Upon return from system call, the calling
-thread is assured that all its running threads siblings have passed
+process as the calling thread.
+Upon return from the system call, the calling
+thread has a guarantee that all its running thread siblings have passed
 through a state where all memory accesses to user-space addresses match
 program order between entry to and return from the system call
 (non-running threads are de facto in such a state).
-This covers only threads from the same process as the calling thread.
+This guarantee is provided only for threads in
+the same process as the calling thread.
 .IP
 The "expedited" commands complete faster than the non-expedited ones;
 they never block, but have the downside of causing extra overhead.
-A process needs to register its intent to use the private
+A process must register its intent to use the private
 expedited command prior to using it.
 .TP
 .BR MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED " (since Linux 4.14)"
@@ -133,12 +136,13 @@ Register the process's intent to use
 .BR MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE " (since Linux 4.16)"
 In addition to providing the memory ordering guarantees described in
 .BR MEMBARRIER_CMD_PRIVATE_EXPEDITED ,
-ensure the calling thread, upon return from system call, that all its
-running threads siblings have executed a core serializing instruction.
-This only covers threads from the same process as the calling thread.
+upon return from system call the calling thread has a guarantee that all its
+running thread siblings have executed a core serializing instruction.
+This guarantee is provided only for threads in
+the same process as the calling thread.
 The "expedited" commands complete faster than the non-expedited ones,
 they never block, but have the downside of causing extra overhead.
-A process needs to register its intent to use the private expedited sync
+A process must register its intent to use the private expedited sync
 core command prior to using it.
 .TP
 .BR MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE " (since Linux 4.16)"


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
