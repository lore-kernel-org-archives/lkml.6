Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74EEC282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775EB20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmrN0R2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfBKCnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 21:43:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41184 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBKCnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 21:43:32 -0500
Received: by mail-lf1-f67.google.com with SMTP id e27so6539755lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 18:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uvk4+RfUThW91/Hikdw5fop9OXueDda/QF2GEkBilBw=;
        b=rmrN0R2KGpZK0TuSxhHpbiq5ZylSrKlERU7QYqjNdDv7gZBTygCuVbc4QI1+snbmfi
         HVaeljKERmSm6iaLIhw1bu5ofR/aMVLfeineW+UwAldj0m6+oVMaXZqUUlbE3mg+trLQ
         jF4JRjA79BGLCpVa+qyb+nDlAYd6zFA1PX/xyklZnd5aCME2ues8+xeafKGWYtw9MuxI
         dJvDZuxCATBO/afZkV3xVCkMuH/fwRCXgMezdCGf1S2zFWqymWb3dqL/HWhSfh8yvWoY
         m7XnCWJZV+OBArqbRYHIF4yAilTY5MoRh9HRkcDUcbvqqmoXnY5VqBmRA8ak6sgj4EYu
         dQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uvk4+RfUThW91/Hikdw5fop9OXueDda/QF2GEkBilBw=;
        b=KlhABvEP6Fq7ce/zZGx51by/w3DSpJcEyyrWGhehSSeo+5Yt4QgRQgL0UpbOqLUD7Z
         EmbHNRN58JE8CU7+zMzzSD3KKSC7gB8YFi08o6ea90i3P+z26N1lZQ/lNLWCKsQppSca
         NAgSi/EYjZ73fFcjZS+QdCezS1FK+cZdidVHjSk9C15F7dLKpzODLOfgsmawOlxFFHOG
         HnY3eG9vkjOG9ZoNsDXcBhtgdlcIk3CiKng2XWJJgxTLM9a71HMDmmjvEdRre9Zn5Vu+
         FtbSBlIqTm2fKfJD8WTSvOeKapvXyCtvs+e9TWUnrOCCW1A4mMXT728KDYZX8hfp5zcN
         kKuw==
X-Gm-Message-State: AHQUAuY4P/QHNPE2Gidfz4IFhsfVc0jIW6ro8xYarIV+6HYQ6p1xSFRi
        DWSIE9h7bMjAjTNohGPEVbrKq+r+eeGeUUmZMzA=
X-Google-Smtp-Source: AHgI3Ia/KWs1B83SVhiSJgaUjSxP23LM/NYBraatfZmeEgLKjMVlPvCVlQvaxkc69PHi4Ks5X/iQPfXee/O8/QKgp3o=
X-Received: by 2002:a19:95c1:: with SMTP id x184mr8735994lfd.155.1549853010106;
 Sun, 10 Feb 2019 18:43:30 -0800 (PST)
MIME-Version: 1.0
References: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com> <20190206171915.GJ17564@hirez.programming.kicks-ass.net>
In-Reply-To: <20190206171915.GJ17564@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Mon, 11 Feb 2019 10:43:18 +0800
Message-ID: <CAHCio2jB6J4YyGDbui9dstasfVDpp0Sns16+EAe8YcFOouqypA@mail.gmail.com>
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

Hi Peter
> The problem I have with this is that it will make schedstats even more
expensive :/

I think the overhead for accounting hierarchy wait time is just the
same as cpuacct.usage. If the performance overhead is low enough(<
1%), is it acceptable?

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
