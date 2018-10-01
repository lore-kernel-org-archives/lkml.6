Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F09C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C6F2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rjx00+7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C6F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeJAQuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:50:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38378 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbeJAQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:50:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id u197-v6so10693987oif.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjrNI957PmoW1+8QQ4lupBn1kFO7oVVRQ7oQrhPWpPg=;
        b=Rjx00+7gwh1Fgvn5bLUGSEa3X/VDoVdyo5rnEaM2CVgBT9V7ARy4wx3UZevmYQfX6+
         K3XT/+CkuYCQAw72vlVeju2Z2vwKBubpzdkn0OWAkENRtqfvypVUCbRJf6k+3QWoD4+q
         h2wX0O//uqCC6Me+TCig5rBpxWVojXroCPY2hVIweFT34tHWVc/d1lsqzp5M+NAj0O/M
         ZkvXvW1aCTGz4ks3kk0NMs8dvUTDolhY2swk7cDVcrxpyd0/Qs6mz1t64aqgbb8rpbJM
         Z8IIbREoEdIr35uYfa6UnEFSHYwV7Orlx0UG+Q8rE82jdWHbOmFHy5e8U+415We6vtbC
         vRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjrNI957PmoW1+8QQ4lupBn1kFO7oVVRQ7oQrhPWpPg=;
        b=UN21eka8cxL7GzC/x4F87oR+HxNmns4AbS6bsEtPcNxTfr+LUC1ugQW2x2Gi2gsZX6
         QtVSep09+7otlyQah2qWmOox8N9Tl4pHsKi3LsDsSFt9RJDJGdUbINXDnj0nCSRlHPHP
         Dh8q1RaEOMDQD5wViN73Lra4xw+AyQqCCeIluQt5QsbszNtBlaLkO33ls17th3RJDMAJ
         zL7yjWau59MRX3H+6VlNYTM7tO+xYq5ysifIEIGiOO+S5LhM/ubIc4lCwDonZpIxoGR3
         KzMNiM3JhzDJl1RMiLI1ByrNxlb5Bt5C74PBPt2yKPP5PcVk282Hiu2Cackw3GGshS77
         qUtg==
X-Gm-Message-State: ABuFfoj6ZwVsIxSFal4uIHKlJkPEYD862f+ueIcQNEEOloZ8oLmAat1v
        fQEFbLbe6vEQ4qe0WtXPbAn9hs2EZy6m/7xghrwHoWYODOHQHpqnT3/QMvp4Hj69n7ZNxyBTYMF
        g7brf1+zrZ0q4ft92loeJMqRq3wDohSs=
X-Google-Smtp-Source: ACcGV60zNrFR+Ls6/ZvcJV1SE7h7WhDBiMGYBSRQRFLjLc7A7/WXpsxxxWytW3cXZwKIi2s2N+z1Cn97dHapgPtbc0c=
X-Received: by 2002:aca:c444:: with SMTP id u65-v6mr4888467oif.8.1538388826845;
 Mon, 01 Oct 2018 03:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180929103453.12025-1-cyphar@cyphar.com> <20180929131534.24472-1-cyphar@cyphar.com>
 <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com> <20181001054246.gfinmx3api7kjhmc@ryuk>
In-Reply-To: <20181001054246.gfinmx3api7kjhmc@ryuk>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 1 Oct 2018 12:13:19 +0200
Message-ID: <CAG48ez3ApZC5cGzTxyt1ej0CyhYPD4PUEf5nbkqPmNbO+daOXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
To:     cyphar@cyphar.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     jlayton@kernel.org, Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 7:44 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-09-29, Jann Horn <jannh@google.com> wrote:
> > The problem is what happens if a folder you are walking through is
> > concurrently moved out of the chroot. Consider the following scenario:
> >
> > You attempt to open "C/../../etc/passwd" under the root "/A/B".
> > Something else concurrently moves /A/B/C to /A/C. This can result in
> > the following:
> >
> > 1. You start the path walk and reach /A/B/C.
> > 2. The other process moves /A/B/C to /A/C. Your path walk is now at /A/C.
> > 3. Your path walk follows the first ".." up into /A. This is outside
> > the process root, but you never actually encountered the process root,
> > so you don't notice.
> > 4. Your path walk follows the second ".." up to /. Again, this is
> > outside the process root, but you don't notice.
> > 5. Your path walk walks down to /etc/passwd, and the open completes
> > successfully. You now have an fd pointing outside your chroot.
> >
> > If the root of your walk is below an attacker-controlled directory,
> > this of course means that you lose instantly. If you point the root of
> > the walk at a directory out of which a process in the container
> > wouldn't be able to move the file, you're probably kinda mostly fine -
> > as long as you know, for certain, that nothing else on the system
> > would ever do that. But I still wouldn't feel good about that.
>
> Please correct me if I'm wrong here (this is the first patch I've
> written for VFS). Isn't the retry/LOOKUP_REVAL code meant to handle this
> -- or does that only handle if a particular path component changes
> *while* it's being walked through?

Eric Biederman should be able to talk about all this much better than
me, but as far as I know, the LOOKUP_REVAL path is only for dealing
with some special filesystems like procfs.

