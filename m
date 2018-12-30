Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94238C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9C720811
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546174461;
	bh=nOPiQDmOBCo+DvXRzA0bBdsUyScZQDPZWJpfxs4652c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W1eqlIhv+MIlPCx3uxh2uzL9dl4NTicl62xZkTTI/FnCFPUsIcDqmqxH0WvBjuFSN
	 0f2y8lYisq5E4EG5fGj7quPL6RTrHX/uFSfJT1qyFu+JJOJtlxkrrm43Xn/oYFgz1D
	 9xlWlhWFRgDELk1xTDNAZfVGblJeQ9o1hpAs8zMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeL3MyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 07:54:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37719 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeL3MyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 07:54:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so24622006wrt.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 04:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wtK0GrMXX4f7XI6v69xhC9KfiRtu1wEFTL4tj7hCT6o=;
        b=DSQsAcalv21MlvWz6AghmtayD5TdWeLHOU+nIIA5dsu7lK7/64qIE/HSn7VOPbmnOt
         9/o/3WQXGMnEi7ltYV55DcaX+KJPGUA0WutjBD9m0f0RBzunNZoe47KwWy6QH74wivt+
         frAAxqMvg1Eco8rVK92b6fWlDHi8i5jB4+rqm97AUEKKm3X/2xlAro49OImtL7l6Jy5t
         K1i7c/nF3Zg7C4GlY1dTF+NApnqHokThwqUop0jV5Y2FmMKcSABVMyIoJHJ0HpMTE/pg
         vj7gwjgdpBauR+DFrFIdFUzTp+PyslRbw+69qPZgJa4MWwZmkqAjIca6cyxc+tRjt+Yj
         OFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wtK0GrMXX4f7XI6v69xhC9KfiRtu1wEFTL4tj7hCT6o=;
        b=bsrUn9VJT1R7T/FUGx6zESvsKMiJhaGB1hKc4D3i9nE1Eimege+Wj3E9G2GsBhaSS6
         fAxBQ1N2cIKD8zVuSvvULRJINlZJMLX9kw5lAGcHpuW7+WTkCH3qy1hMai7huRQz0Sf6
         VbtmYo30FISqjYPlSI63am/wVxgc3xwvm5JerHSQQkbK6SHvgDxKWs0gy4Cb3WZWKX1l
         P5fSpJlkOgj/+anIUL6lH7eiEcqOH0JjxJA8rb8CPX1ZfkpH/LCpC0NKZl1F8kD/C4S2
         ktPdDUh4Q7i+SnKTVVzBXihKFM+A3oxDg2+U32hr06SuIIjmCZI5grEgznsvArxvVBCD
         IMEQ==
X-Gm-Message-State: AJcUukfIYSSTvtL5Wm3powFpVXbasyWl3dtRWF+7Ly2PJCz60/AezGa9
        m2XY7SuALnGja3ndBoGftAM=
X-Google-Smtp-Source: ALg8bN7DCBul2qJcvfE67vTs2wDGUwJtd3tRp8J3ypuHT7wuf/AfsyfLoZMKoo5AJG63OquvZw5G6w==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr11231717wrv.161.1546174458046;
        Sun, 30 Dec 2018 04:54:18 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c14sm28985704wme.13.2018.12.30.04.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Dec 2018 04:54:17 -0800 (PST)
Date:   Sun, 30 Dec 2018 13:54:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Xie XiuQi <xiexiuqi@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
Message-ID: <20181230125415.GA45462@gmail.com>
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181230120435.GA17231@gmail.com>
 <CAKfTPtA2ibYVJdqdWbEVjjCYueSCzc15Jwt9RNo=D=3kUFpEFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA2ibYVJdqdWbEVjjCYueSCzc15Jwt9RNo=D=3kUFpEFw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> On Sun, 30 Dec 2018 at 13:04, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > > > Reported-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> > > > Cc: Bin Li <huawei.libin@huawei.com>
> > > > Cc: <stable@vger.kernel.org>        [4.10+]
> > > > Fixes: 9c2791f936ef (sched/fair: Fix hierarchical order in rq->leaf_cfs_rq_list)
> > >
> > > If it only happens in update_blocked_averages(), the del leaf has been added by:
> > > a9e7f6544b9c (sched/fair: Fix O(nr_cgroups) in load balance path)
> >
> > So I think until we are confident in the proposed fixes, how about
> > applying Linus's patch that reverts a9e7f6544b9c and simplifies the list
> > manipulation?
> 
> looks good to me

Excellent - I've added your Acked-by.

Thanks,

	Ingo
