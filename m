Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1884699-1519749618-2-17902534843344312240
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519749617; b=Q+oNIiFSvzv5jP4F8uuIWWmsG+ZtWTbT/6kfsMFOCjvwByd
    p3eMl8FyHCOzEM4wA4MoDQNGsa9uqalHv3wNzCw0YEtobbS86NCPwux6GPIcv22Y
    uKihuXgFZzPjMci3brucmlxnl/xnYRN0GNoQSLIq5xFBxRKT8xs2l/ZlGOPkI++W
    sWHVs+EG0lKzM//c1lQ2UHMfbW5eq3B2PSWp9TRg+GU2W8Y6fR0k4JONnwitSepF
    lUT8AqZDvoj5fCy/QaBUDau0hGrZKtC3VR8Q8agPbd8BChwcvATpbsI2oWmHxejv
    zXsXdUTOph0UD+iFiYwmV4QdNQOg+MXMRglBm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519749617; bh=9GI1ZyCCcnxbB/zHLwqL0fxRLTSfr+WTjTZ78sGN8DM=; b=N
    N109TUNf8F+gjqONzceYW8gBNausLMWffXw137nlbjLNDAIsMsf2AS5155c4OX+9
    +hgUuceBJO0gaow60LOzjvING1k8N/13edEG+qg/aAPwEEVxkUyWHT46n3RDeVW/
    IckURlFkuwZRwCLmGZiBkexv33xyUrOJhvYZKTOIsB9068WXWc1TM6QRvBjCaksZ
    qunrWVi5cC+KGa0YLey+SjyZj3cfvwWbpVWIPAFKGLjXdmLbp4BCWOKnqxGSFTBK
    acOvZTyXg9pxmUGK/+UpDro81W1tMdtq7K3RPbQwLY9aUb+GaEPcClsbT4Bla+si
    qPZredNLsHAdmzDIFZ54A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeB0QkO convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 27 Feb 2018 11:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752085AbeB0QkM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 27 Feb 2018 11:40:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B31217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x227dUmDROsVe93bEGdOSzZbmcfW1bTB5WlXxv/R3aFg5RNyEf8Y6g47l9kmxOM7uAmAdi06zCmnak5pamsuqImM=
MIME-Version: 1.0
In-Reply-To: <20180227053255.a7ua24kjd6tvei2a@ast-mbp>
References: <20180227004121.3633-1-mic@digikod.net> <20180227004121.3633-6-mic@digikod.net>
 <20180227020856.teq4hobw3zwussu2@ast-mbp> <CALCETrVKRYnGJ9XNW-x7eHdMt+eGP90j7cAed-KTzp1KT_kMeQ@mail.gmail.com>
 <20180227045458.wjrbbsxf3po656du@ast-mbp> <CALCETrXZ=xJEd53RhA67_VDoAKBWgUeyBi9XN7ibrE7V6nzk5Q@mail.gmail.com>
 <20180227053255.a7ua24kjd6tvei2a@ast-mbp>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 27 Feb 2018 16:39:50 +0000
