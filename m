Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57245C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02915214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02915214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeHVKzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:55:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:48534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727649AbeHVKzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:55:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40F17AE95;
        Wed, 22 Aug 2018 07:32:05 +0000 (UTC)
Date:   Wed, 22 Aug 2018 09:32:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
Message-ID: <20180822073204.GC29735@dhcp22.suse.cz>
References: <20180730145425.GE1206094@devbig004.ftw2.facebook.com>
 <0018ac3b-94ee-5f09-e4e0-df53d2cbc925@i-love.sakura.ne.jp>
 <20180730154424.GG1206094@devbig004.ftw2.facebook.com>
 <20180730185110.GB24267@dhcp22.suse.cz>
 <20180730191005.GC24267@dhcp22.suse.cz>
 <6f433d59-4a56-b698-e119-682bb8bf6713@i-love.sakura.ne.jp>
 <20180731050928.GA4557@dhcp22.suse.cz>
 <d11c3aa2-0f14-d882-59c5-6634dc56eed1@i-love.sakura.ne.jp>
 <20180803061653.GB27245@dhcp22.suse.cz>
 <804b50cb-0b17-201a-790b-18604396f826@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804b50cb-0b17-201a-790b-18604396f826@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-08-18 06:07:40, Tetsuo Handa wrote:
> On 2018/08/03 15:16, Michal Hocko wrote:
[...]
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

I plan to do so after merge window closes.
-- 
Michal Hocko
SUSE Labs
