Return-Path: <kernel-hardening-return-12897-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+SwXQLSUO4AQgwIOyM4xxpaZugt3qNKAqDNxMcfB6B0RPA6+ODoty1r7eg5vFavQJcFvJ/
ARC-Seal: i=1; a=rsa-sha256; t=1523225045; cv=none;
        d=google.com; s=arc-20160816;
        b=pdfu2OOPOnm67DjgR0nWqzO8bsYa8TC0saUBrAFAsDrnGOOoKPlgMxbmdiwY8d0mOr
         KsQ0bP/y/zYjVreLd9VZMyBC29tJi1IHO8v8zXd3DtQ9jMk/DvihVcWQNQXm6jQiGtdW
         WzqWWXV183jfAwbvqT3BYBjCSQOG7YFSHI7kyBb0lREzCcKWYZj1zUvc9L7f/gXUQxvr
         +5kPPR5669WoBgLW9RWNR5ELjEbHdFJcPv2NE/+mSBruBc8hMOGWqgWM087e4VJmceYO
         VkF5SK+Y3cIuVhQQ29g6WFMXMDuAxvY0evL4zzePbuDvMxTHv7GpmrFw4fwXJ7dBtHCI
         soxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:autocrypt
         :openpgp:from:references:cc:to:subject:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Yc3+ths1SoaTgHkDFeHciyD69rXFx+YMo2paKwwVqu8=;
        b=BAXQsoKjjF9sU6VAKKZ8rcxN5mneO8TK4BYkbSONmtpLyip8ZfuxyrKblwVM47Zn/L
         Ff5kDPX4iRar6oY7USG9lRDPxLzYHKBoJSQBkmdOfRXRn9lKjdJ9m28kYNenPg/BD0K6
         /9iwtsPfnDE+lFlQeJ6vj/aAljXhZ8R3GaTsKJduy+/oFOygKSNH8Un/wXra3ALwReu+
         3tiCkiojsrPNxBqj5msmhW0LjM/zkpC+NxD5a9F8MpOMfqK4cZUMa6eiqXoZuTMgLIY4
         cVrL4Yi9ElM2AklI1CLot32Q84JN2O/cJsAfC6qsrK/sO5NTURUgnXsS8P5zT9xRrQHm
         jhZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12897-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12897-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12897-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12897-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH bpf-next v8 05/11] seccomp,landlock: Enforce Landlock
 programs per process hierarchy
To: Andy Lutomirski <luto@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro
 <viro@ZenIV.linux.org.uk>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-6-mic@digikod.net>
 <20180227020856.teq4hobw3zwussu2@ast-mbp>
 <CALCETrVKRYnGJ9XNW-x7eHdMt+eGP90j7cAed-KTzp1KT_kMeQ@mail.gmail.com>
 <20180227045458.wjrbbsxf3po656du@ast-mbp>
 <CALCETrXZ=xJEd53RhA67_VDoAKBWgUeyBi9XN7ibrE7V6nzk5Q@mail.gmail.com>
 <20180227053255.a7ua24kjd6tvei2a@ast-mbp>
 <CALCETrUqc0wbig4ntQe9KNS-fOgYOpD+MPodXYruCRyJ7bhagA@mail.gmail.com>
 <ab8dda73-4a6e-4e10-cda0-3e91c5019a63@digikod.net>
 <498f8193-c909-78b2-e4ca-c1dd05605255@digikod.net>
 <CALCETrViaXEx1iQ6q8bEEWSLchj=FH6LjcRY6+hjMx8A+rtgDQ@mail.gmail.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mic@digikod.net; prefer-encrypt=mutual; keydata=
 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
 RjVFnCHFbtPhnyvGdQQ=
Message-ID: <c6621359-e8f8-dc14-d449-f8e5d7149a97@digikod.net>
Date: Mon, 9 Apr 2018 00:01:59 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CALCETrViaXEx1iQ6q8bEEWSLchj=FH6LjcRY6+hjMx8A+rtgDQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fsDpHUePup1Pjb0yAkxFgn5ORwNxLpEVq"
X-Antivirus-Code: 0x100000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593512796406478909?=
X-GMAIL-MSGID: =?utf-8?q?1597217225113786488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fsDpHUePup1Pjb0yAkxFgn5ORwNxLpEVq
Content-Type: multipart/mixed; boundary="hHaom91hQZiq9frJExV3TxjZTzpQ1zqIf";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Andy Lutomirski <luto@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
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
 Andrew Morton <akpm@linux-foundation.org>, Al Viro
 <viro@ZenIV.linux.org.uk>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <c6621359-e8f8-dc14-d449-f8e5d7149a97@digikod.net>
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
 <498f8193-c909-78b2-e4ca-c1dd05605255@digikod.net>
 <CALCETrViaXEx1iQ6q8bEEWSLchj=FH6LjcRY6+hjMx8A+rtgDQ@mail.gmail.com>
