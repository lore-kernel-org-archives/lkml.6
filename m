Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1461520844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A07xrtrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1461520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbeGYBqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:46:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59226 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbeGYBqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:46:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6P0YcmW152557;
        Wed, 25 Jul 2018 00:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=/E+ukspvPx4ueqD4ZULSOYVSmkNbzbC8N5M7Xmb4Jak=;
 b=A07xrtrNSFEVdV1jXaFu0JHaUzQ5WUprI3CutOTYztdYoB8ENs98Si4EN8pWkSQUQwhW
 XvQnGE/Q8Es9uc/HWTyMZsVb4C8N3Oi5GnkhEh0k4B7FfUD/Wqwmq2TER/16N3S0fY2R
 hZeg/+oHw8vJ+7EA+8rhRL1Hh41PdUMdeNsWiddbXEEMQvVSXwwu83a3EoD8xF0x4i+K
 w2vgUyzW9F7/35qaGGMS7SC6nkn0w2dFJAH3NkIehuXz/MEQKjD77/kqrvgKSfXAm6GT
 NhenXL6F8NQoB2SmjOjUjNS/ACK/tXtdbwkoxnait8Rh3e4xsJUn7iVT7NzvxaU5lWBc Wg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2kbtbcueur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 00:36:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6P0avlt017549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 00:36:57 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6P0avoN009196;
        Wed, 25 Jul 2018 00:36:57 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Jul 2018 17:36:57 -0700
Received: by mail-oi0-f44.google.com with SMTP id k81-v6so10839462oib.4;
        Tue, 24 Jul 2018 17:36:57 -0700 (PDT)
X-Gm-Message-State: AOUpUlHswg9qOoo/vO9Z8dGIWTc3Nhbg29d4zTDPiAldZU73GFGRYc7A
        mWmDrm0xmwTq3ZEKjT9weAYiIvXMGaNYVFF3W/c=
X-Google-Smtp-Source: AAOMgpdr3XUSD17M2rB/cTlItWG65mjKh9vA3zICLzpU5wnZCNNeAoBtwLQwmKKzgkR1NrPzufFu+iWdnBoVVYDMcgA=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr1274720oia.156.1532479017220;
 Tue, 24 Jul 2018 17:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <tip-857baa87b6422bcfb84ed3631d6839920cb5b09d@git.kernel.org>
 <20180724195215.GA22496@roeck-us.net> <CAGM2reayvBs8rs6yHZYV9SvPz-tsNG_Ux8ypHguLLagiS2SkuA@mail.gmail.com>
In-Reply-To: <CAGM2reayvBs8rs6yHZYV9SvPz-tsNG_Ux8ypHguLLagiS2SkuA@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 24 Jul 2018 20:36:21 -0400
X-Gmail-Original-Message-ID: <CAGM2rebX7dq_ejNuSotV_0gJZY6pqro-KteXz9zzhDkjtSxaOw@mail.gmail.com>
Message-ID: <CAGM2rebX7dq_ejNuSotV_0gJZY6pqro-KteXz9zzhDkjtSxaOw@mail.gmail.com>
Subject: Re: [tip:x86/timers] sched/clock: Enable sched clock early
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 4:22 PM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> On Tue, Jul 24, 2018 at 3:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Hi,
> >
> > On Thu, Jul 19, 2018 at 03:33:21PM -0700, tip-bot for Pavel Tatashin wrote:
> > > Commit-ID:  857baa87b6422bcfb84ed3631d6839920cb5b09d
> > > Gitweb:     https://git.kernel.org/tip/857baa87b6422bcfb84ed3631d6839920cb5b09d
> > > Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
> > > AuthorDate: Thu, 19 Jul 2018 16:55:42 -0400
> > > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > > CommitDate: Fri, 20 Jul 2018 00:02:43 +0200
> > >
> > > sched/clock: Enable sched clock early
> > >
> > > Allow sched_clock() to be used before schec_clock_init() is called.  This
> > > provides a way to get early boot timestamps on machines with unstable
> > > clocks.
> > >
> >
> > This patch causes a regression when running a qemu emulation with
> > arm:integratorcp.
>
> Thank you for the report. I will study it.
>
> >
> > ...
> > Console: colour dummy device 80x30
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:180
> > sched_clock_register+0x44/0x278
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc6-next-20180724 #1
> > Hardware name: ARM Integrator/CP (Device Tree)
> > [<c0010cb4>] (unwind_backtrace) from [<c000dc24>] (show_stack+0x10/0x18)
> > [<c000dc24>] (show_stack) from [<c03ffb94>] (dump_stack+0x18/0x24)
> > [<c03ffb94>] (dump_stack) from [<c001a000>] (__warn+0xc8/0xf0)
> > [<c001a000>] (__warn) from [<c001a13c>] (warn_slowpath_null+0x3c/0x4c)
> > [<c001a13c>] (warn_slowpath_null) from [<c052367c>] (sched_clock_register+0x44/0x278)
> > [<c052367c>] (sched_clock_register) from [<c05238d8>] (generic_sched_clock_init+0x28/0x88)
> > [<c05238d8>] (generic_sched_clock_init) from [<c0521a00>] (sched_clock_init+0x54/0x74)
> > [<c0521a00>] (sched_clock_init) from [<c0519c18>] (start_kernel+0x310/0x3e4)
> > [<c0519c18>] (start_kernel) from [<00000000>] (  (null))
> > ---[ end trace 08080eb81afa002c ]---
> > sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
> > ...
> >
> > A complete boot log is available at
> > http://kerneltests.org/builders/qemu-arm-next/builds/979/steps/qemubuildcommand/logs/stdio
> >
> > Unfortunately, reverting the patch results in conflicts, so I am unable
> > to confirm that it is the only culprit.
> >
> > From the context and from looking into the patch, it appears that this
> > can happen in any system if CONFIG_HAVE_UNSTABLE_SCHED_CLOCK is not
> > enabled.

