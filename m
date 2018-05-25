Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030340AbeEYVN6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030239AbeEYVN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:13:57 -0400
Date: Fri, 25 May 2018 17:13:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20180525171353.53b44f5e@gandalf.local.home>
In-Reply-To: <20180525171229.76bae7a8@gandalf.local.home>
References: <20180516150012.135869655@goodmis.org>
        <20180516150201.246539183@goodmis.org>
        <20180523231331.bf69453f05478e11b00451ab@kernel.org>
        <20180525140731.07d7543a@gandalf.local.home>
        <20180525171229.76bae7a8@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 17:12:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

 
> #!/bin/sh

Hmm, I think I need to make this #!/bin/bash

> test_trace() {
>     file=$1
>     x=$2
> 
>     cat $file | while read line; do
> 	if [ "$line" != "${line/\#/}" ]; then
> 	    continue
> 	fi
> 	echo "testing $line for >$x<"
> 	if [ "$line" == "${line/>$x</}" ]; then

The ${line/>$x</} is unique to bash I believe.

-- Steve

> 	    fail "$line does not have >$x< in it"
> 	fi
> 	let x=$x+2
>     done
> }
> 
