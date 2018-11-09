Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65687C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB9520855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="B1Hti8td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB9520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeKIUPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:15:37 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39892 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeKIUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:15:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so959425lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GovBMPHVb2xC3UNFzrfwbUOwOKuEbee1HACZWfSdBF4=;
        b=B1Hti8td1DL2PVpXC7Y1k9QJmGUqz94a2a/fD70R3k1R9xkPruuvHrG9jnc2wje1M2
         YWynremFx3eiJhWyXvKXfCamuIfL9ziRcAIlUUeZ9OXUyRAvzAEUf7Wgn9H5x/UAPYWA
         mLFjXM3IYxXxYmfF38ubwHK/tHNOTEH/j1ihCkyXS9ECQ9cUX1LSzRW/Hdt6rY8UiWRC
         w2NHtlhthTn75TEIqrj4+lexH+LyvAqtkaKkX8FoNnl0Wwe63MRb9nm9Y6L36WLW8wmF
         Gz6xFGU22KwxVMQHvuh2n3ZJ9mc7cc5Y1oWgeLGTxU3rBjW3FAxNggSvyShnWYR/B4Xa
         KwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GovBMPHVb2xC3UNFzrfwbUOwOKuEbee1HACZWfSdBF4=;
        b=aMwiRFkNr6mAGmrXsB93d0uRALdrUfoTvd0lhDO2xjndzV+vKxX8GwxI4NKcjtpBHn
         RF7d5VNbh5Xfj29pX6tr6+EMRiqZuFQ4Deg1gTsXIQd5KcYRSMZ9Tuoj2TkZBIzTlDcR
         PvPUQlVWfrSvUY6JdfiAtDaWSu2apIJVwTgHquoWFkdk+E5IszVKzHQ/Ub05+WGbfHgJ
         b6hgTMZExkRwnAJQmIlvEDI6zr0tX2NtKlFaDphgyEpXLU6MQ/+l+Tb2B9JjPjRO3nLa
         r4XioCn+2rwVJhSmO0DVovwutc/1hxojz8ilqIlQl/uZhilOiVRnqJlzrzKEAO+/E9yk
         FbtA==
X-Gm-Message-State: AGRZ1gI5PBilLfThR/8veqUJ0MIytMlEVF1qk4YwsBpn1cWwCAO+MaLh
        2DJsDzrUWjF+ww7WygvYqOuT6vQKeEmPMmuH
X-Google-Smtp-Source: AJdET5dNL/oT9o8TbieZ0Kht+p4z2afw/aoEN+Ag8JGA2GwYhcna0bglyqWeK3SnAmYrl/NjuGy5AQ==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr4739469lfd.74.1541759734308;
        Fri, 09 Nov 2018 02:35:34 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id j126sm1262826lfe.10.2018.11.09.02.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 02:35:33 -0800 (PST)
Date:   Fri, 9 Nov 2018 11:35:31 +0100
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
Message-ID: <20181109103531.GA9188@sisyphus.home.austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2018 at 11:07:28AM +0100, Henrik Austad wrote:
> From: Henrik Austad <haustad@cisco.com>
>=20
> Short story:

Sorry for the spam, it looks like I was not very specific in /which/=20
version I targeted this to, as well as not providing a full Cc-list for the=
=20
cover-letter.

The series is targeted at stable v4.4.162.

Expanding Cc-list to those missing from the first attempt.

-Henrik

