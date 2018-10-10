Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C569DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A5A21470
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="So5TyRXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A5A21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJJW4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:56:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37998 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJW4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:56:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id u197-v6so4440755oif.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/k/vZ07BThMqyU8pO7CM5+XYpWL1YyaPbNKQj9nshuY=;
        b=So5TyRXLq3J0A5qnWXtKd4MJfH9wA6HeRjpScqA+8Q4a5SIQE57W8W4HbdCdkT+4GG
         JAOip9uvPeXip5C56VmWIxONS1E7wGzn1sfQtEd3lNbDe9GUktOwmqTxFWb3wGqX2Oa5
         b8b+UkqSeJmgl4Fwj3UbbAVdx8rxS7joDBnQJlsoiAX8MX7f0IVDAPk7INqcu+Q5UI6x
         2KVWY491iMVnxMeDibf7gXNIr4PNP6lQYPUA43p0v3Dql8ASVp4f53iwK7UGwkIC3lB1
         t23rnw4pFFtQL5OrTJMoPGVtX6XPJyCHjpN8xSUHZx+EegYK1IgHzrxlvQE47rf1slVM
         +hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/k/vZ07BThMqyU8pO7CM5+XYpWL1YyaPbNKQj9nshuY=;
        b=Il59FB5O9QczGjdhRRpv+6mgco7P1vDJO4zSg+FnMENFus/5ut12FXfPyO4f63qlws
         1u70CjdJYbqTUJx+u3mqaRYQFswtm/ZasOxD6JKv68z3ZN0r49PPxw0CB47aWUA+aTk5
         QK/g84nHcTUFlyMcRUsfS4yXyBriot42MDH8e806H5GMto/Y0EgBenDWB0pBbpfYrIrh
         29EMUpb4nLRZHn0UD1rb/L3t0HqoPNjgqKFPsKewMhetrhob7Pg/OP7hC4PbexAhpeGs
         icOTIIbcr3m3F0wVbfwiCefBiHo4/SHZrt++HlEPCQwenPRhweW6dmlO8q5KRTsm2PB7
         9Yew==
X-Gm-Message-State: ABuFfoiBioAbu80V1OZT+er4N7FFNDTaT7DX1cVq2qtTE9Mg6KHyg5we
        3ksdfhJU64YmPuK30WwwQivvNOlS/9FBvtatoO7lVw==
X-Google-Smtp-Source: ACcGV60g6CUCtSqEnymRBVXTfYDDgpkB70aWTaHKc7qMDthtImUSBvpV67WDfcHDVSl7HnjzKZ8ftC6zaTzqUSs+saY=
X-Received: by 2002:aca:c045:: with SMTP id q66-v6mr2019639oif.22.1539185650064;
 Wed, 10 Oct 2018 08:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io> <CAG48ez3zaqOXH_jHN8=+jXjOf3vhFyWUkM_6KLPi9T8HcQySeg@mail.gmail.com>
 <20181008162147.ubfxxsv2425l2zsp@brauner.io> <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io> <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io> <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
In-Reply-To: <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 10 Oct 2018 17:33:43 +0200
Message-ID: <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
To:     Paul Moore <paul@paul-moore.com>
Cc:     christian@brauner.io, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 5:32 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Oct 9, 2018 at 9:36 AM Jann Horn <jannh@google.com> wrote:
> > +cc selinux people explicitly, since they probably have opinions on this
>
> I just spent about twenty minutes working my way through this thread,
> and digging through the containers archive trying to get a good
> understanding of what you guys are trying to do, and I'm not quite
> sure I understand it all.  However, from what I have seen, this
> approach looks very ptrace-y to me (I imagine to others as well based
> on the comments) and because of this I think ensuring the usual ptrace
> access controls are evaluated, including the ptrace LSM hooks, is the
> right thing to do.

Basically the problem is that this new ptrace() API does something
that doesn't just influence the target task, but also every other task
that has the same seccomp filter. So the classic ptrace check doesn't
work here.

