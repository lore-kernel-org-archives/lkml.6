Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB98C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042A720827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdKw8BcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfAHUgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:36:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42737 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfAHUgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:36:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so2429312plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HAiNRxjnamjJs7foBFRydsfbmARLDQ7hr/Drh+QCbSE=;
        b=mdKw8BcY9LnhFjtdwY8huJ6ltRHDFB/UWcjqrz/TDSihtSk7IgEuX7qyRFOnpw8mkj
         MA9FuyZV8ZBcbl5mtqxHdqzB23ehuMMga/JdfwTz/jwTWrgvwR9I2swP6pIh1qQfJyTX
         gxS0/qiSOF9VnweaBW3xXzO5kxml+9Gn7EgrKaoxhQrNdcVhXL60nBtMfmBGi9BgW/L8
         n87mSwGL4Fdh2JnOf32V4sGrp8qhlAKXBkDsaoYJmFxmgqQC2qoIhZBDTZAhIHCKQd/h
         Z+zJBdDAF+Nf0LtfQMNYgu/ER3bbWVqpfAfI0EMiWaO6epxf1xJnLZRAyvFa2/QUmDzf
         3IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HAiNRxjnamjJs7foBFRydsfbmARLDQ7hr/Drh+QCbSE=;
        b=Ias2hQgqArq2L9TJE91bnJMj6B5NIducYhH1WLsZbf7SD0CRFqPbYVi+j8TH+Fsn8i
         JzzdB28LcJLbzmXWhIKQsunJ4NdEm/A5JjksIb2WCdWSJmt9wyAW2AwYvKsvgQT4T9VO
         KhFyAAciHWoXI1e6IPBWufRstrkxfEMJglCzTlS8BS0Fx2tzfFptimvA9fnC25vVBJCj
         LNLNkS4pLC/qU6yOgSb1pVj7/nhxkegn94qANLElCvWKg7Zqpy8xUtXrwmQwUrqfvyHb
         dN+PaR2XObHlpLQkbbghJ2CkCo/vwbvnZY7AfvL/8Mdg7kpjBAsmurZHq6d0dX1VIQJS
         xrTg==
X-Gm-Message-State: AJcUukc384iYTVmYDadtDPEqimPeti58+HEINCTdcPmkIyu5SGO2Rg3W
        uRTEKULz+23e9a59OzCBTUE=
X-Google-Smtp-Source: ALg8bN722StuzKpHZu+8lBWaoGP9XNNasah1TVrM96U5kg1GtZLNhvFJUZGWRZJusWjV7xXY7yDTHg==
X-Received: by 2002:a17:902:6848:: with SMTP id f8mr3147703pln.300.1546979774989;
        Tue, 08 Jan 2019 12:36:14 -0800 (PST)
Received: from gmail.com ([2620:0:1008:fd00:78b4:3a07:980a:287b])
        by smtp.gmail.com with ESMTPSA id h134sm140961811pfe.27.2019.01.08.12.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 12:36:14 -0800 (PST)
Date:   Tue, 8 Jan 2019 12:36:13 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kernel: release ptraced tasks before zap_pid_ns_processes
Message-ID: <20190108203612.GA19454@gmail.com>
References: <20190102205939.26231-1-avagin@gmail.com>
 <20190108165043.GA10240@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190108165043.GA10240@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 05:50:43PM +0100, Oleg Nesterov wrote:
> Sorry for delay, vacation,
> 
> On 01/02, Andrei Vagin wrote:
> >
> > zap_pid_ns_processes() can stuck on waiting tasks from the dead list. In
> > this case, we will have one unkillable process with one or more dead
> > children.
> 
> Thanks!
> 
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -664,9 +664,6 @@ static void forget_original_parent(struct task_struct *father,
> >  {
> >  	struct task_struct *p, *t, *reaper;
> >  
> > -	if (unlikely(!list_empty(&father->ptraced)))
> > -		exit_ptrace(father, dead);
> > -
> >  	/* Can drop and reacquire tasklist_lock */
> >  	reaper = find_child_reaper(father);
> >  	if (list_empty(&father->children))
> > @@ -705,8 +702,18 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
> >  	LIST_HEAD(dead);
> >  
> >  	write_lock_irq(&tasklist_lock);
> > -	forget_original_parent(tsk, &dead);
> > +	if (unlikely(!list_empty(&tsk->ptraced)))
> > +		exit_ptrace(tsk, &dead);
> > +	write_unlock_irq(&tasklist_lock);
> > +
> > +	/* Ptraced tasks have to be released before zap_pid_ns_processes(). */
> > +	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
> > +		list_del_init(&p->ptrace_entry);
> > +		release_task(p);
> > +	}
> >  
> > +	write_lock_irq(&tasklist_lock);
> > +	forget_original_parent(tsk, &dead);
> >  	if (group_dead)
> >  		kill_orphaned_pgrp(tsk->group_leader, NULL);
> 
> How about a different fix below? It avoids additional write_lock/unlock(tasklist),
> and another list_for_each_entry_safe(dead) loop is called only if it is actually
> needed.
> 
> Or I missed something?

No, you don't. The patch looks really nice. Thanks!

BTW: We probably need to add the "Fixes:" tag, but I am not sure to which
commit, it looks like the issue is here for years.

Acked-by: Andrei Vagin <avagin@gmail.com>

> 
> Oleg.
> 
> 
> --- x/kernel/exit.c
> +++ x/kernel/exit.c
> @@ -558,12 +558,14 @@ static struct task_struct *find_alive_th
>  	return NULL;
>  }
>  
> -static struct task_struct *find_child_reaper(struct task_struct *father)
> +static struct task_struct *find_child_reaper(struct task_struct *father,
> +						struct list_head *dead)
>  	__releases(&tasklist_lock)
>  	__acquires(&tasklist_lock)
>  {
>  	struct pid_namespace *pid_ns = task_active_pid_ns(father);
>  	struct task_struct *reaper = pid_ns->child_reaper;
> +	struct task_struct *p, *n;
>  
>  	if (likely(reaper != father))
>  		return reaper;
> @@ -579,6 +581,11 @@ static struct task_struct *find_child_re
>  		panic("Attempted to kill init! exitcode=0x%08x\n",
>  			father->signal->group_exit_code ?: father->exit_code);
>  	}
> +
> +	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
> +		list_del_init(&p->ptrace_entry);
> +		release_task(p);
> +	}
>  	zap_pid_ns_processes(pid_ns);
>  	write_lock_irq(&tasklist_lock);
>  
> @@ -668,7 +675,7 @@ static void forget_original_parent(struc
>  		exit_ptrace(father, dead);
>  
>  	/* Can drop and reacquire tasklist_lock */
> -	reaper = find_child_reaper(father);
> +	reaper = find_child_reaper(father, dead);
>  	if (list_empty(&father->children))
>  		return;
>  
> 
