Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D17C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEA02146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7R7J7Px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbeL1JaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 04:30:21 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36118 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbeL1JaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 04:30:21 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so26541032itj.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 01:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAg7JAS0ijZtnBPznNA3j6Qu4HTRBjTq9XVyiwOIhKU=;
        b=j7R7J7PxYE4duzT+VFv2rycDZehE1A+VG9l093qaKZ33jT7rdjSDrj6Yxdujj9qKWh
         ymDmoq1cZZirFb3HTbbK4SxDunI0IUu0sznEees3Avz+aguHjuT7RmRgwyY5vXMx4qWt
         +DgaRMHvej8X180+2h7BRKsbGq8rxY/lWI2HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAg7JAS0ijZtnBPznNA3j6Qu4HTRBjTq9XVyiwOIhKU=;
        b=F64m7WsvFcYBkdEd16SQekbZe26nffDeYKxBRXxAOlSxd8mQeKlwIxPgH0rqR8pUWE
         B56nRSX+UzCvbkSHaLGxOMRaRtbfbiZaBGx0WpRO1AXPVlb52+C3pfm/6u6p7oWgVaIW
         R/TIhDyjiP1hRQjfUqTvVLVsBgBiGfLH8+r0LSuqaLrGaHWT68HltDZtFWO2vz6bQycv
         vLIPZBAH83Q7iaqDcGlw4XUfeo96+MFusks/5u6/0/qsfGqVMk6vP6q/7tUH3/I/YBrV
         or4IWOaxvCXhQNJar9fMRu37qdMoHqxpAOTo2Nl7Mf4e9rOZkxMz5R1cLIxzOs69i30G
         mleA==
X-Gm-Message-State: AA+aEWbchc5o7zEAZM+sYe2jdqt/lavB17LrG2UwudibFRHaxbXRga/t
        kwav9Jecf41voCFvsUyQ01m39y/nIfx3vhydtCJCAg==
X-Google-Smtp-Source: ALg8bN6ddj9sJBZPObUmi1nrfnsBqpUpHqsdee3YW2roVjxq3C8h8QFR28a7OtdBAi39netbMF04AomAKoN8K1DW1j0=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr16906225itk.114.1545989419091;
 Fri, 28 Dec 2018 01:30:19 -0800 (PST)
MIME-Version: 1.0
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org> <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
 <20181228011524.GF2509588@devbig004.ftw2.facebook.com> <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
 <20181228015352.GG2509588@devbig004.ftw2.facebook.com> <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 Dec 2018 10:30:07 +0100
Message-ID: <CAKfTPtA5WBKQ1FMyGqGjn1DdeDbSwT=bTQjD=oW7WMz6iKiS7A@mail.gmail.com>
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

On Fri, 28 Dec 2018 at 03:02, Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Dec 27, 2018 at 05:53:52PM -0800, Tejun Heo wrote:
> > Vincent knows that part way better than me but I think the safest way
> > would be doing the optimization removal iff tmp_alone_branch is
> > already pointing to leaf_cfs_rq_list.  IIUC, it's pointing to
> > something else only while a branch is being built and deferring
> > optimization removal by an avg update cycle isn't gonna make any
> > difference anyway.

But the lock should not be released during the build of a branch and
tmp_alone_branch must always points to rq->leaf_cfs_rq_list at the end
and before the lock is released

I think that there is a bigger problem with commit a9e7f6544b9c and
cfs_rq throttling:
Let take the example of the following topology TG2 --> TG1 --> root
1-The 1st time a task is enqueued, we will add TG2 cfs_rq then TG1
cfs_rq to leaf_cfs_rq_list and we are sure to do the whole branch in
one path because it has never been used and can't be throttled so
tmp_alone_branch will point to leaf_cfs_rq_list at the end.
2-Then TG1 is throttled
3-and we add TG3 as a new child of TG1.
4-The 1st enqueue of a task on TG3 will add TG3 cfs_rq just before TG1
cfs_rq and tmp_alone_branch will stay  on rq->leaf_cfs_rq_list.

With commit a9e7f6544b9c, we can del a cfs_rq from
rq->leaf_cfs_rq_list. So if the load of TG1 cfs_rq becomes null before
step 2 above, TG1 cfs_rq is removed from the list.
Then at step 4, TG3 cfs_rq is added at the beg of rq->leaf_cfs_rq_list
but tmp_alone_branch still points to TG3 cfs_rq  because its throttled
parent can't be enqueued when the lock is released
tmp_alone_branch doesn't point to rq->leaf_cfs_rq_list whereas it should.

so if TG3 cfs_rq is removed or destroyed before tmp_alone_branch
points on another TG cfs_rq, the next TG cfs_rq that will be added,
will be linked  outside rq->leaf_cfs_rq_list

In addition, we can break the ordering of the cfs_rq in
rq->leaf_cfs_rq_list but this ordering is used to update  and
propagate the update from leaf down to root.

>
> So, something like the following.  Xie, can you see whether the
> following patch resolves the problem?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d1907506318a..88b9118b5191 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7698,7 +7698,8 @@ static void update_blocked_averages(int cpu)
>                  * There can be a lot of idle CPU cgroups.  Don't let fully
>                  * decayed cfs_rqs linger on the list.
>                  */
> -               if (cfs_rq_is_decayed(cfs_rq))
> +               if (cfs_rq_is_decayed(cfs_rq) &&
> +                   rq->tmp_alone_branch == &rq->leaf_cfs_rq_list)
>                         list_del_leaf_cfs_rq(cfs_rq);

This patch reduces the cases but I don't thinks it's enough because it
doesn't cover the case of unregister_fair_sched_group()
And we can still break the ordering of the cfs_rq

>
>                 /* Don't need periodic decay once load/util_avg are null */
