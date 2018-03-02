Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtVbh7tm8ljpMIHMFwbluzxcwMsqoaNFkBGMy1kekG/ahBwKReQBXFNPWeoXHR/U1ChOjuP
ARC-Seal: i=1; a=rsa-sha256; t=1519971642; cv=none;
        d=google.com; s=arc-20160816;
        b=xMTLjsGk3oDX/41KwBrNdjarS3AlpDv3CPc+3+0Sp0vJElWDfk3ikhmHkYuZSIReC5
         y9UW5SfJYBaaojnR07TP1BdH7wKSeLsFS5ZeB4jcS7I8dwgyLJNXzvboLF0cTVOed4f0
         sLu54ICMZe6myFoEet2wgU71NedPKeiw0ODy4/wQ+pRGB2eIDCv7n9r39LHPrsNeWN8D
         wpGKGgtdH3GvyoiQN+CdecPbQq5xU7R//I+AIhfR3wJt1gtq8okCq4tgAe//veG9Onxy
         goEPnX5smRti4JIif7yvOvMB6S5vaQaW4U2IzIDGSa0nQ8tEdlhm5A6JpCxmvFswIRLU
         FWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=lNgRVlL2jWIhJRiTzfd6R0fvwWV9ekSj0YN0VOXzEKc=;
        b=giw/MFFCWRUruM/7WXZ7Lky/LL3PsLKWPM5Su+BOPihffHj24f/Hfyy7yGYUU83HlR
         ksKe8lt3g0fLVKYZnKW0LcV3ECwBjf1q/zhRnYvyB3i9GrrRIfAzHQdp7gid8WIGVGT2
         pjAidmHOB4ZUEHuYwLgLplVUe/3ZpR1k/nj1NxmYyCxiPTH4t7hIL5MxxQVBotnaVLyB
         y9gG9xkfLmNDXAKLQPBL5KMUNxeQ0AI0uaqw5SVZxuDe51vpmACPAs6Yk7ik3NnuoVSU
         9dpOzhlr7tVO01aJDegZlPce3W1xtvpu0GVxnObp7ttaY/j1my5GV6oGD4IOFlKGVZ6K
         YUjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935996AbeCBGUZ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 2 Mar 2018 01:20:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932309AbeCBGUY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Mar 2018 01:20:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9DC21737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 2 Mar 2018 15:20:06 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v4 18/19] selftests: ftrace: Add a testcase for $argN
 with kprobe_event
Message-Id: <20180302152006.22a9644429ffaa09ee02c088@kernel.org>
In-Reply-To: <20180302053117.GB31540@sejong>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
        <151978849122.2577.13948527724464684401.stgit@devbox>
        <20180302053117.GB31540@sejong>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613778351976623?=
X-GMAIL-MSGID: =?utf-8?q?1593805785342166853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Mar 2018 14:31:17 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> On Wed, Feb 28, 2018 at 12:28:11PM +0900, Masami Hiramatsu wrote:
> > Add a testcase for array type with kprobe event.
> > This tests whether the traced data is correct or not.
> > If the kernel doesn't support array type, it skips
> > the test as UNSUPPORTED.
> 
> This description is wrong - it's for positional (argN) arguments.

Oops, why I missed this to update it...

----
Add a testcase for $argN with kprobe event.
This tests whether the traced data is correct or not.
If the kernel and arch doesn't support $argN, it skips
the test as UNSUPPORTED.
----

Thanks Namhyung!

> 
> Thanks,
> Namhyung
> 
> 
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  .../ftrace/test.d/kprobe/kprobe_args_argN.tc       |   25 ++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
> > new file mode 100644
> > index 000000000000..d5c5c8c3a51e
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
> > @@ -0,0 +1,25 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: Kprobe event argN argument
> > +
> > +[ -f kprobe_events ] || exit_unsupported # this is configurable
> > +
> > +grep -q "arg<N>" README || exit_unsupported # version issue
> > +
> > +echo 0 > events/enable
> > +echo > kprobe_events
> > +
> > +: "Test bad pattern : arg0 is not allowed"
> > +! echo 'p:testprobe create_trace_kprobe $arg0' > kprobe_events
> > +
> > +: "Test get argument"
> > +echo 'p:testprobe create_trace_kprobe $arg1' > kprobe_events
> > +echo 1 > events/kprobes/testprobe/enable
> > +! echo test >> kprobe_events
> > +tail -n 1 trace | grep -qe "testprobe.* arg1=0x1"
> > +
> > +! echo test test test >> kprobe_events
> > +tail -n 1 trace | grep -qe "testprobe.* arg1=0x3"
> > +
> > +echo 0 > events/enable
> > +echo > kprobe_events
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
