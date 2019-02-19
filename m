Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1451EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B494121736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHgDkOJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfBSWHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:07:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42802 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfBSWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:07:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id b8so25036745qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KIt0QdGw5hPrioCAEJm+R3DJCRy8TSxTGfDZsUjPAjw=;
        b=uHgDkOJp8WxdTppJqI6N5/Le8XRbQTt5dywE4DrMdzxHXp5pj73K7i12tKJ6qx/OQW
         IdMwLt8bNvpWY6db15poFtJjhhFI/0DGt4rW6GxlrViwVS0MdXBCm70jXcB9RpMIXDLR
         +Z99/YcNXRJN+UP39VKQESqHO6HonYbcXMvZZxFzy0DTiYjWZHZr6o5pBMyVWqbvjioH
         lTVD6wBThlgdvvjWzuo/44CZWR6yK1/GKfz4EwYYxPYhAWPJ9X2BqEYAeTagK9qH5ico
         4m5Xgf3qHnYKV/LUs8rBrHPm6Yg8dcz+PepmETlLA8KM8U0CAzfgXqF6Ex9ZYQpJbspM
         zFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KIt0QdGw5hPrioCAEJm+R3DJCRy8TSxTGfDZsUjPAjw=;
        b=lbordAHysePIB9B8tjYFR/CGc328/SNKPcQfO+ceU3vgLKgFcb0HBAh7KEgrf9EvBG
         RPDORdzhk2Uz//L//MfHNNrloKhz+Lgp5zf+Wc5dxNdkBG42k7o490COfe34BkNCx9en
         O1e0IKHR5YwkwkXcja29NxY91SssaLhnn839LgAemN0I2BBSAVsSbchOl7xXZkXLwkJp
         Kcda8/QL5x0EyHKT6GFLpU2K/G6+bXbR//Ri+o6hkQj6nUQ6P9xyAx3mHITAQLoS6Nab
         VbI2L1NUfyyH+d7yYMaR080HESF0rS8BmJq3PSuIcGBD7jwOQ2z4DJy8iaMlVWQfou1I
         b6ww==
X-Gm-Message-State: AHQUAuZpW7nfhdLbgnhHxtG6gDY4XxyIdKs7Q2/xg5n5PF8H7HVuT9yu
        NQRS6x6PeFWT9EdOlYmbQKQ8Wf2yDquaYwv8oYpTQw==
X-Google-Smtp-Source: AHgI3IYU0YiPkhyn+De7RLQNc4zDg+p2RArpKoUlbl70rE9GOxDwCgF2jFwfK/geKl68KrVNJjU+QGccqsy3lsXIlqE=
X-Received: by 2002:aed:3f7b:: with SMTP id q56mr24045813qtf.258.1550614032044;
 Tue, 19 Feb 2019 14:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org>
In-Reply-To: <20190218165620.383905466@infradead.org>
From:   Greg Kerr <kerrnel@google.com>
Date:   Tue, 19 Feb 2019 14:07:01 -0800
Message-ID: <CAJGSLMt_X97Ux=1YiZcXWXvBy4n=ExO=2yAJhfbvxDh+wnWPvQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, Paul Turner <pjt@google.com>,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for posting this patchset Peter. Based on the patch titled, "sched: =
A
quick and dirty cgroup tagging interface," I believe cgroups are used to
define co-scheduling groups in this implementation.

