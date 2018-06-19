Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4603C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522722083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RZHGuRDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522722083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757462AbeFSV0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:26:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42488 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755540AbeFSV0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:26:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JLJtCs148346
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=JEtJIvg0Ao3QuQ91TO5GAYEdG/bnTrjDMQytXh9phro=;
 b=RZHGuRDsnEQEYPAq8XziNzeQSUjg7kHJxmnswH3IWPYxa6Tm3BbASmmQMAsUq7VDhyaH
 OJ65hlGZFfE6VLCHVoRponoZ84nrg17bM1ZqGmCqbEEwS5gIa8XPS89aftyrg+SH7IcP
 f2ryuOinF/W+tzQGBT5gyXeJKoXkWEvEtoM2cK9J46Jc1HcbuMjZZn3KD/nl0eddrLia
 JJQ/ScH3KKX2VMUsmNKtLZzI7XhqR7qXKf0K8CwGPAyLSw+pk7YjixphFFTQDVbuxFR9
 GxqxWT+7mIvhc0YXEGIWWyEcp0QTtme8cuQnoJm97tLz9TaOG5+0Bnr1sIA3zux7l9aX Nw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jmr2mj3h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:26:35 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5JLQXMI023313
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:26:33 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5JLQXMj007702
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:26:33 GMT
Received: from mail-oi0-f52.google.com (/209.85.218.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 14:26:33 -0700
Received: by mail-oi0-f52.google.com with SMTP id t133-v6so1091076oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:26:33 -0700 (PDT)
X-Gm-Message-State: APt69E0bDnjpKSZMk1FGxBFReMQZBfXOv2lGeOQTz1M7Cbg14yANOiiY
        X2G7mg51U0x9SyLQqLv72PwxMzNR3TbOBPMUMHk=
X-Google-Smtp-Source: ADUXVKKw9OoX5r5djtllZUW14QWO/pOHGIMDUFkP6B8U2yA59wT1NXaFwtkj9V0VPbiCLm+hApFUKO/3egwunF3PzPo=
X-Received: by 2002:aca:3b09:: with SMTP id i9-v6mr10932448oia.156.1529443592847;
 Tue, 19 Jun 2018 14:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-3-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806192129460.10546@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806192129460.10546@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 19 Jun 2018 17:25:56 -0400
X-Gmail-Original-Message-ID: <CAGM2reaEGOjVEFu3pDHdRfMFjRNvaLZxTncao3rAgpEijKLb7g@mail.gmail.com>
Message-ID: <CAGM2reaEGOjVEFu3pDHdRfMFjRNvaLZxTncao3rAgpEijKLb7g@mail.gmail.com>
Subject: Re: [PATCH v10 2/7] time: sync read_boot_clock64() with persistent clock
To:     tglx@linutronix.de
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 5:17 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 15 Jun 2018, Pavel Tatashin wrote:
>
> > read_boot_clock64() returns a boot start timestamp from epoch. Some arches
> > may need to access the persistent clock interface in order to calculate the
> > epoch offset. The resolution of the persistent clock, however, might be
> > low.  Therefore, in order to avoid time discrepancies a new argument 'now'
> > is added to read_boot_clock64() parameters. Arch may decide to use it
> > instead of accessing persistent clock again.
>
> I kinda know what you are trying to say, but it's all but obvious.
>
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 4786df904c22..fb6898fab374 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -1502,9 +1502,13 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
> >   * Function to read the exact time the system has been started.
> >   * Returns a timespec64 with tv_sec=0 and tv_nsec=0 if unsupported.
> >   *
> > + * Argument 'now' contains time from persistent clock to calculate offset from
> > + * epoch. May contain zeros if persist ant clock is not available.
>
> What's a 'persist ant' ?

persistent, but I think spell checker decided that I was writing about
some ants. :)

