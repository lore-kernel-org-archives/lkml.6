Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D70C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B902596E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EaV4JKuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B902596E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755389AbeFYMph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:45:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52184 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeFYMpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:45:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5PCiF2X160853;
        Mon, 25 Jun 2018 12:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=PSLXSO/qk6b75cFUu+LPz1DsXeikR16VouWVHyZdmFM=;
 b=EaV4JKuXxcZb0b3IEtLsXoHJIr29ovn/pINIs7YhcxVfc+P5lOVrCn/q2rn0FAYIGfZK
 uR3ZtOf6kniiANOgwyGKklm2T8Lkf1lYA6bkMsw5jyeZEK9QwK5iYvxNjSPyM6mdf2x5
 Z3A1/nb7gu33cl2voo55+VqZc5EqfhYnOLa5Dqj6bgreWlmh4wGFAOZsDCuyB6nqxUvX
 DF3hSarcsxpqTp53HYob7wNu7p+Ox6QSo2qfBKaRAfxKOQUQGzTs+P+i+kTDnYoM0caC
 xlRoGnOcqAr9yP/pGHSgC5lOwgiVryQy0nze5bksa5A5H2+lDN4AT+XavS8XEID9TJAV jA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jt8a7jgn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:45:34 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5PCjXLk032502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:45:34 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5PCjX16021649;
        Mon, 25 Jun 2018 12:45:33 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Jun 2018 05:45:33 -0700
Received: by mail-oi0-f44.google.com with SMTP id 21-v6so1665907oip.8;
        Mon, 25 Jun 2018 05:45:33 -0700 (PDT)
X-Gm-Message-State: APt69E3qgkGzY5WgIzwOaVj3qRHl6lTS1fWRMBXKwVKw5hBSGAqVwO5u
        k/HJP4SU1io4fc9u+NeQNsigOiylv/N51OD+Qok=
X-Google-Smtp-Source: ADUXVKKNBg+YIaLR7Jg2c7EQvauqvXRxGUWXzmS0cyF0fwaFXGwVVdspgBQNK4HRCT5BV1bAQIU0e9jmJctrvLsbKb0=
X-Received: by 2002:aca:bcd4:: with SMTP id m203-v6mr6950185oif.163.1529930732723;
 Mon, 25 Jun 2018 05:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com> <20180625085543.GT2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180625085543.GT2494@hirez.programming.kicks-ass.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 25 Jun 2018 08:44:56 -0400
X-Gmail-Original-Message-ID: <CAGM2reaQTYhRCWHO05h+AjpCpefVetySSD1_3nCC=hjx0Q+sUA@mail.gmail.com>
Message-ID: <CAGM2reaQTYhRCWHO05h+AjpCpefVetySSD1_3nCC=hjx0Q+sUA@mail.gmail.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8934 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 4:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 21, 2018 at 05:25:17PM -0400, Pavel Tatashin wrote:
> > Allow sched_clock() to be used before schec_clock_init() and
> > sched_clock_init_late() are called. This provides us with a way to get
> > early boot timestamps on machines with unstable clocks.
>
> There are !x86 architectures that use this code and might not expect to
> have their sched_clock() called quite that early. Please verify.

Correct, with this change from what I could gather so far, the other
arches with unstable clocks either pick-up and start output time
earlier or output 0. I could not test on every specific configuration
of course.

>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > ---
> >  kernel/sched/clock.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > index 10c83e73837a..f034392b0f6c 100644
> > --- a/kernel/sched/clock.c
> > +++ b/kernel/sched/clock.c
> > @@ -205,6 +205,11 @@ void clear_sched_clock_stable(void)
> >   */
> >  static int __init sched_clock_init_late(void)
> >  {
> > +     /* Transition to unstable clock from early clock */
>
> This is wrong... or at least it smells horribly.
>
> This is not the point where we transition from early to unstable, that
> is in fact in sched_clock_init.
>
> This function, sched_clock_init_late(), is where we attempt to
> transition from unstable to stable. And this is _waaaay_ after SMP init.
>
> > +     local_irq_disable();
> > +     __gtod_offset = sched_clock() + __sched_clock_offset - ktime_get_ns();
> > +     local_irq_enable();
>
> This might work in sched_clock_init(), which is pre-SMP.
>
> >       sched_clock_running = 2;
> >       /*
> >        * Ensure that it is impossible to not do a static_key update.
> > @@ -350,8 +355,9 @@ u64 sched_clock_cpu(int cpu)
> >       if (sched_clock_stable())
> >               return sched_clock() + __sched_clock_offset;
> >
> > -     if (unlikely(!sched_clock_running))
> > -             return 0ull;
> > +     /* Use early clock until sched_clock_init_late() */
> > +     if (unlikely(sched_clock_running < 2))
> > +             return sched_clock() + __sched_clock_offset;
>
> And then this remains !sched_clock_running, except instead of 0, you
> then return sched_clock() + __sched_clock_offset;
>
> >       preempt_disable_notrace();
> >       scd = cpu_sdc(cpu);
>

All the above is because of:

> > +     if (unlikely(sched_clock_running < 2))
> > +             return sched_clock() + __sched_clock_offset;

Keep early boot clock until sched_clock_running
sched_clock_init_late(). This can be changed to:

+     if (unlikely(!sched_clock_running))
+             return sched_clock() + __sched_clock_offset;

And do all the necessary changes in sched_clock_init().

The reason, why I had "< 2" in the first place, is because we did not
have early static branching before, and ended-up with sched_clock()
outputting:  early TSC, jiffies, real TSC. The imprecise jiffies
timestamps during boot were confusing.

However, now with the early branching, and with upcoming change that
Thomas suggested that guarantees that if early TSC are enabled we will
keep them forever, the "< 2" is not needed. I will update this patch
accordingly.

Thank you,
Pavel
