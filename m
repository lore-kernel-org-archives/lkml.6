Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2520872-1519769083-5-4418521747263373387
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519769082; b=Ilay52sO5AIN4Ef+d4T4h80oLpkZLEmkMcksFQQfS7lJWN1
    rBkV78fztdr8TMxZZiDN14MkqmQ+wBDMwZ3JM3eLlJOo9p2XlEHKNcZBVQxJSEuS
    0VCxI1Q1dDAs5sEdyw69JHYZ3398uoQWxI/VvZI/dd2suASn733TNdCP3saMc+0q
    zvnmEY4fQirwStb0HUWzY68b4kZBVYQH8MLLYvWIOTEOc7WjtkWkqqnCYqZ5tHAP
    SYhty2k7cQIkckJnJajsZXowOL+9kz4kXA81jaTmd2iWArxWsLJq+C9OGhyx7vfe
    5ZbZxLJSRPDZqw1jDUF6HeB/N5F3ndVR5qndSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1519769082; bh=MS7ZIF6J6j1l2w1I9hFlalhNnLGchVXwoSNtf3
    4BHuQ=; b=f0HoJ/+TmIRX/nBelshbfUJ8ccfMyoH1cnatpzAbnT7amPpuzDgQxW
    vm5APZP0vOxnu3GSCmeiS8CR3OKpMylbzTaK8yqv0a3dVHZDUJ8GzGZlu9UEgcdk
    GCsvy2Nb9BQe9heVqAptrxuKHL93aPdW9v7EmL4q+sT3sGPz7Xq9cgmuw36OiBQW
    Wn0DVXZRsIAUBrG9U5L9JDlrkydPV4jbuYC9pl51BywndQ8r1AETglCWVTp5T2oq
    oLpTFCoo0jJZRHs6BaHhx8PQ4TMx62dNCdFGSnBtz6nF29/F5Fna/kOYNcqFW4QK
    b8lq7jcBjGo90QVOCzzjG7O8tJdUL/+A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=digikod.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=digikod.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=digikod.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=digikod.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeB0WEk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 17:04:40 -0500
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:44874 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeB0WEi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Feb 2018 17:04:38 -0500
Subject: Re: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
 sandboxing
To: Andy Lutomirski <luto@amacapital.net>
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
References: <20180227004121.3633-1-mic@digikod.net>
 <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
Date: Tue, 27 Feb 2018 23:03:21 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NNBuAyNJX1patDVCOQjx8daLF7SLGAZ8l"
X-Antivirus-Code: 0x100000
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NNBuAyNJX1patDVCOQjx8daLF7SLGAZ8l
Content-Type: multipart/mixed; boundary="tHO53Qh91QSg47LdegCJFtRUDAs1rmtic";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Andy Lutomirski <luto@amacapital.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Daniel Borkmann <daniel@iogearbox.net>, David Drysdale
 <drysdale@google.com>, "David S . Miller" <davem@davemloft.net>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 James Morris <james.l.morris@oracle.com>, Jann Horn <jann@thejh.net>,
 Jonathan Corbet <corbet@lwn.net>, Michael Kerrisk <mtk.manpages@gmail.com>,
 Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
 Sargun Dhillon <sargun@sargun.me>, "Serge E . Hallyn" <serge@hallyn.com>,
 Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
 Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
 Will Drewry <wad@chromium.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Linux API <linux-api@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Message-ID: <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
Subject: Re: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
 sandboxing
References: <20180227004121.3633-1-mic@digikod.net>
 <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
In-Reply-To: <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>

--tHO53Qh91QSg47LdegCJFtRUDAs1rmtic
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 27/02/2018 05:36, Andy Lutomirski wrote:
> On Tue, Feb 27, 2018 at 12:41 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod=
=2Enet> wrote:
>> Hi,
>>
>> This eight series is a major revamp of the Landlock design compared to=

>> the previous series [1]. This enables more flexibility and granularity=

