Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE08BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C63C2154F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ttj//fxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C63C2154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeHWXh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:37:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34950 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeHWXh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:37:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so3372962pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aHa5/rtLstYkWYWr9t9VBxFJXIFOyv9KvgqGTNJZn24=;
        b=Ttj//fxrovqSr4NGg/XzmEjrJu+WqTFW2TC584CSeUgvOrpA+h8dEYQdlkAGutlfiK
         G96JaKKWaaY4bZJut82nfw3m+k31lr06YeXGZ1g4hZkmovoi/slyK5Lf1cWhWznDa7eM
         mN4lfHXWjybRAAqwq3KGyGXAHzY0nrvh5Pw6hjxg3VeqhPo6Az23slHnXPs58lUAuPFe
         JhLIYdh/UuYEL3KQANq1YcWYTW8yTpPdDbydJaoyTkVbIYX+zKCKdjbXX/xmcMy/Lo7R
         LdTHruFGKpLg2lVRtqAnoV2vtS2ydCGOJf9uudTTA7YTIQs5XFCMZUVL4Fp+1hJ8fctt
         DgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aHa5/rtLstYkWYWr9t9VBxFJXIFOyv9KvgqGTNJZn24=;
        b=s6aAnbsWos2R9DnttEoNqMg8mLG9DghO2s2D8ZfxBII15X+VY2gVj5JooCLFKS7x+E
         mFjpXfiYf7eboEiRen89QM4WVoYiiifdu7izILRAuTg0aQXmIjgdIooS4EFDa9tBH0xj
         aPm0mQTAehozYq4DnFlgTpQg6rB9g8Arucb/REchixdrhXQutGkVPsLHgNTdj+oBtX3t
         tFQbtGbUGEy+g4hQY6HZ/GkL96YuMAEFIU4uWL/c4YOgPHNkzdLU3NoKkAQ/FSLQuBwo
         XQFUdsfcXzE4kTF4fkmmr9NM0/b9fpCypo7m+qXAe83yYtDGoG+x9LQJd21TomXAbT9R
         ytcg==
X-Gm-Message-State: AOUpUlEuwysWW5Z0EryBh3gU6duX6XwzFfHzrMNXlFiRbuPLcBLsiX9M
        y7cyDCjAiRu/BpXGBh81voUJFg==
X-Google-Smtp-Source: AA+uWPzziaSSsxwlbwaqzbLZlghAvRuyu/KtxXv9Ij/XEjOUW+BiXvdBRuCxRrLoiT7p9mxE6ZYrbQ==
X-Received: by 2002:a17:902:bd84:: with SMTP id q4-v6mr59953714pls.145.1535054800644;
        Thu, 23 Aug 2018 13:06:40 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u83-v6sm18350203pfj.37.2018.08.23.13.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 13:06:39 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:06:38 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
In-Reply-To: <804b50cb-0b17-201a-790b-18604396f826@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1808231304080.15798@chino.kir.corp.google.com>
References: <9158a23e-7793-7735-e35c-acd540ca59bf@i-love.sakura.ne.jp> <20180730144647.GX24267@dhcp22.suse.cz> <20180730145425.GE1206094@devbig004.ftw2.facebook.com> <0018ac3b-94ee-5f09-e4e0-df53d2cbc925@i-love.sakura.ne.jp> <20180730154424.GG1206094@devbig004.ftw2.facebook.com>
 <20180730185110.GB24267@dhcp22.suse.cz> <20180730191005.GC24267@dhcp22.suse.cz> <6f433d59-4a56-b698-e119-682bb8bf6713@i-love.sakura.ne.jp> <20180731050928.GA4557@dhcp22.suse.cz> <d11c3aa2-0f14-d882-59c5-6634dc56eed1@i-love.sakura.ne.jp>
 <20180803061653.GB27245@dhcp22.suse.cz> <804b50cb-0b17-201a-790b-18604396f826@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018, Tetsuo Handa wrote:

> On 2018/08/03 15:16, Michal Hocko wrote:
> > On Fri 03-08-18 07:05:54, Tetsuo Handa wrote:
> >> On 2018/07/31 14:09, Michal Hocko wrote:
> >>> On Tue 31-07-18 06:01:48, Tetsuo Handa wrote:
> >>>> On 2018/07/31 4:10, Michal Hocko wrote:
> >>>>> Since should_reclaim_retry() should be a natural reschedule point,
> >>>>> let's do the short sleep for PF_WQ_WORKER threads unconditionally in
> >>>>> order to guarantee that other pending work items are started. This will
> >>>>> workaround this problem and it is less fragile than hunting down when
> >>>>> the sleep is missed. E.g. we used to have a sleeping point in the oom
> >>>>> path but this has been removed recently because it caused other issues.
> >>>>> Having a single sleeping point is more robust.
> >>>>
> >>>> linux.git has not removed the sleeping point in the OOM path yet. Since removing the
> >>>> sleeping point in the OOM path can mitigate CVE-2016-10723, please do so immediately.
> >>>
> >>> is this an {Acked,Reviewed,Tested}-by?
> >>>
> >>> I will send the patch to Andrew if the patch is ok. 
> >>>
> >>>> (And that change will conflict with Roman's cgroup aware OOM killer patchset. But it
> >>>> should be easy to rebase.)
> >>>
> >>> That is still a WIP so I would lose sleep over it.
> >>>
> >>
> >> Now that Roman's cgroup aware OOM killer patchset will be dropped from linux-next.git ,
> >> linux-next.git will get the sleeping point removed. Please send this patch to linux-next.git .
> > 
> > I still haven't heard any explicit confirmation that the patch works for
> > your workload. Should I beg for it? Or you simply do not want to have
> > your stamp on the patch? If yes, I can live with that but this playing
> > hide and catch is not really a lot of fun.
> > 
> 
> I noticed that the patch has not been sent to linux-next.git yet.
> Please send to linux-next.git without my stamp on the patch.
> 

For those of us who are tracking CVE-2016-10723 which has peristently been 
labeled as "disputed" and with no clear indication of what patches address 
it, I am assuming that commit 9bfe5ded054b ("mm, oom: remove sleep from 
under oom_lock") and this patch are the intended mitigations?

A list of SHA1s for merged fixed and links to proposed patches to address 
this issue would be appreciated.