> Is it possible for a path walk to
> succeed after a path component was unmounted (obviously you can't delete
> a directory path component since you'd get -ENOTEMPTY)?

I don't think so, but I'm not exactly a VFS expert.

> If this is an issue for AT_THIS_ROOT, I believe this might also be an
> issue for AT_BENEATH since they are effectively both using the same
> nd->root trick (so you could similarly trick AT_BENEATH to not error
> out). So we'd need to figure out how to solve this problem in order for
> AT_BENEATH to be safe.

Oh, wait, what? I think I didn't notice that the semantics of
AT_BENEATH changed like that since the original posting of David
Drysdale's O_BENEATH_ONLY patch
(https://lore.kernel.org/lkml/1439458366-8223-2-git-send-email-drysdale@google.com/).
David's patch had nice, straightforward semantics, blocking any form
of upwards traversal. Why was that changed? Does anyone actually want
to use paths that contain ".." with AT_BENEATH? I would strongly
prefer something that blocks any use of "..".

@Al: It looks like this already changed back when you posted
https://lore.kernel.org/lkml/20170429220414.GT29622@ZenIV.linux.org.uk/
?

> Speaking naively, doesn't it make sense to invalidate the walk if a path
> component was modified? Or is this something that would be far too
> costly with little benefit? What if we do more aggressive nd->root
> checks when resolving with AT_BENEATH or AT_THIS_ROOT (or if nd->root !=
> current->mnt_ns->root)?

It seems to me like doing that would basically require looking at each
node in the path walk twice? And it'd be difficult to guarantee
forward progress unless you're willing to do some fairly heavy
locking.

> Regarding chroot attacks, I was aware of the trivial
> chroot-open-chroot-fchdir attack but I was not aware that there was a
> rename attack for chroot. Thanks for bringing this up!
>
> > I believe that the only way to robustly use this would be to point the
> > dirfd at a mount point, such that you know that being moved out of the
> > chroot is impossible because the mount point limits movement of
> > directories under it. (Well, technically, it doesn't, but it ensures
> > that if a directory does dangerously move away, the syscall fails.) It
> > might make sense to hardcode this constraint in the implementation of
> > AT_THIS_ROOT, to keep people from shooting themselves in the foot.
>
> Unless I'm missing something, would this not also affect using a
> mountpoint as a dirfd-root (with MS_MOVE of an already-walked-through
> path component) -- or does MS_MOVE cause a rewalk in a way that rename
> does not?

Hmm. Good point.

It looks to me like you probably wouldn't be able to walk up through a
mountpoint in RCU mode after the mount hierarchy has changed (see
follow_dotdot_rcu()), but it might work in refwalk mode.

Eric?

> I wouldn't mind tying AT_THIS_ROOT to only work on mountpoints (I
> thought that bind-mounts would be an issue but you also get -EXDEV when
> trying to rename across bind-mounts even if they are on the same
> underlying filesystem). But AT_BENEATH might be a more bitter pill to
> swallow. I'm not sure.

Which is part of why I strongly prefer the semantics from David
Drysdale's O_BENEATH_ONLY.

> In the usecase of container runtimes, we wouldn't generally be doing
> resolution of attacker-controlled paths but it still definitely doesn't
> hurt to consider this part of the threat model -- to avoid foot-gunning
> as you've said. (There also might be some nested-container cases where
> you might want to do that.)
>
> > > Currently most container runtimes try to do this resolution in
> > > userspace[1], causing many potential race conditions. In addition, the
> > > "obvious" alternative (actually performing a {ch,pivot_}root(2))
> > > requires a fork+exec which is *very* costly if necessary for every
> > > filesystem operation involving a container.
> >
> > Wait. fork() I understand, but why exec? And actually, you don't need
> > a full fork() either, clone() lets you do this with some process parts
> > shared. And then you also shouldn't need to use SCM_RIGHTS, just keep
> > the file descriptor table shared. And why chroot()/pivot_root(),
> > wouldn't you want to use setns()?
>
> You're right about this -- for C runtimes. In Go we cannot do a raw
> clone() or fork() (if you do it manually with RawSyscall you'll end with
> broken runtime state). So you're forced to do fork+exec (which then
> means that you can't use CLONE_FILES and must use SCM_RIGHTS). Same goes
> for CLONE_VFORK.

If you insist on implementing every last bit of your code in Go, I guess.

> (It should be noted that multi-threaded C runtimes have somewhat similar
> issues -- AFAIK you can technically only use AS-Safe glibc functions
> after a fork() but that's more of a theoretical concern here. If you
> just use raw syscalls there isn't an issue.)
>
> As for why use setns() rather than pivot_root(), there are cases where
> you're operating on a container's image without a running container
> (think image extraction or snapshotting tools). In those cases, you
> would need to set up a dummy container process in order to setns() into
> its namespaces. You are right that setns() would be a better option if
> you want the truthful state of what mounts the container sees.
>
> [I also don't like the idea of joining the user namespace of a malicious
> container unless it's necessary but that's probably just needless
> paranoia more than anything -- since you're not joining the pidns you
> aren't trivially addressable by a malicious container.]
>
> > // Ensure that we are non-dumpable. Together with
> > // commit bfedb589252c, this ensures that container root
> > // can't trace our child once it enters the container.
> > // My patch
> > // https://lore.kernel.org/lkml/1451098351-8917-1-git-send-email-jann@thejh.net/
> > // would make this unnecessary, but that patch didn't
> > // land because Eric nacked it (for political reasons,
> > // because people incorrectly claimed that this was a
> > // security fix):
>
> Unless I'm very much mistaken this was fixed by bfedb589252c ("mm: Add a
> user_ns owner to mm_struct and fix ptrace permission checks"). If you
> join a user namespace then processes within that user namespace won't
> have ptrace_may_access() permissions because your mm is owned by an
> ancestor user namespace -- only after exec() will you be traceable.

Nope. The code added in bfedb589252c only applies if `get_dumpable(mm)
!= SUID_DUMP_USER`.

Looking at the current version, you can see that
`ptrace_has_cap(tcred->user_ns, mode)` is enough to ptrace a process
that is not nondumpable.

> We still use PR_SET_DUMPABLE in runc but that's because we support older
> kernels (and people don't use user namespaces under Docker) but with
> user namespaces this should not be required anymore.
