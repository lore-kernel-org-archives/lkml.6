Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeERGCi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:02:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34574 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbeERGCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:02:36 -0400
X-Google-Smtp-Source: AB8JxZrZg5TyRx+ONiF8nTFqZkXn57i/D5iWro6iCWDewSF0L40GwIq1wz8UgjW4rgNPErZI2fXvcQ==
Date: Fri, 18 May 2018 08:02:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH ghak81 V3a] fixup! audit: collect audit task parameters
Message-ID: <20180518060233.GA23531@gmail.com>
References: <03014913acdc9dc6fbbee0e16c937170fea86b06.1526577485.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03014913acdc9dc6fbbee0e16c937170fea86b06.1526577485.git.rgb@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Richard Guy Briggs <rgb@redhat.com> wrote:

> Enable fork.c compilation with audit disabled.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Hi Paul, this one got caught by the 0-day kbuildbot.  Can you squash it
> down if you haven't merged it yet?
> ---
>  kernel/fork.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 92ab849..ff82928 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1713,7 +1713,9 @@ static __latent_entropy struct task_struct *copy_process(
>  	p->start_time = ktime_get_ns();
>  	p->real_start_time = ktime_get_boot_ns();
>  	p->io_context = NULL;
> +#ifdef CONFIG_AUDITSYSCALL
>  	p->audit = NULL;
> +#endif /* CONFIG_AUDITSYSCALL */

Please, simply use:

  #endif

the comment is used for (much) larger blocks, to make it clear which block ends 
there if the top is not visible.

Thanks,

	Ingo
