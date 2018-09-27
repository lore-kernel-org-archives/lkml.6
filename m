Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA85AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D54B2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ZFz37cjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D54B2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeI0Wxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:53:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40361 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeI0Wxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:53:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id s5-v6so2286517pfj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fWk6RPKFJis6w3MZFPx/DZVADSgeMqpr+KynDO3uqU0=;
        b=ZFz37cjfQeLONxgUmndzfFs0+2vep1QQzwQ+v8JWBWTq+V1mlWgFKqpHo7+liKvXZ6
         3/JVmCnjaUkg7Nida6ZGfUUmzy/jRbUMpoycFGgfUGAuI2wpsjdMRJNrO23WkptbQLlQ
         Z3SRNtxPEEodOUQiixrSoqMp/vS3RmrBsAlZOnY7Ux5GjLWBqszc+mXeeewbq4e9koCi
         Se+5ze9XtI+zNZtUs7iBG/ub/hIwCG6STBeC6EU2g6BX6lWNRPziD1IeVUlW7JMCOVWl
         4qiz0FK+2txEcU2cDuNZ+scJYPX3xiG7lhqH6IH23X+xmOfkJ/6N3ygkrz0URAAxW/3W
         f2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fWk6RPKFJis6w3MZFPx/DZVADSgeMqpr+KynDO3uqU0=;
        b=L9bpVNpojJQv8pv+z3xSo3S6dv13eDGmd/n3r++cy8uT/D6ja0iXlWs7WZaTdHJKw8
         sLgTumZ+xg1SBZCnBS/VdzsmYwyYvD3kwAOV7G/xiSOMhQGrgKQnxrWMySyYK3wqba4Q
         Pk/78DUIBzGmHK9EwRBZJVByondV+Ir1wN2VDQCxor55zSXCDA9Y3Og6BuFjse2DTm6r
         0ZMX5sq94oMXLyBKAM6DU3Jfuh4WRJFMEHvuzOuuVv9QfSkAr2vWzpxWZhXLXv2WW3rj
         ezCtv1tueGJMlsS/+dvgp9JpoXx2qlYGGkvv5a9v4DM7Iip1dqK9d6ds8PNOEBa+Kpg+
         Myjw==
X-Gm-Message-State: ABuFfoj6WPLdEXwQdBAH6/Qnwjp8xBGlCar+QZx63nGpZKmzyeVIP4WV
        dqhHQTigDf1SUDWSdITzg17/kw==
X-Google-Smtp-Source: ACcGV61Gr4HRjTcRa63DGixz12f2oZ73p+v3dDZsNGU0ORYFSgdGPZWT1fJUBRsDfDW48a5erc2Ruw==
X-Received: by 2002:a65:5545:: with SMTP id t5-v6mr10995186pgr.157.1538066080913;
        Thu, 27 Sep 2018 09:34:40 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.178])
        by smtp.gmail.com with ESMTPSA id p7-v6sm4157226pfb.101.2018.09.27.09.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:34:39 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:34:37 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20180927163437.GA30761@cisco.cisco.com>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-4-tycho@tycho.ws>
 <CAG48ez0V--kdYh5-tqLJxu=+jOLLjJ65QdGoqoJMdySCDw2CzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0V--kdYh5-tqLJxu=+jOLLjJ65QdGoqoJMdySCDw2CzQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 06:20:23PM +0200, Jann Horn wrote:
> On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > version which can acquire filters is useful. There are at least two reasons
> > this is preferable, even though it uses ptrace:
> >
> > 1. You can control tasks that aren't cooperating with you
> > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> >    task installs a filter which blocks these calls, there's no way with
> >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> >
> > v2: fix a bug where listener mode was not unset when an unused fd was not
> >     available
> > v3: fix refcounting bug (Oleg)
> > v4: * change the listener's fd flags to be 0
> >     * rename GET_LISTENER to NEW_LISTENER (Matthew)
> > v5: * add capable(CAP_SYS_ADMIN) requirement
> > v7: * point the new listener at the right filter (Jann)
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > CC: Kees Cook <keescook@chromium.org>
> > CC: Andy Lutomirski <luto@amacapital.net>
> > CC: Oleg Nesterov <oleg@redhat.com>
> > CC: Eric W. Biederman <ebiederm@xmission.com>
> > CC: "Serge E. Hallyn" <serge@hallyn.com>
> > CC: Christian Brauner <christian.brauner@ubuntu.com>
> > CC: Tyler Hicks <tyhicks@canonical.com>
> > CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> 
> If you address the two nits below, you can add:
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks!

