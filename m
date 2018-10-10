Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E7EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F077F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bcjsOpho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F077F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJJUks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:40:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34765 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:40:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so5299921wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mrNWOe4D332Ao3uTuRsJGgtjrAka4HbmLpkdyldlMQE=;
        b=bcjsOphoOHTGWG312QANtPLIwMDdataW2a1nU958uGzG+sw9gVD/1rnxNPVaZGkZ1b
         bmBgarh1SQ0SYDktmGXSbJ5VajrPqnqDQqXkTWy44yDKeo825w1xyR0HJ7V1jOuU6QOc
         55d/H0/AVsf6Tto3kaWyhb+n6oPJLX3QNPizN8iGJP+mwlz/0hjFk0WtXvd9f+goG9UY
         +SLPDYst/src4XOKDMhXLH1f5YpTbZHOAbYpWzMlQqNVfDRzUwOLjFkoBm3zXh63Okuc
         O2txvrx4Noih4/qF6f+3kV6D/Y6KXDAp38uCEoQn7wB36//odpAO1aQ1Vfh+yQe2FCiN
         d3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mrNWOe4D332Ao3uTuRsJGgtjrAka4HbmLpkdyldlMQE=;
        b=pvzeKTm9fOGgUr4B+X/2+h+PRJC8x8nRLQVPPGQW7iAWhiLQOz5/t9QfwdKilj3R4E
         5+7XNj2zOpS8IsV7lxk24xU13l5EiYoFlWWTSp7CBb8P4OaeNpg76LESLan87oOWJ0Gz
         ihBX+OeQHqIx+XWuttJxuRJ2Xownp5M2V6NriKRQXU0d3s+9VtZj+7dNSsoJY+UoWCg8
         oDLlGUofKUHpsDeDS26y2Q9oyweqAPcxHMYgbZsw2R20fXFZIOj+qMFWC24VBl6K21QV
         rrpUz7jUphq7vfvSb4STkDqjS4ZbCp7a1Jo9QFs8hTF7mVx00/xkGxkF+2O9qQxxysNI
         58mg==
X-Gm-Message-State: ABuFfohHudlGomoCnMNNXbYN0M0kz+pN7/D1F0PCM18edP5gHOZwellk
        DAM0VuVE26d1UndEkOTcdypzptRnkDACnw==
X-Google-Smtp-Source: ACcGV63H48agUJ1un3WFx3Ad2N8e7J3MCPDHE1TkSVigtVvaG6M2m/wqJDznLfHedn+zFP81QqbiOA==
X-Received: by 2002:a5d:47cb:: with SMTP id l11-v6mr23627970wrs.195.1539177517344;
        Wed, 10 Oct 2018 06:18:37 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id a18sm17792956wrx.55.2018.10.10.06.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 06:18:36 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:18:30 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181010131829.rlczow555y6gig5p@brauner.io>
References: <20181009132850.fp6yne2vgmfpi27k@brauner.io>
 <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <20181009134923.2fvf5roghqgaj5gq@brauner.io>
 <CAG48ez1hnKkm7mzXuZLP4n6x8K1JqmTwQb-e79oJguTaH1mkUw@mail.gmail.com>
 <20181009140932.e5w5lgbgucbl72kt@brauner.io>
 <CAG48ez12SYRUJTWRdzWhpvHBkQion4i8Gpef4r1L6epo9JF-ng@mail.gmail.com>
 <20181009162022.d7fd2wibyq6xi6sg@brauner.io>
 <CAG48ez2ROhq4R1az2TXNmBvCXY=3UVxnmh6CeR05N0xVGrpwpA@mail.gmail.com>
 <20181010125422.rouslofknxzvygzr@brauner.io>
 <CAG48ez0ct7_i1U0=vr1Z=4WhVH7GQKFzhtuxR+1oknmPiDTqKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0ct7_i1U0=vr1Z=4WhVH7GQKFzhtuxR+1oknmPiDTqKg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:10:11PM +0200, Jann Horn wrote:
