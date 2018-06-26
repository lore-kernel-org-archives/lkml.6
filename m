Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1CCC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA3D26A0C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bMMwrcQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA3D26A0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934745AbeFZLwh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:52:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44412 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934063AbeFZLwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:52:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QBmuuJ081665;
        Tue, 26 Jun 2018 11:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=TfdLR9jac+rzbZoMlQWcpSbbzocwyi8ifuB4dt+hyw8=;
 b=bMMwrcQ2Le3MdSd4sAAGE2nIMEXcBYhm2OaRjoZRyVmRndyBEUIMk81wPfi3YqCTxszZ
 RbKvE3p1fZ9zGj8QzhYr+lcbTcc0Et4TNia4fs06CmQ+8FYdoVQfLCrjMwmpgohBuWv0
 ZPZvEoYL/vf4oGnIBWtSS9FHDz5J822KVp4Kwc7iJwz5uEDVYZ55xNBM+Q+GpG1GwPpq
 +DBnHZWtOXoSvxocTM7PAr72R+7GMuW7y+FTkgAQ++6R2tHaxxYyeuqAWGT7EleJfssk
 x792c8sxiybQHjAYNOFyrDnGr6tARR5WG+oVfa+6exqGl94+PC+Xw1e7ztJ1Rp2ceNd7 Qw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jum0a06jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 11:52:33 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5QBqVKn029728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 11:52:32 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5QBqVhb018744;
        Tue, 26 Jun 2018 11:52:31 GMT
Received: from mail-oi0-f48.google.com (/209.85.218.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 04:52:31 -0700
Received: by mail-oi0-f48.google.com with SMTP id 18-v6so6195645oiq.6;
        Tue, 26 Jun 2018 04:52:30 -0700 (PDT)
X-Gm-Message-State: APt69E1qQYOXyEIdwfxgcwJTt8F3Srb3+z4YRakkw0nWizWzglJ5txW9
        OskvXmZub1uqXgzrgkq+fDCxV6z+zUnYsquYjBQ=
X-Google-Smtp-Source: AAOMgpd9QD8PfA7QGZZinlO38uTSegY03XsNDosrIG6yBh1PdUaYKg12IFxesMAAxAKjY/UpFG9axw0BEBmzyV8bcSU=
X-Received: by 2002:aca:e5d2:: with SMTP id c201-v6mr657384oih.191.1530013950310;
 Tue, 26 Jun 2018 04:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com> <20180625085543.GT2494@hirez.programming.kicks-ass.net>
 <20180625192320.kzmqkvmfh5aeuhhx@xakep.localdomain> <20180626090003.GA2458@hirez.programming.kicks-ass.net>
 <20180626112705.4dxrsd5acvobla5y@xakep.localdomain>
In-Reply-To: <20180626112705.4dxrsd5acvobla5y@xakep.localdomain>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 26 Jun 2018 07:51:54 -0400
X-Gmail-Original-Message-ID: <CAGM2reZ98fm1TJEpeXErrXFOsMUwB9xHPr-Aq8E7uGjPQDvz+A@mail.gmail.com>
Message-ID: <CAGM2reZ98fm1TJEpeXErrXFOsMUwB9xHPr-Aq8E7uGjPQDvz+A@mail.gmail.com>
Subject: Re: [PATCH v12 10/11] sched: early boot clock
To:     peterz@infradead.org
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8935 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 7:29 AM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> >
> > How's something like this? That moves sched_clock_init() to right before
> > we enable IRQs for the first time (which is after we've started the
> > whole timekeeping business).
> >
> > The thing is, sched_clock_init_late() reall is far too late, we need to
> > switch to unstable before we bring up SMP.
>
> OK, sure.
>
> > -     sched_clock_postinit();
> > +     sched_clock_init();
>
> Yes, we can move sched_clock_init(). But placing it after time_init() would
> work on all arches with unstable clock except for x86.
>
> See comment above time_init x86:
> arch/x86/kernel/time.c
>
>  99/*
> 100 * Initialize TSC and delay the periodic timer init to
> 101 * late x86_late_time_init() so ioremap works.
> 102 */
> 103void __init time_init(void)
> 104{
> 105     late_time_init = x86_late_time_init;
> 106}
>
> Only After this:
> > >     late_time_init()
> > >         x86_late_time_init()
> > >             x86_init.timers.timer_init()
> > >             hpet_time_init() Only after this call we finally start
> > >             getting clock interrupts, and can get precise output from
> > >             sched_clock_local().
>
> We start getting timer interrupts. Is it acceptable to move
> sched_clock_init() after late_time_init()?

A change like this on top of your suggested change, would work:

1. Move  sched_clock_init() after late_time_init().
diff --git a/init/main.c b/init/main.c
index 162d931c9511..ff0a24170b95 100644
--- a/init/main.c
+++ b/init/main.c
@@ -642,7 +642,6 @@ asmlinkage __visible void __init start_kernel(void)
        softirq_init();
        timekeeping_init();
        time_init();
-       sched_clock_init();
        printk_safe_init();
        perf_event_init();
        profile_init();
@@ -697,6 +696,7 @@ asmlinkage __visible void __init start_kernel(void)
        acpi_early_init();
        if (late_time_init)
                late_time_init();
+       sched_clock_init();
        calibrate_delay();
        pid_idr_init();
        anon_vma_init();

2. sched_clock_tick() bailouts while sched_clock_running == 0, so we
must do __sched_clock_gtod_offset() after setting sched_clock_running
to 1, but also, we must have at least one tick passed in order for
correct computation. So something like this works, and preserves
continuity:

 void __init sched_clock_init(void)
 {
+       unsigned long flags;
+
+       pr_err("before sched_clock_running = 1");
+       sched_clock_running = 1;
        /*
         * Set __gtod_offset such that once we mark sched_clock_running,
         * sched_clock_tick() continues where sched_clock() left off.
@@ -208,8 +212,11 @@ void __init sched_clock_init(void)
         * Even if TSC is buggered, we're still UP at this point so it
         * can't really be out of sync.
         */
+       local_irq_save(flags);
+       sched_clock_tick();
+       local_irq_restore(flags);
        __sched_clock_gtod_offset();
-       sched_clock_running = 1;
+       pr_err("after sched_clock_running = 1");
 }

[    0.712302] APIC: Switch to symmetric I/O mode setup
[    0.717386] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.722031] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x2e02bde913e, max
_idle_ns: 440795290413 ns
[    0.722415] before sched_clock_running = 1
[    0.722544] after sched_clock_running = 1
[    0.722680] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6383.98 BogoMIPS (lpj=3191993)
[    0.723546] pid_max: default: 32768 minimum: 301
[    0.724087] Security Framework initialized
