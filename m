Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-452929-1519706267-2-12623965985572837529
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519706266; b=jFSF1wSJ1nLikgR6CJyDO35NLqfiCWtcRoBLIIeEbDGEOfS
    /mTfb9OEQi7ZMSdjBeluLBzENuyI7qQtdpBvyYrqzG/zTeM8KOjujF92msUtzSUL
    83HA78ezJVhvz3uk9FL4BB5BkGZ7OO7waRX9S4tV71CuMDTKTEUd2wnqhmIl6Y5T
    tI0DqQqoIr77XEnBcCNwgM5Fa330dH0qBJ7DfiJn3eADN3elDvBUk8B4arlIiDcQ
    B7TyuqDvHZOuc11y7JbRLvfjGJ0J/cd9SaihaGFeUJ76J8skXhYCxXOzEZptF2e/
    +U/eOxcsDg3aVKb3OYntOlHg3vYLCEMV3GIrRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519706266; bh=yvoUsMYcrr65QcbkHfV90rneQRpZ/hzcRXbrj3RnKpE=; b=C
    wMAcpSCuerYpZ2uwzkPoja+Vctqz5BU7VNjZ+kFRz8xoZNMhf8utj5hd2v7sq2MR
    bC1b3eDToyFVIXmfrrzmaGeKzPenAD0qCCrXig4AJN7IyXF8BiEw9n2pTLMVLgV1
    szA8jpKyt8AUy6yxqIcv1SuL1IYijIG5WGxLDWQ3efMY8/9gGd4zmRkixXDhHI+v
    22K8s7or+eIldEOn0vVTsl9LJQnNo3AdlJuB0Mlq1Hx6k9e8zymc7zP4hImBlLRF
    At9IUCxHflaE6kO0RrjLxAGsJT4W5x8cmKa4h79p1asgTmegL1+VjjEoZ6Wk0Jlj
    sAb0Yg0VgYCiJMuoV5tng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=XTeJzoef x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qyBF9m+t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=XTeJzoef x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qyBF9m+t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeB0EhV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:37:21 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:33838 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbeB0EhT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Feb 2018 23:37:19 -0500
