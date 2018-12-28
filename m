Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2841C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869A32148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545962570;
	bh=UuHRVtE5TOF51cQ882HbjSfzxjsKe2O1mPugL3Z0ip0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tg1l+Y8GJgrKeOasma2y9YS+Yn7Ra1g1gGEvsjBHNLXWak2fRpnGE/UFQZxUQYbCx
	 WYwojncnn4/Gt7I01mUiUpCaT474mgbE3Ekf8IDRCMAQ3hXhv42o66erqET16gG0FP
	 Epjf+G1i4Dd8vQ2ABQSjOYe87PWOzSmIILCQF4Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeL1CCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 21:02:49 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33259 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeL1CCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 21:02:49 -0500
Received: by mail-yw1-f67.google.com with SMTP id p65so6775912ywe.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 18:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qFOK9QSGto8EOXWIC+uhgBoTwFjpX9AyK9r/zP53OZI=;
        b=XgvLc9Ka4D7a48teev/Fi6Zs2+oLiMTziRxaPEpRbmX6vyTOSLd1RGdTOO24nOakSS
         cUPGrSr0PG9fz0o4Czv2iQmP5ZCJ1ULwWHHQI4x92EL7gYK0fmgw/pTqmomyrAO30+oc
         hPxkuuDszDPQQgg9Mvyh7mHDIj/w4cFXizPaSXTbXVraqkDJm9n3RUh5sWQfvOOo42MA
         Qqx/iCj60LD94oZGTrATGbrzOTOHdZeevpcm1MLlTt6Sa7IbKxQyNgRGB1NT7gBh7/ck
         ATd0fd+3AXoLO855hg2xRKyJcxzt3e5rHHWxPdVMIT81dflOK+ND0bsYMbiHRmvh6bMd
         fSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFOK9QSGto8EOXWIC+uhgBoTwFjpX9AyK9r/zP53OZI=;
        b=Z/uxTknAgUB0/2q6jwHSz8S1xERtPf7mHpxVQJTbMKAb1Xwn95oBAmYg8uGmst5Ms+
         CAh0zdAcVNI2HqqTQyvCNRw2bROYbvYebv2EwyR20TlJ/EX8MN6nPCsdlAER3yVS72VK
         +QOUNdGbi31qSDaPng7CZU4eigBDX8qpYC7x87NeORnV5Kgd7M1cL15Kp195o6IWz4gB
         DpJI/m0tCOPBMFQ9YuP4DXUsK0YhR3OO+v0A9XjLPcCQPjlcAuRhML+PKUSOilwAuNst
         bW6iAHuIJWb1hG7UqUCRbYcl2d3cZQoS7M2A4Us4aulG8ZR3y/PBuaRoa+RqVMEUW5JV
         e4Dw==
X-Gm-Message-State: AA+aEWY+yU0f8+1QbaiSTaXukv0WR/BaCfjenTt/2NSpQm4qcEAuaZlO
        dmhteOUmPdhjh3ELFjWDt28=
X-Google-Smtp-Source: AFSGD/VeDqxm7wZ8X+rI6UI5HtGKf0rckZ/BI15oSaoKgxsr1RzRyTSu1QdiG2quEGtiilwQHVbE6g==
X-Received: by 2002:a0d:e6ca:: with SMTP id p193mr25445891ywe.217.1545962566763;
        Thu, 27 Dec 2018 18:02:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:7729])
        by smtp.gmail.com with ESMTPSA id m126sm14259666ywd.39.2018.12.27.18.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 18:02:45 -0800 (PST)
Date:   Thu, 27 Dec 2018 18:02:43 -0800
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
Message-ID: <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org>
 <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
 <20181228011524.GF2509588@devbig004.ftw2.facebook.com>
 <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
 <20181228015352.GG2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228015352.GG2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 05:53:52PM -0800, Tejun Heo wrote:
> Vincent knows that part way better than me but I think the safest way
> would be doing the optimization removal iff tmp_alone_branch is
> already pointing to leaf_cfs_rq_list.  IIUC, it's pointing to
> something else only while a branch is being built and deferring
> optimization removal by an avg update cycle isn't gonna make any
> difference anyway.

So, something like the following.  Xie, can you see whether the
following patch resolves the problem?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d1907506318a..88b9118b5191 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7698,7 +7698,8 @@ static void update_blocked_averages(int cpu)
 		 * There can be a lot of idle CPU cgroups.  Don't let fully
 		 * decayed cfs_rqs linger on the list.
 		 */
-		if (cfs_rq_is_decayed(cfs_rq))
+		if (cfs_rq_is_decayed(cfs_rq) &&
+		    rq->tmp_alone_branch == &rq->leaf_cfs_rq_list)
 			list_del_leaf_cfs_rq(cfs_rq);
 
 		/* Don't need periodic decay once load/util_avg are null */
