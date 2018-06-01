Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeFAQ0c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:26:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751422AbeFAQ02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:26:28 -0400
Date: Fri, 1 Jun 2018 18:26:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 16/17] signal: make security_task_kill() return bool
Message-ID: <20180601162625.GE1058@redhat.com>
References: <20180601132239.4421-1-christian@brauner.io>
 <20180601132239.4421-17-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601132239.4421-17-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Christian Brauner wrote:
>
> security_task_kill() already behaves like a boolean function. Let's
> actually declare it as such too.

The subject/changelog is wrong, this patch changes sigkill_pending()

> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> v1->v2:
> * unchanged
> v0->v1:
> * patch added
> ---
>  kernel/signal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 515fa59a0e9c..d5f9472a0935 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1922,10 +1922,10 @@ static inline bool may_ptrace_stop(void)
>   * Return non-zero if there is a SIGKILL that should be waking us up.
>   * Called with the siglock held.
>   */
> -static int sigkill_pending(struct task_struct *tsk)
> +static bool sigkill_pending(struct task_struct *tsk)
>  {
> -	return	sigismember(&tsk->pending.signal, SIGKILL) ||
> -		sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
> +	return sigismember(&tsk->pending.signal, SIGKILL) ||
> +	       sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
>  }
>  
>  /*
> -- 
> 2.17.0
> 
