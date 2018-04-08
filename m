Return-Path: <kernel-hardening-return-12895-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49Ojfs4FzDknKD1KajU4h1AtnVjc3DJ+Nz6y60WUuwtuRJ3FKv74ue47jxV9Zzx4pJTbiSS
ARC-Seal: i=1; a=rsa-sha256; t=1523193295; cv=none;
        d=google.com; s=arc-20160816;
        b=txOCGDzguRdNjAt6CRiVA31Kjrz7ZXmKYasqtSWQVYNXdyVvRTKTi6MEpgm/u0VU9r
         Xra8AmKK24pGUS4dFPjLoo0ne3vHTKfNCBYJupoMqPTHEQTtrxMBYj9+NWFMKxoODERP
         0bytZBBd9nHVJ3vjcU3EAB9iFJUi1U4n4mgEp9K2mj8KVxVFpoUHYJIxw59ZQ39hkiTP
         tb//hsjsb9LhUp0k7srseMe/CColWKg1w+75ZxmIHotnG2+sxXyzu4B/nB5chMEcQXT3
         z02JELg2TycmFfg00/JgdL7O8GJFuGbUrcv3ohjFY17qSqgDiQA+fJRVrKNHzpYzIspN
         jXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:autocrypt
         :openpgp:from:references:cc:to:subject:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=YSsmw62UODmzNeNUZT3i3oZXVTjLowT7+1BUionNCFg=;
        b=Za5ZEyrXqkNxCK9ICRcW9UtD/3HKw5WfJITr2Qbc2qRROJuUe08gK7raD81kvoqPv0
         lLYEIJOBR+x3NSBbHRMHTD/cFUpRGjrWhdoPSQev3cLuJk3dxOzfW5N1m1X5l8aepJYW
         +zF2v8IkwuPKUlkzpesh48J/nIbpRqPtuNXZl9SeS+whmoXGQwwrYY16mpKGUS8znSwB
         FHgwGwNGhCpEDDkZy1NSWo0psdnXXtKomusg92bKuZg80F5MGagHRFJMTqrNgJD/D1js
         zijXs/iWIS7k3paomVYoPFrJQCqWv+uEkUU2Sd6MBsVBBqofQD0kiLnvlbwVJB+vBfgH
         DFDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12895-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12895-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12895-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12895-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH bpf-next v8 05/11] seccomp,landlock: Enforce Landlock
 programs per process hierarchy
To: Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Drysdale <drysdale@google.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Tejun Heo <tj@kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Tycho Andersen <tycho@tycho.ws>, Will Drewry <wad@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-6-mic@digikod.net>
 <20180227020856.teq4hobw3zwussu2@ast-mbp>
 <CALCETrVKRYnGJ9XNW-x7eHdMt+eGP90j7cAed-KTzp1KT_kMeQ@mail.gmail.com>
 <20180227045458.wjrbbsxf3po656du@ast-mbp>
 <CALCETrXZ=xJEd53RhA67_VDoAKBWgUeyBi9XN7ibrE7V6nzk5Q@mail.gmail.com>
 <20180227053255.a7ua24kjd6tvei2a@ast-mbp>
 <CALCETrUqc0wbig4ntQe9KNS-fOgYOpD+MPodXYruCRyJ7bhagA@mail.gmail.com>
 <ab8dda73-4a6e-4e10-cda0-3e91c5019a63@digikod.net>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mic@digikod.net; prefer-encrypt=mutual; keydata=
 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
 RjVFnCHFbtPhnyvGdQQ=
Message-ID: <498f8193-c909-78b2-e4ca-c1dd05605255@digikod.net>
Date: Sun, 8 Apr 2018 15:13:43 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <ab8dda73-4a6e-4e10-cda0-3e91c5019a63@digikod.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9sVp4jyhj9nHgVZXiioKseBp8DitdjOYZ"
X-Antivirus-Code: 0x100000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593512796406478909?=
X-GMAIL-MSGID: =?utf-8?q?1597183932911999867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9sVp4jyhj9nHgVZXiioKseBp8DitdjOYZ
Content-Type: multipart/mixed; boundary="QE42lGOKgpCyyk5VfsFkK328GETpBnIh9";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Andy Lutomirski <luto@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 David Drysdale <drysdale@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Eric W . Biederman" <ebiederm@xmission.com>,
 Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Kees Cook <keescook@chromium.org>,
 Paul Moore <paul@paul-moore.com>, Sargun Dhillon <sargun@sargun.me>,
 "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Graf <tgraf@suug.ch>,
 Tycho Andersen <tycho@tycho.ws>, Will Drewry <wad@chromium.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Linux API <linux-api@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Message-ID: <498f8193-c909-78b2-e4ca-c1dd05605255@digikod.net>
