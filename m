Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F67C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A3E20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Q6STUWoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A3E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeK3KaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:30:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35329 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeK3KaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:30:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so1807378pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rBTLrlmojRvYosToedNHSpx1jpulEiJMFb2T1wZxCIk=;
        b=Q6STUWohDmT3MxfZRKGMEW5rqR4VfRKJ/lq8/sDPMo7TREtKba7AYxNYKEdcxpMjZy
         ms7gEujDXt93hFeeHqdZatkrJ+mIOojLdYqgLjbXmrxudbHrNfNMP7nezce2nw94ahMf
         6sxe4ZKSttMBY3bvezO35y570ZRpEMI1M01xyj/Gbdm3k6D/jAnZEKzArx+Wwc67Fwix
         4jtMtNaXGohGeGk8mN8jJ7VsWXIMGG2C4UcXc3Tx7bh7b32ExTk2pz4ZZE/KI46TjOAj
         ExpNC601oj0qxFNtwTw1/j7n3SrCL2g5meOwA5TS+GYOH/SCrbbCQ1HmtpVydwG1ece0
         PD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rBTLrlmojRvYosToedNHSpx1jpulEiJMFb2T1wZxCIk=;
        b=h+eUOIp6LDbFJ/hM38G/kgoqjuzHfgIDsnhYE9TU5MXPpNK6brcEp8u8HMHIvGZDjv
         ekFSoT+qTFxOxL5SDZR+/TDlcvGl7RfqP0Vk5IeUGcIL3wByE5jT2LyY2RE9u8XmrW9q
         vl4GkpzPzfdFqsvKeOdnSspuzWlCTYzm+5Ip7fnptEC+rDfevPkz+SUYqnhzh1qQpaDD
         yY7md4VIzU9jyVAv52Q6F8IgV0UfHNXd97wssOJ41vF1lx+PgUtKa6x9trV0HgMk+Z18
         +z8O86qD79Ilp8e+k2KqgtDwoelgTOA+6GiMbb5iUAmKIaC7iTbK+K7MyibdSXPZozWi
         RQcw==
X-Gm-Message-State: AA+aEWawfYvJpjufC2malEJk7JNFwlI9OkJR3hJLtADOukCOa6meonov
        DM4xLSOlCjVE3Cs5CpK7WPtkfHPX/Rg=
X-Google-Smtp-Source: AFSGD/VxDA1+1Fr0GYyl/Bw7X0zsbbW63x5T4cpvuytafVu57kpUdyx9sYV5ybh2eT0Rkd7otaIYHA==
X-Received: by 2002:a63:e516:: with SMTP id r22mr2984738pgh.256.1543533768203;
        Thu, 29 Nov 2018 15:22:48 -0800 (PST)
Received: from cisco ([128.107.241.161])
        by smtp.gmail.com with ESMTPSA id z13sm8742521pgf.84.2018.11.29.15.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:22:47 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:22:45 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: siginfo pid not populated from ptrace?
Message-ID: <20181129232245.GC4676@cisco>
References: <20181112171144.GI3645@cisco>
 <87efbqi1xa.fsf@xmission.com>
 <20181112185538.GK3645@cisco>
 <20181112192443.GL3645@cisco>
 <20181127232126.GA23658@cisco>
 <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
 <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
 <87zhtthkuy.fsf@xmission.com>
 <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 01:17:01PM -0800, Kees Cook wrote:
