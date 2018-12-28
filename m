Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8A2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6760A20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QH3jHzzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbeL1RZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:25:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39704 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeL1RZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:25:49 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so27740563itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 09:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7PYXEbho+iDCU0XXTHdMZCs4YKxu18fFx+s5fS54DI=;
        b=QH3jHzzvXCKp8rIxup+C6z5Mhy6iZowKiMDVdAveunTabeE6Kgjk/wGUnQCDI2WUwe
         rGGG84Fwm7JeISMDbO+ROpCKorY5+AJ3ddt3UHupAsDgqXCkLcVSa4dewVcPrQ2PPHmf
         K2lvQH2LN/r5JSgDpcKCEw4TeymVoFuAxW/sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7PYXEbho+iDCU0XXTHdMZCs4YKxu18fFx+s5fS54DI=;
        b=D/v+PK0czhhejX9xsUdrIgiwd90AgI/Ry5bQE6qEWa5SBplQfJK+wXEzx7UNUFVVsF
         Qjcc9sHUDPN7a5ppTML676blJpjzix74lpxZ0qPwbMAK12RkXjcZt6pPPZROtZnwi0tE
         kAai6rAAGLT/wEvtvJ1V3AigFG1sBnpveQhIJ3XWCpPLIqup5P7qUruByuK+RBf8xjQG
         YG57L1bGtYtRaO+rKwfW58MziU4KyAfBA3LKLoSzciL37ut3aZwx8xKKhje20MZ20Fxn
         rZ64fUQUoZfJRzguNKLNVUM6CSPLfstxbvHNUtLd0igjdNUVdSCUdwtitkFTQWXAehDF
         OUKA==
X-Gm-Message-State: AA+aEWZLuX6eFgiguOqGVYYuWI+va4TkgZfMiQNpDaWyXz2FQQ1hU+N1
        lYGUZPFSohsckvWjxmr/mH3uZDgRKIHtXFtEP29wFA==
X-Google-Smtp-Source: ALg8bN5D06utccMSW0OBq6k/QYR7Y3HULvocaCgPOepkbnXrVPWHEvgRegIwAR3u1j8XacrYtmQ9AuFE/Cgr5hSEyW8=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr17901041itk.114.1546017948472;
 Fri, 28 Dec 2018 09:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20181227102107.GA21156@linaro.org> <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
 <20181228011524.GF2509588@devbig004.ftw2.facebook.com> <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
 <20181228015352.GG2509588@devbig004.ftw2.facebook.com> <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
 <CAKfTPtA5WBKQ1FMyGqGjn1DdeDbSwT=bTQjD=oW7WMz6iKiS7A@mail.gmail.com> <20181228165451.GJ2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181228165451.GJ2509588@devbig004.ftw2.facebook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 Dec 2018 18:25:37 +0100
Message-ID: <CAKfTPtAMjfnNHu_JdDSi1BSMoXKgGkm2+G_QLsUBDAhq1wFvZQ@mail.gmail.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 at 17:54, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Dec 28, 2018 at 10:30:07AM +0100, Vincent Guittot wrote:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index d1907506318a..88b9118b5191 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7698,7 +7698,8 @@ static void update_blocked_averages(int cpu)
> > >                  * There can be a lot of idle CPU cgroups.  Don't let fully
> > >                  * decayed cfs_rqs linger on the list.
> > >                  */
> > > -               if (cfs_rq_is_decayed(cfs_rq))
> > > +               if (cfs_rq_is_decayed(cfs_rq) &&
> > > +                   rq->tmp_alone_branch == &rq->leaf_cfs_rq_list)
> > >                         list_del_leaf_cfs_rq(cfs_rq);
> >
> > This patch reduces the cases but I don't thinks it's enough because it
> > doesn't cover the case of unregister_fair_sched_group()
> > And we can still break the ordering of the cfs_rq
>
> So, if unregister_fair_sched_group() can corrupt list, the bug is
> there regardless of a9e7f6544b9ce, right?

I don't think so because without a9e7f6544b9ce, the insertion in the
list is done only once and we can't  call unregister_fair_sched_group
while an enqueue is ongoing so tmp_alone_branch always point to
rq->leaf_cfs_rq_list.
a9e7f6544b9ce enables to have tmp_alone_branch not pointing to
rq->leaf_cfs_rq_list

>
> Is there a reason why we're building a dedicated list for avg
> propagation?  AFAICS, it's just doing depth first walk, which can be

we have this list of sched group of the rq to update the load of each
cfs_rq and as a result the load of the task group. This is then used
to compute the share of a task group between CPUs.
This list must be ordered to correctly propagate the updates from leafs to root.

> done without extra space as long as each node has the parent pointer,
> which they do.  Is the dedicated list an optimization?

It prevents to parse and walk all task group struct every time.
Instead, you just have to follow a linked list

Regards,
Vincent
>
> Thanks.
>
> --
> tejun
