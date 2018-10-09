Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C929CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E78214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezTuF0aA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E78214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJIXo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:44:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46419 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIXo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:44:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id o21so2247191otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whg6ewkYniyV6HAKiVc8/3Z0EKakuoHttAUFhDfk8ZI=;
        b=ezTuF0aAYVz+gybDq6QJGX+MpuCNJoJpqO/tuRPzVbK4cBQ/qyqECcQsJvmeZfX6kx
         Y+6wGvnyToSSGHS4s2/Ku5jc13x+DVpQcAWaciMK3QFIq71lOyrNKpkf9DJTkjA79NGH
         wG1yQ9240+Ol6AB4vJk44pjKt3XsVED8brNe/UJzLRayCrd4T5P/vDqkEOGJMyVNs4aF
         ccA7qiBfNRptrz2xXeqDFrEY8wrs91NvCNfAJD/Xx4iQAvN+7dy62dwCshug4yjhpgst
         vo5qVrfV2wQ4Xwgt8iH0Zf8PMiSJoED4HKcAH0zNYMmkXYMYBGeoTR8QeR3JhWOB+ts+
         DspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whg6ewkYniyV6HAKiVc8/3Z0EKakuoHttAUFhDfk8ZI=;
        b=sk5MZlzrRmwUtXDhKI1ze1n4By4GodGtyi74hnHFZAboNNEWeL01zBhSF3i0GZ7BWz
         X67732BZZK4EZns6Kyh2tkAz7GIwZTbp7pa6VsnDORqevaRk3Jg+T9dnakexUdSzCsfw
         nlz1aqMWaMHa4Z+I/hnTKKzO1GH+yCFEDOxHpa92urnnDYeCw+Z4Ih9kjrGjMAfIVhbs
         9hMeMGPKzyTFlnfUm4WX0MTtC9lgwJQqg92b138OqvTDz3f1PkZb3hMb/wa1ddv6oMSZ
         uZAeE523HyKuiavwCD7y9c1jdz3FskRaUW48zAy/c5BNIZueNWVG3Yde1JP7WsGj3EkZ
         aX5Q==
X-Gm-Message-State: ABuFfohgbtwZuniLqwsiS4Myisjt1ENNhtcOTK5r3VlwNQDx6CquCyVK
        GK2HRdncBUM0sIz1ly78T8LqN20ysvBgo3A1WioZMA==
X-Google-Smtp-Source: ACcGV61095dHsPiDP8asA/3AK/Le8YQaF7/H9V5hdrQRj0LFYCdO2L5CAgJ4CR7U2pqrQmsQK/qdcjxFX0+bTXwRo4A=
X-Received: by 2002:a9d:4917:: with SMTP id e23mr15593210otf.73.1539102434276;
 Tue, 09 Oct 2018 09:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181008162147.ubfxxsv2425l2zsp@brauner.io> <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io> <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io> <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <20181009134923.2fvf5roghqgaj5gq@brauner.io> <CAG48ez1hnKkm7mzXuZLP4n6x8K1JqmTwQb-e79oJguTaH1mkUw@mail.gmail.com>
 <20181009140932.e5w5lgbgucbl72kt@brauner.io> <CAG48ez12SYRUJTWRdzWhpvHBkQion4i8Gpef4r1L6epo9JF-ng@mail.gmail.com>
 <20181009162022.d7fd2wibyq6xi6sg@brauner.io>
