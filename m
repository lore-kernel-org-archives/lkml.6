Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A74C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC52720823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="K2SgDnb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC52720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeKSVut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:50:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45552 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbeKSVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:50:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so25783096ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 03:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t5uTk1+gdaFjUDPsSuFp1Xhw/I50f1KTycgKFIEfIHE=;
        b=K2SgDnb6RohlYOrWU/XbAjiF9hPX4ABOL5lltn8j7+qxoGpJ8uEsaGjTBiR9jkChYm
         Why+BM963H0O/dGnu5Q24RIQ00Kew/Ep+ID5oXtFH3lKcqzHJZ+s0grWZAZwkevxALrZ
         ZVq6fLgwNY8rJtbbLc/7kn8Xf/dxTUc5KANgRvnxpsitWxVt6otZ+II3+ISlWuWnpTAi
         uuaWMy4w7nk9cPT2/s53Nu7f1V92FHehhHuIaBeS2kAssJvai9m9RKz5nttTzRopiJzy
         FMvGc1MPpk32tOHfzRN86zxKPvh7HNz0PsFVODKMZM+XEcId8UaZelvwGEsPLBr9RQXM
         R/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t5uTk1+gdaFjUDPsSuFp1Xhw/I50f1KTycgKFIEfIHE=;
        b=oGlCiM/Hox4tHECkf6zPx6BDPc7W4/J1ct2Rdzk+rP/JXsnKCzgrjoCjnEGI1c4B8x
         EuM6JriUEZduaLgNNURIOR6Nh5NSJF0BJugLhbtucH0VkmyshpJXJGF5902ar5Afas0D
         T+rJ6VotCvxCqkgfnmkWBagFMn4UbTd5cRJAxr2Aw9JCpAtIAkMw3xz4MAwkz7HRSUH0
         YIVojxUqknmCFCMGl9yrL7jDPwgjDIBu9khKw8R4dvEFUdByeZIf8jUrWCnFRzExE1bl
         Tmicb0ZWuuX3LjdpeBo4Uoz8H4z+IgM/iyg71+GaDBairemST04ZEwlKN413BPycl5Vw
         3NoQ==
X-Gm-Message-State: AGRZ1gKrJUYXGHzCkULbWCO6Yg0RzPP13nGrxr8UUSZ6N8+iId3MMbsp
        J5UdJAvCrSv/ImF3rZA7JIGyZ/kSLc0XLw==
X-Google-Smtp-Source: AJdET5fg3qKNmIA7pEopzeQf/9cXskdKgyFl7O0N7y2s/cLzkdMgem4O9n8EzCgFYb2sUIiZQ/nrJw==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr11075033lja.170.1542626845487;
        Mon, 19 Nov 2018 03:27:25 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id g17sm2961461lfg.78.2018.11.19.03.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 03:27:24 -0800 (PST)
Date:   Mon, 19 Nov 2018 12:27:21 +0100
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/17] Backport rt/deadline crash and the ardous story of
 FUTEX_UNLOCK_PI to 4.4
Message-ID: <20181119112720.GA29334@sisyphus.home.austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
 <20181109103531.GA9188@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20181109103531.GA9188@sisyphus.home.austad.us>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2018 at 11:35:31AM +0100, Henrik Austad wrote:
> On Fri, Nov 09, 2018 at 11:07:28AM +0100, Henrik Austad wrote:
> > From: Henrik Austad <haustad@cisco.com>
> >=20
> > Short story:
>=20
> Sorry for the spam, it looks like I was not very specific in /which/=20
> version I targeted this to, as well as not providing a full Cc-list for t=
he=20
> cover-letter.

Gentle prod. I realize this was sent out just before plumbers and that=20
people had pretty packed agendas, so a small nudge to gain a spot closer to=
=20
the top of the inbox :)

This series has now been running on an arm64 system for 9 days without any=
=20
issues and pi_stress showed a dramatic improvement from ~30 seconds and up=
=20
to several ours (it finally deadlocked at 3.9e9 inversions).

I'd greatly appreciate if someone could give the list of patches a quick=20
glance to verify that I got all the required patches and then if it could=
=20
be added to 4.4.y.

Thanks!

-Henrik


