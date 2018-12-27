Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D126C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425692148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="KxBZNjfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbeL0VJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:09:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34305 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeL0VJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:09:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so16204398ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 13:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeDMijcpAMRtx9PUwmCW56P5NPXFc6qdEWwwmvNRlcI=;
        b=KxBZNjfVetBRUL7pJhf0umW8WHsat0LQDDiMnc8L/Om0JFjPHWAD7Oesql7Bvo487u
         Y+4AECxIvS4c3+r0NBPgrU/q887teytpaeYeyAIGGgt91iAqJXvbgVbssMS+sQgmJiW+
         NpJmikwhowAuMtC7SmBW1phYxqPV0HTZHQ4Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeDMijcpAMRtx9PUwmCW56P5NPXFc6qdEWwwmvNRlcI=;
        b=c40HqtZu2t29talEk+VMqlQ011oRYjHtTSuxDZC6qBmgA3ay5sTw/KOAinKGSaISCt
         kOibU8f/AkV0m5tWxNFXn6gpFsGI6JbWnZ+MUMCz3ho2da6Cg7e6Eh6b6+1S8Vx6MFTM
         cWN+a3rZ8BZl4FQ3BKl3BCVy3cE652dwaCF0txms07/+gOhc+r+1yvXtvny9FxJJEwhq
         JBGI0y/nmxJWoDaEiKiMY8XYTrpVQdtHY9lo4kmOea20pL+AlufhevoAFZbXD3/QqKJ9
         4BF0PuTVseve/Wf1YDp+O73f0QRBY+cPDbffNsJCrAfH5UGCrv9CukMVzHOOAXI9C9vH
         7geA==
X-Gm-Message-State: AA+aEWbErArzPJOMDQ31R1MvomwX0oMkIWL/l2kP3mqoDzoinNrfMFhL
        5RDCkFn02+6MQ9WzGoCzI3z59SlqE1l4hyMnDdm/6Q==
X-Google-Smtp-Source: AFSGD/VqknUXURz6fjoWni+zpFRkH4cITldwvy4kXNastxOBVGToDcDk7QngI4gOsxdRk6QcB7JgDhgb0wieJrYKElI=
X-Received: by 2002:a50:b667:: with SMTP id c36mr20680578ede.190.1545944953055;
 Thu, 27 Dec 2018 13:09:13 -0800 (PST)
MIME-Version: 1.0
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org> <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com> <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
In-Reply-To: <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 27 Dec 2018 16:08:37 -0500
Message-ID: <CAMp4zn_N9fVNmyaiH-XGJW=E8QO0OnnVmAwQM_kcXjiybmhyGw@mail.gmail.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 1:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Dec 27, 2018 at 9:02 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > In the original behavior, the cs_rq was removed from the list only
> > when the cgroup was removed.
> > patch a9e7f6544b9c (sched/fair: Fix O(nr_cgroups) in load balance
> > path) has added an optimization which remove the cfs_rq when there
> > were no blocked load to update in order to optimize the loop but it
> > has introduced a race condition that create this infinite loop. The
> > patch fixes the problem by removing the optimization.
> > I will look at re-adding the optimization once i will have afix for
> > the race condition
>
> Hmm. What's the race? We seem to take the rq lock for all the cases,
> but maybe I'm missing something?
>
> That commit a9e7f6544b9c is a year and a half old, why did this start
> being reported now?
>
This appears to be broken since October on 4.18.5. We've only noticed
it recently with a workload which does ridiculously parallel compiles
in cgroups that are rapidly churned.

It's also an awkward bug to catch, because none of the lockup
detectors, were catching it in our environment. The only reason we
caught it was that it was blocking other cores, and those other cores
were missing IPIs, resulting in catastrophic failure.

> [ goes off and looks ]
>
> Oh. unthrottle_cfs_rq -> enqueue_entity -> list_add_leaf_cfs_rq()
> doesn't actually seem to hold the rq lock at all. It's just called
> under a rcu read lock.
>
> So it all seems to depend on that "on_list" flag for exclusion. Which
> seems fundamentally racy, since it's not protected by a lock.
>
> So yeah, the whole logic seems to depend on "on_list is sticky and
> stays set until the whole task group is destroyed".
>
> So commit a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance
> path") would appear to be entirely wrong, because on_list isn't
> actually protected by a lock, and that can confuse things.
>
> But that still makes me go "how come is this only noticed 18 months
> after the fact"?
>
> So I'm probably still missing something.
>
> Tejun? PeterZ? Tell my why I'm being dense.
>
>                    Linus
