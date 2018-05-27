Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032912AbeE0QdH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 12:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032736AbeE0QdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 12:33:03 -0400
Date: Mon, 28 May 2018 01:32:58 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org, Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH v3 13/14] tracing/selftest: Add selftests to test
 trace_marker histogram triggers
Message-Id: <20180528013258.59715b8111d3e59319006cd2@kernel.org>
In-Reply-To: <20180525171353.53b44f5e@gandalf.local.home>
References: <20180516150012.135869655@goodmis.org>
        <20180516150201.246539183@goodmis.org>
        <20180523231331.bf69453f05478e11b00451ab@kernel.org>
        <20180525140731.07d7543a@gandalf.local.home>
        <20180525171229.76bae7a8@gandalf.local.home>
        <20180525171353.53b44f5e@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, 25 May 2018 17:13:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 25 May 2018 17:12:29 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>  
> > #!/bin/sh
> 
> Hmm, I think I need to make this #!/bin/bash
> 
> > test_trace() {
> >     file=$1
> >     x=$2
> > 
> >     cat $file | while read line; do
> > 	if [ "$line" != "${line/\#/}" ]; then
> > 	    continue
> > 	fi
> > 	echo "testing $line for >$x<"
> > 	if [ "$line" == "${line/>$x</}" ]; then
> 
> The ${line/>$x</} is unique to bash I believe.

Hmm, could you try to use only posix-shell based test ?
Since I would like to keep this can run on small 
environment, like busybox, etc.

Thank you,

> 
> -- Steve
> 
> > 	    fail "$line does not have >$x< in it"
> > 	fi
> > 	let x=$x+2
> >     done
> > }
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