X-Google-Smtp-Source: AG47ELtxBrMBf94RSsPbmRwx2xfVrOKDQPG7hDR2NRWYg4wMHFDuWB5DMOi4QBznc2x1o3InWaLiRNrmi+ObDbO7CDc=
MIME-Version: 1.0
In-Reply-To: <20180227004121.3633-1-mic@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 27 Feb 2018 04:36:58 +0000
Message-ID: <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged sandboxing
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 12:41 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net=
> wrote:
> Hi,
>
> This eight series is a major revamp of the Landlock design compared to
> the previous series [1]. This enables more flexibility and granularity
> of access control with file paths. It is now possible to enforce an
> access control according to a file hierarchy. Landlock uses the concept
> of inode and path to identify such hierarchy. In a way, it brings tools
> to program what is a file hierarchy.
>
> There is now three types of Landlock hooks: FS_WALK, FS_PICK and FS_GET.
> Each of them accepts a dedicated eBPF program, called a Landlock
> program.  They can be chained to enforce a full access control according
> to a list of directories or files. The set of actions on a file is well
> defined (e.g. read, write, ioctl, append, lock, mount...) taking
> inspiration from the major Linux LSMs and some other access-controls
> like Capsicum.  These program types are designed to be cache-friendly,
> which give room for optimizations in the future.
>
> The documentation patch contains some kernel documentation and
> explanations on how to use Landlock.  The compiled documentation and
> a talk I gave at FOSDEM can be found here: https://landlock.io
> This patch series can be found in the branch landlock-v8 in this repo:
> https://github.com/landlock-lsm/linux
>
> There is still some minor issues with this patch series but it should
> demonstrate how powerful this design may be. One of these issues is that
> it is not a stackable LSM anymore, but the infrastructure management of
> security blobs should allow to stack it with other LSM [4].
>
> This is the first step of the roadmap discussed at LPC [2].  While the
> intended final goal is to allow unprivileged users to use Landlock, this
> series allows only a process with global CAP_SYS_ADMIN to load and
> enforce a rule.  This may help to get feedback and avoid unexpected
> behaviors.
>
> This series can be applied on top of bpf-next, commit 7d72637eb39f
> ("Merge branch 'x86-jit'").  This can be tested with
> CONFIG_SECCOMP_FILTER and CONFIG_SECURITY_LANDLOCK.  I would really
> appreciate constructive comments on the design and the code.
>
>
> # Landlock LSM
>
> The goal of this new Linux Security Module (LSM) called Landlock is to
> allow any process, including unprivileged ones, to create powerful
> security sandboxes comparable to XNU Sandbox or OpenBSD Pledge. This
> kind of sandbox is expected to help mitigate the security impact of bugs
> or unexpected/malicious behaviors in user-space applications.
>
> The approach taken is to add the minimum amount of code while still
> allowing the user-space application to create quite complex access
> rules.  A dedicated security policy language such as the one used by
> SELinux, AppArmor and other major LSMs involves a lot of code and is
> usually permitted to only a trusted user (i.e. root).  On the contrary,
> eBPF programs already exist and are designed to be safely loaded by
> unprivileged user-space.
>
> This design does not seem too intrusive but is flexible enough to allow
> a powerful sandbox mechanism accessible by any process on Linux. The use
> of seccomp and Landlock is more suitable with the help of a user-space
> library (e.g.  libseccomp) that could help to specify a high-level
> language to express a security policy instead of raw eBPF programs.
> Moreover, thanks to the LLVM front-end, it is quite easy to write an
> eBPF program with a subset of the C language.
>
>
> # Frequently asked questions
>
> ## Why is seccomp-bpf not enough?
>
> A seccomp filter can access only raw syscall arguments (i.e. the
> register values) which means that it is not possible to filter according
> to the value pointed to by an argument, such as a file pathname. As an
> embryonic Landlock version demonstrated, filtering at the syscall level
> is complicated (e.g. need to take care of race conditions). This is
> mainly because the access control checkpoints of the kernel are not at
> this high-level but more underneath, at the LSM-hook level. The LSM
> hooks are designed to handle this kind of checks.  Landlock abstracts
> this approach to leverage the ability of unprivileged users to limit
> themselves.
>
> Cf. section "What it isn't?" in Documentation/prctl/seccomp_filter.txt
>
>
> ## Why use the seccomp(2) syscall?
>
> Landlock use the same semantic as seccomp to apply access rule
> restrictions. It add a new layer of security for the current process
> which is inherited by its children. It makes sense to use an unique
> access-restricting syscall (that should be allowed by seccomp filters)
> which can only drop privileges. Moreover, a Landlock rule could come
> from outside a process (e.g.  passed through a UNIX socket). It is then
> useful to differentiate the creation/load of Landlock eBPF programs via
> bpf(2), from rule enforcement via seccomp(2).

This seems like a weak argument to me.  Sure, this is a bit different
from seccomp(), and maybe shoving it into the seccomp() multiplexer is
awkward, but surely the bpf() multiplexer is even less applicable.

But I think that you have more in common with seccomp() than you're
giving it credit for.  With seccomp, you need to either prevent
ptrace() of any more-privileged task or you need to filter to make
sure you can't trace a more privileged program.  With landlock, you
need exactly the same thing.  You have basically the same no_new_privs
considerations, etc.

Also, looking forward, I think you're going to want a bunch of the
stuff that's under consideration as new seccomp features.  Tycho is
working on a "user notifier" feature for seccomp where, in addition to
accepting, rejecting, or kicking to ptrace, you can send a message to
the creator of the filter and wait for a reply.  I think that Landlock
will want exactly the same feature.

In other words, it really seems to be that you should extend seccomp()
with the ability to attach filters to things that aren't syscall
entry, e.g. file open.

I would also seriously consider doing a scaled-back Landlock variant
first, with the intent of getting the main mechanism into the kernel.
In particular, there are two big sources of complexity in Landlock.
You need to deal with the API for managing bpf programs that filter
various actions beyond just syscall entry, and you need to deal with
giving those filters a way to deal with inodes, paths, etc.  But you
can do the former without the latter.  For example, you could start
with some Landlock-style filters on things that have nothing to do
with files.  For example, you could allow a filter for connecting to
an abstract-namespace unix socket.  Or you could have a hook for
file_receive.  (You couldn't meaningfully filter based on the *path*
of the fd being received without adding all the path infrastructure,
but you could fitler on the *type* of the fd being received.)  Both of
these add new sandboxing abilities that don't currently exist.  In
particular, you can't write a seccomp rule that prevents receiving an
fd using recvmsg() right now unless you block cmsg entirely.  And you
can't write a filter that allows connecting to unix sockets by path
without allowing abstract namespace sockets either.

If you split up Landlock like this then, once you got all the
installation and management of filters down, you could submit patches
to add all the path stuff and deal with that review separately.

What do you all think?