> If I've missed something, or I'm thinking about this wrong, please
> educate me; just a heads-up that I'm largely offline for most of this
> week so responses on my end are going to be delayed much more than
> usual.
>
> > On Tue, Oct 9, 2018 at 3:29 PM Christian Brauner <christian@brauner.io> wrote:
> > > On Tue, Oct 09, 2018 at 02:39:53PM +0200, Jann Horn wrote:
> > > > On Mon, Oct 8, 2018 at 8:18 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > On Mon, Oct 08, 2018 at 06:42:00PM +0200, Jann Horn wrote:
> > > > > > On Mon, Oct 8, 2018 at 6:21 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > > On Mon, Oct 08, 2018 at 05:33:22PM +0200, Jann Horn wrote:
> > > > > > > > On Mon, Oct 8, 2018 at 5:16 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > > > > On Thu, Sep 27, 2018 at 09:11:16AM -0600, Tycho Andersen wrote:
> > > > > > > > > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > > > > > > > > index 44a31ac8373a..17685803a2af 100644
> > > > > > > > > > --- a/kernel/seccomp.c
> > > > > > > > > > +++ b/kernel/seccomp.c
> > > > > > > > > > @@ -1777,4 +1777,35 @@ static struct file *init_listener(struct task_struct *task,
> > > > > > > > > >
> > > > > > > > > >       return ret;
> > > > > > > > > >  }
> > > > > > > > > > +
> > > > > > > > > > +long seccomp_new_listener(struct task_struct *task,
> > > > > > > > > > +                       unsigned long filter_off)
> > > > > > > > > > +{
> > > > > > > > > > +     struct seccomp_filter *filter;
> > > > > > > > > > +     struct file *listener;
> > > > > > > > > > +     int fd;
> > > > > > > > > > +
> > > > > > > > > > +     if (!capable(CAP_SYS_ADMIN))
> > > > > > > > > > +             return -EACCES;
> > > > > > > > >
> > > > > > > > > I know this might have been discussed a while back but why exactly do we
> > > > > > > > > require CAP_SYS_ADMIN in init_userns and not in the target userns? What
> > > > > > > > > if I want to do a setns()fd, CLONE_NEWUSER) to the target process and
> > > > > > > > > use ptrace from in there?
> > > > > > > >
> > > > > > > > See https://lore.kernel.org/lkml/CAG48ez3R+ZJ1vwGkDfGzKX2mz6f=jjJWsO5pCvnH68P+RKO8Ow@mail.gmail.com/
> > > > > > > > . Basically, the problem is that this doesn't just give you capability
> > > > > > > > over the target task, but also over every other task that has the same
> > > > > > > > filter installed; you need some sort of "is the caller capable over
> > > > > > > > the filter and anyone who uses it" check.
> > > > > > >
> > > > > > > Thanks.
> > > > > > > But then this new ptrace feature as it stands is imho currently broken.
> > > > > > > If you can install a seccomp filter with SECCOMP_RET_USER_NOTIF if you
> > > > > > > are ns_cpabable(CAP_SYS_ADMIN) and also get an fd via seccomp() itself
> > > > > > > if you are ns_cpabable(CAP_SYS_ADMIN)
> > > >
> > > > Actually, you don't need CAP_SYS_ADMIN for seccomp() at all as long as
> > > > you enable the NNP flag, I think?
> > >
> > > Yes, if you turn on NNP you don't even need sys_admin.
> > >
> > > >
> > > > > > > then either the new ptrace() api
> > > > > > > extension should be fixed to allow for this too or the seccomp() way of
> > > > > > > retrieving the pid - which I really think we want - needs to be fixed to
> > > > > > > require capable(CAP_SYS_ADMIN) too.
> > > > > > > The solution where both require ns_capable(CAP_SYS_ADMIN) is - imho -
> > > > > > > the preferred way to solve this.
> > > > > > > Everything else will just be confusing.
> > > > > >
> > > > > > First you say "broken", then you say "confusing". Which one do you mean?
> > > > >
> > > > > Both. It's broken in so far as it places a seemingly unnecessary
> > > > > restriction that could be fixed. You outlined one possible fix yourself
> > > > > in the link you provided.
> > > >
> > > > If by "possible fix" you mean "check whether the seccomp filter is
> > > > only attached to a single task": That wouldn't fundamentally change
> > > > the situation, it would only add an additional special case.
> > > >
> > > > > And it's confusing in so far as there is a way
> > > > > via seccomp() to get the fd without said requirement.
> > > >
> > > > I don't find it confusing at all. seccomp() and ptrace() are very
> > >
> > > Fine, then that's a matter of opinion. I find it counterintuitive that
> > > you can get an fd without privileges via one interface but not via
> > > another.
> > >
> > > > different situations: When you use seccomp(), infrastructure is
> > >
> > > Sure. Note, that this is _one_ of the reasons why I want to make sure we
> > > keep the native seccomp() only based way of getting an fd without
> > > forcing userspace to switching to a differnet kernel api.
> > >
> > > > already in place for ensuring that your filter is only applied to
> > > > processes over which you are capable, and propagation is limited by
> > > > inheritance from your task down. When you use ptrace(), you need a
> > > > pretty different sort of access check that checks whether you're
> > > > privileged over ancestors, siblings and so on of the target task.
> > >
> > > So, don't get me wrong I'm not arguing against the ptrace() interface in
> > > general. If this is something that people find useful, fine. But, I
> > > would like to have a simple single-syscall pure-seccomp() based way of
> > > getting an fd, i.e. what we have in patch 1 of this series.
> >
> > Yeah, I also prefer the seccomp() one.
> >
> > > > But thinking about it more, I think that CAP_SYS_ADMIN over the saved
> > > > current->mm->user_ns of the task that installed the filter (stored as
> > > > a "struct user_namespace *" in the filter) should be acceptable.
> > >
> > > Hm... Why not CAP_SYS_PTRACE?
> >
> > Because LSMs like SELinux add extra checks that apply even if you have
> > CAP_SYS_PTRACE, and this would subvert those. The only capability I
> > know of that lets you bypass LSM checks by design (if no LSM blocks
> > the capability itself) is CAP_SYS_ADMIN.
> >
> > > One more thing. Citing from [1]
> > >
> > > > I think there's a security problem here. Imagine the following scenario:
> > > >
> > > > 1. task A (uid==0) sets up a seccomp filter that uses SECCOMP_RET_USER_NOTIF
> > > > 2. task A forks off a child B
> > > > 3. task B uses setuid(1) to drop its privileges
> > > > 4. task B becomes dumpable again, either via prctl(PR_SET_DUMPABLE, 1)
> > > > or via execve()
> > > > 5. task C (the attacker, uid==1) attaches to task B via ptrace
> > > > 6. task C uses PTRACE_SECCOMP_NEW_LISTENER on task B
> > >
> > > Sorry, to be late to the party but would this really pass
> > > __ptrace_may_access() in ptrace_attach()? It doesn't seem obvious to me
> > > that it would... Doesn't look like it would get past:
> > >
> > >         tcred = __task_cred(task);
> > >         if (uid_eq(caller_uid, tcred->euid) &&
> > >             uid_eq(caller_uid, tcred->suid) &&
> > >             uid_eq(caller_uid, tcred->uid)  &&
> > >             gid_eq(caller_gid, tcred->egid) &&
> > >             gid_eq(caller_gid, tcred->sgid) &&
> > >             gid_eq(caller_gid, tcred->gid))
> > >                 goto ok;
> > >         if (ptrace_has_cap(tcred->user_ns, mode))
> > >                 goto ok;
> > >         rcu_read_unlock();
> > >         return -EPERM;
> > > ok:
> > >         rcu_read_unlock();
> > >         mm = task->mm;
> > >         if (mm &&
> > >             ((get_dumpable(mm) != SUID_DUMP_USER) &&
> > >              !ptrace_has_cap(mm->user_ns, mode)))
> > >             return -EPERM;
> >
> > Which specific check would prevent task C from attaching to task B? If
> > the UIDs match, the first "goto ok" executes; and you're dumpable, so
> > you don't trigger the second "return -EPERM".
> >
> > > > 7. because the seccomp filter is shared by task A and task B, task C
> > > > is now able to influence syscall results for syscalls performed by
> > > > task A
> > >
> > > [1]: https://lore.kernel.org/lkml/CAG48ez3R+ZJ1vwGkDfGzKX2mz6f=jjJWsO5pCvnH68P+RKO8Ow@mail.gmail.com/
>
>
>
> --
> paul moore
> www.paul-moore.com
