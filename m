Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66283C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B70A2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h943bmeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfABVRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:17:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45276 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfABVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:17:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so14968086plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJ2oVcbQ92As/PIuIVMLD9oLARFady9J9+58udv/F9s=;
        b=h943bmeQon7Sv9WNXM9IZ7b8ofhiDHxJK3JTtDrpzex9Z48P+q1MEbQ4Mz8NVRAOmz
         SV9bYn9hXOYJ/kNpu0AlpgeOoJlLde9hMIuKa6YKaFBB33D+AiydEpun73aKIDS7Sowe
         ElobUHbQMgyOwKfxOF94cGbcsdv2mznJx7EBjSkPS2JI1IWUvZ5V8RDWzZ1y/RX5AdWo
         /tbOsnZz+XiYIM0T7Pnt92HT5a2eyYvkYIja8h3F6Aaa2Tv5lgssrlwL8FWdI8fi0m75
         NEOODV5RsGggnfpMLv/LMso0DqkarY5VDArkrp1rjmfUMZeKinYIYl0LTAahu337+Xid
         AJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJ2oVcbQ92As/PIuIVMLD9oLARFady9J9+58udv/F9s=;
        b=fGLN+cctz+e7GHgXulG6mGBRSCB6E2PAOO4JReWTOjq4sVM3GnXawqueFnYu5lxODJ
         LohssKTfy25hWZ+hIfFB2TXzH33JDlj/eDKhPhhdlfcqLqt8zel3yHL/fQ6w/A7cc3mc
         o31Huyly9p1UlTHrrScgSrODh6suSLSA/jt0+Ui6A0SEpgExr2pscWwf/0W/iN2+RL7T
         kEelomjbMgQs29xRLhBL0HgVHPCxDJk86HGkxkkmNC5o0Gh+WOvJEqyIjLxqFPjQw1BZ
         MWLMXJNAf2ejWzUoJYbMqAo/r7HGAabk+v/IvbLNZyXpfPFg+AfElXYnA4rQjuaefxDn
         95ZQ==
X-Gm-Message-State: AJcUukeT5n71x/BVBoXc0yzUtY1msF/4zHkLSM0ccvUFOqLaMuyG6fEf
        09qgnS7scdVUHOo5RqI29To6v/XA
X-Google-Smtp-Source: ALg8bN5URL8Qp0ACfl7gqTSBEc9vKT4PHu/6/iqbZWLCqDyCPsq1TVBpSm06swyY7fX71zcTd/7lmA==
X-Received: by 2002:a17:902:bb86:: with SMTP id m6mr45417920pls.315.1546463843677;
        Wed, 02 Jan 2019 13:17:23 -0800 (PST)
Received: from gmail.com ([2620:0:1008:fd00:78b4:3a07:980a:287b])
        by smtp.gmail.com with ESMTPSA id a18sm71540510pgj.30.2019.01.02.13.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 13:17:23 -0800 (PST)
Date:   Wed, 2 Jan 2019 13:17:21 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kernel: release ptraced tasks before zap_pid_ns_processes
Message-ID: <20190102211720.GB3237@gmail.com>
References: <20190102205939.26231-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190102205939.26231-1-avagin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, Al is here by mistake. Sorry about that.

On Wed, Jan 02, 2019 at 12:59:39PM -0800, Andrei Vagin wrote:
> Currently, exit_ptrace() adds all ptraced tasks in a dead list, than
> zap_pid_ns_processes() waits all tasks in a current pid ns, and only
> then tasks from the dead list are released.
> 
> zap_pid_ns_processes() can stuck on waiting tasks from the dead list. In
> this case, we will have one unkillable process with one or more dead
> children.
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  kernel/exit.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 0e21e6d21f35..ccaa6f6549ba 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -664,9 +664,6 @@ static void forget_original_parent(struct task_struct *father,
>  {
>  	struct task_struct *p, *t, *reaper;
>  
> -	if (unlikely(!list_empty(&father->ptraced)))
> -		exit_ptrace(father, dead);
> -
>  	/* Can drop and reacquire tasklist_lock */
>  	reaper = find_child_reaper(father);
>  	if (list_empty(&father->children))
> @@ -705,8 +702,18 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  	LIST_HEAD(dead);
>  
>  	write_lock_irq(&tasklist_lock);
> -	forget_original_parent(tsk, &dead);
> +	if (unlikely(!list_empty(&tsk->ptraced)))
> +		exit_ptrace(tsk, &dead);
> +	write_unlock_irq(&tasklist_lock);
> +
> +	/* Ptraced tasks have to be released before zap_pid_ns_processes(). */
> +	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
> +		list_del_init(&p->ptrace_entry);
> +		release_task(p);
> +	}
>  
> +	write_lock_irq(&tasklist_lock);
> +	forget_original_parent(tsk, &dead);
>  	if (group_dead)
>  		kill_orphaned_pgrp(tsk->group_leader, NULL);
>  
> -- 
> 2.17.2
> 
