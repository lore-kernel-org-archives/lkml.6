Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BBC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15ABA2084C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhAb+Ifm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfBBKEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:04:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44043 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfBBKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:04:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id p4so1252886plq.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 02:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9xDMejnxtfTklT2oXYVbm9EEbkLLZPi6FL7oGEKGEQc=;
        b=HhAb+IfmU+HMdVVnhiM1hN5C3fUsg9NwJysZh2oncx0fwsWhDiqUYlP289TmO70MK8
         maYEc9HJ9htNKWqHIThyB76aYuaejUzawK4zMU2Cm8k6cYTpxA9TB8KUpwXiUmXhZqIf
         qkryZu6Z2a6MBqAjIqviSB5We7cNs3EzhFXm0TOEKzIE47efrri+uMsGmgZ5qUJYrDbo
         drBaBeavNhBi6XbLnO9eA7nHa/45Q51f40rWu4VNWrtxQt3uZpP65SqhK5aateUJPlrk
         fcZMnMqGG4yRwgY1VYtAWfDmtlO+VVWe2s5Gwb9IP07cRi3lxFn2y8wTW0hbQTPZf+jE
         WR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9xDMejnxtfTklT2oXYVbm9EEbkLLZPi6FL7oGEKGEQc=;
        b=kN4g7OGae8e6WHxYipQsOgF9rYKzn/KzWefjdsjtfpDzgznbZO6FJgNaXs6YELFMhr
         fgT0yXtTjQMGQmMOba+IXwZR4WLqTwC3ex4bmVbGQXEgi79jH+POFi4Z0DAYwbr2NqQK
         qzBIGGVirqJhjB0NlhtmIlzQEBLy0+uwvuZ4zja9+gyWsE7opz+WT3bPSgPVfX+EWpSM
         SyJwSa0oaO3TV0eGAlFN/hMcYJ9l7aMHDzBi64ngXjc34Jwo6z/XkP4Ma2K+Sy49nQtL
         HUQMivIs/QzPc6i8Q2HWCjHLCrfkatA/hIIwrd3zQmftoxPJlNe2vnFKdmgx3xGoaUGT
         qXrA==
X-Gm-Message-State: AJcUukdZgeOfawIZKltW0eiydMZmfVvOWhot6/8GWwPw9e+XNkv1F6dv
        CkdHgN0HWTOMmdsBxvirosM=
X-Google-Smtp-Source: ALg8bN5v4rjwbcnKlhQ3i/+6xmQmlKDoXJZF0M34U7wsLRYyFQxhNFndI3mOvBMn3qrYUthTsRjwow==
X-Received: by 2002:a17:902:6683:: with SMTP id e3mr41346783plk.93.1549101882752;
        Sat, 02 Feb 2019 02:04:42 -0800 (PST)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id u8sm14684681pfl.16.2019.02.02.02.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 02:04:42 -0800 (PST)
Date:   Sat, 2 Feb 2019 02:04:40 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] ptrace: take into account saved_sigmask in
 PTRACE_{GET,SET}SIGMASK
Message-ID: <20190202100439.GA16265@gmail.com>
References: <20181120060616.6043-1-avagin@gmail.com>
 <20181121181650.8d2d6abcf83b9defb7195cd3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20181121181650.8d2d6abcf83b9defb7195cd3@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 06:16:50PM -0800, Andrew Morton wrote:
> On Mon, 19 Nov 2018 22:06:16 -0800 Andrei Vagin <avagin@gmail.com> wrote:
> 
> > There are a few system calls (pselect, ppoll, etc) which replace a task
> > sigmask while they are running in a kernel-space
> > 
> > When a task calls one of these syscalls, the kernel saves a current
> > sigmask in task->saved_sigmask and sets a syscall sigmask.
> > 
> > On syscall-exit-stop, ptrace traps a task before restoring the
> > saved_sigmask, so PTRACE_GETSIGMASK returns the syscall sigmask and
> > PTRACE_SETSIGMASK does nothing, because its sigmask is replaced by
> > saved_sigmask, when the task returns to user-space.
> > 
> > This patch fixes this problem. PTRACE_GET_SIGMASK returns saved_sigmask
> > is it's set. PTRACE_SETSIGMASK drops the TIF_RESTORE_SIGMASK flag.
> 
> Looks good to me, but what would I know.  I'll await input from Eric
> and/or Oleg (please).

Hi Andrew,

What is your plan for this patch? In the ~akpm/mmotm/series, I see a
comment of waiting for ack from Oleg.

Here was a feedback from Oleg:
https://www.spinics.net/lists/kernel/msg2972154.html

where he said: "Ok, I think the patch is fine".

Is it enough or should I convince him to send a "real" ack?

Thanks,
Andrei

> 
> > --- a/include/linux/sched/signal.h
> > +++ b/include/linux/sched/signal.h
> > @@ -417,10 +417,20 @@ static inline void set_restore_sigmask(void)
> >  	set_thread_flag(TIF_RESTORE_SIGMASK);
> >  	WARN_ON(!test_thread_flag(TIF_SIGPENDING));
> >  }
> > +
> > +static inline void clear_tsk_restore_sigmask(struct task_struct *tsk)
> > +{
> > +	clear_tsk_thread_flag(tsk, TIF_RESTORE_SIGMASK);
> > +}
> 
> How irritating is it that this file uses "task" 85 times and "tsk" 19
> times?  What did that gain us?  This patch worsens things.
> 
> Oh well.
