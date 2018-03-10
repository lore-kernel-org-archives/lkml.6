Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933034AbeCJNz0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 08:55:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932863AbeCJNzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 08:55:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368B32133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 10 Mar 2018 22:55:19 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Yang Bo <yangbo@deepin.com>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RFC PATCH -tip 0/9] kprobes: Cleanup jprobe implementation
Message-Id: <20180310225519.11461d77742247c927268dfe@kernel.org>
In-Reply-To: <20180309185402.301a97ae@gandalf.local.home>
References: <152059891712.4214.9539716544254881611.stgit@devbox>
        <20180309185402.301a97ae@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018 18:54:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri,  9 Mar 2018 21:35:17 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hello,
> > 
> > Since we decided to remove jprobe from kernel last year,
> > its APIs are disabled and we worked on moving in-kernel
> > jprobe users to kprobes or trace-events. And now no jprobe
> > users are here anymore.
> > 
> > I think it is good time to get rid of jprobe implementation
> > from the kernel. However, I need other arch developers help
> > to complete it, since jprobe is implemented multi arch wide.
> > I can remove those code, but can not test all of those.
> > 
> > Here is the series of patches to show how to do that.
> > I tried to remove it from x86 tree. Basically we need to
> > do 3 things;
> > 
> >  - Remove jprobe functions (register/unregister,
> >    setjump/longjump) from generic/arch-dependent code.
> >    [1/9][2/9][3/9]
> >  - Remove break_handler related code.
> >    [4/9][5/9][6/9]
> >  - Do not disable preemption on exception handler
> >    [7/9][8/9][9/9]
> > 
> > The [3/9] and [6/9] are destractive changes except for x86
> > (means causes build errors) since those arch still have some
> > references of those functions. So we need to write patches
> > similar to [2/9] and [5/9] for each arch before applying those.
> > In this series I sorted it as this order just for review,
> > [3/9] and [6/9] should be applied after all archs have
> > been fixed.
> > 
> > Also, [7/9] is a kind of destractive, which changes required
> > behavior for the pre_handlers which changes regs->ip.
> > So we also need a patch similar to [7/9] for each arch too.
> > Fortunately, current in-tree such user is very limited, both
> > works only on x86. So it is not hurry, but we need to change
> > arch dependent code.
> >
> 
> Hi Masami,
> 
> thanks for doing all this. I do want to review this and your other
> patch set.

Thanks!

> I've just been traveling a lot. I came home from California
> yesterday and will be leaving Sunday to Portland for ELC. Will you be
> there?

Oh, no, sorry I'll not be there. Anyway, I will wait for your review. :)

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