Do you have a complete config, and also qemu args that were used? I
have tried defconfig arm, and run in qemu, could not reproduce the
problem.

Thank you,
Pavel

> >
> > Bisect log is attached.
> >
> > Guenter
> >
> > ---
> > # bad: [3946cd385042069ec57d3f04240def53b4eed7e5] Add linux-next specific files for 20180724
> > # good: [d72e90f33aa4709ebecc5005562f52335e106a60] Linux 4.18-rc6
> > git bisect start 'HEAD' 'v4.18-rc6'
> > # good: [f5fa891e325acf096c0f79e1d1b922002e251e5a] Merge remote-tracking branch 'crypto/master'
> > git bisect good f5fa891e325acf096c0f79e1d1b922002e251e5a
> > # good: [cb6471f6bcfdacbeef9c23ba9dac00e67bd3c3a4] Merge remote-tracking branch 'spi/for-next'
> > git bisect good cb6471f6bcfdacbeef9c23ba9dac00e67bd3c3a4
> > # bad: [6b5bfa57bf4553d051be65d85d021465041406d8] Merge remote-tracking branch 'char-misc/char-misc-next'
> > git bisect bad 6b5bfa57bf4553d051be65d85d021465041406d8
> > # bad: [675a67e9ef3c041999f412cb75418d2b0def3854] Merge remote-tracking branch 'rcu/rcu/next'
> > git bisect bad 675a67e9ef3c041999f412cb75418d2b0def3854
> > # good: [e78b01a51131f25fc2d881bc43001575c129069c] Merge branch 'perf/core'
> > git bisect good e78b01a51131f25fc2d881bc43001575c129069c
> > # good: [4e581bce514f4107ce84525f0f75f89c92b4140e] Merge branch 'x86/cpu'
> > git bisect good 4e581bce514f4107ce84525f0f75f89c92b4140e
> > # good: [20fa22e90e54e2d21cace7ba083598531670f7cf] Merge branch 'x86/pti'
> > git bisect good 20fa22e90e54e2d21cace7ba083598531670f7cf
> > # good: [4763f03d3d186ce8a1125844790152d76804ad60] x86/tsc: Use TSC as sched clock early
> > git bisect good 4763f03d3d186ce8a1125844790152d76804ad60
> > # good: [5f9ef44c7d1c59d0eda1d86e31d981bdffe2a725] tools/memory-model: Rename litmus tests to comply to norm7
> > git bisect good 5f9ef44c7d1c59d0eda1d86e31d981bdffe2a725
> > # bad: [fc3d25e1c8f6a9232530db02a1072033e22e0fe3] Merge branch 'x86/timers'
> > git bisect bad fc3d25e1c8f6a9232530db02a1072033e22e0fe3
> > # bad: [46457ea464f5341d1f9dad8dd213805d45f7f117] sched/clock: Use static key for sched_clock_running
> > git bisect bad 46457ea464f5341d1f9dad8dd213805d45f7f117
> > # bad: [857baa87b6422bcfb84ed3631d6839920cb5b09d] sched/clock: Enable sched clock early
> > git bisect bad 857baa87b6422bcfb84ed3631d6839920cb5b09d
> > # good: [5d2a4e91a541cb04d20d11602f0f9340291322ac] sched/clock: Move sched clock initialization and merge with generic clock
> > git bisect good 5d2a4e91a541cb04d20d11602f0f9340291322ac
> > # first bad commit: [857baa87b6422bcfb84ed3631d6839920cb5b09d] sched/clock: Enable sched clock early