Chrome OS engineers (kerrnel@google.com, mpdenton@google.com, and
palmer@google.com) are considering an interface that is usable by unprivile=
ged
userspace apps. cgroups are a global resource that require privileged acces=
s.
Have you considered an interface that is akin to namespaces? Consider the
following strawperson API proposal (I understand prctl() is generally
used for process
specific actions, so we aren't married to using prctl()):

# API Properties

The kernel introduces coscheduling groups, which specify which processes ma=
y
be executed together. An unprivileged process may use prctl() to create a
coscheduling group. The process may then join the coscheduling group, and
place any of its child processes into the coscheduling group. To
provide flexibility for
unrelated processes to join pre-existing groups, an IPC mechanism could sen=
d a
coscheduling group handle between processes.

# Strawperson API Proposal
To create a new coscheduling group:
    int coscheduling_group =3D prctl(PR_CREATE_COSCHEDULING_GROUP);

The return value is >=3D 0 on success and -1 on failure, with the following
possible values for errno:

    ENOTSUP: This kernel doesn=E2=80=99t support the PR_NEW_COSCHEDULING_GR=
OUP
operation.
    EMFILE: The process=E2=80=99 kernel-side coscheduling group table is fu=
ll.

To join a given process to the group:
    pid_t process =3D /* self or child... */
    int status =3D prctl(PR_JOIN_COSCHEDULING_GROUP, coscheduling_group, pr=
ocess);
    if (status) {
        err(errno, NULL);
    }

The kernel will check and enforce that the given process ID really is the
caller=E2=80=99s own PID or a PID of one of the caller=E2=80=99s children, =
and that the given
group ID really exists. The return value is 0 on success and -1 on failure,
with the following possible values for errno:

    EPERM: The caller could not join the given process to the coscheduling
           group because it was not the creator of the given coscheduling g=
roup.
    EPERM: The caller could not join the given process to the coscheduling
           group because the given process was not the caller or one
of the caller=E2=80=99s
           children.
    EINVAL: The given group ID did not exist in the kernel-side coschedulin=
g
            group table associated with the caller.
    ESRCH: The given process did not exist.

Regards,

Greg Kerr (kerrnel@google.com)

On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
>
> A much 'demanded' feature: core-scheduling :-(
>
> I still hate it with a passion, and that is part of why it took a little
> longer than 'promised'.
>
> While this one doesn't have all the 'features' of the previous (never
> published) version and isn't L1TF 'complete', I tend to like the structur=
e
> better (relatively speaking: I hate it slightly less).
>
> This one is sched class agnostic and therefore, in principle, doesn't hor=
ribly
> wreck RT (in fact, RT could 'ab'use this by setting 'task->core_cookie =
=3D task'
> to force-idle siblings).
>
> Now, as hinted by that, there are semi sane reasons for actually having t=
his.
> Various hardware features like Intel RDT - Memory Bandwidth Allocation, w=
ork
> per core (due to SMT fundamentally sharing caches) and therefore grouping
> related tasks on a core makes it more reliable.
>
> However; whichever way around you turn this cookie; it is expensive and n=
asty.
>
> It doesn't help that there are truly bonghit crazy proposals for using th=
is out
> there, and I really hope to never see them in code.
>
> These patches are lightly tested and didn't insta explode, but no promise=
s,
> they might just set your pets on fire.
>
> 'enjoy'
>
> @pjt; I know this isn't quite what we talked about, but this is where I e=
nded
> up after I started typing. There's plenty design decisions to question an=
d my
> changelogs don't even get close to beginning to cover them all. Feel free=
 to ask.
>
> ---
>  include/linux/sched.h    |   9 +-
>  kernel/Kconfig.preempt   |   8 +-
>  kernel/sched/core.c      | 762 +++++++++++++++++++++++++++++++++++++++++=
+++---
>  kernel/sched/deadline.c  |  99 +++---
>  kernel/sched/debug.c     |   4 +-
>  kernel/sched/fair.c      | 129 +++++---
>  kernel/sched/idle.c      |  42 ++-
>  kernel/sched/pelt.h      |   2 +-
>  kernel/sched/rt.c        |  96 +++---
>  kernel/sched/sched.h     | 183 ++++++++----
>  kernel/sched/stop_task.c |  35 ++-
>  kernel/sched/topology.c  |   4 +-
>  kernel/stop_machine.c    |   2 +
>  13 files changed, 1096 insertions(+), 279 deletions(-)
>
>