>> of access control with file paths. It is now possible to enforce an
>> access control according to a file hierarchy. Landlock uses the concep=
t
>> of inode and path to identify such hierarchy. In a way, it brings tool=
s
>> to program what is a file hierarchy.
>>
>> There is now three types of Landlock hooks: FS_WALK, FS_PICK and FS_GE=
T.
>> Each of them accepts a dedicated eBPF program, called a Landlock
>> program.  They can be chained to enforce a full access control accordi=
ng
>> to a list of directories or files. The set of actions on a file is wel=
l
>> defined (e.g. read, write, ioctl, append, lock, mount...) taking
>> inspiration from the major Linux LSMs and some other access-controls
>> like Capsicum.  These program types are designed to be cache-friendly,=

>> which give room for optimizations in the future.
>>
>> The documentation patch contains some kernel documentation and
>> explanations on how to use Landlock.  The compiled documentation and
>> a talk I gave at FOSDEM can be found here: https://landlock.io
>> This patch series can be found in the branch landlock-v8 in this repo:=

>> https://github.com/landlock-lsm/linux
>>
>> There is still some minor issues with this patch series but it should
>> demonstrate how powerful this design may be. One of these issues is th=
at
>> it is not a stackable LSM anymore, but the infrastructure management o=
f
>> security blobs should allow to stack it with other LSM [4].
>>
>> This is the first step of the roadmap discussed at LPC [2].  While the=

>> intended final goal is to allow unprivileged users to use Landlock, th=
is
>> series allows only a process with global CAP_SYS_ADMIN to load and
>> enforce a rule.  This may help to get feedback and avoid unexpected
>> behaviors.
>>
>> This series can be applied on top of bpf-next, commit 7d72637eb39f
>> ("Merge branch 'x86-jit'").  This can be tested with
>> CONFIG_SECCOMP_FILTER and CONFIG_SECURITY_LANDLOCK.  I would really
>> appreciate constructive comments on the design and the code.
>>
>>
>> # Landlock LSM
>>
>> The goal of this new Linux Security Module (LSM) called Landlock is to=

>> allow any process, including unprivileged ones, to create powerful
>> security sandboxes comparable to XNU Sandbox or OpenBSD Pledge. This
>> kind of sandbox is expected to help mitigate the security impact of bu=
gs
>> or unexpected/malicious behaviors in user-space applications.
>>
>> The approach taken is to add the minimum amount of code while still
>> allowing the user-space application to create quite complex access
>> rules.  A dedicated security policy language such as the one used by
>> SELinux, AppArmor and other major LSMs involves a lot of code and is
>> usually permitted to only a trusted user (i.e. root).  On the contrary=
,
>> eBPF programs already exist and are designed to be safely loaded by
>> unprivileged user-space.
>>
>> This design does not seem too intrusive but is flexible enough to allo=
w
>> a powerful sandbox mechanism accessible by any process on Linux. The u=
se
>> of seccomp and Landlock is more suitable with the help of a user-space=

>> library (e.g.  libseccomp) that could help to specify a high-level
>> language to express a security policy instead of raw eBPF programs.
>> Moreover, thanks to the LLVM front-end, it is quite easy to write an
>> eBPF program with a subset of the C language.
>>
>>
>> # Frequently asked questions
>>
>> ## Why is seccomp-bpf not enough?
>>
>> A seccomp filter can access only raw syscall arguments (i.e. the
>> register values) which means that it is not possible to filter accordi=
ng
>> to the value pointed to by an argument, such as a file pathname. As an=

>> embryonic Landlock version demonstrated, filtering at the syscall leve=
l
>> is complicated (e.g. need to take care of race conditions). This is
>> mainly because the access control checkpoints of the kernel are not at=

>> this high-level but more underneath, at the LSM-hook level. The LSM
>> hooks are designed to handle this kind of checks.  Landlock abstracts
>> this approach to leverage the ability of unprivileged users to limit
>> themselves.
>>
>> Cf. section "What it isn't?" in Documentation/prctl/seccomp_filter.txt=

>>
>>
>> ## Why use the seccomp(2) syscall?
>>
>> Landlock use the same semantic as seccomp to apply access rule
>> restrictions. It add a new layer of security for the current process
>> which is inherited by its children. It makes sense to use an unique
>> access-restricting syscall (that should be allowed by seccomp filters)=