>
> > + *
> >   *  XXX - Do be sure to remove it once all arches implement it.
> >   */
> > -void __weak read_boot_clock64(struct timespec64 *ts)
> > +void __weak __init read_boot_clock64(struct timespec64 *now,
> > +                                  struct timespec64 *ts)
> >  {
> >       ts->tv_sec = 0;
> >       ts->tv_nsec = 0;
> > @@ -1535,7 +1539,7 @@ void __init timekeeping_init(void)
> >       } else if (now.tv_sec || now.tv_nsec)
> >               persistent_clock_exists = true;
> >
> > -     read_boot_clock64(&boot);
> > +     read_boot_clock64(&now, &boot);
>
> This interface was already bolted on and this extension just makes it
> worse. If 'now' is invalid then you need the same checks as after
> read_persistent_clock() replicated along with conditionals of some sort.
>
> 'boot' time is used to adjust the wall to monotonic offset. So looking at
> the math behind all of that:
>
>    read_persistent_clock(&now);
>    read_boot_clock(&boot);
>
>    tk_set_xtime(tk, now)
>      tk->xtime_sec = now.sec;
>      tk->xtime_nsec = now.nsec;
>
>   tk_set_wall_to_mono(tk, -boot);
>      tk->wall_to_mono = boot;
>      tk->offs_real = -boot;
>
>   timekeeping_update(tk)
>      tk->tkr_mono = tk->xtime + tk->wall_to_mono;
>
> tkr_mono.base is guaranteed to be >= 0. So you need to make sure that
>
>      tk->xtime + tk->wall_to_mono >= 0
>
> Yet another check which you need to do in that magic function. That's just
> wrong. If this grows more users then they all have to copy the same sanity
> checks over and over and half of them will be wrong.
>
> Fortunately there is only a single real user of read_boot_clock() in the
> tree: S390. By virtue of being S390 there is no worry about any sanity
> checks. It just works.
>
> ARM has the function, but there is no single subarch which actually
> implements the thing, so this is easy to fix by removing it.
>
> So the right thing to do is the following:
>
> Provide a new function:
>
> void __weak read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
>                                                  ktime_t *boot_offset)
> {
>         read_persistent_clock(wall_time);
> }
>
> Then add the new function to S390:
>
> void read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
>                                           ktime_t *boot_offset)
> {
>         unsigned char clk[STORE_CLOCK_EXT_SIZE];
>         struct timespec64 boot_time;
>         __u64 delta;
>
>         read_persistent_clock(wall_time);
>
>         delta = initial_leap_seconds + TOD_UNIX_EPOCH;
>         memcpy(clk, tod_clock_base, 16);
>         *(__u64 *) &clk[1] -= delta;
>         if (*(__u64 *) &clk[1] > delta)
>                 clk[0]--;
>         ext_to_timespec64(clk, boot_time);
>         *boot_offset = timespec64_to_ns(timespec64_sub(wall_time, boot_time));
> }
>
> Then rework timekeeping_init():
>
> timekeeping_init()
>    struct timespec64 wall_time, wall_to_mono, offs;
>    ktime_t boot_offset = 0;
>
>    read_persistent_wall_and_boot_offset(&walltime, &boot_offset);
>
>    if (!valid(walltime))
>         boottime = wall_time.tv_sec = wall_time.tv_nsec = 0;
>    else
>         persistent_clock = true;
>
>    if (boot_offset > timespec64_to_nsec(wall_time))
>        offs.tv_sec = offs.tv_nsec = 0;
>    else
>        offs = ns_to_timespec64(boot_offset);
>
>    wall_to_mono = timespec64_sub(offs, wall_time);
>    tk_set_wall_to_mono(tk, wall_time);
>
>
> After that remove the read_boot_time() leftovers all over the place. And
> then the x86 implementation boils down to:
>
> void read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
>                                           ktime_t *boot_offset)
> {
>          x86_platform.get_wallclock(ts);
>          *boot_offset = sched_clock();
> }
>
> And doing it this way - by adding the extra math to the only architecture
> on the planet which has sane timers - is the right thing to do because all
> other architectures will have to fall back to tricks similar to x86 by
> doing clocksource/schedclock based guestimation of the time where the
> machine actually reached the kernel.
>
> Hmm?

Sounds good, I will redo this and the next patch with your suggestions.

Thank you,
Pavel