Subject: Re: [PATCH bpf-next v8 05/11] seccomp,landlock: Enforce Landlock
 programs per process hierarchy
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-6-mic@digikod.net>
 <20180227020856.teq4hobw3zwussu2@ast-mbp>
 <CALCETrVKRYnGJ9XNW-x7eHdMt+eGP90j7cAed-KTzp1KT_kMeQ@mail.gmail.com>
 <20180227045458.wjrbbsxf3po656du@ast-mbp>
 <CALCETrXZ=xJEd53RhA67_VDoAKBWgUeyBi9XN7ibrE7V6nzk5Q@mail.gmail.com>
 <20180227053255.a7ua24kjd6tvei2a@ast-mbp>
 <CALCETrUqc0wbig4ntQe9KNS-fOgYOpD+MPodXYruCRyJ7bhagA@mail.gmail.com>
 <ab8dda73-4a6e-4e10-cda0-3e91c5019a63@digikod.net>
In-Reply-To: <ab8dda73-4a6e-4e10-cda0-3e91c5019a63@digikod.net>

--QE42lGOKgpCyyk5VfsFkK328GETpBnIh9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 02/27/2018 10:48 PM, Micka=C3=ABl Sala=C3=BCn wrote:
>=20
> On 27/02/2018 17:39, Andy Lutomirski wrote:
>> On Tue, Feb 27, 2018 at 5:32 AM, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> On Tue, Feb 27, 2018 at 05:20:55AM +0000, Andy Lutomirski wrote:
>>>> On Tue, Feb 27, 2018 at 4:54 AM, Alexei Starovoitov
>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>> On Tue, Feb 27, 2018 at 04:40:34AM +0000, Andy Lutomirski wrote:
>>>>>> On Tue, Feb 27, 2018 at 2:08 AM, Alexei Starovoitov
>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>> On Tue, Feb 27, 2018 at 01:41:15AM +0100, Micka=C3=ABl Sala=C3=BC=
n wrote:
>>>>>>>> The seccomp(2) syscall can be used by a task to apply a Landlock=
 program
>>>>>>>> to itself. As a seccomp filter, a Landlock program is enforced f=
or the
>>>>>>>> current task and all its future children. A program is immutable=
 and a
>>>>>>>> task can only add new restricting programs to itself, forming a =
list of
>>>>>>>> programss.
>>>>>>>>
>>>>>>>> A Landlock program is tied to a Landlock hook. If the action on =
a kernel
>>>>>>>> object is allowed by the other Linux security mechanisms (e.g. D=
AC,
>>>>>>>> capabilities, other LSM), then a Landlock hook related to this k=
ind of
>>>>>>>> object is triggered. The list of programs for this hook is then
>>>>>>>> evaluated. Each program return a 32-bit value which can deny the=
 action
>>>>>>>> on a kernel object with a non-zero value. If every programs of t=
he list
>>>>>>>> return zero, then the action on the object is allowed.
>>>>>>>>
>>>>>>>> Multiple Landlock programs can be chained to share a 64-bits val=
ue for a
>>>>>>>> call chain (e.g. evaluating multiple elements of a file path).  =
This
>>>>>>>> chaining is restricted when a process construct this chain by lo=
ading a
>>>>>>>> program, but additional checks are performed when it requests to=
 apply
>>>>>>>> this chain of programs to itself.  The restrictions ensure that =
it is
>>>>>>>> not possible to call multiple programs in a way that would imply=
 to
>>>>>>>> handle multiple shared values (i.e. cookies) for one chain.  For=
 now,
