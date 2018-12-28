Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178FD20873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546016099;
	bh=Vyhq6lvi238qd/G49+ON0QQe1/xdRJMsRO7Sqm1jP6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gCgJGn4D5PN5kro6q9ClZlBBG6OgTehF/4VVhr4gGWzldyZHW3bvML0J8KveaiLaV
	 BnfmplGlO9Hv8ii5iLl4mt+aGb/7TC/IhFhSw6ij1DHOP5MTiw7q3gEhRnIbI0gCy+
	 Bbc6j3xYPErP8xTROBpYb6dKFJq7hA4BXlepCiCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbeL1Qy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:54:57 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34445 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbeL1Qy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:54:57 -0500
Received: by mail-yb1-f193.google.com with SMTP id w6so4119982ybq.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GaOGefTmsN0Fk8oI/MTd0cKcVszA3DvNNMxstzlblg8=;
        b=nOzKF+EV0ecaM4x9gAgHBSa6eRYjW2BeADF1JVhXdSOU+1EHRB2ojU07Od9eYlbYIG
         3YlndSIHAwdT9+HER9QamZU8OPtv8WSusTeEuekxUf3kpV1t2HUljK/IMI+jX1Ek977s
         ACboiMgz9EYTUL/585TN6ENflVugQ7wSAzOiZAuyMw2W8Z+TYXay7I7g+PVWQ3WXQSWK
         6yJLaDutke8NS1fiQJsxKCU6fmgkyPDxo87KkgzAt+7JaSI2//PssezmD/sDx2ZAPHkL
         ppT9fH7C5Ab20Q9VOTYZRD2KbcJJccvEMHAZXVDvG7DjRy9b6l/3yMh2nc4XA04af2YA
         zIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GaOGefTmsN0Fk8oI/MTd0cKcVszA3DvNNMxstzlblg8=;
        b=PTunXAHrPT3dCDFIyNwFQBT3sJtAygUef8Z+vhW+FEF62NSHVMWUtCg+zxUIzON8uA
         S9sJfLiHGjlYbWHtpzz1+HgWrYdXyHwlmy47IBoDyUCT10m1GhrWQ8u7PclQqgJ3R9Ig
         aXXmXwj7xMHwZHzHv657xpxFDX+yJCzPmB6UU1AeNXv0m4hXFcMtdWnNbnQA/nVLn4vf
         miX+Ppi33XAgpLquSobPmNsnv20mMwf/QqUMv2iealjtJ7KZwP5ITtgP97gIQjGxOleJ
         nmr1VTVo4RXRN2pqqMbMaIbs1fspn62yH3nQGSoklMi5TmRlVwvLvzozcFHEXo/Eub4v
         lsKQ==
X-Gm-Message-State: AJcUukfI3Eh5nH9oGpU8NN5CeV7OTQYJAhVJZP3ERjYckYc5bfCVu69A
        bcGLxLq8KlWiK9YPXTKa4lY=
X-Google-Smtp-Source: ALg8bN58uji4aU4KSgi+kT+meWiHU3VmXOHE5Zqa7dxrlVyh9s/iSvuhDYIw9WyD2/Y6ckeGgo6P/g==
X-Received: by 2002:a25:7a82:: with SMTP id v124mr2498572ybc.190.1546016096093;
        Fri, 28 Dec 2018 08:54:56 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4800])
        by smtp.gmail.com with ESMTPSA id 77sm15268508ywb.54.2018.12.28.08.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:54:54 -0800 (PST)
Date:   Fri, 28 Dec 2018 08:54:51 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
Message-ID: <20181228165451.GJ2509588@devbig004.ftw2.facebook.com>
References: <20181227102107.GA21156@linaro.org>
 <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
 <20181228011524.GF2509588@devbig004.ftw2.facebook.com>
 <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
 <20181228015352.GG2509588@devbig004.ftw2.facebook.com>
 <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
 <CAKfTPtA5WBKQ1FMyGqGjn1DdeDbSwT=bTQjD=oW7WMz6iKiS7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA5WBKQ1FMyGqGjn1DdeDbSwT=bTQjD=oW7WMz6iKiS7A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Dec 28, 2018 at 10:30:07AM +0100, Vincent Guittot wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d1907506318a..88b9118b5191 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7698,7 +7698,8 @@ static void update_blocked_averages(int cpu)
> >                  * There can be a lot of idle CPU cgroups.  Don't let fully
> >                  * decayed cfs_rqs linger on the list.
> >                  */
> > -               if (cfs_rq_is_decayed(cfs_rq))
> > +               if (cfs_rq_is_decayed(cfs_rq) &&
> > +                   rq->tmp_alone_branch == &rq->leaf_cfs_rq_list)
> >                         list_del_leaf_cfs_rq(cfs_rq);
> 
> This patch reduces the cases but I don't thinks it's enough because it
> doesn't cover the case of unregister_fair_sched_group()
> And we can still break the ordering of the cfs_rq

So, if unregister_fair_sched_group() can corrupt list, the bug is
there regardless of a9e7f6544b9ce, right?

Is there a reason why we're building a dedicated list for avg
propagation?  AFAICS, it's just doing depth first walk, which can be
done without extra space as long as each node has the parent pointer,
which they do.  Is the dedicated list an optimization?

Thanks.

-- 
tejun