>> which can only drop privileges. Moreover, a Landlock rule could come
>> from outside a process (e.g.  passed through a UNIX socket). It is the=
n
>> useful to differentiate the creation/load of Landlock eBPF programs vi=
a
>> bpf(2), from rule enforcement via seccomp(2).
>=20
> This seems like a weak argument to me.  Sure, this is a bit different
> from seccomp(), and maybe shoving it into the seccomp() multiplexer is
> awkward, but surely the bpf() multiplexer is even less applicable.

I think using the seccomp syscall is fine, and everyone agreed on it.

>=20
> But I think that you have more in common with seccomp() than you're
> giving it credit for.  With seccomp, you need to either prevent
> ptrace() of any more-privileged task or you need to filter to make
> sure you can't trace a more privileged program.  With landlock, you
> need exactly the same thing.  You have basically the same no_new_privs
> considerations, etc.

Right, I did not mean to not give credit to seccomp at all.

>=20
> Also, looking forward, I think you're going to want a bunch of the
> stuff that's under consideration as new seccomp features.  Tycho is
> working on a "user notifier" feature for seccomp where, in addition to
> accepting, rejecting, or kicking to ptrace, you can send a message to
> the creator of the filter and wait for a reply.  I think that Landlock
> will want exactly the same feature.

I don't think why this may be useful at all her. Landlock does not
filter at the syscall level but handles kernel object and actions as
does an LSM. That is the whole purpose of Landlock.

>=20
> In other words, it really seems to be that you should extend seccomp()
> with the ability to attach filters to things that aren't syscall
> entry, e.g. file open.

It seems that it is what I do=E2=80=A6 Not sure to understand you here.

>=20
> I would also seriously consider doing a scaled-back Landlock variant
> first, with the intent of getting the main mechanism into the kernel.
> In particular, there are two big sources of complexity in Landlock.
> You need to deal with the API for managing bpf programs that filter
> various actions beyond just syscall entry, and you need to deal with
> giving those filters a way to deal with inodes, paths, etc.  But you
> can do the former without the latter.  For example, you could start
> with some Landlock-style filters on things that have nothing to do
> with files.  For example, you could allow a filter for connecting to
> an abstract-namespace unix socket.  Or you could have a hook for
> file_receive.  (You couldn't meaningfully filter based on the *path*
> of the fd being received without adding all the path infrastructure,
> but you could fitler on the *type* of the fd being received.)  Both of
> these add new sandboxing abilities that don't currently exist.  In
> particular, you can't write a seccomp rule that prevents receiving an
> fd using recvmsg() right now unless you block cmsg entirely.  And you
> can't write a filter that allows connecting to unix sockets by path
> without allowing abstract namespace sockets either.

What you are proposing here seems like my previous patch series (v7). As
it was suggested by Kees (and requested by future users), this patch
series is able to handle file paths. This is a good thing because it
highlight that this design can scale to evaluate complex objects (i.e.
file paths), which was not the case for the previous patch series.

>=20
> If you split up Landlock like this then, once you got all the
> installation and management of filters down, you could submit patches
> to add all the path stuff and deal with that review separately.
>=20
> What do you all think?
>=20

I may be able to strip some parts for a first inclusion, but a complex
use case like controlling access to files is an important use case.


--tHO53Qh91QSg47LdegCJFtRUDAs1rmtic--

--NNBuAyNJX1patDVCOQjx8daLF7SLGAZ8l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlqV1akACgkQIt7+33O9
apX3RAf/Vh1bZkIdMHhgQcqBuFYZhfGucJV/oz28btHZBbludlxFzMOZzwOrMl3c
6YTaajUH2fq4PMB1nmi6hFrt9YZBUNCD7omgpS1CqYfp5fATK+bHnZ407u9Xm8ox
z9bQXgwBJMyXMh0wdjLYoDJ3NTN2i6sNBVZJ9sJhjjV2KT0N7wZJQ1HtK+8dgX7x
ZuLHQsmTsefGcU5FUTJt09OKVshqi1NTTST5nygm9HO1C8XlvLxw3zJgH61GXnPd
nb4RvNsPe+9HJ7addbl/tji0qW/CVBF1ZRq1QOlhMcOA9Lt8YXfuRvOXOFuyUUN+
WS5sPTKmod3XY8N+moKAxNSUvLVVCg==
=uHFL
-----END PGP SIGNATURE-----

--NNBuAyNJX1patDVCOQjx8daLF7SLGAZ8l--
