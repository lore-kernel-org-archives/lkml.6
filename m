Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbeFBJcF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 05:32:05 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:63568 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbeFBJcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 05:32:04 -0400
Date: Sat, 2 Jun 2018 11:31:58 +0200
From: Christian Brauner <christian@brauner.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 16/17] signal: make security_task_kill() return bool
Message-ID: <20180602093158.GA6095@mailbox.org>
References: <20180601132239.4421-1-christian@brauner.io>
 <20180601132239.4421-17-christian@brauner.io>
 <20180601162625.GE1058@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162625.GE1058@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:26:25PM +0200, Oleg Nesterov wrote:
> On 06/01, Christian Brauner wrote:
> >
> > security_task_kill() already behaves like a boolean function. Let's
> > actually declare it as such too.
> 
> The subject/changelog is wrong, this patch changes sigkill_pending()

Ah yes, s/security_task_kill()/sigkill_pending()

Thanks!
Christian

> 
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > ---
> > v1->v2:
> > * unchanged
> > v0->v1:
> > * patch added
> > ---
> >  kernel/signal.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 515fa59a0e9c..d5f9472a0935 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1922,10 +1922,10 @@ static inline bool may_ptrace_stop(void)
> >   * Return non-zero if there is a SIGKILL that should be waking us up.
> >   * Called with the siglock held.
> >   */
> > -static int sigkill_pending(struct task_struct *tsk)
> > +static bool sigkill_pending(struct task_struct *tsk)
> >  {
> > -	return	sigismember(&tsk->pending.signal, SIGKILL) ||
> > -		sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
> > +	return sigismember(&tsk->pending.signal, SIGKILL) ||
> > +	       sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
> >  }
> >  
> >  /*
> > -- 
> > 2.17.0
> > 
> 
