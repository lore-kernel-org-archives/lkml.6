Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935062AbeE2Oas (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:30:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934533AbeE2Oan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:30:43 -0400
Date: Tue, 29 May 2018 16:30:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH v1 06/20] signal: drop else branch in do_signal_stop()
Message-ID: <20180529143039.GA1802@redhat.com>
References: <20180528215355.16119-1-christian@brauner.io>
 <20180528215355.16119-7-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528215355.16119-7-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am busy now, can't review, just picked a random patch from this series...

On 05/28, Christian Brauner wrote:
> do_signal_stop() already returns in the if branch so there's no need to
> keep the else branch around.

OK, but for what???

Do you think this change makes the code more readable? more clean? or what?

I do not really care but to me these "if/else" branches make this code more
symmetrical, so I don't understand the purpose.



> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> v0->v1:
> * patch unchanged
> ---
>  kernel/signal.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a628b56415e6..d1914439f144 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2214,14 +2214,14 @@ static bool do_signal_stop(int signr)
>  		/* Now we don't run again until woken by SIGCONT or SIGKILL */
>  		freezable_schedule();
>  		return true;
> -	} else {
> -		/*
> -		 * While ptraced, group stop is handled by STOP trap.
> -		 * Schedule it and let the caller deal with it.
> -		 */
> -		task_set_jobctl_pending(current, JOBCTL_TRAP_STOP);
> -		return false;
>  	}
> +
> +	/*
> +	 * While ptraced, group stop is handled by STOP trap.
> +	 * Schedule it and let the caller deal with it.
> +	 */
> +	task_set_jobctl_pending(current, JOBCTL_TRAP_STOP);
> +	return false;
>  }
>  
>  /**
> -- 
> 2.17.0
> 