In-Reply-To: <CALCETrViaXEx1iQ6q8bEEWSLchj=FH6LjcRY6+hjMx8A+rtgDQ@mail.gmail.com>

--hHaom91hQZiq9frJExV3TxjZTzpQ1zqIf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 04/08/2018 11:06 PM, Andy Lutomirski wrote:
> On Sun, Apr 8, 2018 at 6:13 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
>>
>> On 02/27/2018 10:48 PM, Micka=C3=ABl Sala=C3=BCn wrote:
>>>
>>> On 27/02/2018 17:39, Andy Lutomirski wrote:
>>>> On Tue, Feb 27, 2018 at 5:32 AM, Alexei Starovoitov
>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>> On Tue, Feb 27, 2018 at 05:20:55AM +0000, Andy Lutomirski wrote:
>>>>>> On Tue, Feb 27, 2018 at 4:54 AM, Alexei Starovoitov
>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>> On Tue, Feb 27, 2018 at 04:40:34AM +0000, Andy Lutomirski wrote:
>>>>>>>> On Tue, Feb 27, 2018 at 2:08 AM, Alexei Starovoitov
>>>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>>>> On Tue, Feb 27, 2018 at 01:41:15AM +0100, Micka=C3=ABl Sala=C3=BC=
n wrote:
>>>>>>>>>> The seccomp(2) syscall can be used by a task to apply a Landlo=
ck program
>>>>>>>>>> to itself. As a seccomp filter, a Landlock program is enforced=
 for the
>>>>>>>>>> current task and all its future children. A program is immutab=
le and a
>>>>>>>>>> task can only add new restricting programs to itself, forming =
a list of
>>>>>>>>>> programss.
>>>>>>>>>>
>>>>>>>>>> A Landlock program is tied to a Landlock hook. If the action o=
n a kernel
>>>>>>>>>> object is allowed by the other Linux security mechanisms (e.g.=
 DAC,
>>>>>>>>>> capabilities, other LSM), then a Landlock hook related to this=
 kind of
>>>>>>>>>> object is triggered. The list of programs for this hook is the=
n
>>>>>>>>>> evaluated. Each program return a 32-bit value which can deny t=
he action
>>>>>>>>>> on a kernel object with a non-zero value. If every programs of=
 the list
>>>>>>>>>> return zero, then the action on the object is allowed.
>>>>>>>>>>
>>>>>>>>>> Multiple Landlock programs can be chained to share a 64-bits v=
alue for a
>>>>>>>>>> call chain (e.g. evaluating multiple elements of a file path).=
  This
