Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C006BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C321A16
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mlu/Mfa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5C321A16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933219AbeFZSmw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:42:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33816 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752285AbeFZSmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:42:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QIe0t2102811;
        Tue, 26 Jun 2018 18:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=3J9DSDLz9nsLv43HQKxoGHpt8HsrtT/+o2r3LCFvNzY=;
 b=mlu/Mfa4T5YRNQ3UB/CcIgY7xTHNXGH/ebbQVeygTwwlcrdWjpjhAMZ3CzQja4Epekri
 a4jY/8ynaGNo4HvqMOsh0yYT3M1rhYynwC41umWF/nn46F0gQcAr4KGsZhZWIC015ljM
 S3R+gYZqYu5DQwa2LCG3ooSFZry++2xZOqveVDVXytQQ+4Omj0owFA8B6GozEMUo4ZtN
 Qg1lT3cEF2meQGa5PI0LKVYUDWg9TI5uGSNi46QK1CuhMHb0NhubV9Z0jUpugLzzYJRA
 v+SDsgzEEb/FoDOWRo6L2I9vk9o6lSzwyjDLH6uMOVlUaSdFy94R1v9tgqQkAXdNY3j6 VQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jukmtswqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 18:42:50 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5QIglpM001911
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 18:42:47 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5QIgkRx024992;
        Tue, 26 Jun 2018 18:42:47 GMT
Received: from mail-ot0-f177.google.com (/74.125.82.177)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 11:42:46 -0700
Received: by mail-ot0-f177.google.com with SMTP id a6-v6so5623796otf.2;
        Tue, 26 Jun 2018 11:42:46 -0700 (PDT)
X-Gm-Message-State: APt69E36OzNU1B3Df/qavn/3OKNk9zYapWGiRC47GoY33zvzkvkDYs2C
        wSqoq7pYnGpZ2rVAbG/pU3/0B0+5JpPnN7Yggdc=
X-Google-Smtp-Source: AAOMgpciQAZxrUrzcwYDswYnwSLuVtz0R7/vCrvRiY/tfNmQvsXr8h7JIw403eA1xDfGfDRYzC7eTuapGv8cQUmWsLE=
X-Received: by 2002:a9d:5b39:: with SMTP id x54-v6mr1435664oth.275.1530038566271;
 Tue, 26 Jun 2018 11:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
 <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 26 Jun 2018 14:42:09 -0400
X-Gmail-Original-Message-ID: <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
Message-ID: <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
To:     tglx@linutronix.de
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Jun 26, 2018 at 11:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Pavel,
>
> first of all, sorry for my last outburst. I just was in a lousy mood after
> staring into too much half baken stuff and failed to make myself stay away
> from the computer.

Thank you.

>
> On Sun, 24 Jun 2018, Thomas Gleixner wrote:
> > On Sat, 23 Jun 2018, Pavel Tatashin wrote:
> > And this early init sequence also needs to pull over the tsc adjust
> > magic. So tsc_early_delay_calibrate() which should btw. be renamed to
> > tsc_early_init() should have:
> >
> > {
> >       cpu_khz = x86_platform.calibrate_cpu();
> >         tsc_khz = x86_platform.calibrate_tsc();
> >
> >         tsc_khz = tsc_khz ? : cpu_khz;
> >         if (!tsc_khz)
> >                 return;
> >
> >         /* Sanitize TSC ADJUST before cyc2ns gets initialized */
> >         tsc_store_and_check_tsc_adjust(true);
> >
> >       calc_lpj(tsc_khz);
> >
> >       tsc_sched_clock_init();
> > }
>
> Peter made me look deeper into this and there are a few issues, which I
> missed, depending on when some of the resources become available. So we
> probably cannot hook all of this into tsc_early_delay_calibrate().
>
> I have an idea how to distangle it and we'll end up in a staged approach,
> which looks like this:
>
>     1) Earliest one (not sure how early yet)
>
>        Attempt to use MSR/CPUID. If not running on a hypervisor this can
>        try the quick PIT calibration, but nothing else.
>
>     2) Post init_hypervisor_platform()
>
>        An attempt to use the hypervisor data can be made.
>
>     3) Post early_acpi_boot_init()
>
>        This can do PIT/HPET based calibration
>
>     4) Post x86_dtb_init()
>
>        PIT/PMTIMER based calibration
>
> Once tsc_khz is known, no further attempts of calibration are made. I'll
> look into that later tonight.

I think, there are no reasons to try staged attempts. It usually gets
harder to maintain overtime. In my opinion it is best if do it in two
tries, as right now, but just cleaner. The first attempt we get a
crude result, using the lowest denominator to which current logic
might fallback if something else is not available that early in boot:
i.e cpu calibration loop in native_calibrate_cpu() but later get
something better. Also, even if early clock does not work because we
could not get tsc early, it is not a problem, we still will probably
determine it later during tsc_init call.

I have re-wrote tsc_early_init()/tsc_init(), they are much simpler now:

void __init tsc_early_init(void)
{
        if (!boot_cpu_has(X86_FEATURE_TSC))
                return;

        if (!determine_cpu_tsc_frequncies())
                return;

        cyc2ns_init_boot_cpu();
        static_branch_enable(&__use_tsc);

        loops_per_jiffy = get_loops_per_jiffy(tsc_khz);
}

void __init tsc_init(void)
{
        if (!boot_cpu_has(X86_FEATURE_TSC))
                return;

        if (!determine_cpu_tsc_frequncies()) {
                setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
                return;
        }

        /* Sanitize TSC ADJUST before cyc2ns gets initialized */
        tsc_store_and_check_tsc_adjust(true);

        cyc2ns_reinit_boot_cpu();
        cyc2ns_init_secondary_cpus();
        static_branch_enable(&__use_tsc);

        if (!no_sched_irq_time)
                enable_sched_clock_irqtime();

        lpj_fine = get_loops_per_jiffy(tsc_khz);
        use_tsc_delay();
        check_system_tsc_reliable();

        if (unsynchronized_tsc()) {
                mark_tsc_unstable("TSCs unsynchronized");
                return;
        }

        clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
        detect_art();
}

All the new functions are self explanatory. I added three cyc2ns
related functions based on your suggestions on how to clean-up that
code:

static void __init cyc2ns_init_boot(void)
{
        struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);

        seqcount_init(&c2n->seq);
        __set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
}

static void __init cyc2ns_init_secondary(void)
{
        unsigned int cpu, this_cpu = smp_processor_id();
        struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
        struct cyc2ns_data *data = c2n->data;

        for_each_possible_cpu(cpu) {
                if (cpu != this_cpu) {
                        seqcount_init(&c2n->seq);
                        c2n = per_cpu_ptr(&cyc2ns, cpu);
                        c2n->data[0] = data[0];
                        c2n->data[1] = data[1];
                }
        }
}

/* Reinitialize boot cpu c2ns, using the offset of the current
sched_clock() value */
static void __init cyc2ns_reinit_boot(void)
{
        struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
        unsigned long sched_now = sched_clock();

        __set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
        c2n->data[0].cyc2ns_offset += sched_now;
        c2n->data[1].cyc2ns_offset += sched_now;
}

I know, conceptually, it is similar to what I had before, but I think
it is simple enough, easy to maintain, but more importantly safe. What
do you think?

Thank you,
Pavel
