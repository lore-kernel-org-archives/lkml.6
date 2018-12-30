Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54596C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C59B20861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546171482;
	bh=pR9LxT80TjmMDt19R2Psf6JxjI6f6zCq/OEOw945w54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xV10lVFs5BX3D9TD2LMaGfatIKR1rCH9D6+MKE3I5Vv7pWtk53aKtMj80N1dQZMKD
	 vRu+cCQBGg88Pzc3hMRiniR/NLwGJAz3tMchR63OitmjJdq5nk4K4DSc1u8olmIoZP
	 yMi+1SqMgxOtDha5csjY1/eGH3TWuQt7tIU4TlPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeL3MEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 07:04:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35469 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeL3MEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 07:04:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so10827531wmt.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 04:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tNijJ/aFlw2SFIH/qJFXPhCMT9WEtXSQm7oLvhbjg8A=;
        b=vK+B4ZGbw47KK2gogBw9Xqpj3OabLicAKar329E/HbPaBPCYQwYGbhQG4UspA6DR0O
         9jbnvaBSX50E44uTMIxxCATDL44sjGCaoCo6MH0Nbo7f869JQZBpROqMhvej1Z7FGV6y
         FfJwF+OSz7ksTNSG7XoI0pYbhDxXGjJm0VGJLOWlni/hydhOJsHExq3OXukzjk1Krhra
         jzs9eF/jSWGE5D9cZ3vYIUynrtb0K2PMF89whsncACAB5U0LE9FsLUhng0oqfkFTK9mh
         LWp8PHzFszVDmgmAjrkk98Opr8AcjQ2NVY/lMVOwrfnz9YJZVqPsXXFBFpIrtOVmu7/3
         cAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tNijJ/aFlw2SFIH/qJFXPhCMT9WEtXSQm7oLvhbjg8A=;
        b=Oo3Z69ckXR/uWjzBV20DES1MW0lqGjT/ZbY6vO1IZO0ZDY3GAYocYKgj0T+0oxannQ
         vUpdF6ZO5voEd0F/IbJt02+xOnR+f8tsR07/cX3f3s4skZ4KPlPIDeqJc0XzQ+PTQVYA
         EYSOKchGLamEs0KtqyFt+WTS4ZOYh1peUX6yEQTf2FM6VONbX370m7Tpy5QY+bPWxGCd
         txCDbwvOXO8rq0UIULEwBllvslcKPaJKluGIyq6dAU+D8szpsLp/MdfOKC+EHgKcAz+k
         S6DAAWAFDMfarJbA9zW7Awc+66qvXqqI2vvcL4XzROBewcIn6Yf4NqXi07sywTvNPBuz
         CfWw==
X-Gm-Message-State: AJcUukdlOXajgfo+0W/vc5yXBfeY5GXynfMwdGNbRJwUBFKSfom3PBVx
        aL7vviaywocV/WhmaMyVpOY=
X-Google-Smtp-Source: ALg8bN7gFe1Chlx6buqxWxF+81Dbjra1ttD4pl9dxSaRMky+dWcNlErikG0l5FsBGhZw3KoAule2Zg==
X-Received: by 2002:a1c:8d53:: with SMTP id p80mr16295606wmd.68.1546171478787;
        Sun, 30 Dec 2018 04:04:38 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j129sm27732783wmb.39.2018.12.30.04.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Dec 2018 04:04:38 -0800 (PST)
Date:   Sun, 30 Dec 2018 13:04:35 +0100
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
Message-ID: <20181230120435.GA17231@gmail.com>
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> > Reported-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> > Cc: Bin Li <huawei.libin@huawei.com>
> > Cc: <stable@vger.kernel.org>        [4.10+]
> > Fixes: 9c2791f936ef (sched/fair: Fix hierarchical order in rq->leaf_cfs_rq_list)
> 
> If it only happens in update_blocked_averages(), the del leaf has been added by:
> a9e7f6544b9c (sched/fair: Fix O(nr_cgroups) in load balance path)

So I think until we are confident in the proposed fixes, how about 
applying Linus's patch that reverts a9e7f6544b9c and simplifies the list 
manipulation?

That way we can re-introduce the O(nr_cgroups) optimization without 
pressure.

I'll prepare a commit for sched/urgent that does this, please holler if 
any of you disagrees!

Thanks,

	Ingo