>>>>>>>>>> chaining is restricted when a process construct this chain by =
loading a
>>>>>>>>>> program, but additional checks are performed when it requests =
to apply
>>>>>>>>>> this chain of programs to itself.  The restrictions ensure tha=
t it is
>>>>>>>>>> not possible to call multiple programs in a way that would imp=
ly to
>>>>>>>>>> handle multiple shared values (i.e. cookies) for one chain.  F=
or now,
>>>>>>>>>> only a fs_pick program can be chained to the same type of prog=
ram,
>>>>>>>>>> because it may make sense if they have different triggers (cf.=
 next
>>>>>>>>>> commits).  This restrictions still allows to reuse Landlock pr=
ograms in
>>>>>>>>>> a safe way (e.g. use the same loaded fs_walk program with mult=
iple
>>>>>>>>>> chains of fs_pick programs).
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>>>>>>>>>
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>>> +struct landlock_prog_set *landlock_prepend_prog(
>>>>>>>>>> +             struct landlock_prog_set *current_prog_set,
>>>>>>>>>> +             struct bpf_prog *prog)
>>>>>>>>>> +{
>>>>>>>>>> +     struct landlock_prog_set *new_prog_set =3D current_prog_=
set;
>>>>>>>>>> +     unsigned long pages;
>>>>>>>>>> +     int err;
>>>>>>>>>> +     size_t i;
>>>>>>>>>> +     struct landlock_prog_set tmp_prog_set =3D {};
>>>>>>>>>> +
>>>>>>>>>> +     if (prog->type !=3D BPF_PROG_TYPE_LANDLOCK_HOOK)
>>>>>>>>>> +             return ERR_PTR(-EINVAL);
>>>>>>>>>> +
>>>>>>>>>> +     /* validate memory size allocation */
>>>>>>>>>> +     pages =3D prog->pages;
>>>>>>>>>> +     if (current_prog_set) {
>>>>>>>>>> +             size_t i;
>>>>>>>>>> +
>>>>>>>>>> +             for (i =3D 0; i < ARRAY_SIZE(current_prog_set->p=
rograms); i++) {
>>>>>>>>>> +                     struct landlock_prog_list *walker_p;
>>>>>>>>>> +
>>>>>>>>>> +                     for (walker_p =3D current_prog_set->prog=
rams[i];
>>>>>>>>>> +                                     walker_p; walker_p =3D w=
alker_p->prev)
>>>>>>>>>> +                             pages +=3D walker_p->prog->pages=
;
>>>>>>>>>> +             }
>>>>>>>>>> +             /* count a struct landlock_prog_set if we need t=
o allocate one */
>>>>>>>>>> +             if (refcount_read(&current_prog_set->usage) !=3D=
 1)
>>>>>>>>>> +                     pages +=3D round_up(sizeof(*current_prog=
_set), PAGE_SIZE)
>>>>>>>>>> +                             / PAGE_SIZE;
>>>>>>>>>> +     }
>>>>>>>>>> +     if (pages > LANDLOCK_PROGRAMS_MAX_PAGES)
>>>>>>>>>> +             return ERR_PTR(-E2BIG);
>>>>>>>>>> +
>>>>>>>>>> +     /* ensure early that we can allocate enough memory for t=
he new
>>>>>>>>>> +      * prog_lists */
>>>>>>>>>> +     err =3D store_landlock_prog(&tmp_prog_set, current_prog_=
set, prog);
>>>>>>>>>> +     if (err)
>>>>>>>>>> +             return ERR_PTR(err);
>>>>>>>>>> +
>>>>>>>>>> +     /*
>>>>>>>>>> +      * Each task_struct points to an array of prog list poin=
ters.  These
>>>>>>>>>> +      * tables are duplicated when additions are made (which =
means each
>>>>>>>>>> +      * table needs to be refcounted for the processes using =
it). When a new
>>>>>>>>>> +      * table is created, all the refcounters on the prog_lis=
t are bumped (to
>>>>>>>>>> +      * track each table that references the prog). When a ne=
w prog is
>>>>>>>>>> +      * added, it's just prepended to the list for the new ta=
ble to point
>>>>>>>>>> +      * at.
>>>>>>>>>> +      *
>>>>>>>>>> +      * Manage all the possible errors before this step to no=
t uselessly
>>>>>>>>>> +      * duplicate current_prog_set and avoid a rollback.
>>>>>>>>>> +      */
>>>>>>>>>> +     if (!new_prog_set) {
>>>>>>>>>> +             /*
>>>>>>>>>> +              * If there is no Landlock program set used by t=
he current task,
>>>>>>>>>> +              * then create a new one.
>>>>>>>>>> +              */
>>>>>>>>>> +             new_prog_set =3D new_landlock_prog_set();
>>>>>>>>>> +             if (IS_ERR(new_prog_set))
>>>>>>>>>> +                     goto put_tmp_lists;
>>>>>>>>>> +     } else if (refcount_read(&current_prog_set->usage) > 1) =
{
>>>>>>>>>> +             /*
>>>>>>>>>> +              * If the current task is not the sole user of i=
ts Landlock
>>>>>>>>>> +              * program set, then duplicate them.
>>>>>>>>>> +              */
>>>>>>>>>> +             new_prog_set =3D new_landlock_prog_set();
>>>>>>>>>> +             if (IS_ERR(new_prog_set))
>>>>>>>>>> +                     goto put_tmp_lists;
>>>>>>>>>> +             for (i =3D 0; i < ARRAY_SIZE(new_prog_set->progr=
ams); i++) {
>>>>>>>>>> +                     new_prog_set->programs[i] =3D
>>>>>>>>>> +                             READ_ONCE(current_prog_set->prog=
rams[i]);
>>>>>>>>>> +                     if (new_prog_set->programs[i])
>>>>>>>>>> +                             refcount_inc(&new_prog_set->prog=
rams[i]->usage);
>>>>>>>>>> +             }
>>>>>>>>>> +
>>>>>>>>>> +             /*
>>>>>>>>>> +              * Landlock program set from the current task wi=
ll not be freed
>>>>>>>>>> +              * here because the usage is strictly greater th=
an 1. It is
>>>>>>>>>> +              * only prevented to be freed by another task th=
anks to the
>>>>>>>>>> +              * caller of landlock_prepend_prog() which shoul=
d be locked if
>>>>>>>>>> +              * needed.
>>>>>>>>>> +              */
>>>>>>>>>> +             landlock_put_prog_set(current_prog_set);
>>>>>>>>>> +     }
>>>>>>>>>> +
>>>>>>>>>> +     /* prepend tmp_prog_set to new_prog_set */
>>>>>>>>>> +     for (i =3D 0; i < ARRAY_SIZE(tmp_prog_set.programs); i++=
) {
>>>>>>>>>> +             /* get the last new list */
>>>>>>>>>> +             struct landlock_prog_list *last_list =3D
>>>>>>>>>> +                     tmp_prog_set.programs[i];
>>>>>>>>>> +
>>>>>>>>>> +             if (last_list) {
>>>>>>>>>> +                     while (last_list->prev)
>>>>>>>>>> +                             last_list =3D last_list->prev;
>>>>>>>>>> +                     /* no need to increment usage (pointer r=
eplacement) */
>>>>>>>>>> +                     last_list->prev =3D new_prog_set->progra=
ms[i];
>>>>>>>>>> +                     new_prog_set->programs[i] =3D tmp_prog_s=
et.programs[i];
>>>>>>>>>> +             }
>>>>>>>>>> +     }
>>>>>>>>>> +     new_prog_set->chain_last =3D tmp_prog_set.chain_last;
>>>>>>>>>> +     return new_prog_set;
>>>>>>>>>> +
>>>>>>>>>> +put_tmp_lists:
>>>>>>>>>> +     for (i =3D 0; i < ARRAY_SIZE(tmp_prog_set.programs); i++=
)
>>>>>>>>>> +             put_landlock_prog_list(tmp_prog_set.programs[i])=
;
>>>>>>>>>> +     return new_prog_set;
>>>>>>>>>> +}
>>>>>>>>>
>>>>>>>>> Nack on the chaining concept.
>>>>>>>>> Please do not reinvent the wheel.
>>>>>>>>> There is an existing mechanism for attaching/detaching/quering =
multiple
>>>>>>>>> programs attached to cgroup and tracing hooks that are also
>>>>>>>>> efficiently executed via BPF_PROG_RUN_ARRAY.
>>>>>>>>> Please use that instead.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I don't see how that would help.  Suppose you add a filter, then=

