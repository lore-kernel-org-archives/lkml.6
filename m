Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeBHP7F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHP7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:59:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BC2204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 10:59:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 11/20 v2] tracing: Add symbol type to function based
 events
Message-ID: <20180208105900.71a8ee8c@gandalf.local.home>
In-Reply-To: <20180208112031.GB30958@krava>
References: <20180207202402.253089656@goodmis.org>
        <20180207202816.348135328@goodmis.org>
        <20180208112031.GB30958@krava>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 12:20:31 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> > +Symbols (function names)
> > +========================
> > +
> > +To display kallsyms "%pS" type of output, use the special type "symbol".
> > +
> > +Again, using gdb to find the offset of the "func" field of struct work_struct
> > +
> > +(gdb) printf "%d\n", &((struct work_struct *)0)->func
> > +24  
> 
> you could also use Arnaldo's pahole for this, seems like less typing:
> 
>   $ pahole ./vmlinux -C work_struct
>   die__process_function: tag not supported (INVALID)!
>   struct work_struct {
>           atomic_long_t              data;                 /*     0     8 */
>           struct list_head           entry;                /*     8    16 */
>           work_func_t                func;                 /*    24     8 */
> 
> it's in 'dwarves' package

Nice, I'll have to document that:

 $ pahole ./vmlinux -C net_device |grep perm
        unsigned char              perm_addr[32];        /*   558    32 */


-- Steve
