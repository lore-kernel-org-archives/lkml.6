Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2088ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD8C20883
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="scwJLjFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD8C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeGMLyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:54:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56382 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeGMLyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:54:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6DBclPQ014716;
        Fri, 13 Jul 2018 11:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=ZQnSgseBEdYtCg5YQ6J5kjvU8iAJ1P02+MDU4MoWe2c=;
 b=scwJLjFCTFRJkxzXN9oL2G4696xv/+FIHLj6ALzi4n70/9RY0psynfzy327A+E2t1y7c
 TLjoRzNqDVGWV1POr3WeOU4Y9sejNzMczh+qYBVuFP5OjAW+W9i5uZgS/iAZYv0tsXXn
 Vp0ZO1ExGIrj/N0tNsjIcF1GQl4AH5eGbsUAAwcUSu9q0O1YDvFdCSBOgeZfVDTGV6hP
 xw8yQBVIdZ62m3NdrGHexD6c6Pkm//qcOR+Pq3Mw8HF1jDfRYBqc+Spw7miCmEJfVrQ9
 2uVnF+CkEpO5q0P3kicqPZuTI5T482q5yUJseOq3g6ktLhsgsjhNvYZ/aRocqGGmVdIe 5g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k2p7e7ga4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 11:39:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6DBdeju029753
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 11:39:40 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6DBdduW028517;
        Fri, 13 Jul 2018 11:39:40 GMT
Received: from mail-oi0-f42.google.com (/209.85.218.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 04:39:39 -0700
Received: by mail-oi0-f42.google.com with SMTP id q11-v6so36070195oic.12;
        Fri, 13 Jul 2018 04:39:39 -0700 (PDT)
X-Gm-Message-State: AOUpUlEF8PlHyTM/ZUlbdaSh3KFhc8POOwjZ2/36QJfVBdiz9llKxXLy
        All5T9tQT2Kv/wgMUOvPk+YFdGHSqIcCtSlAXG0=
X-Google-Smtp-Source: AAOMgpcg9DJ96325Gr8qCW0lvNW6f/AEIj/uz0jPVvVblgGoNhNQial0JNmPwhb8qRwKhFDPFsOgK8d2WWHeojnbScI=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr7001255oia.156.1531481978946;
 Fri, 13 Jul 2018 04:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-15-pasha.tatashin@oracle.com> <dfd0e8d4-0020-d07c-2570-c1e1652875c5@cn.fujitsu.com>
In-Reply-To: <dfd0e8d4-0020-d07c-2570-c1e1652875c5@cn.fujitsu.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 13 Jul 2018 07:39:02 -0400
X-Gmail-Original-Message-ID: <CAGM2readdMd4t5vp0=RxDSZfhdJD_8XWBx0QT1dSKNM6d1xT0Q@mail.gmail.com>
Message-ID: <CAGM2readdMd4t5vp0=RxDSZfhdJD_8XWBx0QT1dSKNM6d1xT0Q@mail.gmail.com>
Subject: Re: [PATCH v13 14/18] x86/tsc: initialize cyc2ns when tsc freq. is determined
To:     douly.fnst@cn.fujitsu.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 5:13 AM Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
>
>
> At 07/12/2018 08:04 AM, Pavel Tatashin wrote:
> > cyc2ns converts tsc to nanoseconds, and it is handled in a per-cpu data
> > structure.
> >
> > Currently, the setup code for c2ns data for every possible CPU goes through
> > the same sequence of calculations as for the boot CPU, but is based on the
> > same tsc frequency as the boot CPU, and thus this is not necessary.
> >
> > Initialize the boot cpu when tsc frequency is determined. Copy the
> > calculated data from the boot CPU to the other CPUs in tsc_init().
> >
> > In addition do the following:
> >
> > - Remove unnecessary zeroing of c2ns data by removing cyc2ns_data_init()
> > - Split set_cyc2ns_scale() into two functions, so set_cyc2ns_scale() can be
> >    called when system is up, and wraps around __set_cyc2ns_scale() that can
> >    be called directly when system is booting but avoids saving restoring
> >    IRQs and going and waking up from idle.
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > ---
> >   arch/x86/kernel/tsc.c | 94 ++++++++++++++++++++++++-------------------
> >   1 file changed, 53 insertions(+), 41 deletions(-)
> >
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index bc8eb82050a3..0b1abe7fdd8e 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -103,23 +103,6 @@ void cyc2ns_read_end(void)
> >    *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
> >    */
> >
> > -static void cyc2ns_data_init(struct cyc2ns_data *data)
> > -{
> > -     data->cyc2ns_mul = 0;
> > -     data->cyc2ns_shift = 0;
> > -     data->cyc2ns_offset = 0;
> > -}
> > -
> > -static void __init cyc2ns_init(int cpu)
> > -{
> > -     struct cyc2ns *c2n = &per_cpu(cyc2ns, cpu);
> > -
> > -     cyc2ns_data_init(&c2n->data[0]);
> > -     cyc2ns_data_init(&c2n->data[1]);
> > -
> > -     seqcount_init(&c2n->seq);
> > -}
> > -
> >   static inline unsigned long long cycles_2_ns(unsigned long long cyc)
> >   {
> >       struct cyc2ns_data data;
> > @@ -135,18 +118,11 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
> >       return ns;
> >   }
> >
> > -static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
> > +static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
> >   {
> >       unsigned long long ns_now;
> >       struct cyc2ns_data data;
> >       struct cyc2ns *c2n;
> > -     unsigned long flags;
> > -
> > -     local_irq_save(flags);
> > -     sched_clock_idle_sleep_event();
> > -
> > -     if (!khz)
> > -             goto done;
> >
> >       ns_now = cycles_2_ns(tsc_now);
> >
> > @@ -178,12 +154,55 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
> >       c2n->data[0] = data;
> >       raw_write_seqcount_latch(&c2n->seq);
> >       c2n->data[1] = data;
> > +}
> > +
> > +static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
> > +{
> > +     unsigned long flags;
> > +
> > +     local_irq_save(flags);
> > +     sched_clock_idle_sleep_event();
> > +
> > +     if (khz)
> > +             __set_cyc2ns_scale(khz, cpu, tsc_now);
> >
> > -done:
> >       sched_clock_idle_wakeup_event();
> >       local_irq_restore(flags);
> >   } >
> > +/*
> > + * Initialize cyc2ns for boot cpu
> > + */
> > +static void __init cyc2ns_init_boot_cpu(void)
> > +{
> > +     struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
> > +
> > +     seqcount_init(&c2n->seq);
> > +     __set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
> > +}
> Hi Paval,
>
> Here we didn't protect it with local_irq_save()/local_irq_restore()

Hi Dou,

Thank you for reviewing this work.

Correct, but no need to do that: we do local_irqsave()/restore() only
in set_cyc2ns_scale(), because that is called when system is live, and
frequency changes.

cyc2ns_init_boot_cpu(), and cyc2ns_init_secondary_cpus(), are called
during boot, before smp_init(), and frequency does not change during
that time. So, nothing to protect us from.

> In tsc_init(), the timer interrupt has worked, Is that OK?
>
> IMO, no need to change so much, just use the original code,
> eg:

The request and suggestions on how to cleanup cyc2ns came from Thomas.
Overall, code is cleaner now.

Thank you,
Pavel
