Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeERNmX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752141AbeERNmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:42:22 -0400
Date: Fri, 18 May 2018 22:42:18 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip v3 5/7] x86: kprobes: Ignore break_handler
Message-Id: <20180518224218.2050525a24682a8d32a0b135@kernel.org>
In-Reply-To: <20180518062638.GD27960@gmail.com>
References: <152651499561.25583.14488389770693278906.stgit@devbox>
        <152651514451.25583.15475048007255467863.stgit@devbox>
        <20180518062638.GD27960@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 08:26:38 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Remove break_handler related code since that was used
> > only for jprobe and jprobe is removed now.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/x86/kernel/kprobes/common.h |   10 ----------
> >  arch/x86/kernel/kprobes/core.c   |   13 ++-----------
> >  arch/x86/kernel/kprobes/ftrace.c |   16 ++--------------
> >  3 files changed, 4 insertions(+), 35 deletions(-)
> 
> Even after this change there's a stale reference to ->break_handler():
> 
>   arch/x86/include/asm/kprobes.h:  * a post_handler or break_handler).
> 
> Please use 'git grep'!

Oops, I missed it. Thank you, I'll use git-grep next time.

> 
> Also, there's no reason to send an incomplete series: please remove _all_ 
> ->break_handler() references so that it's 100% gone! The pain of having and not 
> having ->break_handler() is completely unnecessary.

Would you mean a single patch for all arch?
I'm currently has arch-separated patches for removing it. Should I fold those?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