>>>>>>>> fork(), and then the child adds another filter.  Do you want to
>>>>>>>> duplicate the entire array?  You certainly can't *modify* the ar=
ray
>>>>>>>> because you'll affect processes that shouldn't be affected.
>>>>>>>>
>>>>>>>> In contrast, doing this through seccomp like the earlier patches=

>>>>>>>> seemed just fine to me, and seccomp already had the right logic.=

>>>>>>>
>>>>>>> it doesn't look to me that existing seccomp side of managing fork=

>>>>>>> situation can be reused. Here there is an attempt to add 'chainin=
g'
>>>>>>> concept which sort of an extension of existing seccomp style,
>>>>>>> but somehow heavily done on bpf side and contradicts cgroup/traci=
ng.
>>>>>>>
>>>>>>
>>>>>> I don't see why the seccomp way can't be used.  I agree with you t=
hat
>>>>>> the seccomp *style* shouldn't be used in bpf code like this, but I=

>>>>>> think that Landlock programs can and should just live in the exist=
ing
>>>>>> seccomp chain.  If the existing seccomp code needs some modificati=
on
>>>>>> to make this work, then so be it.
>>>>>
>>>>> +1
>>>>> if that was the case...
>>>>> but that's not my reading of the patch set.
>>>>
>>>> An earlier version of the patch set used the seccomp filter chain.
>>>> Micka=C3=ABl, what exactly was wrong with that approach other than t=
hat the
>>>> seccomp() syscall was awkward for you to use?  You could add a
>>>> seccomp_add_landlock_rule() syscall if you needed to.
>>>
>>> Nothing was wrong about about that, this part did not changed (see my=

>>> next comment).
>>>
>>>>
>>>> As a side comment, why is this an LSM at all, let alone a non-stacki=
ng
>>>> LSM?  It would make a lot more sense to me to make Landlock depend o=
n
>>>> having LSMs configured in but to call the landlock hooks directly fr=
om
>>>> the security_xyz() hooks.
>>>
>>> See Casey's answer and his patch series: https://lwn.net/Articles/741=
963/
>>>
>>>>
>>>>>
>>>>>> In other words, the kernel already has two kinds of chaining:
>>>>>> seccomp's and bpf's.  bpf's doesn't work right for this type of us=
age
>>>>>> across fork(), whereas seccomp's already handles that case correct=
ly.
>>>>>> (In contrast, seccomp's is totally wrong for cgroup-attached filte=
rs.)
>>>>>>  So IMO Landlock should use the seccomp core code and call into bp=
f
>>>>>> for the actual filtering.
>>>>>
>>>>> +1
>>>>> in cgroup we had to invent this new BPF_PROG_RUN_ARRAY mechanism,
>>>>> since cgroup hierarchy can be complicated with bpf progs attached
>>>>> at different levels with different override/multiprog properties,
>>>>> so walking link list and checking all flags at run-time would have
>>>>> been too slow. That's why we added compute_effective_progs().
>>>>
>>>> If we start adding override flags to Landlock, I think we're doing i=
t
>>>> wrong.   With cgroup bpf programs, the whole mess is set up by the
>>>> administrator.  With seccomp, and with Landlock if done correctly, i=
t
>>>> *won't* be set up by the administrator, so the chance that everyone
>>>> gets all the flags right is about zero.  All attached filters should=

