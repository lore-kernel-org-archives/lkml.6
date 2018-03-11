Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeCKTyV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:54:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932161AbeCKTyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:54:20 -0400
Date: Sun, 11 Mar 2018 20:54:16 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 0/3] tracing: Rewrite the function filter code
Message-ID: <20180311195416.GB13895@krava>
References: <20180310023442.791997138@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310023442.791997138@goodmis.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:34:42PM -0500, Steven Rostedt wrote:

SNIP

> Special thanks goes out to Al for his patience and his time that he spent in
> educating us in a proper logical parser.
> 
> Two patches were added to do some initial clean up. The last patch
> implements Al's suggestions. I wrote up a very lengthy comment describing
> what Al taught us in my own words (hopefully I got it right), and the
> implementation is similar to what Al showed with a few changes (again,
> hopefully I got that right too). I tested this with lots of different
> filters and it looks to be holding up.
> 
> 
>  Jiri,
> 
> This affects perf as well. I ran some tests and I believe I got
> it woking as it does today.

nice, it looks ok to me.. I guess the only concern is the filter for
ftrace:function event, which uses the pred parsing code just to get
the 'ip == ...' pairs and feeds it to ftrace_ops filter api

I'll check and make some tests

I think tracepoint events filters should be working without any special
care because they use the same api as ftrace filters

jirka