X-Gmail-Original-Message-ID: <CALCETrUqc0wbig4ntQe9KNS-fOgYOpD+MPodXYruCRyJ7bhagA@mail.gmail.com>
Message-ID: <CALCETrUqc0wbig4ntQe9KNS-fOgYOpD+MPodXYruCRyJ7bhagA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/11] seccomp,landlock: Enforce Landlock
 programs per process hierarchy
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 5:32 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Feb 27, 2018 at 05:20:55AM +0000, Andy Lutomirski wrote:
>> On Tue, Feb 27, 2018 at 4:54 AM, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> > On Tue, Feb 27, 2018 at 04:40:34AM +0000, Andy Lutomirski wrote:
>> >> On Tue, Feb 27, 2018 at 2:08 AM, Alexei Starovoitov
>> >> <alexei.starovoitov@gmail.com> wrote:
>> >> > On Tue, Feb 27, 2018 at 01:41:15AM +0100, Mickaël Salaün wrote:
>> >> >> The seccomp(2) syscall can be used by a task to apply a Landlock program
>> >> >> to itself. As a seccomp filter, a Landlock program is enforced for the
>> >> >> current task and all its future children. A program is immutable and a
>> >> >> task can only add new restricting programs to itself, forming a list of
>> >> >> programss.
>> >> >>
>> >> >> A Landlock program is tied to a Landlock hook. If the action on a kernel
>> >> >> object is allowed by the other Linux security mechanisms (e.g. DAC,
>> >> >> capabilities, other LSM), then a Landlock hook related to this kind of
>> >> >> object is triggered. The list of programs for this hook is then
>> >> >> evaluated. Each program return a 32-bit value which can deny the action
>> >> >> on a kernel object with a non-zero value. If every programs of the list
>> >> >> return zero, then the action on the object is allowed.
>> >> >>
>> >> >> Multiple Landlock programs can be chained to share a 64-bits value for a
>> >> >> call chain (e.g. evaluating multiple elements of a file path).  This
>> >> >> chaining is restricted when a process construct this chain by loading a
>> >> >> program, but additional checks are performed when it requests to apply
>> >> >> this chain of programs to itself.  The restrictions ensure that it is
>> >> >> not possible to call multiple programs in a way that would imply to
>> >> >> handle multiple shared values (i.e. cookies) for one chain.  For now,
>> >> >> only a fs_pick program can be chained to the same type of program,
>> >> >> because it may make sense if they have different triggers (cf. next
>> >> >> commits).  This restrictions still allows to reuse Landlock programs in
>> >> >> a safe way (e.g. use the same loaded fs_walk program with multiple
>> >> >> chains of fs_pick programs).
>> >> >>
>> >> >> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> >> >
>> >> > ...
>> >> >
>> >> >> +struct landlock_prog_set *landlock_prepend_prog(
>> >> >> +             struct landlock_prog_set *current_prog_set,
>> >> >> +             struct bpf_prog *prog)
>> >> >> +{
>> >> >> +     struct landlock_prog_set *new_prog_set = current_prog_set;
>> >> >> +     unsigned long pages;
>> >> >> +     int err;
>> >> >> +     size_t i;
>> >> >> +     struct landlock_prog_set tmp_prog_set = {};
>> >> >> +
>> >> >> +     if (prog->type != BPF_PROG_TYPE_LANDLOCK_HOOK)
>> >> >> +             return ERR_PTR(-EINVAL);
>> >> >> +
>> >> >> +     /* validate memory size allocation */
>> >> >> +     pages = prog->pages;
>> >> >> +     if (current_prog_set) {
>> >> >> +             size_t i;
>> >> >> +
>> >> >> +             for (i = 0; i < ARRAY_SIZE(current_prog_set->programs); i++) {
>> >> >> +                     struct landlock_prog_list *walker_p;
>> >> >> +
>> >> >> +                     for (walker_p = current_prog_set->programs[i];
>> >> >> +                                     walker_p; walker_p = walker_p->prev)
>> >> >> +                             pages += walker_p->prog->pages;
>> >> >> +             }
>> >> >> +             /* count a struct landlock_prog_set if we need to allocate one */
>> >> >> +             if (refcount_read(&current_prog_set->usage) != 1)
>> >> >> +                     pages += round_up(sizeof(*current_prog_set), PAGE_SIZE)
>> >> >> +                             / PAGE_SIZE;
>> >> >> +     }
>> >> >> +     if (pages > LANDLOCK_PROGRAMS_MAX_PAGES)
>> >> >> +             return ERR_PTR(-E2BIG);
>> >> >> +
>> >> >> +     /* ensure early that we can allocate enough memory for the new
>> >> >> +      * prog_lists */
>> >> >> +     err = store_landlock_prog(&tmp_prog_set, current_prog_set, prog);
>> >> >> +     if (err)
>> >> >> +             return ERR_PTR(err);
>> >> >> +
>> >> >> +     /*
>> >> >> +      * Each task_struct points to an array of prog list pointers.  These
>> >> >> +      * tables are duplicated when additions are made (which means each
>> >> >> +      * table needs to be refcounted for the processes using it). When a new
>> >> >> +      * table is created, all the refcounters on the prog_list are bumped (to
>> >> >> +      * track each table that references the prog). When a new prog is
>> >> >> +      * added, it's just prepended to the list for the new table to point
>> >> >> +      * at.
>> >> >> +      *
>> >> >> +      * Manage all the possible errors before this step to not uselessly
>> >> >> +      * duplicate current_prog_set and avoid a rollback.
>> >> >> +      */
>> >> >> +     if (!new_prog_set) {
>> >> >> +             /*
>> >> >> +              * If there is no Landlock program set used by the current task,
>> >> >> +              * then create a new one.
>> >> >> +              */
>> >> >> +             new_prog_set = new_landlock_prog_set();
>> >> >> +             if (IS_ERR(new_prog_set))
>> >> >> +                     goto put_tmp_lists;
>> >> >> +     } else if (refcount_read(&current_prog_set->usage) > 1) {
>> >> >> +             /*
>> >> >> +              * If the current task is not the sole user of its Landlock
>> >> >> +              * program set, then duplicate them.
>> >> >> +              */
>> >> >> +             new_prog_set = new_landlock_prog_set();
>> >> >> +             if (IS_ERR(new_prog_set))
>> >> >> +                     goto put_tmp_lists;
>> >> >> +             for (i = 0; i < ARRAY_SIZE(new_prog_set->programs); i++) {
>> >> >> +                     new_prog_set->programs[i] =
>> >> >> +                             READ_ONCE(current_prog_set->programs[i]);
>> >> >> +                     if (new_prog_set->programs[i])
>> >> >> +                             refcount_inc(&new_prog_set->programs[i]->usage);
>> >> >> +             }
>> >> >> +
>> >> >> +             /*
>> >> >> +              * Landlock program set from the current task will not be freed
>> >> >> +              * here because the usage is strictly greater than 1. It is
>> >> >> +              * only prevented to be freed by another task thanks to the
>> >> >> +              * caller of landlock_prepend_prog() which should be locked if
>> >> >> +              * needed.
>> >> >> +              */
>> >> >> +             landlock_put_prog_set(current_prog_set);
>> >> >> +     }
>> >> >> +
>> >> >> +     /* prepend tmp_prog_set to new_prog_set */
>> >> >> +     for (i = 0; i < ARRAY_SIZE(tmp_prog_set.programs); i++) {
>> >> >> +             /* get the last new list */
>> >> >> +             struct landlock_prog_list *last_list =
>> >> >> +                     tmp_prog_set.programs[i];
>> >> >> +
>> >> >> +             if (last_list) {
>> >> >> +                     while (last_list->prev)
>> >> >> +                             last_list = last_list->prev;
>> >> >> +                     /* no need to increment usage (pointer replacement) */
>> >> >> +                     last_list->prev = new_prog_set->programs[i];
>> >> >> +                     new_prog_set->programs[i] = tmp_prog_set.programs[i];
>> >> >> +             }
>> >> >> +     }
>> >> >> +     new_prog_set->chain_last = tmp_prog_set.chain_last;
>> >> >> +     return new_prog_set;
>> >> >> +
>> >> >> +put_tmp_lists:
>> >> >> +     for (i = 0; i < ARRAY_SIZE(tmp_prog_set.programs); i++)
>> >> >> +             put_landlock_prog_list(tmp_prog_set.programs[i]);
>> >> >> +     return new_prog_set;
>> >> >> +}
>> >> >
>> >> > Nack on the chaining concept.
>> >> > Please do not reinvent the wheel.
>> >> > There is an existing mechanism for attaching/detaching/quering multiple
>> >> > programs attached to cgroup and tracing hooks that are also
>> >> > efficiently executed via BPF_PROG_RUN_ARRAY.
>> >> > Please use that instead.
>> >> >
>> >>
>> >> I don't see how that would help.  Suppose you add a filter, then
>> >> fork(), and then the child adds another filter.  Do you want to
>> >> duplicate the entire array?  You certainly can't *modify* the array
>> >> because you'll affect processes that shouldn't be affected.
>> >>
>> >> In contrast, doing this through seccomp like the earlier patches
>> >> seemed just fine to me, and seccomp already had the right logic.
>> >
>> > it doesn't look to me that existing seccomp side of managing fork
>> > situation can be reused. Here there is an attempt to add 'chaining'
>> > concept which sort of an extension of existing seccomp style,
>> > but somehow heavily done on bpf side and contradicts cgroup/tracing.
>> >
>>
>> I don't see why the seccomp way can't be used.  I agree with you that
>> the seccomp *style* shouldn't be used in bpf code like this, but I
>> think that Landlock programs can and should just live in the existing
>> seccomp chain.  If the existing seccomp code needs some modification
>> to make this work, then so be it.
>
> +1
> if that was the case...
> but that's not my reading of the patch set.

