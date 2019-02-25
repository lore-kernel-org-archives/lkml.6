Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DEBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5322087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLKhFUsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfBYDaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 22:30:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38786 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfBYDaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 22:30:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id n15so5736078lfe.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 19:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z7EvVksQNA/GNIsNhmc3zKZrFHcVZEWtWYdG0JcbzfY=;
        b=sLKhFUsKiRNzZV4hQklzMarQ8DjeXSlKowhoJeGZTzxwurNCJc2ObuugbSZPT5UUqD
         EOsYUZYoDxbX9MQh9hjGqyIS1+Rcoz/+ntH32HcvwmFM98gu9YnWE3I3dGCJxgLveAkz
         Z5UlrhbIfb4EovJbOzaQJRMkv81X9sSMx+Eb2dO6suKgKEdJxwph1r/cB69jPYXjm4sa
         kcLDrV5Ni4A0f0ZFU2FrbM5XCFkBo1ecnab1dvap8sBs2MTEVePvU9bhLjg2vIMHJMUs
         Q5GMgNXdsSMHtrRtIGfSjpqDhGB6T0LT1/d+43vVxKwCrufnOfhVDZsysHOELNzgd0tL
         uw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z7EvVksQNA/GNIsNhmc3zKZrFHcVZEWtWYdG0JcbzfY=;
        b=BTvUBRRo6QRB5wfHBAjHZ2p2+d+pk5gExJRSJfbZyOV4CNC5+K6pi+fzJGCYv9M+xA
         jBCkXlPZ93f9A1A2JwV3gX7XisAH7V89L2jYZN90O825I1/xvf5ZwibVhBk+bQiroF1O
         9+TJCnmUCZPHwKHEEUP7bYqnTbb2vlKaPxnuBm5WxrBOb+oLCaIIeLfqznRazQiMZ5Xt
         vuX69N1BVhDj/gSOHBHfF46ILObGW5e4DDWrcH5DsbNjMFzZgP1rm+hhinrDPBicUpBj
         XvV3dY//SS4PFWcrvKtvrUK69eBQmDz/Alf/k3pGaWbFhlR7jLa3pdw4mzTfXG984GP5
         UHZg==
X-Gm-Message-State: AHQUAuYYt5EP4aVwokpX8RcM4fkPYHjHIIyO8PhO4mX09MywlLfc7vbq
        tjlxWrYIGigV5Pb6ocdwkql7lA4a9eIFSZKsgVvTZw==
X-Google-Smtp-Source: AHgI3Ibx6crSbZTpTZo8G57MLXIqnXHKdRhrJ9LitGhIATD0DaJZoE11EzOPYhgSb71sOlpaw4VICUQgoNinBuVEMks=
X-Received: by 2002:ac2:5542:: with SMTP id l2mr1537447lfk.108.1551065398284;
 Sun, 24 Feb 2019 19:29:58 -0800 (PST)
MIME-Version: 1.0
References: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com>
 <20190206171915.GJ17564@hirez.programming.kicks-ass.net> <CAHCio2ggaG9gCB642=GgwfM2iCRm+ZcAp0HGqevJtVrRmnKPUA@mail.gmail.com>
 <CAHCio2hn-r1_4bCEPtTm7=EjZmD=kUAFvLB9KEsEDbLi0mGvEg@mail.gmail.com>
In-Reply-To: <CAHCio2hn-r1_4bCEPtTm7=EjZmD=kUAFvLB9KEsEDbLi0mGvEg@mail.gmail.com>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Mon, 25 Feb 2019 11:29:46 +0800
Message-ID: <CAHCio2g4DR8DcCtRvW69Ct2A3fZCnYaS39QP-VL3BJxVr-OAnA@mail.gmail.com>
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
=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:15=E5=86=99=E9=
=81=93=EF=BC=9A
>
> PING
>
> =E7=A6=B9=E8=88=9F=E9=94=AE <ufo19890607@gmail.com> =E4=BA=8E2019=E5=B9=
=B42=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8811:14=E5=86=99=
=E9=81=93=EF=BC=9A
> >
> > Hi, Peter
> > I think hierarchy wait time for task groups is worth accounting
> > despite with a little extra overhead. Because we can evaluate task
> > groups' condition with a more direct metric. We cannot get the real
> > situation just with some general metrics, like idle or loadavg, since
> > their value is decreased with the elapse of time. So, I think general
> > metrics cannot satisify the request for task groups.
> >
> > Thanks
> > Yuzhoujian
> >
> >
> > Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2019=E5=B9=B42=E6=9C=887=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:19=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Wed, Jan 23, 2019 at 05:46:56PM +0800, ufo19890607@gmail.com wrote=
:
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index e2ff4b6..35e89ca 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -858,6 +858,19 @@ static void update_curr_fair(struct rq *rq)
> > > >  }
> > > >
> > > >  static inline void
> > > > +update_hierarchy_wait_sum(struct sched_entity *se,
> > > > +                     u64 delta_wait)
> > > > +{
> > > > +     for_each_sched_entity(se) {
> > > > +             struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> > > > +
> > > > +             if (cfs_rq->tg !=3D &root_task_group)
> > > > +                     __schedstat_add(cfs_rq->hierarchy_wait_sum,
> > > > +                                     delta_wait);
> > > > +     }
> > > > +}
> > > > +
> > > > +static inline void
> > > >  update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *=
se)
> > > >  {
> > > >       struct task_struct *p;
> > > > @@ -880,6 +893,7 @@ static void update_curr_fair(struct rq *rq)
> > > >                       return;
> > > >               }
> > > >               trace_sched_stat_wait(p, delta);
> > > > +             update_hierarchy_wait_sum(se, delta);
> > > >       }
> > > >
> > > >       __schedstat_set(se->statistics.wait_max,
> > >
> > > The problem I have with this is that it will make schedstats even mor=
e
> > > expensive :/
