Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-452929-1519709587-2-13978774459042933714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519709586; b=MTSxji8RC2GUIN7Im1jXl65mK/Z13cZjPppw7SQG7KDniZY
    iK1cZPNdztM4HLGIxvVG33dCoa5fz0k/xKPLjTtfZtV9qppfz/x5FRn5EIoiHhd+
    WGlhxALaFbcMuUtYFHtTxWsig+wWSz9zd+O35zpXy1vnX1MI+FoiTD27fsB9AA2i
    KRsiTAfiAV8nlu6yVyBrdpzCeV0OAugJ1ettkD+CkV/jdrDVA3v/aOzSzjTRQY7e
    FV/czUgtZYADFU9zM0surB8SV1wZjz4rIXuFIG1IduJ5/o/m+MUePFqWvYzVwmaY
    5Nk4/SLKYk9JmRIu9K7fI8coOIGLTWbuD9slvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519709586; bh=QpzqQGU
    Wmzd6V14WhAaDCBZ7p4Cy1rokA84zvLzHMRM=; b=wUzhHPtNNeqVtjo7rMsaVww
    b/brkP9NJmA/v/JFjgQ4iibHTmJGqFnOeKFshw9Pa7jLqAC0FegJUCKnNIcOW6BW
    bew2CtCmgg0qChT7D2Msd5OT31QIGF+0rgAYdfNuLEUa+VeDBOGM7qTmuY5Yofnb
    0xL0ykt33kHXnf6DZocjHqfJZA0z4udvSCp00wftStNMgWQsFVMBri9yf/ELlBCe
    wOLX+cTicDOj7lBw8oYwpvTTOXEn3X+WOSYalorS2J7a8IVvGezLiWLe6fdQmltY
    KrG8lQtiCTjiooVqma1YG+7Tk2qag7xpU5r9k/6WjukE4rCzKkrIGIvEuxgOOvg=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Zy1dIlbG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=arsLyaqZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Zy1dIlbG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=arsLyaqZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750888AbeB0FdE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 00:33:04 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:46623 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbeB0FdC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Feb 2018 00:33:02 -0500
X-Google-Smtp-Source: AG47ELtqX/hGCK4kSl92CnKTQIt8WO2yxgP+fx4v0dC0woXu9RpE7zAM1H98at9hORd6YEDWLk0VNQ==
Date: Mon, 26 Feb 2018 21:32:57 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
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
        Network Development <netdev@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v8 05/11] seccomp,landlock: Enforce Landlock
 programs per process hierarchy
Message-ID: <20180227053255.a7ua24kjd6tvei2a@ast-mbp>
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-6-mic@digikod.net>
 <20180227020856.teq4hobw3zwussu2@ast-mbp>
 <CALCETrVKRYnGJ9XNW-x7eHdMt+eGP90j7cAed-KTzp1KT_kMeQ@mail.gmail.com>
 <20180227045458.wjrbbsxf3po656du@ast-mbp>
 <CALCETrXZ=xJEd53RhA67_VDoAKBWgUeyBi9XN7ibrE7V6nzk5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrXZ=xJEd53RhA67_VDoAKBWgUeyBi9XN7ibrE7V6nzk5Q@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 05:20:55AM +0000, Andy Lutomirski wrote:
> On Tue, Feb 27, 2018 at 4:54 AM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Tue, Feb 27, 2018 at 04:40:34AM +0000, Andy Lutomirski wrote:
> >> On Tue, Feb 27, 2018 at 2:08 AM, Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >> > On Tue, Feb 27, 2018 at 01:41:15AM +0100, Mickaël Salaün wrote:
> >> >> The seccomp(2) syscall can be used by a task to apply a Landlock program
> >> >> to itself. As a seccomp filter, a Landlock program is enforced for the
> >> >> current task and all its future children. A program is immutable and a
> >> >> task can only add new restricting programs to itself, forming a list of
> >> >> programss.
> >> >>
> >> >> A Landlock program is tied to a Landlock hook. If the action on a kernel
> >> >> object is allowed by the other Linux security mechanisms (e.g. DAC,
> >> >> capabilities, other LSM), then a Landlock hook related to this kind of
> >> >> object is triggered. The list of programs for this hook is then
> >> >> evaluated. Each program return a 32-bit value which can deny the action
> >> >> on a kernel object with a non-zero value. If every programs of the list
> >> >> return zero, then the action on the object is allowed.
> >> >>
> >> >> Multiple Landlock programs can be chained to share a 64-bits value for a
> >> >> call chain (e.g. evaluating multiple elements of a file path).  This
> >> >> chaining is restricted when a process construct this chain by loading a
> >> >> program, but additional checks are performed when it requests to apply
> >> >> this chain of programs to itself.  The restrictions ensure that it is
> >> >> not possible to call multiple programs in a way that would imply to
> >> >> handle multiple shared values (i.e. cookies) for one chain.  For now,
> >> >> only a fs_pick program can be chained to the same type of program,
> >> >> because it may make sense if they have different triggers (cf. next
> >> >> commits).  This restrictions still allows to reuse Landlock programs in
> >> >> a safe way (e.g. use the same loaded fs_walk program with multiple
> >> >> chains of fs_pick programs).
> >> >>
> >> >> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> >> >
> >> > ...
> >> >
> >> >> +struct landlock_prog_set *landlock_prepend_prog(
> >> >> +             struct landlock_prog_set *current_prog_set,
> >> >> +             struct bpf_prog *prog)
> >> >> +{
> >> >> +     struct landlock_prog_set *new_prog_set = current_prog_set;
> >> >> +     unsigned long pages;
> >> >> +     int err;
> >> >> +     size_t i;
> >> >> +     struct landlock_prog_set tmp_prog_set = {};
> >> >> +
> >> >> +     if (prog->type != BPF_PROG_TYPE_LANDLOCK_HOOK)
> >> >> +             return ERR_PTR(-EINVAL);
> >> >> +
> >> >> +     /* validate memory size allocation */
> >> >> +     pages = prog->pages;
> >> >> +     if (current_prog_set) {
> >> >> +             size_t i;
> >> >> +
> >> >> +             for (i = 0; i < ARRAY_SIZE(current_prog_set->programs); i++) {
> >> >> +                     struct landlock_prog_list *walker_p;
> >> >> +
> >> >> +                     for (walker_p = current_prog_set->programs[i];
> >> >> +                                     walker_p; walker_p = walker_p->prev)
> >> >> +                             pages += walker_p->prog->pages;
> >> >> +             }
> >> >> +             /* count a struct landlock_prog_set if we need to allocate one */
> >> >> +             if (refcount_read(&current_prog_set->usage) != 1)
> >> >> +                     pages += round_up(sizeof(*current_prog_set), PAGE_SIZE)
> >> >> +                             / PAGE_SIZE;
> >> >> +     }
> >> >> +     if (pages > LANDLOCK_PROGRAMS_MAX_PAGES)
> >> >> +             return ERR_PTR(-E2BIG);
> >> >> +
> >> >> +     /* ensure early that we can allocate enough memory for the new
> >> >> +      * prog_lists */
> >> >> +     err = store_landlock_prog(&tmp_prog_set, current_prog_set, prog);
> >> >> +     if (err)
> >> >> +             return ERR_PTR(err);
> >> >> +
> >> >> +     /*
> >> >> +      * Each task_struct points to an array of prog list pointers.  These
> >> >> +      * tables are duplicated when additions are made (which means each
> >> >> +      * table needs to be refcounted for the processes using it). When a new
> >> >> +      * table is created, all the refcounters on the prog_list are bumped (to
> >> >> +      * track each table that references the prog). When a new prog is
> >> >> +      * added, it's just prepended to the list for the new table to point
> >> >> +      * at.
> >> >> +      *
> >> >> +      * Manage all the possible errors before this step to not uselessly
> >> >> +      * duplicate current_prog_set and avoid a rollback.
> >> >> +      */
> >> >> +     if (!new_prog_set) {
> >> >> +             /*
> >> >> +              * If there is no Landlock program set used by the current task,
> >> >> +              * then create a new one.
> >> >> +              */
> >> >> +             new_prog_set = new_landlock_prog_set();
> >> >> +             if (IS_ERR(new_prog_set))
> >> >> +                     goto put_tmp_lists;
> >> >> +     } else if (refcount_read(&current_prog_set->usage) > 1) {
> >> >> +             /*
> >> >> +              * If the current task is not the sole user of its Landlock
> >> >> +              * program set, then duplicate them.
> >> >> +              */
> >> >> +             new_prog_set = new_landlock_prog_set();
> >> >> +             if (IS_ERR(new_prog_set))
> >> >> +                     goto put_tmp_lists;
> >> >> +             for (i = 0; i < ARRAY_SIZE(new_prog_set->programs); i++) {
> >> >> +                     new_prog_set->programs[i] =
> >> >> +                             READ_ONCE(current_prog_set->programs[i]);
> >> >> +                     if (new_prog_set->programs[i])
> >> >> +                             refcount_inc(&new_prog_set->programs[i]->usage);
> >> >> +             }
> >> >> +
> >> >> +             /*
> >> >> +              * Landlock program set from the current task will not be freed
> >> >> +              * here because the usage is strictly greater than 1. It is
> >> >> +              * only prevented to be freed by another task thanks to the
> >> >> +              * caller of landlock_prepend_prog() which should be locked if
> >> >> +              * needed.
> >> >> +              */
> >> >> +             landlock_put_prog_set(current_prog_set);
> >> >> +     }
> >> >> +
> >> >> +     /* prepend tmp_prog_set to new_prog_set */
> >> >> +     for (i = 0; i < ARRAY_SIZE(tmp_prog_set.programs); i++) {
> >> >> +             /* get the last new list */
> >> >> +             struct landlock_prog_list *last_list =
> >> >> +                     tmp_prog_set.programs[i];
> >> >> +
> >> >> +             if (last_list) {
> >> >> +                     while (last_list->prev)
> >> >> +                             last_list = last_list->prev;
> >> >> +                     /* no need to increment usage (pointer replacement) */
> >> >> +                     last_list->prev = new_prog_set->programs[i];
> >> >> +                     new_prog_set->programs[i] = tmp_prog_set.programs[i];
> >> >> +             }
> >> >> +     }
> >> >> +     new_prog_set->chain_last = tmp_prog_set.chain_last;
> >> >> +     return new_prog_set;
> >> >> +
> >> >> +put_tmp_lists:
> >> >> +     for (i = 0; i < ARRAY_SIZE(tmp_prog_set.programs); i++)
> >> >> +             put_landlock_prog_list(tmp_prog_set.programs[i]);
> >> >> +     return new_prog_set;
> >> >> +}
> >> >
> >> > Nack on the chaining concept.
> >> > Please do not reinvent the wheel.
> >> > There is an existing mechanism for attaching/detaching/quering multiple
> >> > programs attached to cgroup and tracing hooks that are also
> >> > efficiently executed via BPF_PROG_RUN_ARRAY.
> >> > Please use that instead.
> >> >
> >>
> >> I don't see how that would help.  Suppose you add a filter, then
> >> fork(), and then the child adds another filter.  Do you want to
> >> duplicate the entire array?  You certainly can't *modify* the array
> >> because you'll affect processes that shouldn't be affected.
> >>
> >> In contrast, doing this through seccomp like the earlier patches
> >> seemed just fine to me, and seccomp already had the right logic.
> >
> > it doesn't look to me that existing seccomp side of managing fork
> > situation can be reused. Here there is an attempt to add 'chaining'
> > concept which sort of an extension of existing seccomp style,
> > but somehow heavily done on bpf side and contradicts cgroup/tracing.
> >
> 
> I don't see why the seccomp way can't be used.  I agree with you that
> the seccomp *style* shouldn't be used in bpf code like this, but I
> think that Landlock programs can and should just live in the existing
> seccomp chain.  If the existing seccomp code needs some modification
> to make this work, then so be it.

+1
if that was the case...
but that's not my reading of the patch set.

> In other words, the kernel already has two kinds of chaining:
> seccomp's and bpf's.  bpf's doesn't work right for this type of usage
> across fork(), whereas seccomp's already handles that case correctly.
> (In contrast, seccomp's is totally wrong for cgroup-attached filters.)
>  So IMO Landlock should use the seccomp core code and call into bpf
> for the actual filtering.

+1
in cgroup we had to invent this new BPF_PROG_RUN_ARRAY mechanism,
since cgroup hierarchy can be complicated with bpf progs attached
at different levels with different override/multiprog properties,
so walking link list and checking all flags at run-time would have
been too slow. That's why we added compute_effective_progs().

imo doing similar stuff at fork is not a big deal either.
allocating new bpf_prog_array for the task and computing
array of progs is trivial.

> For what it's worth, I haven't figured out that Mickaël means about
> chaining restrictions involving cookies.  This seems like something
> wrong and the design is too complicated.

the cookie part I don't like either.
In networking land we have cb in skb and xdp metadata to pass data
between programs.
imo right now for landlock there is no need to do any of this stuff.
It's purely a feature extension that is clearly controversial and
blocking even basic review of the rest of the patches.

