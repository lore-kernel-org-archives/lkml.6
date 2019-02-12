Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404D9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5CC2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwyDT4be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfBLDOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:14:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47008 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBLDOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 22:14:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id v16so875514ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 19:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q0D8QPhSuW9+T5/dRwTDGITKXPRbagBgRSccKlG9/+w=;
        b=AwyDT4be4njOKakXdRw2bfY/u7XeYMyINP9kWVtjezzPy+uF37ip1orPB8uNq6sv8n
         NcJr0hHMUybMzj95/CHOE0guDq21CiZ9MalWK36XpkvLm8q+e3wSlmQ+ncTDddMmRD+0
         rB0b7CgHwPMBGaEvRnTv5QXJ2+cojr8R7yBT7cU2ZUjeeLboU+fTf5+FaEs1iWo5BK2s
         S9zkCLn6+BwDzvtIYXBSqSuTlnjVkeior6Xu7UIPYR/xIxJTipbO6FZDqhat2WXKLFfQ
         waf7S/q3j+5Ey6OAl9hzBkQHLn+XHPyjwHLh+fiOmKxt/IIyKiPF8a2KnqdSiyR5kpIF
         JYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q0D8QPhSuW9+T5/dRwTDGITKXPRbagBgRSccKlG9/+w=;
        b=CFMrTlzV3qvoqgBxA1SP38171jRAFzaPiEPEA08jKDRC8xaZDEibU3Qb9ys7uq34Ri
         KcccaLa+uByCiHJwLXOzHTOmrK3hwZmlAOPKARIDk/fWLdd6UOV/eh2qHFuPreR1NOZ0
         uKQbvcd3YHlKBb/or/5eAV/W/KiTVlS9ucVRbAsmyuS5Fyiw7rW+GjmHoQV8v0qymoqk
         SFq6TLSZM1Q8K3ol/bxEwXxorQdkDQIOaxQaLR5DL2pW91CoSAmQI7sEPMnnCCaXUim3
         0n9oYqK0ssE8SfC8ToJ2jkRNI4V8JMtc2qa8dUJ5zgVXcrgIDfTY9AOKcW1TXtl8C9Jm
         xD2g==
X-Gm-Message-State: AHQUAuaDQjEdTt3HmHwI+wICpopnXumMfF2q+F6PQFq03J8RzymzLssY
        f+BEouqN1jhrd1AWwjy4Hyy3zTUIwHH/szCJjqo=
X-Google-Smtp-Source: AHgI3IZoly4JysLMRssJP+1oPHC7KJlbd2TXJOQS9OdBnU0pF76KSAyAMUu7yRkPya7jiLDpWhumv2YmKQALTPjlwNE=
X-Received: by 2002:a2e:860d:: with SMTP id a13-v6mr798333lji.176.1549941261818;
 Mon, 11 Feb 2019 19:14:21 -0800 (PST)
MIME-Version: 1.0
References: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com> <20190206171915.GJ17564@hirez.programming.kicks-ass.net>
In-Reply-To: <20190206171915.GJ17564@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Tue, 12 Feb 2019 11:14:10 +0800
Message-ID: <CAHCio2ggaG9gCB642=GgwfM2iCRm+ZcAp0HGqevJtVrRmnKPUA@mail.gmail.com>
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

Hi, Peter
I think hierarchy wait time for task groups is worth accounting
despite with a little extra overhead. Because we can evaluate task
groups' condition with a more direct metric. We cannot get the real
situation just with some general metrics, like idle or loadavg, since
their value is decreased with the elapse of time. So, I think general
metrics cannot satisify the request for task groups.

Thanks
Yuzhoujian


Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2019=E5=B9=B42=E6=9C=887=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jan 23, 2019 at 05:46:56PM +0800, ufo19890607@gmail.com wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e2ff4b6..35e89ca 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -858,6 +858,19 @@ static void update_curr_fair(struct rq *rq)
> >  }
> >
> >  static inline void
> > +update_hierarchy_wait_sum(struct sched_entity *se,
> > +                     u64 delta_wait)
> > +{
> > +     for_each_sched_entity(se) {
> > +             struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> > +
> > +             if (cfs_rq->tg !=3D &root_task_group)
> > +                     __schedstat_add(cfs_rq->hierarchy_wait_sum,
> > +                                     delta_wait);
> > +     }
> > +}
> > +
> > +static inline void
> >  update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  {
> >       struct task_struct *p;
> > @@ -880,6 +893,7 @@ static void update_curr_fair(struct rq *rq)
> >                       return;
> >               }
> >               trace_sched_stat_wait(p, delta);
> > +             update_hierarchy_wait_sum(se, delta);
> >       }
> >
> >       __schedstat_set(se->statistics.wait_max,
>
> The problem I have with this is that it will make schedstats even more
> expensive :/
