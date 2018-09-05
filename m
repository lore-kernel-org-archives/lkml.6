Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38496C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F303E2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F303E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeIESfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeIESfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:35:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11184ACE3;
        Wed,  5 Sep 2018 14:04:54 +0000 (UTC)
Date:   Wed, 5 Sep 2018 16:04:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
Message-ID: <20180905140451.GG14951@dhcp22.suse.cz>
References: <cb2d635c-c14d-c2cc-868a-d4c447364f0d@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1808231544001.150774@chino.kir.corp.google.com>
 <201808240031.w7O0V5hT019529@www262.sakura.ne.jp>
 <195a512f-aecc-f8cf-f409-6c42ee924a8c@i-love.sakura.ne.jp>
 <20180905134038.GE14951@dhcp22.suse.cz>
 <81cc1f29-e42e-7813-dc70-5d6d9e999dd1@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81cc1f29-e42e-7813-dc70-5d6d9e999dd1@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 22:53:33, Tetsuo Handa wrote:
> On 2018/09/05 22:40, Michal Hocko wrote:
> > Changelog said 
> > 
> > "Although this is possible in principle let's wait for it to actually
> > happen in real life before we make the locking more complex again."
> > 
> > So what is the real life workload that hits it? The log you have pasted
> > below doesn't tell much.
> 
> Nothing special. I just ran a multi-threaded memory eater on a CONFIG_PREEMPT=y kernel.

I strongly suspec that your test doesn't really represent or simulate
any real and useful workload. Sure it triggers a rare race and we kill
another oom victim. Does this warrant to make the code more complex?
Well, I am not convinced, as I've said countless times.
-- 
Michal Hocko
SUSE Labs