>>>>>>>> only a fs_pick program can be chained to the same type of progra=
m,
>>>>>>>> because it may make sense if they have different triggers (cf. n=
ext
>>>>>>>> commits).  This restrictions still allows to reuse Landlock prog=
rams in
>>>>>>>> a safe way (e.g. use the same loaded fs_walk program with multip=
le
>>>>>>>> chains of fs_pick programs).
>>>>>>>>
>>>>>>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>> +struct landlock_prog_set *landlock_prepend_prog(
>>>>>>>> +             struct landlock_prog_set *current_prog_set,
>>>>>>>> +             struct bpf_prog *prog)
>>>>>>>> +{
>>>>>>>> +     struct landlock_prog_set *new_prog_set =3D current_prog_se=
t;
>>>>>>>> +     unsigned long pages;
>>>>>>>> +     int err;
>>>>>>>> +     size_t i;
>>>>>>>> +     struct landlock_prog_set tmp_prog_set =3D {};
>>>>>>>> +
>>>>>>>> +     if (prog->type !=3D BPF_PROG_TYPE_LANDLOCK_HOOK)
>>>>>>>> +             return ERR_PTR(-EINVAL);
>>>>>>>> +
>>>>>>>> +     /* validate memory size allocation */
>>>>>>>> +     pages =3D prog->pages;
>>>>>>>> +     if (current_prog_set) {
>>>>>>>> +             size_t i;
>>>>>>>> +
>>>>>>>> +             for (i =3D 0; i < ARRAY_SIZE(current_prog_set->pro=
grams); i++) {
>>>>>>>> +                     struct landlock_prog_list *walker_p;
>>>>>>>> +
>>>>>>>> +                     for (walker_p =3D current_prog_set->progra=
ms[i];
>>>>>>>> +                                     walker_p; walker_p =3D wal=
ker_p->prev)
>>>>>>>> +                             pages +=3D walker_p->prog->pages;
>>>>>>>> +             }
>>>>>>>> +             /* count a struct landlock_prog_set if we need to =
allocate one */
>>>>>>>> +             if (refcount_read(&current_prog_set->usage) !=3D 1=
)
>>>>>>>> +                     pages +=3D round_up(sizeof(*current_prog_s=
et), PAGE_SIZE)
>>>>>>>> +                             / PAGE_SIZE;
>>>>>>>> +     }
>>>>>>>> +     if (pages > LANDLOCK_PROGRAMS_MAX_PAGES)
>>>>>>>> +             return ERR_PTR(-E2BIG);
>>>>>>>> +
>>>>>>>> +     /* ensure early that we can allocate enough memory for the=
 new
>>>>>>>> +      * prog_lists */
>>>>>>>> +     err =3D store_landlock_prog(&tmp_prog_set, current_prog_se=
t, prog);
>>>>>>>> +     if (err)
>>>>>>>> +             return ERR_PTR(err);
>>>>>>>> +
>>>>>>>> +     /*
>>>>>>>> +      * Each task_struct points to an array of prog list pointe=
rs.  These
>>>>>>>> +      * tables are duplicated when additions are made (which me=
ans each
>>>>>>>> +      * table needs to be refcounted for the processes using it=
). When a new
>>>>>>>> +      * table is created, all the refcounters on the prog_list =
are bumped (to
>>>>>>>> +      * track each table that references the prog). When a new =
prog is
>>>>>>>> +      * added, it's just prepended to the list for the new tabl=
e to point
>>>>>>>> +      * at.
>>>>>>>> +      *
>>>>>>>> +      * Manage all the possible errors before this step to not =
uselessly
>>>>>>>> +      * duplicate current_prog_set and avoid a rollback.
>>>>>>>> +      */
>>>>>>>> +     if (!new_prog_set) {
>>>>>>>> +             /*
>>>>>>>> +              * If there is no Landlock program set used by the=
 current task,
>>>>>>>> +              * then create a new one.
>>>>>>>> +              */
>>>>>>>> +             new_prog_set =3D new_landlock_prog_set();
>>>>>>>> +             if (IS_ERR(new_prog_set))
>>>>>>>> +                     goto put_tmp_lists;
>>>>>>>> +     } else if (refcount_read(&current_prog_set->usage) > 1) {
>>>>>>>> +             /*
>>>>>>>> +              * If the current task is not the sole user of its=
 Landlock
>>>>>>>> +              * program set, then duplicate them.
>>>>>>>> +              */
>>>>>>>> +             new_prog_set =3D new_landlock_prog_set();
>>>>>>>> +             if (IS_ERR(new_prog_set))
>>>>>>>> +                     goto put_tmp_lists;
>>>>>>>> +             for (i =3D 0; i < ARRAY_SIZE(new_prog_set->program=
s); i++) {
>>>>>>>> +                     new_prog_set->programs[i] =3D
>>>>>>>> +                             READ_ONCE(current_prog_set->progra=
ms[i]);
>>>>>>>> +                     if (new_prog_set->programs[i])
>>>>>>>> +                             refcount_inc(&new_prog_set->progra=
ms[i]->usage);
>>>>>>>> +             }
>>>>>>>> +
>>>>>>>> +             /*
>>>>>>>> +              * Landlock program set from the current task will=
 not be freed
>>>>>>>> +              * here because the usage is strictly greater than=
 1. It is
>>>>>>>> +              * only prevented to be freed by another task than=
ks to the
>>>>>>>> +              * caller of landlock_prepend_prog() which should =
be locked if
>>>>>>>> +              * needed.
>>>>>>>> +              */
>>>>>>>> +             landlock_put_prog_set(current_prog_set);
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     /* prepend tmp_prog_set to new_prog_set */
>>>>>>>> +     for (i =3D 0; i < ARRAY_SIZE(tmp_prog_set.programs); i++) =
{
>>>>>>>> +             /* get the last new list */
>>>>>>>> +             struct landlock_prog_list *last_list =3D
>>>>>>>> +                     tmp_prog_set.programs[i];
>>>>>>>> +
>>>>>>>> +             if (last_list) {
>>>>>>>> +                     while (last_list->prev)
>>>>>>>> +                             last_list =3D last_list->prev;
>>>>>>>> +                     /* no need to increment usage (pointer rep=
lacement) */
>>>>>>>> +                     last_list->prev =3D new_prog_set->programs=
[i];
>>>>>>>> +                     new_prog_set->programs[i] =3D tmp_prog_set=
=2Eprograms[i];
>>>>>>>> +             }
>>>>>>>> +     }
>>>>>>>> +     new_prog_set->chain_last =3D tmp_prog_set.chain_last;
>>>>>>>> +     return new_prog_set;
>>>>>>>> +
>>>>>>>> +put_tmp_lists:
>>>>>>>> +     for (i =3D 0; i < ARRAY_SIZE(tmp_prog_set.programs); i++)
>>>>>>>> +             put_landlock_prog_list(tmp_prog_set.programs[i]);
>>>>>>>> +     return new_prog_set;
>>>>>>>> +}
>>>>>>>
>>>>>>> Nack on the chaining concept.
>>>>>>> Please do not reinvent the wheel.
>>>>>>> There is an existing mechanism for attaching/detaching/quering mu=
ltiple
>>>>>>> programs attached to cgroup and tracing hooks that are also
>>>>>>> efficiently executed via BPF_PROG_RUN_ARRAY.
>>>>>>> Please use that instead.
>>>>>>>
>>>>>>
>>>>>> I don't see how that would help.  Suppose you add a filter, then
>>>>>> fork(), and then the child adds another filter.  Do you want to
>>>>>> duplicate the entire array?  You certainly can't *modify* the arra=
y
>>>>>> because you'll affect processes that shouldn't be affected.
>>>>>>
>>>>>> In contrast, doing this through seccomp like the earlier patches
>>>>>> seemed just fine to me, and seccomp already had the right logic.
>>>>>
>>>>> it doesn't look to me that existing seccomp side of managing fork
>>>>> situation can be reused. Here there is an attempt to add 'chaining'=

>>>>> concept which sort of an extension of existing seccomp style,
>>>>> but somehow heavily done on bpf side and contradicts cgroup/tracing=
=2E
>>>>>
>>>>
>>>> I don't see why the seccomp way can't be used.  I agree with you tha=
t
>>>> the seccomp *style* shouldn't be used in bpf code like this, but I
>>>> think that Landlock programs can and should just live in the existin=
g
>>>> seccomp chain.  If the existing seccomp code needs some modification=

>>>> to make this work, then so be it.
>>>
>>> +1
>>> if that was the case...
>>> but that's not my reading of the patch set.
>>
>> An earlier version of the patch set used the seccomp filter chain.
>> Micka=C3=ABl, what exactly was wrong with that approach other than tha=
t the
>> seccomp() syscall was awkward for you to use?  You could add a
>> seccomp_add_landlock_rule() syscall if you needed to.
>=20
> Nothing was wrong about about that, this part did not changed (see my
> next comment).
>=20
>>
>> As a side comment, why is this an LSM at all, let alone a non-stacking=

>> LSM?  It would make a lot more sense to me to make Landlock depend on
>> having LSMs configured in but to call the landlock hooks directly from=

>> the security_xyz() hooks.
>=20
> See Casey's answer and his patch series: https://lwn.net/Articles/74196=
3/
>=20
>>
>>>
>>>> In other words, the kernel already has two kinds of chaining:
>>>> seccomp's and bpf's.  bpf's doesn't work right for this type of usag=
e
>>>> across fork(), whereas seccomp's already handles that case correctly=
=2E
>>>> (In contrast, seccomp's is totally wrong for cgroup-attached filters=
=2E)
>>>>  So IMO Landlock should use the seccomp core code and call into bpf
>>>> for the actual filtering.
>>>
>>> +1
>>> in cgroup we had to invent this new BPF_PROG_RUN_ARRAY mechanism,
>>> since cgroup hierarchy can be complicated with bpf progs attached
>>> at different levels with different override/multiprog properties,
>>> so walking link list and checking all flags at run-time would have
>>> been too slow. That's why we added compute_effective_progs().
>>
>> If we start adding override flags to Landlock, I think we're doing it
>> wrong.   With cgroup bpf programs, the whole mess is set up by the
>> administrator.  With seccomp, and with Landlock if done correctly, it
>> *won't* be set up by the administrator, so the chance that everyone
>> gets all the flags right is about zero.  All attached filters should
>> run unconditionally.
>=20
>=20
> There is a misunderstanding about this chaining mechanism. This should
> not be confused with the list of seccomp filters nor the cgroup
> hierarchies. Landlock programs can be stacked the same way seccomp's
> filters can (cf. struct landlock_prog_set, the "chain_last" field is an=

> optimization which is not used for this struct handling). This stackabl=
e
> property did not changed from the previous patch series. The chaining
> mechanism is for another use case, which does not make sense for seccom=
p
> filters nor other eBPF program types, at least for now, from what I can=

> tell.
>=20
> You may want to get a look at my talk at FOSDEM
> (https://landlock.io/talks/2018-02-04_landlock-fosdem.pdf), especially
> slides 11 and 12.
>=20
> Let me explain my reasoning about this program chaining thing.
>=20
> To check if an action on a file is allowed, we first need to identify
> this file and match it to the security policy. In a previous
> (non-public) patch series, I tried to use one type of eBPF program to
> check every kind of access to a file. To be able to identify a file, I
> relied on an eBPF map, similar to the current inode map. This map store=

> a set of references to file descriptors. I then created a function
> bpf_is_file_beneath() to check if the requested file was beneath a file=

> in the map. This way, no chaining, only one eBPF program type to check
> an access to a file... but some issues then emerged. First, this design=

> create a side-channel which help an attacker using such a program to
> infer some information not normally available, for example to get a hin=
t
> on where a file descriptor (received from a UNIX socket) come from.
> Another issue is that this type of program would be called for each
> component of a path. Indeed, when the kernel check if an access to a
> file is allowed, it walk through all of the directories in its path
> (checking if the current process is allowed to execute them). That firs=
t
> attempt led me to rethink the way we could filter an access to a file
> *path*.
>=20
> To minimize the number of called to an eBPF program dedicated to
> validate an access to a file path, I decided to create three subtype of=

> eBPF programs. The FS_WALK type is called when walking through every
> directory of a file path (except the last one if it is the target). We
> can then restrict this type of program to the minimum set of functions
> it is allowed to call and the minimum set of data available from its
> context. The first implicit chaining is for this type of program. To be=

> able to evaluate a path while being called for all its components, this=

> program need to store a state (to remember what was the parent director=
y
> of this path). There is no "previous" field in the subtype for this
> program because it is chained with itself, for each directories. This
> enable to create a FS_WALK program to evaluate a file hierarchy, thank
> to the inode map which can be used to check if a directory of this
> hierarchy is part of an allowed (or denied) list of directories. This
> design enables to express a file hierarchy in a programmatic way,
> without requiring an eBPF helper to do the job (unlike my first experim=
ent).
>=20
> The explicit chaining is used to tied a path evaluation (with a FS_WALK=

> program) to an access to the actual file being requested (the last
> component of a file path), with a FS_PICK program. It is only at this
> time that the kernel check for the requested action (e.g. read, write,
> chdir, append...). To be able to filter such access request we can have=

> one call to the same program for every action and let this program chec=
k
> for which action it was called. However, this design does not allow the=

> kernel to know if the current action is indeed handled by this program.=

> Hence, it is not possible to implement a cache mechanism to only call
> this program if it knows how to handle this action.
>=20
> The approach I took for this FS_PICK type of program is to add to its
> subtype which action it can handle (with the "triggers" bitfield, seen
> as ORed actions). This way, the kernel knows if a call to a FS_PICK
> program is necessary. If the user wants to enforce a different security=

> policy according to the action requested on a file, then it needs
> multiple FS_PICK programs. However, to reduce the number of such
> programs, this patch series allow a FS_PICK program to be chained with
> another, the same way a FS_WALK is chained with itself. This way, if th=
e
> user want to check if the action is a for example an "open" and a "read=
"
> and not a "map" and a "read", then it can chain multiple FS_PICK
> programs with different triggers actions. The OR check performed by the=

> kernel is not a limitation then, only a way to know if a call to an eBP=
F
> program is needed.
>=20
> The last type of program is FS_GET. This one is called when a process
> get a struct file or change its working directory. This is the only
> program type able (and allowed) to tag a file. This restriction is
> important to not being subject to resource exhaustion attacks (i.e.
> tagging every inode accessible to an attacker, which would allocate too=

> much kernel memory).
>=20
> This design gives room for improvements to create a cache of eBPF
> context (input data, including maps if any), with the result of an eBPF=

> program. This would help limit the number of call to an eBPF program th=
e
> same way SELinux or other kernel components do to limit costly checks.
>=20
> The eBPF maps of progs are useful to call the same type of eBPF
> program. It does not fit with this use case because we may want multipl=
e
> eBPF program according to the action requested on a kernel object (e.g.=

> FS_GET). The other reason is because the eBPF program does not know wha=
t
> will be the next (type of) access check performed by the kernel.
>=20
> To say it another way, this chaining mechanism is a way to split a
> kernel object evaluation with multiple specialized programs, each of
> them being able to deal with data tied to their type. Using a monolithi=
c
> eBPF program to check everything does not scale and does not fit with
> unprivileged use either.
>=20
> As a side note, the cookie value is only an ephemeral value to keep a
> state between multiple programs call. It can be used to create a state
> machine for an object evaluation.
>=20
> I don't see a way to do an efficient and programmatic path evaluation,
> with different access checks, with the current eBPF features. Please le=
t
> me know if you know how to do it another way.
>=20

Andy, Alexei, Daniel, what do you think about this Landlock program
chaining and cookie?


--QE42lGOKgpCyyk5VfsFkK328GETpBnIh9--

--9sVp4jyhj9nHgVZXiioKseBp8DitdjOYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlrKFYcACgkQIt7+33O9
apWXLwf/WOWtLpgcxyR1J1fQxvJAV1RT37qfgV2O1++VcGRrI1bNWy0/N5vt9OkF
DtZMSd8OsujDooTYkvZhC10i4ckeS9kdMRwSlNlKdu8I3V64vQU/h6luzo0hO9m4
1I8tAR2KT6r+cFN7Z6C8XYiuD5TlK3rbdYhJOwBkZ7wbKeTNQhpF4CXcEjonxWEr
JTAPrxzVDx31xwlJ5UZcNUhUnrdztdBvozwdqDV3O/F2Kt/eN5ihO4QFiUk58c7R
g0YtXjuh9hMHySlOKJTSvaujYwkZn9bTJ+DiJ+vkyvaqyYOxEI2HQlJVKNtuEW1i
7VB1SDybCH2M+yypJXjW0ETmh2L9Tg==
=jp66
-----END PGP SIGNATURE-----

--9sVp4jyhj9nHgVZXiioKseBp8DitdjOYZ--