> The following patches are needed on a 4.4 kernel to avoid
> Oops in the scheduler when a sched_rr and sched_deadline task contends
> on the same futex (with PI).
>=20
> Longer story:
>=20
> On one of our arm64 systems, we occasionally crash with an Oops in the
> scheduler with the following backtrace.
>=20
> [<ffffffc0000ee398>] enqueue_task_dl+0x1f0/0x420
> [<ffffffc0000d0f14>] activate_task+0x7c/0x90
> [<ffffffc0000edbdc>] push_dl_task+0x164/0x1c8
> [<ffffffc0000edc60>] push_dl_tasks+0x20/0x30
> [<ffffffc0000cc00c>] __balance_callback+0x44/0x68
> [<ffffffc000d2c018>] __schedule+0x6f0/0x728
> [<ffffffc000d2c278>] schedule+0x78/0x98
> [<ffffffc000d2e76c>] __rt_mutex_slowlock+0x9c/0x108
> [<ffffffc000d2e9d0>] rt_mutex_slowlock+0xd8/0x198
> [<ffffffc0000f7f28>] rt_mutex_timed_futex_lock+0x30/0x40
> [<ffffffc00012c1a8>] futex_lock_pi+0x200/0x3b0
> [<ffffffc00012cf84>] do_futex+0x1c4/0x550
> [<ffffffc00012d92c>] compat_SyS_futex+0x10c/0x138
> [<ffffffc00008504c>] __sys_trace_return+0x0/0x4
>=20
> This seems to be the same bug Xuneli Pang triggered and fixed in
> e96a7705e7d3 "sched/rtmutex/deadline: Fix a PI crash for deadline
> tasks". As noted by Peter Zijlstra in the previous attempt, this fix
> requires a few other patches, most notably the FUTEX_UNLOCK_PI series
> [1]
>=20
> Testing this on a dual-core VM I have not been able to reproduce the
> same crash, but pi_stress (part of the rt-test suite) reveals that
> vanilla 4.4.162 behaves rather badly with a mix of deadline and
> sched_(rr|fifo) tasks:
>=20
> time pi_stress --rr --mlockall --sched id=3Dhigh,policy=3Ddeadline,runtim=
e=3D100000,deadline=3D200000,period=3D200000
> Starting PI Stress Test
> Number of thread groups: 1
> Duration of test run: infinite
> Number of inversions per group: unlimited
>      Admin thread SCHED_RR priority 4
> 1 groups of 3 threads will be created
>       High thread SCHED_DEADLINE runtime 100000 deadline 200000 period 20=
0000
>        Med thread SCHED_RR priority 2
>        Low thread SCHED_RR priority 1
> Current Inversions: 141627
> WATCHDOG triggered: group 0 is deadlocked!
> reporter stopping due to watchdog event
> Stopping test
> Terminated
>=20
> real    0m26.291s
> user    0m0.148s
> sys     0m18.819s
>=20
> With this series applied, the test ran for ~4.5 hours and again for 129
> minutes (when I remembered to time it) before crashing:
>=20
> time pi_stress --rr --mlockall --sched id=3Dhigh,policy=3Ddeadline,runtim=
e=3D100000,deadline=3D200000,period=3D200000
> Starting PI Stress Test
> Number of thread groups: 1
> Duration of test run: infinite
> Number of inversions per group: unlimited
>      Admin thread SCHED_RR priority 4
> 1 groups of 3 threads will be created
>       High thread SCHED_DEADLINE runtime 100000 deadline 200000 period 20=
0000
>        Med thread SCHED_RR priority 2
>        Low thread SCHED_RR priority 1
> Current Inversions: 51985223
> WATCHDOG triggered: group 0 is deadlocked!
> reporter stopping due to watchdog event
> Stopping test
> Terminated
>=20
> real    129m38.807s
> user    0m59.084s
> sys     109m53.666s
>=20
>=20
> So clearly not perfect, but a *lot* better.
>=20
> The same series on our vendor-4.4 kernel moves pi_stress up from ~30
> seconds before deadlock up to the same level as the VM (the test is
> still going as of this writing).
>=20
> I suspect other users of 4.4 would benefit from having these patches
> backported, so tag them for stable. I assume 4.9 and 4.14 could benefit
> as well, but I have not had time to look into those.
>=20
> 1) https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1359667.h=
tml
>=20
> Peter Zijlstra (13):
>   futex: Cleanup variable names for futex_top_waiter()
>   futex: Use smp_store_release() in mark_wake_futex()
>   futex: Remove rt_mutex_deadlock_account_*()
>   futex,rt_mutex: Provide futex specific rt_mutex API
>   futex: Change locking rules
>   futex: Cleanup refcounting
>   futex: Rework inconsistent rt_mutex/futex_q state
>   futex: Pull rt_mutex_futex_unlock() out from under hb->lock
>   futex,rt_mutex: Introduce rt_mutex_init_waiter()
>   futex,rt_mutex: Restructure rt_mutex_finish_proxy_lock()
>   futex: Rework futex_lock_pi() to use rt_mutex_*_proxy_lock()
>   futex: Futex_unlock_pi() determinism
>   futex: Drop hb->lock before enqueueing on the rtmutex
>=20
> Thomas Gleixner (2):
>   rtmutex: Make wait_lock irq safe
>   futex: Rename free_pi_state() to put_pi_state()
>=20
> Xunlei Pang (2):
>   rtmutex: Deboost before waking up the top waiter
>   sched/rtmutex/deadline: Fix a PI crash for deadline tasks
>=20
>  include/linux/init_task.h       |   1 +
>  include/linux/sched.h           |   2 +
>  include/linux/sched/rt.h        |   1 +
>  kernel/fork.c                   |   1 +
>  kernel/futex.c                  | 532 ++++++++++++++++++++++++++--------=
------
>  kernel/locking/rtmutex-debug.c  |   9 -
>  kernel/locking/rtmutex-debug.h  |   3 -
>  kernel/locking/rtmutex.c        | 406 ++++++++++++++++++------------
>  kernel/locking/rtmutex.h        |   2 -
>  kernel/locking/rtmutex_common.h |  24 +-
>  kernel/sched/core.c             |   2 +
>  11 files changed, 620 insertions(+), 363 deletions(-)
>=20
> --=20
> 2.7.4
>=20

--=20
Henrik Austad

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvlYvMACgkQ6k5VT6v45lll1ACdG0ZuI8262HgyZVK38DgkSuDe
+HQAoJXwkwRP9d3fOqiWSBC+YN0xR1a8
=21mi
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
