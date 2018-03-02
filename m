Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELt3f/LLKq6KXXgJzHOmRlg3Qo0NAwEdy8LOEeOSbar+yPzpyspgT/5AGNApzFQiUDe3GXCs
ARC-Seal: i=1; a=rsa-sha256; t=1519968683; cv=none;
        d=google.com; s=arc-20160816;
        b=ebmJu+NYHfQaZe/601yWqDqRcUeMjFr1945lIV4lumrgFyniL47XoN4lBaOfs65AGT
         d1Yrpw+7U2Lgqj35rQ9wz4Qd4VUyTS/+k4IXnXF7SNSPpK5TLTF4D2Z8pMTEdHKAupYQ
         i3oNfNrkdJLSCNaM7x5nuTOt83a+HoB2XFrmF7TjpTWKXoaqfDpoYtamDubs+n/+D0pS
         ZuyVdn+q3MoaqgWo6ghFplA/ocB1UJBsM7eeUtn3SmsVKVsghJB0Hrl6QbKdTsVD31s0
         6rfeM9Ab+S8x+YUcC87VaSvQcgB9suC2GfOMyESMCw9EMAHf8SqbFe8cM9fuD0Si7O/4
         WzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=cN3rK2En1pxf0USA19Q67I7955mGeyigu9xCO2uKEq4=;
        b=E943g955BMAdJePFyqbGsDIO6dFrPW4bzk/dAHpr/cldneM5aIpx7dLfVAPuwYhlkY
         KMBkj74M5ek3lIkdbxuw/HnIQVG1KW+Yox2dJ16lhMSRTQWFf+AYi7q5wHeOGiaf66uP
         b7XVgqq3HRtg50+hgmPDN7Tp59sf5iglACkuUaIzFvvo4rTfwOS9Bt1wpjwmBCa9jQEy
         vFDEM2hKhvOVVkXTIgifQ9yRDrQz0vYg88xiKQU1fAf5iyofeIS4j31UJV8gKvE1H8pV
         L5++Er5AGqgp3fzYIXCxKQ1P90fbF20hxCmQbopSMJmM74t+YFTKeS6i0vzEpPmc2PzQ
         lQ2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeCBFbW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 2 Mar 2018 00:31:22 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:33036 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933244AbeCBFbV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Mar 2018 00:31:21 -0500
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Fri, 2 Mar 2018 14:31:17 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v4 18/19] selftests: ftrace: Add a testcase for $argN
 with kprobe_event
Message-ID: <20180302053117.GB31540@sejong>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
 <151978849122.2577.13948527724464684401.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <151978849122.2577.13948527724464684401.stgit@devbox>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613778351976623?=
X-GMAIL-MSGID: =?utf-8?q?1593802682207842094?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 12:28:11PM +0900, Masami Hiramatsu wrote:
> Add a testcase for array type with kprobe event.
> This tests whether the traced data is correct or not.
> If the kernel doesn't support array type, it skips
> the test as UNSUPPORTED.

This description is wrong - it's for positional (argN) arguments.

Thanks,
Namhyung


> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/kprobe/kprobe_args_argN.tc       |   25 ++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
> new file mode 100644
> index 000000000000..d5c5c8c3a51e
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Kprobe event argN argument
> +
> +[ -f kprobe_events ] || exit_unsupported # this is configurable
> +
> +grep -q "arg<N>" README || exit_unsupported # version issue
> +
> +echo 0 > events/enable
> +echo > kprobe_events
> +
> +: "Test bad pattern : arg0 is not allowed"
> +! echo 'p:testprobe create_trace_kprobe $arg0' > kprobe_events
> +
> +: "Test get argument"
> +echo 'p:testprobe create_trace_kprobe $arg1' > kprobe_events
> +echo 1 > events/kprobes/testprobe/enable
> +! echo test >> kprobe_events
> +tail -n 1 trace | grep -qe "testprobe.* arg1=0x1"
> +
> +! echo test test test >> kprobe_events
> +tail -n 1 trace | grep -qe "testprobe.* arg1=0x3"
> +
> +echo 0 > events/enable
> +echo > kprobe_events
> 
