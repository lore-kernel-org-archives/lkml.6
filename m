Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeDURLO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 13:11:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42792 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbeDURLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 13:11:12 -0400
X-Google-Smtp-Source: AIpwx4/DoH4gMhRHEBd3xkNF1ZQlFMt5jvAVjgVn9RHddNEm+sNsxbI4O6Wfv9kXO0hEvV1rn4D8fQ==
Date: Sat, 21 Apr 2018 10:12:25 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot
        <syzbot+c9695f0404c72c8f0b7abbac660d986af9008fc5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in perf_trace_destroy (2)
Message-ID: <20180421171225.GA1098@sol.localdomain>
References: <001a114aa95c553065055d6307e2@google.com>
 <001a1141f35af49ace056363ab69@google.com>
 <20180122172013.01841063@gandalf.local.home>
 <20180122231934.GH2228@hirez.programming.kicks-ass.net>
 <CACT4Y+bJ7U_ehBFEVWpvo6rwnT8-oto3c4b=VSyZyv92Y0E=tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bJ7U_ehBFEVWpvo6rwnT8-oto3c4b=VSyZyv92Y0E=tw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2018 at 08:37:49AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Tue, Jan 23, 2018 at 12:19 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Jan 22, 2018 at 05:20:13PM -0500, Steven Rostedt wrote:
> >>
> >> Peter,
> >>
> >> Isn't this the same as what you mentioned (and had a hack patch for)
> >> before?
> >>
> >>  http://lkml.kernel.org/r/20180109133651.GB2369@hirez.programming.kicks-ass.net
> >>
> >
> > Looks like it. Just haven't managed to get those patches merged. I'll
> > try and get that sorted tomorrow. Thanks for the reminder.
> 

No longer occurring, fix was commit 82d94856fa22:

#syz fix: perf/core: Fix lock inversion between perf,trace,cpuhp

- Eric
