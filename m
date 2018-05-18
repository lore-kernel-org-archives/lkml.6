Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeERA30 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 20:29:26 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44478 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeERA3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 20:29:25 -0400
X-Google-Smtp-Source: AB8JxZoROduDFWdpB32094BzyZR4vA0UxgI1PA9wFALoqW7KUHJBSsvHw9WDuwsKG6AuX15CYNAd81HK7YITDqzpSs4=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <03014913acdc9dc6fbbee0e16c937170fea86b06.1526577485.git.rgb@redhat.com>
References: <03014913acdc9dc6fbbee0e16c937170fea86b06.1526577485.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 May 2018 20:29:23 -0400
Message-ID: <CAHC9VhRXGATOiAf1pFT5jJvDEgNHkChwZvoQri5=F7wDTQT_2A@mail.gmail.com>
Subject: Re: [PATCH ghak81 V3a] fixup! audit: collect audit task parameters
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 1:20 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Enable fork.c compilation with audit disabled.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Hi Paul, this one got caught by the 0-day kbuildbot.  Can you squash it
> down if you haven't merged it yet?

See my comment in the original patch.  I would just recommend
squashing this into the original patch the next time you post it.

> ---
>  kernel/fork.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 92ab849..ff82928 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1713,7 +1713,9 @@ static __latent_entropy struct task_struct *copy_process(
>         p->start_time = ktime_get_ns();
>         p->real_start_time = ktime_get_boot_ns();
>         p->io_context = NULL;
> +#ifdef CONFIG_AUDITSYSCALL
>         p->audit = NULL;
> +#endif /* CONFIG_AUDITSYSCALL */
>         cgroup_fork(p);
>  #ifdef CONFIG_NUMA
>         p->mempolicy = mpol_dup(p->mempolicy);
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
