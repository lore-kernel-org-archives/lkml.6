Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002DAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABC6208E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABC6208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeHXEDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 00:03:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55360 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeHXEDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 00:03:15 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w7O0V5VS019534;
        Fri, 24 Aug 2018 09:31:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Fri, 24 Aug 2018 09:31:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w7O0V5sS019530;
        Fri, 24 Aug 2018 09:31:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w7O0V5hT019529;
        Fri, 24 Aug 2018 09:31:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201808240031.w7O0V5hT019529@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] =?ISO-2022-JP?B?bW0scGFnZV9hbGxvYzogUEZfV1FfV09SS0VSIHRocmVh?=
 =?ISO-2022-JP?B?ZHMgbXVzdCBzbGVlcCBhdCBzaG91bGRfcmVjbGFpbV9yZXRyeSgpLg==?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Date:   Fri, 24 Aug 2018 09:31:05 +0900
References: <cb2d635c-c14d-c2cc-868a-d4c447364f0d@i-love.sakura.ne.jp> <alpine.DEB.2.21.1808231544001.150774@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1808231544001.150774@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> On Fri, 24 Aug 2018, Tetsuo Handa wrote:
> 
> > > For those of us who are tracking CVE-2016-10723 which has peristently been 
> > > labeled as "disputed" and with no clear indication of what patches address 
> > > it, I am assuming that commit 9bfe5ded054b ("mm, oom: remove sleep from 
> > > under oom_lock") and this patch are the intended mitigations?
> > > 
> > > A list of SHA1s for merged fixed and links to proposed patches to address 
> > > this issue would be appreciated.
> > > 
> > 
> > Commit 9bfe5ded054b ("mm, oom: remove sleep from under oom_lock") is a
> > mitigation for CVE-2016-10723.
> > 
> > "[PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
> > should_reclaim_retry()." is independent from CVE-2016-10723.
> > 
> 
> Thanks, Tetsuo.  Should commit af5679fbc669 ("mm, oom: remove oom_lock 
> from oom_reaper") also be added to the list for CVE-2016-10723?
> 

Commit af5679fbc669f31f ("mm, oom: remove oom_lock from oom_reaper")
negated one of the two rationales for commit 9bfe5ded054b8e28 ("mm, oom:
remove sleep from under oom_lock"). If we didn't apply af5679fbc669f31f,
we could make sure that CPU resource is given to the owner of oom_lock
by replacing mutex_trylock() in __alloc_pages_may_oom() with mutex_lock().
But now that af5679fbc669f31f was already applied, we don't know how to
give CPU resource to the OOM reaper / exit_mmap(). We might arrive at
direct OOM reaping but we haven't reached there...

For now, I don't think we need to add af5679fbc669f31f to the list for
CVE-2016-10723, for af5679fbc669f31f might cause premature next OOM victim
selection (especially with CONFIG_PREEMPT=y kernels) due to

   __alloc_pages_may_oom():               oom_reap_task():

     mutex_trylock(&oom_lock) succeeds.
     get_page_from_freelist() fails.
     Preempted to other process.
                                            oom_reap_task_mm() succeeds.
                                            Sets MMF_OOM_SKIP.
     Returned from preemption.
     Finds that MMF_OOM_SKIP was already set.
     Selects next OOM victim and kills it.
     mutex_unlock(&oom_lock) is called.

race window like described as

    Tetsuo was arguing that at least MMF_OOM_SKIP should be set under the lock
    to prevent from races when the page allocator didn't manage to get the
    freed (reaped) memory in __alloc_pages_may_oom but it sees the flag later
    on and move on to another victim.  Although this is possible in principle
    let's wait for it to actually happen in real life before we make the
    locking more complex again.

in that commit.