> >  include/linux/seccomp.h                       |  7 ++
> >  include/uapi/linux/ptrace.h                   |  2 +
> >  kernel/ptrace.c                               |  4 ++
> >  kernel/seccomp.c                              | 31 +++++++++
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 68 +++++++++++++++++++
> >  5 files changed, 112 insertions(+)
> >
> > diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> > index 017444b5efed..234c61b37405 100644
> > --- a/include/linux/seccomp.h
> > +++ b/include/linux/seccomp.h
> > @@ -83,6 +83,8 @@ static inline int seccomp_mode(struct seccomp *s)
> >  #ifdef CONFIG_SECCOMP_FILTER
> >  extern void put_seccomp_filter(struct task_struct *tsk);
> >  extern void get_seccomp_filter(struct task_struct *tsk);
> > +extern long seccomp_new_listener(struct task_struct *task,
> > +                                unsigned long filter_off);
> 
> Nit: Sorry, I only noticed this just now, but this should have return
> type int, not long. ptrace_request() returns an int, and an fd is also
> normally represented as an int, not a long.

Ugh, I could have sworn I checked this. In particular because the
other seccomp code that's called from ptrace returns a long too :)

I'll fix that for the next version, and send a different patch for the
other two.

> >  #else  /* CONFIG_SECCOMP_FILTER */
> >  static inline void put_seccomp_filter(struct task_struct *tsk)
> >  {
> > @@ -92,6 +94,11 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
> >  {
> >         return;
> >  }
> > +static inline long seccomp_new_listener(struct task_struct *task,
> > +                                       unsigned long filter_off)
> > +{
> > +       return -EINVAL;
> > +}
> >  #endif /* CONFIG_SECCOMP_FILTER */
> >
> >  #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
> > diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> > index d5a1b8a492b9..e80ecb1bd427 100644
> > --- a/include/uapi/linux/ptrace.h
> > +++ b/include/uapi/linux/ptrace.h
> > @@ -73,6 +73,8 @@ struct seccomp_metadata {
> >         __u64 flags;            /* Output: filter's flags */
> >  };
> >
> > +#define PTRACE_SECCOMP_NEW_LISTENER    0x420e
> > +
> >  /* Read signals from a shared (process wide) queue */
> >  #define PTRACE_PEEKSIGINFO_SHARED      (1 << 0)
> >
> > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > index 21fec73d45d4..289960ac181b 100644
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -1096,6 +1096,10 @@ int ptrace_request(struct task_struct *child, long request,
> >                 ret = seccomp_get_metadata(child, addr, datavp);
> >                 break;
> >
> > +       case PTRACE_SECCOMP_NEW_LISTENER:
> > +               ret = seccomp_new_listener(child, addr);
> > +               break;
> > +
> >         default:
> >                 break;
> >         }
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 44a31ac8373a..17685803a2af 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -1777,4 +1777,35 @@ static struct file *init_listener(struct task_struct *task,
> >
> >         return ret;
> >  }
> > +
> > +long seccomp_new_listener(struct task_struct *task,
> > +                         unsigned long filter_off)
> > +{
> > +       struct seccomp_filter *filter;
> > +       struct file *listener;
> > +       int fd;
> > +
> > +       if (!capable(CAP_SYS_ADMIN))
> > +               return -EACCES;
> > +
> > +       filter = get_nth_filter(task, filter_off);
> > +       if (IS_ERR(filter))
> > +               return PTR_ERR(filter);
> > +
> > +       fd = get_unused_fd_flags(0);
> 
> s/0/O_CLOEXEC/ ? If userspace needs a non-cloexec fd, userspace can
> easily unset O_CLOEXEC; but the reverse isn't true, because it'd be
> racy.

Sure, will do.

Tycho