> On Tue, Nov 27, 2018 at 8:44 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Kees Cook <keescook@chromium.org> writes:
> >
> > > On Tue, Nov 27, 2018 at 4:38 PM, Kees Cook <keescook@chromium.org> wrote:
> > >> On Tue, Nov 27, 2018 at 3:21 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > >>> On Mon, Nov 12, 2018 at 12:24:43PM -0700, Tycho Andersen wrote:
> > >>>> On Mon, Nov 12, 2018 at 11:55:38AM -0700, Tycho Andersen wrote:
> > >>>> > I haven't manage to reproduce it on stock v4.20-rc2, unfortunately.
> > >>>>
> > >>>> Ok, now I have,
> > >>>>
> > >>>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1493) == info._sifields._kill.si_pid (0)
> > >>>> global.syscall_restart: Test failed at step #22
> > >>>
> > >>> Seems like this is still happening on v4.20-rc4,
> > >>>
> > >>> [ RUN      ] global.syscall_restart
> > >>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1901) == info._sifields._kill.si_pid (0)
> > >>> global.syscall_restart: Test failed at step #22
> > >>
> > >> This fails every time for me -- is it still racey for you?
> > >>
> > >> I'm attempting a bisect, hoping it doesn't _become_ racey for me. ;)
> > >
> > > This bisect to here for me:
> > >
> > > commit f149b31557446aff9ca96d4be7e39cc266f6e7cc
> > > Author: Eric W. Biederman <ebiederm@xmission.com>
> > > Date:   Mon Sep 3 09:50:36 2018 +0200
> > >
> > >     signal: Never allocate siginfo for SIGKILL or SIGSTOP
> > >
> > >     The SIGKILL and SIGSTOP signals are never delivered to userspace so
> > >     queued siginfo for these signals can never be observed.  Therefore
> > >     remove the chance of failure by never even attempting to allocate
> > >     siginfo in those cases.
> > >
> > >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > >     Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > >
> > > They are certainly visible via seccomp ;)
> >
> > Well SIGSTOP is visible via PTRACE_GETSIGINFO.
> >
> > I see what is happening now.  Since we don't have queued siginfo
> > we generate some as:
> >                 /*
> >                  * Ok, it wasn't in the queue.  This must be
> >                  * a fast-pathed signal or we must have been
> >                  * out of queue space.  So zero out the info.
> >                  */
> >                 clear_siginfo(info);
> >                 info->si_signo = sig;
> >                 info->si_errno = 0;
> >                 info->si_code = SI_USER;
> >                 info->si_pid = 0;
> >                 info->si_uid = 0;
> >
> > Which allows last_signfo to be set,
> > so despite not really having any siginfo PTRACE_GET_SIGINFO
> > has something to return so does not return -EINVAL.
> >
> > Reconstructing my context that was part of removing SEND_SIG_FORCED
> > so this looks like it will take a little more than a revert to fix
> > this.
> >
> > This is definitely a change that is visible to user space.  The logic in
> > my patch was definitely wrong with respect to SIGSTOP and
> > PTRACE_GETSIGINFO.  Is there something in userspace that actually cares?
> > AKA is the idiom that the test seccomp_bpf.c is using something that
> > non-test code does?
> 
> I think this would be needed by any ptracer that handled multiple
> threads. It needs to figure out which pid stopped. I think it's worth
> fixing, yes.
> 
> > The change below should restore the old behavior.  I am just wondering
> > if this is something we want to do.  siginfo is allocated with
> > GFP_ATOMIC so if your machine is under memory pressure there is a real
> > chance the allocation can fail.  Which would cause whatever is breaking
> > now to break less deterministically then.
> 
> I think memory pressure that would block a 128 byte GFP_ATOMIC
> allocation would mean the system was about to seriously fall over.
> Given the user-facing behavior change and that an existing test was
> already checking for this means we need to fix it.
> 
> > If we need to fix this do we need to make siginfo allocation more
> > reliable?
> 
> I don't think so -- we'd already get a WARN() if allocation failed.
> 
> > Eric
> >
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 4fd431ce4f91..5c34c55bfea4 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1057,10 +1057,10 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
> >
> >         result = TRACE_SIGNAL_DELIVERED;
> >         /*
> > -        * Skip useless siginfo allocation for SIGKILL SIGSTOP,
> > +        * Skip useless siginfo allocation for SIGKILL,
> >          * and kernel threads.
> >          */
> > -       if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
> > +       if ((sig == SIGKILL) || (t->flags & PF_KTHREAD))
> >                 goto out_set;
> >
> >         /*
> >
> 
> This fixes it for me!
> 
> Reported-by: Tycho Andersen <tycho@tycho.ws>
> Tested-by: Kees Cook <keescook@chromium.org>
> Fixes: f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")

Thanks guys, it works for me too.

Tested-by: Tycho Andersen <tycho@tycho.ws>

Tycho
