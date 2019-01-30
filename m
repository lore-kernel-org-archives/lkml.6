Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA072084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNFSOmSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfA3PtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:49:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41654 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfA3Ps7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:48:59 -0500
Received: by mail-io1-f67.google.com with SMTP id s22so19747599ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4cwLjQ6C0wJMOtjxS/EykLQeCJgFzzQE+ZVq247NQQ=;
        b=UNFSOmSjaOp6Flr5E8NFpc8U90cUZdqC/Gw9utfy4uqIIgq4JXTqB6zUzqEMaUfLFw
         P6iiYYXZHLQUwIqjiciICJuVqFR/oxRUGvC5w1kbkC43yK0Z1oDhMSbelSrki1Ppqnoh
         mTgkWFJC9Jxp70+frnHE6jG2hISmx+Ko1wDzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4cwLjQ6C0wJMOtjxS/EykLQeCJgFzzQE+ZVq247NQQ=;
        b=TT86Kq2Khr/xQil8X5aZF66lY+of8dLPO9kskAy5icLWk8wY14RkEn4/CrmsndW/LG
         dpnhFrx68mtlhspR452PFiTWkWhMnjeb6u62KBVyedQ3dGJe4h7fBQnmOVT9zCLjdn4l
         7/+gKekcoF8/oWt4Ly5JPB6YlyOjuXd3OffBeZJc4Qv2Fh4qRct80WkRsV2KXE70ZcCh
         My4xv2nPAEyiFNRqYscIjPUzwXZf9bEx3CXgWfoofwpkLEh7l+Ey0c+kvbiY30mLq22W
         Z8KEwreoAlxzH/qlpMK7JpbdDLVbivGbpxAtIKavhOh3sJxEoshYZ3bud79Z5xTNyy/E
         e15Q==
X-Gm-Message-State: AJcUuker2l0al7/8AnMXTP3hSLqhtlC+u6HLVt1ozdMBl61C/xQJOacK
        QIGfyLrw4cwfXNH425AdPcP1a2v+UBJq3YYPB4M13Q==
X-Google-Smtp-Source: AHgI3Iav5+nIsLa3lfhwo7guQKVaVlVViAsKtVmDl4ZgDxrtP2SbKlyGb3cmGWdtjxv8mgNiXAjnPmuOIYqMla+kIIg=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr17212758ioh.294.1548863338848;
 Wed, 30 Jan 2019 07:48:58 -0800 (PST)
MIME-Version: 1.0
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
 <20190130130410.GG2278@hirez.programming.kicks-ass.net> <20190130130620.GB3103@hirez.programming.kicks-ass.net>
 <20190130132717.GC3103@hirez.programming.kicks-ass.net> <CAKfTPtBhOomgYONsdfaaVgZCENM+QhfPie2qpu0KyOsvMiog_g@mail.gmail.com>
 <20190130134023.GA2296@hirez.programming.kicks-ass.net>
In-Reply-To: <20190130134023.GA2296@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Jan 2019 16:48:47 +0100
Message-ID: <CAKfTPtC1vRrvSH=JdQjOfeh809gRiwKGE7373zaF9jT862C1+g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 at 14:40, Peter Zijlstra <peterz@infradead.org> wrote:
>

>
>  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> @@ -352,7 +354,12 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>         }
>  }
>
> -/* Iterate through all leaf cfs_rq's on a runqueue: */
> +static inline void assert_list_leaf_cfs_rq(struct rq *rq)
> +{
> +       SCHED_WARN_ON(rq->tmp_alone_branch != &rq->lead_cfs_rq_list);

small typo : s/lead_cfs_rq_list/leaf_cfs_rq_list/

> +}
> +
> +/* Iterate through all cfs_rq's on a runqueue in bottom-up order */
>  #define for_each_leaf_cfs_rq(rq, cfs_rq) \
>         list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
>
> @@ -446,6 +453,10 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>  }
>
> +static inline void assert_list_leaf_cfs_rq(struct rq *rq)
> +{
> +}
> +
>  #define for_each_leaf_cfs_rq(rq, cfs_rq)       \
>                 for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
>
> @@ -5179,6 +5190,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>
>         }
>
> +       assert_list_leaf_cfs_rq(rq);
> +
>         hrtick_update(rq);
>  }
>