> The series is targeted at stable v4.4.162.
>=20
> Expanding Cc-list to those missing from the first attempt.
>=20
> -Henrik
>=20
> > The following patches are needed on a 4.4 kernel to avoid
> > Oops in the scheduler when a sched_rr and sched_deadline task contends
> > on the same futex (with PI).
> >=20
> > Longer story:
> >=20
> > On one of our arm64 systems, we occasionally crash with an Oops in the
> > scheduler with the following backtrace.
> >=20
> > [<ffffffc0000ee398>] enqueue_task_dl+0x1f0/0x420
> > [<ffffffc0000d0f14>] activate_task+0x7c/0x90
> > [<ffffffc0000edbdc>] push_dl_task+0x164/0x1c8
> > [<ffffffc0000edc60>] push_dl_tasks+0x20/0x30
> > [<ffffffc0000cc00c>] __balance_callback+0x44/0x68
> > [<ffffffc000d2c018>] __schedule+0x6f0/0x728
> > [<ffffffc000d2c278>] schedule+0x78/0x98
> > [<ffffffc000d2e76c>] __rt_mutex_slowlock+0x9c/0x108
> > [<ffffffc000d2e9d0>] rt_mutex_slowlock+0xd8/0x198
> > [<ffffffc0000f7f28>] rt_mutex_timed_futex_lock+0x30/0x40
> > [<ffffffc00012c1a8>] futex_lock_pi+0x200/0x3b0
> > [<ffffffc00012cf84>] do_futex+0x1c4/0x550
> > [<ffffffc00012d92c>] compat_SyS_futex+0x10c/0x138
> > [<ffffffc00008504c>] __sys_trace_return+0x0/0x4
> >=20
> > This seems to be the same bug Xuneli Pang triggered and fixed in
> > e96a7705e7d3 "sched/rtmutex/deadline: Fix a PI crash for deadline
> > tasks". As noted by Peter Zijlstra in the previous attempt, this fix
> > requires a few other patches, most notably the FUTEX_UNLOCK_PI series
> > [1]
> >=20
> > Testing this on a dual-core VM I have not been able to reproduce the
> > same crash, but pi_stress (part of the rt-test suite) reveals that
> > vanilla 4.4.162 behaves rather badly with a mix of deadline and
> > sched_(rr|fifo) tasks:
> >=20
> > time pi_stress --rr --mlockall --sched id=3Dhigh,policy=3Ddeadline,runt=
ime=3D100000,deadline=3D200000,period=3D200000
> > Starting PI Stress Test
> > Number of thread groups: 1
> > Duration of test run: infinite
> > Number of inversions per group: unlimited
> >      Admin thread SCHED_RR priority 4
> > 1 groups of 3 threads will be created
> >       High thread SCHED_DEADLINE runtime 100000 deadline 200000 period =
200000
> >        Med thread SCHED_RR priority 2
> >        Low thread SCHED_RR priority 1
> > Current Inversions: 141627
> > WATCHDOG triggered: group 0 is deadlocked!
> > reporter stopping due to watchdog event
> > Stopping test
> > Terminated
> >=20
> > real    0m26.291s
> > user    0m0.148s
> > sys     0m18.819s
> >=20
> > With this series applied, the test ran for ~4.5 hours and again for 129
> > minutes (when I remembered to time it) before crashing:
> >=20
> > time pi_stress --rr --mlockall --sched id=3Dhigh,policy=3Ddeadline,runt=
ime=3D100000,deadline=3D200000,period=3D200000
> > Starting PI Stress Test
> > Number of thread groups: 1
> > Duration of test run: infinite
> > Number of inversions per group: unlimited
> >      Admin thread SCHED_RR priority 4
> > 1 groups of 3 threads will be created
> >       High thread SCHED_DEADLINE runtime 100000 deadline 200000 period =
200000
> >        Med thread SCHED_RR priority 2
> >        Low thread SCHED_RR priority 1
> > Current Inversions: 51985223
> > WATCHDOG triggered: group 0 is deadlocked!
> > reporter stopping due to watchdog event
> > Stopping test
> > Terminated
> >=20
> > real    129m38.807s
> > user    0m59.084s
> > sys     109m53.666s
> >=20
> >=20
> > So clearly not perfect, but a *lot* better.
> >=20
> > The same series on our vendor-4.4 kernel moves pi_stress up from ~30
> > seconds before deadlock up to the same level as the VM (the test is
> > still going as of this writing).
> >=20
> > I suspect other users of 4.4 would benefit from having these patches
> > backported, so tag them for stable. I assume 4.9 and 4.14 could benefit
> > as well, but I have not had time to look into those.
> >=20
> > 1) https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1359667=
=2Ehtml
> >=20
> > Peter Zijlstra (13):
> >   futex: Cleanup variable names for futex_top_waiter()
> >   futex: Use smp_store_release() in mark_wake_futex()
> >   futex: Remove rt_mutex_deadlock_account_*()
> >   futex,rt_mutex: Provide futex specific rt_mutex API
> >   futex: Change locking rules
> >   futex: Cleanup refcounting
> >   futex: Rework inconsistent rt_mutex/futex_q state
> >   futex: Pull rt_mutex_futex_unlock() out from under hb->lock
> >   futex,rt_mutex: Introduce rt_mutex_init_waiter()
> >   futex,rt_mutex: Restructure rt_mutex_finish_proxy_lock()
> >   futex: Rework futex_lock_pi() to use rt_mutex_*_proxy_lock()
> >   futex: Futex_unlock_pi() determinism
> >   futex: Drop hb->lock before enqueueing on the rtmutex
> >=20
> > Thomas Gleixner (2):
> >   rtmutex: Make wait_lock irq safe
> >   futex: Rename free_pi_state() to put_pi_state()
> >=20
> > Xunlei Pang (2):
> >   rtmutex: Deboost before waking up the top waiter
> >   sched/rtmutex/deadline: Fix a PI crash for deadline tasks
> >=20
> >  include/linux/init_task.h       |   1 +
> >  include/linux/sched.h           |   2 +
> >  include/linux/sched/rt.h        |   1 +
> >  kernel/fork.c                   |   1 +
> >  kernel/futex.c                  | 532 ++++++++++++++++++++++++++------=
--------
> >  kernel/locking/rtmutex-debug.c  |   9 -
> >  kernel/locking/rtmutex-debug.h  |   3 -
> >  kernel/locking/rtmutex.c        | 406 ++++++++++++++++++------------
> >  kernel/locking/rtmutex.h        |   2 -
> >  kernel/locking/rtmutex_common.h |  24 +-
> >  kernel/sched/core.c             |   2 +
> >  11 files changed, 620 insertions(+), 363 deletions(-)
> >=20
> > --=20
> > 2.7.4
> >=20
>=20
> --=20
> Henrik Austad



--=20
Henrik Austad

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvynhgACgkQ6k5VT6v45lkwPwCbBLNImzUZqVN8HgIZJLusO8I0
RccAn2CTddVK3rZgDaKGS2kFxLnXmQAB
=Iupx
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
