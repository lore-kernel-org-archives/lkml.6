Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22855C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25BB217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RksZb2ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfBSCP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:15:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33694 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfBSCP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:15:27 -0500
Received: by mail-lj1-f194.google.com with SMTP id f24-v6so16062046ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M037U6aipv5HSHtoXlgn20nsrqaH/sUD/ARA/RhtHh8=;
        b=RksZb2ibk50KRaRvwZk35X5nq1c6kM9T5p10Q2Ur+71gkTa/8UHP12DMXqf3atfgpd
         5zAvxmbG6nGzFl3hpkF7lVDwr2dTJvlY9v5fprgC1Z68QOVpavf+BYE4RvTyhTgKwyxn
         KM7Mek8QjlK2XXPhPDhooKqHv/SdNz1usT0eT3Lfie4/vurisjZ0YGJ/PifRJzZGPD/c
         lK/bWTC4K7hm9p+nEua5B5e3IP4bDv1QbTyAs8Yum/rCXyEqaqbkrmDYcPGgZPQAE13J
         2W9LGEr0UyPc8C8vkWhpNo3adLGeCn4Hy1Rfv+AHR3mkH21p14FrRPs7eoyy+0lBbdZb
         lPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M037U6aipv5HSHtoXlgn20nsrqaH/sUD/ARA/RhtHh8=;
        b=DR7dHS+Y+pmSog6UAveQ5RVwFcEm6N4Lr5iqoriEysJHgGQRTJ5WCKOGnY8IAim7mS
         LhgZ4jz882UJ0YlrYk+2tri/a1APoIICphKlwKxBaPIjWu7TgWcli2dmfqZZ1W+ojNhU
         eK6poym053crmcwjLdGZyYaHe8K+4rt6MoZ23NoEkNxbCl6M+aPryn9CqW9S5OhCbGzv
         2RCG8+zL/rHTUxqXiNgEaCBd0nEJdBH6NhbFz6eOW3kjloYGOXJBraAq2lkwHydWZdrF
         ADSTp+fpuxOYPI+NIXpqBghb61bEQlr037ewSqFJ4PaaJZw8rZNT/uqYZdpTgLN+7lOW
         W8/w==
X-Gm-Message-State: AHQUAuaMOkhYH+F8rvMPnIlzAR03FM2Z4rTE74ZT18uX5Kj2cfwdCWEq
        jpStsbPWfCasSIpR0jMfOt5CjRG76XrDYRJKhhQ=
X-Google-Smtp-Source: AHgI3IaFb8otcknhYixmmGcbBjP3xYNADrmh/uI8OT05qKublagPxh4CxO+W0HvTv3I+ZZItSkjWFfh2LeGMVB0ANsA=
X-Received: by 2002:a2e:91d4:: with SMTP id u20mr6156203ljg.54.1550542525612;
 Mon, 18 Feb 2019 18:15:25 -0800 (PST)
MIME-Version: 1.0
References: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com>
 <20190206171915.GJ17564@hirez.programming.kicks-ass.net> <CAHCio2ggaG9gCB642=GgwfM2iCRm+ZcAp0HGqevJtVrRmnKPUA@mail.gmail.com>
In-Reply-To: <CAHCio2ggaG9gCB642=GgwfM2iCRm+ZcAp0HGqevJtVrRmnKPUA@mail.gmail.com>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Tue, 19 Feb 2019 10:15:14 +0800
Message-ID: <CAHCio2hn-r1_4bCEPtTm7=EjZmD=kUAFvLB9KEsEDbLi0mGvEg@mail.gmail.com>
Subject: Re: [PATCH] sched/debug: Show intergroup and hierarchy sum wait time
 of a task group
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com,
        =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Wind Yu <yuzhoujian@didichuxing.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING

=E7=A6=B9=E8=88=9F=E9=94=AE <ufo19890607@gmail.com> =E4=BA=8E2019=E5=B9=B42=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8811:14=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Hi, Peter
> I think hierarchy wait time for task groups is worth accounting
> despite with a little extra overhead. Because we can evaluate task
> groups' condition with a more direct metric. We cannot get the real
> situation just with some general metrics, like idle or loadavg, since
> their value is decreased with the elapse of time. So, I think general
> metrics cannot satisify the request for task groups.
>
> Thanks
> Yuzhoujian
>
>
> Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2019=E5=B9=B42=E6=9C=887=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:19=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Wed, Jan 23, 2019 at 05:46:56PM +0800, ufo19890607@gmail.com wrote:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index e2ff4b6..35e89ca 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -858,6 +858,19 @@ static void update_curr_fair(struct rq *rq)
> > >  }
> > >
> > >  static inline void
> > > +update_hierarchy_wait_sum(struct sched_entity *se,
> > > +                     u64 delta_wait)
> > > +{
> > > +     for_each_sched_entity(se) {
> > > +             struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> > > +
> > > +             if (cfs_rq->tg !=3D &root_task_group)
> > > +                     __schedstat_add(cfs_rq->hierarchy_wait_sum,
> > > +                                     delta_wait);
> > > +     }
> > > +}
> > > +
> > > +static inline void
> > >  update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se=
)
> > >  {
> > >       struct task_struct *p;
> > > @@ -880,6 +893,7 @@ static void update_curr_fair(struct rq *rq)
> > >                       return;
> > >               }
> > >               trace_sched_stat_wait(p, delta);
> > > +             update_hierarchy_wait_sum(se, delta);
> > >       }
> > >
> > >       __schedstat_set(se->statistics.wait_max,
> >
> > The problem I have with this is that it will make schedstats even more
> > expensive :/
