Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53790C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE932148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545959732;
	bh=EvGv4t3UK/XhSpTrLZq1uYTcrnCODTY4kjHzxcCzI7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qOUALiA7itFqNycICkRiHqlaP56WyWt/e2hnlIT3bI9CDbQC17wJVBqV8wnjzbb+n
	 0GDGGwJzJzGtNfKDz5toExDmExNuApQUaGQqZCByHFDOqQ0UDrf2bPZbQANVci7Yto
	 gSduDVtnlJvQmKo5ns6Yd8K0rupj/MiktNU/IcNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbeL1BPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:15:30 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37382 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeL1BPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:15:30 -0500
Received: by mail-yw1-f65.google.com with SMTP id h193so7892506ywc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 17:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4fbyeXMI0vtuOcbeeouQZpFx3cF7BhwKGe4FYzvN9t0=;
        b=RLn7eYmw1YOOcFI5wHGjnUxHLQgAEcP7Z8mbCe1G9uF1f3w0t0CneYgAe+obCJH198
         X+UVRFzWONmSz8u69rvnQtLvuwChQ81cvgcCltlnbmb2KdWSjaVqYxR+BV9ToH/XR7rJ
         UHuGPWiGXE+KZ86LWVKjMMmwWnO3CFqXqloLtq1gjc5XCD8y4rnWFJ8sr9lfnd75BbXe
         wmgmRjLvtmqPyFa5WoRxRT1y0s6oqw6aA8MarBlxlt9V5PQOGmYwvSJOWxXhPdzwl763
         guHyXZw80vuBmrwE22nTIkadXd0FB0593V/KWWgj/NY6w8f2SRZuX0X1Tgif6iQUqdhp
         jQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4fbyeXMI0vtuOcbeeouQZpFx3cF7BhwKGe4FYzvN9t0=;
        b=LxMymZn7ldL1KZ1GoTsRq0z+M6uXdXZk9WnP50KQNLV9+90bnnoFrS33GCweXSmVdK
         4QyipLOyZ7hiAVw19NiWlr1YSYF/VSTcwBjIYhR0pqWXD2Ai8VE+PvifbYGP1wauElqx
         hAK50acp7wvdSPa79rwg1l90VnYNBoMAs1KZ3noyPKjkJvH4vGi3DNx+KuQYkUBKusAY
         n4FP9olxdbKAs8nzmPBohetXZWCqJFIfe/71471Zy1XOQJTCvR47sOifri/97mx9/rl3
         Dk74uDLO+ROD/RA0EEfzzW9RW1nwathOyvmy7+FhUxc8aMU5U3xMbY6daA5kPF4Z7aRm
         PYrg==
X-Gm-Message-State: AA+aEWZ7UcZkbR+Stly2jKvRvvbRJ1jbYOiq2wYSOvLlrYnUUOCNy1SG
        McWUVNfrkVJDYAVz2+v2ViySauIl
X-Google-Smtp-Source: AFSGD/W5zlTAC0iTjCVQuHDhigGu8ygcMlUV6yQBJZTaDj90SpuTjQfGPzYpNYPgW1sm1njJIzhYNw==
X-Received: by 2002:a81:e50d:: with SMTP id s13mr25716307ywl.405.1545959729252;
        Thu, 27 Dec 2018 17:15:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:7729])
        by smtp.gmail.com with ESMTPSA id z74sm16947845ywz.51.2018.12.27.17.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 17:15:27 -0800 (PST)
Date:   Thu, 27 Dec 2018 17:15:24 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
Message-ID: <20181228011524.GF2509588@devbig004.ftw2.facebook.com>
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org>
 <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Happy holidays, everyone.

(cc'ing Rik, who has been looking at the scheduler code a lot lately)

On Thu, Dec 27, 2018 at 10:15:17AM -0800, Linus Torvalds wrote:
> [ goes off and looks ]
> 
> Oh. unthrottle_cfs_rq -> enqueue_entity -> list_add_leaf_cfs_rq()
> doesn't actually seem to hold the rq lock at all. It's just called
> under a rcu read lock.

I'm pretty sure enqueue_entity() *has* to be called with rq lock.
unthrottle_cfs_rq() is called from tg_set_cfs_bandwidth(),
distribute_cfs_runtime() and unthrottle_offline_cfs_rqs.  The first
two grabs the rq_lock just around the calls and the last one has a
lockdep assert on the rq_lock.  What am I missing?

> So it all seems to depend on that "on_list" flag for exclusion. Which
> seems fundamentally racy, since it's not protected by a lock.

The only place on_list is accessed without holding rq_lock is
unregister_fair_sched_group().  It's a minor optimization on a
relatively cold path (group destruction), so if it's racy there, I
think we can take out that optimization.  I'd be surprised if anyone
notices that.

That said, I don't think it's broken.  False positive on on_list is
fine and I can't see how a false negative would happen given that the
only event which can set it is the sched entity getting scheduled and
there's no way the removal path can't race against that transition.

> But that still makes me go "how come is this only noticed 18 months
> after the fact"?

Unless I'm totally confused, which is definitely possible, I don't
think there's a race condition and the only bug is the
tmp_alone_branch pointer getting dangled, which maybe doesn't happen
all that much?

Thanks.

-- 
tejun