>>>> run unconditionally.
>>>
>>>
>>> There is a misunderstanding about this chaining mechanism. This shoul=
d
>>> not be confused with the list of seccomp filters nor the cgroup
>>> hierarchies. Landlock programs can be stacked the same way seccomp's
>>> filters can (cf. struct landlock_prog_set, the "chain_last" field is =
an
>>> optimization which is not used for this struct handling). This stacka=
ble
>>> property did not changed from the previous patch series. The chaining=

>>> mechanism is for another use case, which does not make sense for secc=
omp
>>> filters nor other eBPF program types, at least for now, from what I c=
an
>>> tell.
>>>
>>> You may want to get a look at my talk at FOSDEM
>>> (https://landlock.io/talks/2018-02-04_landlock-fosdem.pdf), especiall=
y
>>> slides 11 and 12.
>>>
>>> Let me explain my reasoning about this program chaining thing.
>>>
>>> To check if an action on a file is allowed, we first need to identify=

>>> this file and match it to the security policy. In a previous
>>> (non-public) patch series, I tried to use one type of eBPF program to=

>>> check every kind of access to a file. To be able to identify a file, =
I
>>> relied on an eBPF map, similar to the current inode map. This map sto=
re
>>> a set of references to file descriptors. I then created a function
>>> bpf_is_file_beneath() to check if the requested file was beneath a fi=
le
>>> in the map. This way, no chaining, only one eBPF program type to chec=
k
>>> an access to a file... but some issues then emerged. First, this desi=
gn
>>> create a side-channel which help an attacker using such a program to
>>> infer some information not normally available, for example to get a h=
int
>>> on where a file descriptor (received from a UNIX socket) come from.
>>> Another issue is that this type of program would be called for each
>>> component of a path. Indeed, when the kernel check if an access to a
>>> file is allowed, it walk through all of the directories in its path
>>> (checking if the current process is allowed to execute them). That fi=
rst
>>> attempt led me to rethink the way we could filter an access to a file=

>>> *path*.
>>>
>>> To minimize the number of called to an eBPF program dedicated to
>>> validate an access to a file path, I decided to create three subtype =
of
>>> eBPF programs. The FS_WALK type is called when walking through every
>>> directory of a file path (except the last one if it is the target). W=
e
>>> can then restrict this type of program to the minimum set of function=
s
>>> it is allowed to call and the minimum set of data available from its
>>> context. The first implicit chaining is for this type of program. To =
be
>>> able to evaluate a path while being called for all its components, th=
is
>>> program need to store a state (to remember what was the parent direct=
ory
>>> of this path). There is no "previous" field in the subtype for this
>>> program because it is chained with itself, for each directories. This=

>>> enable to create a FS_WALK program to evaluate a file hierarchy, than=
k
>>> to the inode map which can be used to check if a directory of this
>>> hierarchy is part of an allowed (or denied) list of directories. This=

>>> design enables to express a file hierarchy in a programmatic way,
>>> without requiring an eBPF helper to do the job (unlike my first exper=
iment).
>>>
>>> The explicit chaining is used to tied a path evaluation (with a FS_WA=
LK
>>> program) to an access to the actual file being requested (the last
>>> component of a file path), with a FS_PICK program. It is only at this=

>>> time that the kernel check for the requested action (e.g. read, write=
,
>>> chdir, append...). To be able to filter such access request we can ha=
ve
>>> one call to the same program for every action and let this program ch=
eck
>>> for which action it was called. However, this design does not allow t=
he
>>> kernel to know if the current action is indeed handled by this progra=
m.
>>> Hence, it is not possible to implement a cache mechanism to only call=

>>> this program if it knows how to handle this action.
>>>
>>> The approach I took for this FS_PICK type of program is to add to its=

>>> subtype which action it can handle (with the "triggers" bitfield, see=
n
>>> as ORed actions). This way, the kernel knows if a call to a FS_PICK
>>> program is necessary. If the user wants to enforce a different securi=
ty
>>> policy according to the action requested on a file, then it needs
>>> multiple FS_PICK programs. However, to reduce the number of such
>>> programs, this patch series allow a FS_PICK program to be chained wit=
h
>>> another, the same way a FS_WALK is chained with itself. This way, if =
the
>>> user want to check if the action is a for example an "open" and a "re=
ad"
>>> and not a "map" and a "read", then it can chain multiple FS_PICK
>>> programs with different triggers actions. The OR check performed by t=
he
>>> kernel is not a limitation then, only a way to know if a call to an e=
BPF
>>> program is needed.
>>>
>>> The last type of program is FS_GET. This one is called when a process=

>>> get a struct file or change its working directory. This is the only
>>> program type able (and allowed) to tag a file. This restriction is
>>> important to not being subject to resource exhaustion attacks (i.e.
>>> tagging every inode accessible to an attacker, which would allocate t=
oo
>>> much kernel memory).
>>>
>>> This design gives room for improvements to create a cache of eBPF
>>> context (input data, including maps if any), with the result of an eB=
PF
>>> program. This would help limit the number of call to an eBPF program =
the
>>> same way SELinux or other kernel components do to limit costly checks=
=2E
>>>
>>> The eBPF maps of progs are useful to call the same type of eBPF
>>> program. It does not fit with this use case because we may want multi=
ple
>>> eBPF program according to the action requested on a kernel object (e.=
g.
>>> FS_GET). The other reason is because the eBPF program does not know w=
hat
>>> will be the next (type of) access check performed by the kernel.
>>>
>>> To say it another way, this chaining mechanism is a way to split a
>>> kernel object evaluation with multiple specialized programs, each of
>>> them being able to deal with data tied to their type. Using a monolit=
hic
>>> eBPF program to check everything does not scale and does not fit with=

>>> unprivileged use either.
>>>
>>> As a side note, the cookie value is only an ephemeral value to keep a=

>>> state between multiple programs call. It can be used to create a stat=
e
>>> machine for an object evaluation.
>>>
>>> I don't see a way to do an efficient and programmatic path evaluation=
,
>>> with different access checks, with the current eBPF features. Please =
let
>>> me know if you know how to do it another way.
>>>
>>
>> Andy, Alexei, Daniel, what do you think about this Landlock program
>> chaining and cookie?
>>
>=20
> Can you give a small pseudocode real world example that acutally needs
> chaining?  The mechanism is quite complicated and I'd like to
> understand how it'll be used.
>=20

Here is the interesting part from the example (patch 09/11):

+SEC("maps")
+struct bpf_map_def inode_map =3D {
+	.type =3D BPF_MAP_TYPE_INODE,
+	.key_size =3D sizeof(u32),
+	.value_size =3D sizeof(u64),
+	.max_entries =3D 20,
+};
+
+SEC("subtype/landlock1")
+static union bpf_prog_subtype _subtype1 =3D {
+	.landlock_hook =3D {
+		.type =3D LANDLOCK_HOOK_FS_WALK,
+	}
+};
+
+static __always_inline __u64 update_cookie(__u64 cookie, __u8 lookup,
+		void *inode, void *chain, bool freeze)
+{
+	__u64 map_allow =3D 0;
+
+	if (cookie =3D=3D 0) {
+		cookie =3D bpf_inode_get_tag(inode, chain);
+		if (cookie)
+			return cookie;
+		/* only look for the first match in the map, ignore nested
+		 * paths in this example */
+		map_allow =3D bpf_inode_map_lookup(&inode_map, inode);
+		if (map_allow)
+			cookie =3D 1 | map_allow;
+	} else {
+		if (cookie & COOKIE_VALUE_FREEZED)
+			return cookie;
+		map_allow =3D cookie & _MAP_MARK_MASK;
+		cookie &=3D ~_MAP_MARK_MASK;
+		switch (lookup) {
+		case LANDLOCK_CTX_FS_WALK_INODE_LOOKUP_DOTDOT:
+			cookie--;
+			break;
+		case LANDLOCK_CTX_FS_WALK_INODE_LOOKUP_DOT:
+			break;
+		default:
+			/* ignore _MAP_MARK_MASK overflow in this example */
+			cookie++;
+			break;
+		}
+		if (cookie >=3D 1)
+			cookie |=3D map_allow;
+	}
+	/* do not modify the cookie for each fs_pick */
+	if (freeze && cookie)
+		cookie |=3D COOKIE_VALUE_FREEZED;
+	return cookie;
+}
+
+SEC("landlock1")
+int fs_walk(struct landlock_ctx_fs_walk *ctx)
+{
+	ctx->cookie =3D update_cookie(ctx->cookie, ctx->inode_lookup,
+			(void *)ctx->inode, (void *)ctx->chain, false);
+	return LANDLOCK_RET_ALLOW;
+}

The program "landlock1" is called for every directory execution (except
the last one if it is the leaf of a path). This enables to identify a
file hierarchy with only a (one dimension) list of file descriptors
(i.e. inode_map).

Underneath, the Landlock LSM part looks if there is an associated path
walk (nameidata) with each inode access request. If there is one, then
the cookie associated with the path walk (if any) is made available
through the eBPF program context. This enables to develop a state
machine with an eBPF program to "evaluate" a file path (without string
parsing).

The goal with this chaining mechanism is to be able to express a complex
kernel object like a file, with multiple run of one or more eBPF
programs, as a multilayer evaluation. This semantic may only make sense
for the user/developer and his security policy. We must keep in mind
that this object identification should be available to unprivileged
processes. This means that we must be very careful to what kind of
information are available to an eBPF program because this can then leak
to a process (e.g. through a map). With this mechanism, only information
already available to user space is available to the eBPF program.

In this example, the complexity of the path evaluation is in the eBPF
program. We can then keep the kernel code more simple and generic. This
enables more flexibility for a security policy definition.


--hHaom91hQZiq9frJExV3TxjZTzpQ1zqIf--

--fsDpHUePup1Pjb0yAkxFgn5ORwNxLpEVq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlrKkVwACgkQIt7+33O9
apUzZQf9H63aJWoUkZXNK/mRrYNCksy5NJOE476+wpAkrVjq7LhfF74pQ5BQG70B
fhPUU9v86sVorcWp26nO5qPmIG5FCUTgIF6WPs1BcGzrOdj0iRzY+Dxs0OYieqoN
6b1Fj2kUm/oMOCuGqWYbNEmthAd8DrM+2tvPInknC1rhhNByuCacTBPRfIJk7G8S
LKvwmVFGRBK7Q4h86y7uhh72KDv/eDyGNQn7evzgS91DUlMklWpM+QdH+0eo25Dw
+HC5zNwS0DVWUCwLWM/vQ2MJNVcSPYF9c48VgnVDSm+e3fPRg+BTxD0pRsmX/W2G
HV1dySa7jNHLNQ48ha+2G2+8Dw5SNg==
=F+M6
-----END PGP SIGNATURE-----

--fsDpHUePup1Pjb0yAkxFgn5ORwNxLpEVq--