An earlier version of the patch set used the seccomp filter chain.
Mickaël, what exactly was wrong with that approach other than that the
seccomp() syscall was awkward for you to use?  You could add a
seccomp_add_landlock_rule() syscall if you needed to.

As a side comment, why is this an LSM at all, let alone a non-stacking
LSM?  It would make a lot more sense to me to make Landlock depend on
having LSMs configured in but to call the landlock hooks directly from
the security_xyz() hooks.

>
>> In other words, the kernel already has two kinds of chaining:
>> seccomp's and bpf's.  bpf's doesn't work right for this type of usage
>> across fork(), whereas seccomp's already handles that case correctly.
>> (In contrast, seccomp's is totally wrong for cgroup-attached filters.)
>>  So IMO Landlock should use the seccomp core code and call into bpf
>> for the actual filtering.
>
> +1
> in cgroup we had to invent this new BPF_PROG_RUN_ARRAY mechanism,
> since cgroup hierarchy can be complicated with bpf progs attached
> at different levels with different override/multiprog properties,
> so walking link list and checking all flags at run-time would have
> been too slow. That's why we added compute_effective_progs().

If we start adding override flags to Landlock, I think we're doing it
wrong.   With cgroup bpf programs, the whole mess is set up by the
administrator.  With seccomp, and with Landlock if done correctly, it
*won't* be set up by the administrator, so the chance that everyone
gets all the flags right is about zero.  All attached filters should
run unconditionally.