In-Reply-To: <20181009162022.d7fd2wibyq6xi6sg@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 9 Oct 2018 18:26:47 +0200
Message-ID: <CAG48ez2ROhq4R1az2TXNmBvCXY=3UVxnmh6CeR05N0xVGrpwpA@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 6:20 PM Christian Brauner <christian@brauner.io> wrote:
> On Tue, Oct 09, 2018 at 05:26:26PM +0200, Jann Horn wrote:
> > On Tue, Oct 9, 2018 at 4:09 PM Christian Brauner <christian@brauner.io> wrote:
> > > On Tue, Oct 09, 2018 at 03:50:53PM +0200, Jann Horn wrote:
> > > > On Tue, Oct 9, 2018 at 3:49 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > On Tue, Oct 09, 2018 at 03:36:04PM +0200, Jann Horn wrote:
> > > > > > On Tue, Oct 9, 2018 at 3:29 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > > One more thing. Citing from [1]
> > > > > > >
> > > > > > > > I think there's a security problem here. Imagine the following scenario:
> > > > > > > >
> > > > > > > > 1. task A (uid==0) sets up a seccomp filter that uses SECCOMP_RET_USER_NOTIF
> > > > > > > > 2. task A forks off a child B
> > > > > > > > 3. task B uses setuid(1) to drop its privileges
> > > > > > > > 4. task B becomes dumpable again, either via prctl(PR_SET_DUMPABLE, 1)
> > > > > > > > or via execve()
> > > > > > > > 5. task C (the attacker, uid==1) attaches to task B via ptrace
> > > > > > > > 6. task C uses PTRACE_SECCOMP_NEW_LISTENER on task B
> > > > > > >
> > > > > > > Sorry, to be late to the party but would this really pass
> > > > > > > __ptrace_may_access() in ptrace_attach()? It doesn't seem obvious to me
> > > > > > > that it would... Doesn't look like it would get past:
> > > > > > >
> > > > > > >         tcred = __task_cred(task);
> > > > > > >         if (uid_eq(caller_uid, tcred->euid) &&
> > > > > > >             uid_eq(caller_uid, tcred->suid) &&
> > > > > > >             uid_eq(caller_uid, tcred->uid)  &&
> > > > > > >             gid_eq(caller_gid, tcred->egid) &&
> > > > > > >             gid_eq(caller_gid, tcred->sgid) &&
> > > > > > >             gid_eq(caller_gid, tcred->gid))
> > > > > > >                 goto ok;
> > > > > > >         if (ptrace_has_cap(tcred->user_ns, mode))
> > > > > > >                 goto ok;
> > > > > > >         rcu_read_unlock();
> > > > > > >         return -EPERM;
> > > > > > > ok:
> > > > > > >         rcu_read_unlock();
> > > > > > >         mm = task->mm;
> > > > > > >         if (mm &&
> > > > > > >             ((get_dumpable(mm) != SUID_DUMP_USER) &&
> > > > > > >              !ptrace_has_cap(mm->user_ns, mode)))
> > > > > > >             return -EPERM;
> > > > > >
> > > > > > Which specific check would prevent task C from attaching to task B? If
> > > > > > the UIDs match, the first "goto ok" executes; and you're dumpable, so
> > > > > > you don't trigger the second "return -EPERM".
> > > > >
> > > > > You'd also need CAP_SYS_PTRACE in the mm->user_ns which you shouldn't
> > > > > have if you did a setuid to an unpriv user. (But I always find that code
> > > > > confusing.)
> > > >
> > > > Only if the target hasn't gone through execve() since setuid().
> > >
> > > Sorry if I want to know this in excessive detail but I'd like to
> > > understand this properly so bear with me :)
> > > - If task B has setuid()ed and prctl(PR_SET_DUMPABLE, 1)ed but not
> > >   execve()ed then C won't pass ptrace_has_cap(mm->user_ns, mode).
> >
> > Yeah.
> >
> > > - If task B has setuid()ed, exeved()ed it will get its dumpable flag set
> > >   to /proc/sys/fs/suid_dumpable
> >
> > Not if you changed all UIDs (e.g. by calling setuid() as root). In
> > that case, setup_new_exec() calls "set_dumpable(current->mm,
> > SUID_DUMP_USER)".
>
> Actually, looking at this when C is trying to PTRACE_ATTACH to B as an
> unprivileged user even if B execve()ed and it is dumpable C still
> wouldn't have CAP_SYS_PTRACE in the mm->user_ns unless it already is
> privileged over mm->user_ns which means it must be in an ancestor
> user_ns.

Huh? Why would you need CAP_SYS_PTRACE for anything here? You can
ptrace another process running under your UID just fine, no matter
what the namespaces are. I'm not sure what you're saying.
