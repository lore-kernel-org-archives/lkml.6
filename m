Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401FAECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA88521473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="aeVMLmt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA88521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJGEyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:54:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42152 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeJGEyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:54:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id y71-v6so14601598lje.9
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p7Jmrd88GmEufUjHC+0kTwst8h+qXFIOgp3IHcLykWE=;
        b=aeVMLmt+qsMjjB2N1dAjzU7d6RQlUeB8kN4vF9rqQD/yz2KP84RobIFhywzsvXVBa4
         jJwnvHKqBWAUjPXfgk7jcbdjCnKjoR1FBLWhDpSfw8sseIYerKGjmh1doC5G0ZjB964P
         yuP1XzxKrUJQmzEuvhjTHZ5ualA0uM7cLnVeLkNhm24zY6VLfwCV82xge3zLjMgkfrcu
         4V4rsQGPljJG06n6zRm2iOxtB9wZvq7TosR/5HRg1du27NPcwGP4VcE/QmpMGqUbZe7U
         FqsBZyMCK7LopuX1Gj0gTFeFPzFbY6+lwdhHbG2Fx7hyDvlivwj6dzLrb/Xhb6LkxYgV
         riqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p7Jmrd88GmEufUjHC+0kTwst8h+qXFIOgp3IHcLykWE=;
        b=FKUeCokS9OvhURjQoN/L9xVB9qRbviN+pFrAFgAxb6N1PvOaMKx5rC//2wYvLae+zF
         Z3f/k5FyVUtjuLZlsWuCMWGPLlU076SfmcmZmf4V8fiZo6ngfJyIgNADHooYi9GRA8uE
         M47uvb7L1snk2ubWEQTmwmJAsMUH4tIXg6tO2xOL9t6pc1VMEDvvs2eoe18lp6Mt0RGa
         r/8ylzwruHaptBnTozrGGCHinAoet+ztw7VhLImohI/Pa4SfnNFKVi+AIz3SCe8vWaKo
         1XnZUnseBuJIHShUNpnfkdxIJ78edDzHDv2YdFyCoatcLYZOJ1lcKbfFrJC39piy/Iex
         XgvA==
X-Gm-Message-State: ABuFfogjmwULmr8qffX/PuZVwMXEaIm+otrVORIq5XcvCoAaUWpXGJN8
        SL+qjbmOEfYt5eZFr0GK1DOgdSf9dnYJWF0FYoyNfg==
X-Google-Smtp-Source: ACcGV61OaXSTjE6GlyUz2H0uH9y+nBJ9zZmz0eCOoT5LcZfrUmAnAiqKdw6mK3WVLH9iuLlz3BZGb5pLDMfEg9dqREg=
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr10512552ljd.129.1538862568291;
 Sat, 06 Oct 2018 14:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180929103453.12025-1-cyphar@cyphar.com> <20180929131534.24472-1-cyphar@cyphar.com>
 <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
 <20181001054246.gfinmx3api7kjhmc@ryuk> <C89D720F-3CC4-4FA9-9CBB-E41A67360A6B@amacapital.net>
 <20181002073220.7mzndna4tdnxdvdt@ryuk> <875zyeg5fs.fsf@mid.deneb.enyo.de>
In-Reply-To: <875zyeg5fs.fsf@mid.deneb.enyo.de>
From:   Christian Brauner <christian@brauner.io>
Date:   Sat, 6 Oct 2018 23:49:17 +0200
Message-ID: <CAHrFyr7213j+dEuKvSg9HFRMec3VK7hubJXCpQrWN+erTJ9hWw@mail.gmail.com>
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
To:     fw@deneb.enyo.de
Cc:     Aleksa Sarai <cyphar@cyphar.com>, luto@amacapital.net,
        Jann Horn <jannh@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev <dev@opencontainers.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 10:56 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Aleksa Sarai:
