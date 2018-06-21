Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2D0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B61522528
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="izqS/vHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B61522528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934088AbeFUXIB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:08:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37185 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933537AbeFUXIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:08:00 -0400
Received: by mail-qt0-f193.google.com with SMTP id a18-v6so4452605qtj.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MKQ7+lpzCTyohELNY0ocjlghXCzY4OPguzrKK4Zl/+g=;
        b=izqS/vHyK6+JHOhaubJgoQnd9l0E4r9VSgYS5mnZTLXLr/e7rr1UVpz6Lj1hQ5YAqI
         lFW842R983KG453UaknBuKzNLQFGfchNDyGjpxI3B1geH/Xfv1aXPNTqjkS5zNGbVGoP
         autDXPu66sLN7Z1zExxAPwZkMqtsH9/3u9dVrAiyyidLx3y/FJPemsiZyGqztDEQVREJ
         yHvRz0loVMqchmSGzurh8BVZuGlwf2h9USvPNXwnEp5KUjBlY4BVjZMwC5o/uyo4YFY0
         mbxl5G19aXY+v/94GKok4STGI9riGNssuSkwpHGrFxgrvUbPcQqJRm5sUJhyFQibFOCa
         fbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MKQ7+lpzCTyohELNY0ocjlghXCzY4OPguzrKK4Zl/+g=;
        b=VNYFup4THWVSUQST+H4WxtolUXz/Pmhg/ItrshHDNFHePOitg15a5R/TfgF7FLsNP7
         B9QdUn5a9z2E7dxgHEheuZBAE24RwLaL0TIBsByNBbPE2pgZKli3aLlie5B+3v+VUAPM
         eLW+flsWZv9Aqz0H9UDBcvy2QUGru56QngWfiujAre/79pjKqwmqlnIYQAdPXRtpRRJf
         Vz5xp2yAo1BATcBLns7A0Kr4HsXQ6yLmYz2nAXrQGfKgnK1BWAj6O6UfvUnlbbMFNk5R
         Tt6NV0/3tGLPgJFAH85Vnoq4XCTdhvaiTUk+RJyb7zuvmhCu+23cAalnyu82N57IvfsN
         2Zpg==
X-Gm-Message-State: APt69E3x3Bw3gDi6jSmGWdTVvoWoP+e3uuzVVrin1iKcUv+N7H/musFG
        5D3agFOiiKWFCL8BNRir+k2hYg==
X-Google-Smtp-Source: ADUXVKL1H5EMTfgnw0WM+RCZQk892sf1cOb63A/tNLwttJIPjzpNOo55/v9o1PqmDGb/YtWcKOfi8Q==
X-Received: by 2002:a0c:870a:: with SMTP id 10-v6mr25069909qvh.169.1529622479190;
        Thu, 21 Jun 2018 16:07:59 -0700 (PDT)
Received: from cisco ([173.38.117.67])
        by smtp.gmail.com with ESMTPSA id s39-v6sm4844571qts.42.2018.06.21.16.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 16:07:58 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:07:55 -0600
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
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH v4 3/4] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20180621230755.GI3992@cisco>
References: <20180621220416.5412-1-tycho@tycho.ws>
 <20180621220416.5412-4-tycho@tycho.ws>
 <CAG48ez3R+ZJ1vwGkDfGzKX2mz6f=jjJWsO5pCvnH68P+RKO8Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3R+ZJ1vwGkDfGzKX2mz6f=jjJWsO5pCvnH68P+RKO8Ow@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

On Fri, Jun 22, 2018 at 12:48:09AM +0200, Jann Horn wrote:
> On Fri, Jun 22, 2018 at 12:04 AM Tycho Andersen <tycho@tycho.ws> wrote:
> > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > version which can acquire filters is useful. There are at least two reasons
> > this is preferable, even though it uses ptrace:
> >
> > 1. You can control tasks that aren't cooperating with you
> > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> >    task installs a filter which blocks these calls, there's no way with
> >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> [...]
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index bbc24938c51d..b68a5d4a15cd 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -1743,6 +1743,34 @@ static struct file *init_listener(struct task_struct *task,
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
> > +       filter = get_nth_filter(task, filter_off);
> > +       if (IS_ERR(filter))
> > +               return PTR_ERR(filter);
> > +
> > +       fd = get_unused_fd_flags(0);
> > +       if (fd < 0) {
> > +               __put_seccomp_filter(filter);
> > +               return fd;
> > +       }
> > +
> > +       listener = init_listener(task, task->seccomp.filter);
> > +       __put_seccomp_filter(filter);
> > +       if (IS_ERR(listener)) {
> > +               put_unused_fd(fd);
> > +               return PTR_ERR(listener);
> > +       }
> > +
> > +       fd_install(fd, listener);
> > +       return fd;
> > +}
> 
> I think there's a security problem here. Imagine the following scenario:
> 
> 1. task A (uid==0) sets up a seccomp filter that uses SECCOMP_RET_USER_NOTIF
> 2. task A forks off a child B
> 3. task B uses setuid(1) to drop its privileges
> 4. task B becomes dumpable again, either via prctl(PR_SET_DUMPABLE, 1)
> or via execve()
> 5. task C (the attacker, uid==1) attaches to task B via ptrace
> 6. task C uses PTRACE_SECCOMP_NEW_LISTENER on task B
> 7. because the seccomp filter is shared by task A and task B, task C
> is now able to influence syscall results for syscalls performed by
> task A
> 
> Unless I'm missing something, you might have to add some extra
> security check here: Either a check to ensure that no other task is
> using the same seccomp filter, or (as a last resort) a check for
> capable(CAP_SYS_ADMIN).

I guess my first thought is "don't do that". But I am also not opposed
to adding a check for capable(CAP_SYS_ADMIN) to prevent the footgun,
so I can do that for v5. I think checking whether other tasks are
using a filter would be hard without adding some additional counter
logic or something, and at least for the use cases I know of,
capable(CAP_SYS_ADMIN) is fine.

Tycho
