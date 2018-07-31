Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46C6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB05208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB05208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbeGaNfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:35:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50196 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731962AbeGaNfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:35:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D1E0AD94;
        Tue, 31 Jul 2018 11:55:05 +0000 (UTC)
Date:   Tue, 31 Jul 2018 13:55:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
Message-ID: <20180731115504.GJ4557@dhcp22.suse.cz>
References: <20180730145425.GE1206094@devbig004.ftw2.facebook.com>
 <0018ac3b-94ee-5f09-e4e0-df53d2cbc925@i-love.sakura.ne.jp>
 <20180730154424.GG1206094@devbig004.ftw2.facebook.com>
 <20180730185110.GB24267@dhcp22.suse.cz>
 <20180730191005.GC24267@dhcp22.suse.cz>
 <6f433d59-4a56-b698-e119-682bb8bf6713@i-love.sakura.ne.jp>
 <20180731050928.GA4557@dhcp22.suse.cz>
 <b03f09c2-f749-9c80-b4f6-d0b4a9634013@i-love.sakura.ne.jp>
 <20180731111519.GH4557@dhcp22.suse.cz>
 <08292e78-9a28-12ec-4164-2934cde5be51@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08292e78-9a28-12ec-4164-2934cde5be51@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-07-18 20:30:08, Tetsuo Handa wrote:
> On 2018/07/31 20:15, Michal Hocko wrote:
> >>> I will send the patch to Andrew if the patch is ok. 
> >>
> >> Andrew, can we send the "we used to have a sleeping point in the oom path but this has
> >> been removed recently" patch to linux.git ?
> > 
> > This can really wait for the next merge window IMHO.
> > 
> 
> "mm, oom: cgroup-aware OOM killer" in linux-next.git is reviving that sleeping point.
> Current "mm, oom: cgroup-aware OOM killer" will not be sent to linux.git in the next
> merge window? I'm confused...

This has nothing to do with cgroup-aware OOM killer.

-- 
Michal Hocko
SUSE Labs
