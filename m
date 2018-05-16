Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeEPHAw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752358AbeEPHAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:00:50 -0400
Date: Wed, 16 May 2018 16:00:45 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Yang Bo <yangbo@deepin.com>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip v2 0/5] kprobes: x86: Cleanup jprobe implementation
 on x86
Message-Id: <20180516160045.cfb2058f21129e94bbe1ebdc@kernel.org>
In-Reply-To: <152086565510.32679.6953754320525763743.stgit@devbox>
References: <152086565510.32679.6953754320525763743.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018 23:40:55 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> Since we decided to remove jprobe from kernel last year,
> its APIs are disabled and we worked on moving in-kernel
> jprobe users to kprobes or trace-events. And now no jprobe
> users are here anymore.
> 
> This series removes jprobe implementation from x86 and
> generic code. I would like to send other series for each
> arch. After all those patches are merged, I will remove
> jprobes APIs and data structures, since changing those
> definitions will break build on other archs.
> 
> Here is the series of patches to show how to do that.
> I've dropped arch-independent header changes from this
> version and merged kprobe-user code changes into the
> last patch since that changed the kprobes expected
> behavior when the kprobes modifies execution path.
> (no need to enable preempt anymore)
> 
>  - Remove jprobe functions (register/unregister,
>    setjump/longjump) from generic/arch-dependent code.
>    [1/5][2/5]
>  - Remove break_handler related code.
>    [3/5][4/5]
>  - Do not disable preemption on exception handler
>    [5/5]
> 
> As I said above, the last patch [5/5] will change the
> expected behavior on x86. Other archs also have to change
> it. But anyway, currently such execution-path modifying
> users in tree are very limited and only works on x86.
> So we can safely modify it.

Ah, I forgot I had sent this in March... 
Basically, this is same thing what I sent last week, and this is more
aggressively removing all the jprobes related code including
break_handler. I would like to merge both series and start sending
new series, including removing jprobe test code too.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
