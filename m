Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeEGPWC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbeEGPV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:21:58 -0400
Date: Mon, 7 May 2018 11:21:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
Message-ID: <20180507112154.5c1ea44c@gandalf.local.home>
In-Reply-To: <20180505113803.45700179a93091b114ec6984@kernel.org>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
        <20180503181137.6d82d897@gandalf.local.home>
        <20180505004828.9b75b6802472f09b0d2de5b8@kernel.org>
        <20180504120642.354cdd1f@gandalf.local.home>
        <20180505113803.45700179a93091b114ec6984@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 May 2018 11:38:03 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 4 May 2018 12:06:42 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 5 May 2018 00:48:28 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > So the syntax will be
> > > 
> > > p[:EVENT] SYM[(CAST)|+OFFS] [FETCHARG]
> > > 
> > > And here is an example;
> > > 
> > > p:myevent vfs_read(void *file, char *buf, size_t count, void *pos) $arg1 $arg2  
> > 
> > If we do this, why bother with $arg1 $arg2?  
> 
> User may want to trace only some of them. :)

Yes, and this is why I like my solution of the NULL parameter, and you
don't need to show anything after what you want.

 p:myevent vfs_read(void *file, NULL, size_t count)

would only trace file and count, and ignore buf and pos.

-- Steve
