Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAFDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569B721479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZm7d/8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569B721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeJJUcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:32:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36035 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJJUcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:32:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id x4so3866777otg.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IJW5UZ/gWXBa+phmhn5Fy/gAvtsD4FHOJFLxsnscEj4=;
        b=WZm7d/8YH2bTXIOuX/U4y9UPZtg+xlp9Q6X/vUFNYPsbebEXSS7apcAhsH2c4pLrCV
         /dwQRPmGCz0TkApjIFug//pDaDEJYRTf75hhlf3DVb/YcsSbtgcF5s4o5OSEoPT9uBUe
         0SK2RJ7OAp0WVTUDOQhzoOl1GSZeVTKKAZepP5/HUWko56rkTZvTCmqqG5FrxoBZ9934
         xZZLb5PdcieJbg1UcqZAmkUoytF9xZ9cctWpercJrw1V8XaXVirNCC+g+JY+YFeeUkra
         OYCPk+I3YKvNV1hvrbMzp0COIl1Z3DA9weQmqENKCQea8GNAgH/UCZa3Co0w0hD4J4dr
         tTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IJW5UZ/gWXBa+phmhn5Fy/gAvtsD4FHOJFLxsnscEj4=;
        b=MpbEOSVToTRH0V4Juaj0zSvNKM5sWbteqlJ29NBVu0JaGUFnY9UYMDZcchNZBFOY6t
         jAyxfTBXfVN6WwAmTuId2n5oPwWVxFXCoknT8XuhEb7ic8EowsCBsBu/E8uRtFdcDdRY
         Y4JT/q/z4hCFKQLjf0NV5sHEs8hsoR2axj1OiLICA7d+pfAqDlKZmt4hrbgDQfJD2lOX
         mIEpgFfpYvA1p5t87Ia0Oi/Vuq2hLay1vmmhkDTOZYSXJIjBw8AnpaLUeLPTvWURXq6/
         CNKAO8E4f3IsROGEXy5rjIJRYY1EcrOlNcR5dij7ozg5luDEks6kewVuiuzd+FLRpNXz
         gGlA==
X-Gm-Message-State: ABuFfog6JBI1TxjBD9wic28u6ZrozvXd833NT/malD9b+ceVXN4cVih1
        sJSOgtmPFLcJrmoId/12KV0UAdkyzQAH2e8i0Euqbg==
X-Google-Smtp-Source: ACcGV63vT9nIb6XxW/Yy2W03+maIknGI/t9fLpLv4zq19nxMBcND4CMs9LTaGK7yQUfHx3ROu1WXeSJc3hbgjP9Rggw=
X-Received: by 2002:a9d:5733:: with SMTP id p48mr18703394oth.292.1539177038482;
 Wed, 10 Oct 2018 06:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181008181815.pwnqxngj22mhm2vj@brauner.io> <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io> <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <20181009134923.2fvf5roghqgaj5gq@brauner.io> <CAG48ez1hnKkm7mzXuZLP4n6x8K1JqmTwQb-e79oJguTaH1mkUw@mail.gmail.com>
 <20181009140932.e5w5lgbgucbl72kt@brauner.io> <CAG48ez12SYRUJTWRdzWhpvHBkQion4i8Gpef4r1L6epo9JF-ng@mail.gmail.com>
 <20181009162022.d7fd2wibyq6xi6sg@brauner.io> <CAG48ez2ROhq4R1az2TXNmBvCXY=3UVxnmh6CeR05N0xVGrpwpA@mail.gmail.com>
 <20181010125422.rouslofknxzvygzr@brauner.io>
In-Reply-To: <20181010125422.rouslofknxzvygzr@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 10 Oct 2018 15:10:11 +0200
Message-ID: <CAG48ez0ct7_i1U0=vr1Z=4WhVH7GQKFzhtuxR+1oknmPiDTqKg@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
To:     christian@brauner.io
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 2:54 PM Christian Brauner <christian@brauner.io> wr=
ote:
> On Tue, Oct 09, 2018 at 06:26:47PM +0200, Jann Horn wrote:
> > On Tue, Oct 9, 2018 at 6:20 PM Christian Brauner <christian@brauner.io>=
 wrote:
> > > On Tue, Oct 09, 2018 at 05:26:26PM +0200, Jann Horn wrote:
> > > > On Tue, Oct 9, 2018 at 4:09 PM Christian Brauner <christian@brauner=
.io> wrote:
> > > > > On Tue, Oct 09, 2018 at 03:50:53PM +0200, Jann Horn wrote:
> > > > > > On Tue, Oct 9, 2018 at 3:49 PM Christian Brauner <christian@bra=
uner.io> wrote:
> > > > > > > On Tue, Oct 09, 2018 at 03:36:04PM +0200, Jann Horn wrote:
> > > > > > > > On Tue, Oct 9, 2018 at 3:29 PM Christian Brauner <christian=
@brauner.io> wrote:
> > > > > > > > > One more thing. Citing from [1]
> > > > > > > > >
> > > > > > > > > > I think there's a security problem here. Imagine the fo=
llowing scenario:
> > > > > > > > > >
> > > > > > > > > > 1. task A (uid=3D=3D0) sets up a seccomp filter that us=
es SECCOMP_RET_USER_NOTIF
> > > > > > > > > > 2. task A forks off a child B
> > > > > > > > > > 3. task B uses setuid(1) to drop its privileges
> > > > > > > > > > 4. task B becomes dumpable again, either via prctl(PR_S=
ET_DUMPABLE, 1)
> > > > > > > > > > or via execve()
> > > > > > > > > > 5. task C (the attacker, uid=3D=3D1) attaches to task B=
 via ptrace