> On Wed, Oct 10, 2018 at 2:54 PM Christian Brauner <christian@brauner.io> wrote:
> > On Tue, Oct 09, 2018 at 06:26:47PM +0200, Jann Horn wrote:
> > > On Tue, Oct 9, 2018 at 6:20 PM Christian Brauner <christian@brauner.io> wrote:
> > > > On Tue, Oct 09, 2018 at 05:26:26PM +0200, Jann Horn wrote:
> > > > > On Tue, Oct 9, 2018 at 4:09 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > On Tue, Oct 09, 2018 at 03:50:53PM +0200, Jann Horn wrote:
> > > > > > > On Tue, Oct 9, 2018 at 3:49 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > > > On Tue, Oct 09, 2018 at 03:36:04PM +0200, Jann Horn wrote:
> > > > > > > > > On Tue, Oct 9, 2018 at 3:29 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > > > > > One more thing. Citing from [1]
> > > > > > > > > >
> > > > > > > > > > > I think there's a security problem here. Imagine the following scenario:
> > > > > > > > > > >
> > > > > > > > > > > 1. task A (uid==0) sets up a seccomp filter that uses SECCOMP_RET_USER_NOTIF
> > > > > > > > > > > 2. task A forks off a child B
> > > > > > > > > > > 3. task B uses setuid(1) to drop its privileges
> > > > > > > > > > > 4. task B becomes dumpable again, either via prctl(PR_SET_DUMPABLE, 1)
> > > > > > > > > > > or via execve()
> > > > > > > > > > > 5. task C (the attacker, uid==1) attaches to task B via ptrace
> > > > > > > > > > > 6. task C uses PTRACE_SECCOMP_NEW_LISTENER on task B
> > > > > > > > > >
> > > > > > > > > > Sorry, to be late to the party but would this really pass
> > > > > > > > > > __ptrace_may_access() in ptrace_attach()? It doesn't seem obvious to me
> > > > > > > > > > that it would... Doesn't look like it would get past:
> > > > > > > > > >
> > > > > > > > > >         tcred = __task_cred(task);
> > > > > > > > > >         if (uid_eq(caller_uid, tcred->euid) &&
> > > > > > > > > >             uid_eq(caller_uid, tcred->suid) &&
> > > > > > > > > >             uid_eq(caller_uid, tcred->uid)  &&
> > > > > > > > > >             gid_eq(caller_gid, tcred->egid) &&
> > > > > > > > > >             gid_eq(caller_gid, tcred->sgid) &&
> > > > > > > > > >             gid_eq(caller_gid, tcred->gid))
> > > > > > > > > >                 goto ok;
> > > > > > > > > >         if (ptrace_has_cap(tcred->user_ns, mode))
> > > > > > > > > >                 goto ok;
> > > > > > > > > >         rcu_read_unlock();
> > > > > > > > > >         return -EPERM;
> > > > > > > > > > ok:
> > > > > > > > > >         rcu_read_unlock();
> > > > > > > > > >         mm = task->mm;
> > > > > > > > > >         if (mm &&
> > > > > > > > > >             ((get_dumpable(mm) != SUID_DUMP_USER) &&
> > > > > > > > > >              !ptrace_has_cap(mm->user_ns, mode)))
> > > > > > > > > >             return -EPERM;
> > > > > > > > >
> > > > > > > > > Which specific check would prevent task C from attaching to task B? If
> > > > > > > > > the UIDs match, the first "goto ok" executes; and you're dumpable, so
> > > > > > > > > you don't trigger the second "return -EPERM".
> > > > > > > >
> > > > > > > > You'd also need CAP_SYS_PTRACE in the mm->user_ns which you shouldn't
> > > > > > > > have if you did a setuid to an unpriv user. (But I always find that code
> > > > > > > > confusing.)
> > > > > > >
> > > > > > > Only if the target hasn't gone through execve() since setuid().
> > > > > >
> > > > > > Sorry if I want to know this in excessive detail but I'd like to
> > > > > > understand this properly so bear with me :)
> > > > > > - If task B has setuid()ed and prctl(PR_SET_DUMPABLE, 1)ed but not
> > > > > >   execve()ed then C won't pass ptrace_has_cap(mm->user_ns, mode).
> > > > >
> > > > > Yeah.
> > > > >
> > > > > > - If task B has setuid()ed, exeved()ed it will get its dumpable flag set
> > > > > >   to /proc/sys/fs/suid_dumpable
> > > > >
> > > > > Not if you changed all UIDs (e.g. by calling setuid() as root). In
> > > > > that case, setup_new_exec() calls "set_dumpable(current->mm,
> > > > > SUID_DUMP_USER)".
> > > >
> > > > Actually, looking at this when C is trying to PTRACE_ATTACH to B as an
> > > > unprivileged user even if B execve()ed and it is dumpable C still
> > > > wouldn't have CAP_SYS_PTRACE in the mm->user_ns unless it already is
> > > > privileged over mm->user_ns which means it must be in an ancestor
> > > > user_ns.
> > >
> > > Huh? Why would you need CAP_SYS_PTRACE for anything here? You can
> > > ptrace another process running under your UID just fine, no matter
> > > what the namespaces are. I'm not sure what you're saying.
> >
> > Sorry, I was out the door yesterday when answering this and was too
> > brief. I forgot to mention: /proc/sys/kernel/yama/ptrace_scope. It
> > should be enabled by default on nearly all distros
> 
> "nearly all distros"? AFAIK it's off on Debian, for starters. And Yama
> still doesn't help you if one of the tasks enters a new user namespace
> or whatever.
> 
> Yama is a little bit of extra, heuristic, **opt-in** hardening enabled
> in some configurations. It is **not** a fundamental building block you
> can rely on.
> 
> > and even if not -
> > which is an administrators choice - you can usually easily enable it via
> > sysctl.
> 
> Opt-in security isn't good enough. Kernel interfaces should still be
> safe to use even on a system that has all the LSM stuff disabled in
> the kernel config.

Then ptrace() isn't, I guess?

But see https://lists.linuxfoundation.org/pipermail/containers/2018-October/039567.html
I don't care as long as we have a way of getting the fd without the
CAP_SYS_ADMIN requirement throught seccomp().

> 
> > 1 ("restricted ptrace") [default value]
> > When  performing an operation that requires a PTRACE_MODE_ATTACH check,
> > the calling process must either have the CAP_SYS_PTRACE capability in
> > the user namespace of the target process or it must have a prede‐ fined
> > relationship with the target process.  By default, the predefined
> > relationship is that the target process must be a descendant of the
> > caller.
> >
> > If you don't have it set you're already susceptible to all kinds of
> > other attacks
> 
> Oh? Can you be more specific, please?

I was referring to attacks where you attach to processes that run as
your user but might expose in-memory credentials or other sensitive
information, (essentially what the manpage is outlining).

> 
> > and I'm still not convinced we need to bring out the big
> > capable(CAP_SYS_ADMIN) gun here.
