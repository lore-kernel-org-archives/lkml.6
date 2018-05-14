Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeENS7u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:59:50 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40727 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeENS7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:59:48 -0400
X-Google-Smtp-Source: AB8JxZrAGzLPk2abw8PkHFoxLJlUbDtobGGitONvNQJyWFAIbFvOabpm2gq6ezJExZF4aEuNMqXvFx+OW/Dq+4adM+4=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <28df5659605d7b2ace94deca3b831b462183303f.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com> <28df5659605d7b2ace94deca3b831b462183303f.1525964381.git.joe@perches.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 May 2018 14:59:46 -0400
Message-ID: <CAHC9VhRS1ww3Hv44p3W3C7WBoefrU2shQM4UHL8b6MK1kHso3g@mail.gmail.com>
Subject: Re: [PATCH 01/18] kernel: Use pr_fmt
To: Joe Perches <joe@perches.com>
Cc: Eric Paris <eparis@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 11:45 AM, Joe Perches <joe@perches.com> wrote:
> Sometime in the future, it would be useful to convert pr_fmt from a
> default simple define to use a default prefix with KBUILD_MODNAME.
>
> There are files in kernel/ that use pr_<level>, some with an embedded
> prefix, that also do not have a specific pr_fmt define.
>
> Add pr_fmt for those files.
>
> There are some differences in output as some messages are now prefixed
> with their KBUILD_MODNAME.
>
> Miscellanea:
>
> o Align multiline statements to open parenthesis
> o Wrap and realign arguments to 80 columns where sensible
> o Coalesce formats
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  kernel/acct.c          |  2 ++
>  kernel/async.c         | 14 ++++++------
>  kernel/audit_tree.c    |  2 +-
>  kernel/backtracetest.c |  8 +++----
>  kernel/crash_core.c    | 29 ++++++++++++++-----------
>  kernel/exit.c          |  2 ++
>  kernel/hung_task.c     | 13 +++++------
>  kernel/kprobes.c       | 20 ++++++++++-------
>  kernel/module.c        | 59 +++++++++++++++++++++++---------------------------
>  kernel/panic.c         |  3 +++
>  kernel/params.c        | 13 ++++++-----
>  kernel/pid.c           |  2 ++
>  kernel/profile.c       |  2 ++
>  kernel/range.c         |  2 +-
>  kernel/relay.c         |  5 ++++-
>  kernel/seccomp.c       |  4 +++-
>  kernel/signal.c        | 10 +++++----
>  kernel/smpboot.c       |  5 ++++-
>  kernel/taskstats.c     |  4 +++-
>  kernel/torture.c       |  6 +++--
>  kernel/tracepoint.c    |  3 +++
>  kernel/workqueue.c     |  2 ++
>  22 files changed, 122 insertions(+), 88 deletions(-)

The audit change looks fine to me, thanks Joe.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 67e6956c0b61..f34f90b4a346 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -739,7 +739,7 @@ static int audit_launch_prune(void)
>         prune_thread = kthread_run(prune_tree_thread, NULL,
>                                 "audit_prune_tree");
>         if (IS_ERR(prune_thread)) {
> -               pr_err("cannot start thread audit_prune_tree");
> +               pr_err("cannot start thread audit_prune_tree\n");
>                 prune_thread = NULL;
>                 return -ENOMEM;
>         }

-- 
paul moore
www.paul-moore.com