>
> > On 2018-10-01, Andy Lutomirski <luto@amacapital.net> wrote:
> >> >>> Currently most container runtimes try to do this resolution in
> >> >>> userspace[1], causing many potential race conditions. In addition,=
 the
> >> >>> "obvious" alternative (actually performing a {ch,pivot_}root(2))
> >> >>> requires a fork+exec which is *very* costly if necessary for every
> >> >>> filesystem operation involving a container.
> >> >>
> >> >> Wait. fork() I understand, but why exec? And actually, you don't ne=
ed
> >> >> a full fork() either, clone() lets you do this with some process pa=
rts
> >> >> shared. And then you also shouldn't need to use SCM_RIGHTS, just ke=
ep
> >> >> the file descriptor table shared. And why chroot()/pivot_root(),
> >> >> wouldn't you want to use setns()?
> >> >
> >> > You're right about this -- for C runtimes. In Go we cannot do a raw
> >> > clone() or fork() (if you do it manually with RawSyscall you'll end =
with
> >> > broken runtime state). So you're forced to do fork+exec (which then
> >> > means that you can't use CLONE_FILES and must use SCM_RIGHTS). Same =
goes
> >> > for CLONE_VFORK.
> >>
> >> I must admit that I=E2=80=99m not very sympathetic to the argument tha=
t =E2=80=9CGo=E2=80=99s
> >> runtime model is incompatible with the simpler solution.=E2=80=9D
> >
> > Multi-threaded programs have a similar issue (though with Go it's much
> > worse). If you fork a multi-threaded C program then you can only safely
> > use AS-Safe glibc functions (those that are safe within a signal
> > handler). But if you're just doing three syscalls this shouldn't be as
> > big of a problem as Go where you can't even do said syscalls.
>
> The situation is a bit more complicated.  There are many programs out
> there which use malloc and free (at least indirectly) after a fork,
> and we cannot break them.  In glibc, we have a couple of subsystems
> which are put into a known state before calling the fork/clone system
> call if the application calls fork.  The price we pay for that is a
> fork which is not POSIX-compliant because it is not async-signal-safe.
> Admittedly, other libcs chose different trade-offs.
>
> However, what is the same across libcs is this: You cannot call the
> clone system call directly and get a fully working new process.  Some
> things break.  For example, for recursive mutexes, we need to know the
> TID of the current thread, and we cannot perform a system call to get
> it for performance reasons.  So everyone has a TID cache for that.
> But the TID cache does not get reset when you bypass the fork
> implementation in libc, so you end up with subtle corruption bugs on
> TID reuse.

Sure, but recursive mutexes etc. are very specific use-case.
I'd even go so far to say that if you use mutexes + threads and then
also fork in those threads you're hosed anyway. If you don't things get a l=
ittle
cleaner assuming you don't call library functions that use mutexes
internally.
Event then you might (sometimes at least) still get around most problems
with atfork handlers (thought I really don't like him). But you know more
about this then I do. :)

>
> So I'd say that in most cases, the C situation is pretty much the same
> as the Go situation.  If I recall correctly, the problem for Go is
> that it cannot call setns from Go code because it fails in the kernel
> for multi-threaded processes, and Go processes are already
> multi-threaded when user Go code runs.

That is true for *some* namespaces (user, mount) but not for all.
For example, setns(CLONE_NEWNET) would be fine from go.
But the go runtime thinks it's clever to clone a new thread in between
entry and exit of a syscall. If you switch namespaces you might end
up with a new thread that belongs to the wrong namespace which is
very problematic.
So you can either rely on calling some go magic that locks
you to a specific os thread but that does only work in later go versions or
you go the constructor route, i.e. you e.g. implement a (dummy)
subcommand that you can call and that triggers the execution of a
C function that is marked with __attribute__((constructor)) that runs
before the go runtime and in which you can do setns(), fork() and
friends (somewhat) safely. This has very
bad performance and is a nasty hack but it's really unavoidable.