> > > > > > > > > > 6. task C uses PTRACE_SECCOMP_NEW_LISTENER on task B
> > > > > > > > >
> > > > > > > > > Sorry, to be late to the party but would this really pass
> > > > > > > > > __ptrace_may_access() in ptrace_attach()? It doesn't seem=
 obvious to me
> > > > > > > > > that it would... Doesn't look like it would get past:
> > > > > > > > >
> > > > > > > > >         tcred =3D __task_cred(task);
> > > > > > > > >         if (uid_eq(caller_uid, tcred->euid) &&
> > > > > > > > >             uid_eq(caller_uid, tcred->suid) &&
> > > > > > > > >             uid_eq(caller_uid, tcred->uid)  &&
> > > > > > > > >             gid_eq(caller_gid, tcred->egid) &&
> > > > > > > > >             gid_eq(caller_gid, tcred->sgid) &&
> > > > > > > > >             gid_eq(caller_gid, tcred->gid))
> > > > > > > > >                 goto ok;
> > > > > > > > >         if (ptrace_has_cap(tcred->user_ns, mode))
> > > > > > > > >                 goto ok;
> > > > > > > > >         rcu_read_unlock();
> > > > > > > > >         return -EPERM;
> > > > > > > > > ok:
> > > > > > > > >         rcu_read_unlock();
> > > > > > > > >         mm =3D task->mm;
> > > > > > > > >         if (mm &&
> > > > > > > > >             ((get_dumpable(mm) !=3D SUID_DUMP_USER) &&
> > > > > > > > >              !ptrace_has_cap(mm->user_ns, mode)))
> > > > > > > > >             return -EPERM;
> > > > > > > >
> > > > > > > > Which specific check would prevent task C from attaching to=
 task B? If
> > > > > > > > the UIDs match, the first "goto ok" executes; and you're du=
mpable, so
> > > > > > > > you don't trigger the second "return -EPERM".
> > > > > > >
> > > > > > > You'd also need CAP_SYS_PTRACE in the mm->user_ns which you s=
houldn't
> > > > > > > have if you did a setuid to an unpriv user. (But I always fin=
d that code
> > > > > > > confusing.)
> > > > > >
> > > > > > Only if the target hasn't gone through execve() since setuid().
> > > > >
> > > > > Sorry if I want to know this in excessive detail but I'd like to
> > > > > understand this properly so bear with me :)
> > > > > - If task B has setuid()ed and prctl(PR_SET_DUMPABLE, 1)ed but no=
t
> > > > >   execve()ed then C won't pass ptrace_has_cap(mm->user_ns, mode).
> > > >
> > > > Yeah.
> > > >
> > > > > - If task B has setuid()ed, exeved()ed it will get its dumpable f=
lag set
> > > > >   to /proc/sys/fs/suid_dumpable
> > > >
> > > > Not if you changed all UIDs (e.g. by calling setuid() as root). In
> > > > that case, setup_new_exec() calls "set_dumpable(current->mm,
> > > > SUID_DUMP_USER)".
> > >
> > > Actually, looking at this when C is trying to PTRACE_ATTACH to B as a=
n
> > > unprivileged user even if B execve()ed and it is dumpable C still
> > > wouldn't have CAP_SYS_PTRACE in the mm->user_ns unless it already is
> > > privileged over mm->user_ns which means it must be in an ancestor
> > > user_ns.
> >
> > Huh? Why would you need CAP_SYS_PTRACE for anything here? You can
> > ptrace another process running under your UID just fine, no matter
> > what the namespaces are. I'm not sure what you're saying.
>
> Sorry, I was out the door yesterday when answering this and was too
> brief. I forgot to mention: /proc/sys/kernel/yama/ptrace_scope. It
> should be enabled by default on nearly all distros

"nearly all distros"? AFAIK it's off on Debian, for starters. And Yama
still doesn't help you if one of the tasks enters a new user namespace
or whatever.

Yama is a little bit of extra, heuristic, **opt-in** hardening enabled
in some configurations. It is **not** a fundamental building block you
can rely on.

> and even if not -
> which is an administrators choice - you can usually easily enable it via
> sysctl.

Opt-in security isn't good enough. Kernel interfaces should still be
safe to use even on a system that has all the LSM stuff disabled in
the kernel config.

> 1 ("restricted ptrace") [default value]
> When  performing an operation that requires a PTRACE_MODE_ATTACH check,
> the calling process must either have the CAP_SYS_PTRACE capability in
> the user namespace of the target process or it must have a prede=E2=80=90=
 fined
> relationship with the target process.  By default, the predefined
> relationship is that the target process must be a descendant of the
> caller.
>
> If you don't have it set you're already susceptible to all kinds of
> other attacks

Oh? Can you be more specific, please?

> and I'm still not convinced we need to bring out the big
> capable(CAP_SYS_ADMIN) gun here.
