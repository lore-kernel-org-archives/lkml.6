Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeDXPIX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:08:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750916AbeDXPIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:08:22 -0400
Date: Tue, 24 Apr 2018 17:08:20 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/x86: Fix arch_syscall_match_sym_name for x86_64
Message-ID: <20180424150820.GA3396@krava>
References: <20180424101738.30015-1-jolsa@kernel.org>
 <20180424103358.3e8efe6e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424103358.3e8efe6e@gandalf.local.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 10:33:58AM -0400, Steven Rostedt wrote:
> On Tue, 24 Apr 2018 12:17:38 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Recent commit changed the name prefix of syscalls
> > for x86_64 (check the 'Fixes:' for commit number).
> > 
> > The names switch from "sys_" prefix to ""__x64_sys_",
> > which made the default matching function always fail.
> > 
> > Consequently the ftrace syscall __init code could not
> > match any syscall metadata so the "syscall" events
> > vanished. This fix returns them back.
> > 
> 
> Hi Jiri,
> 
> I already fixed it and it's queued it my tree. I'm waiting for some
> other patches that are waiting for review so I can start testing and
> push to Linus.
> 
> Also, this was half the fix, the total fix is here:

yep, that's why I enclosed it to CONFIG_X86_64 ;-)

> 
>   http://lkml.kernel.org/r/20180418114509.5a76847d@gandalf.local.home

after long time I needed 'syscalls' events and couldn't believe my eyes ;-)

> 
> I think I'm done waiting, I'll start testing and get my queue out. If
> the other patches don't get the proper acks, I'm not taking them.

cool, I'll stick with my change for now and rebase when it's in

thanks,
jirka
