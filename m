Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFE0C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05B421A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05B421A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbeHFWpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:45:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:40764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387916AbeHFWpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:45:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6379FACA8;
        Mon,  6 Aug 2018 20:34:38 +0000 (UTC)
Date:   Mon, 6 Aug 2018 22:34:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
Subject: Re: WARNING in try_charge
Message-ID: <20180806203437.GK10003@dhcp22.suse.cz>
References: <fc6e173e-8bda-269f-d44f-1c5f5215beac@I-love.SAKURA.ne.jp>
 <0000000000006350880572c61e62@google.com>
 <20180806174410.GB10003@dhcp22.suse.cz>
 <20180806175627.GC10003@dhcp22.suse.cz>
 <078bde8d-b1b5-f5ad-ed23-0cd94b579f9e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <078bde8d-b1b5-f5ad-ed23-0cd94b579f9e@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-08-18 05:26:23, Tetsuo Handa wrote:
> On 2018/08/07 2:56, Michal Hocko wrote:
> > So the oom victim indeed passed the above force path after the oom
> > invocation. But later on hit the page fault path and that behaved
> > differently and for some reason the force path hasn't triggered. I am
> > wondering how could we hit the page fault path in the first place. The
> > task is already killed! So what the hell is going on here.
> > 
> > I must be missing something obvious here.
> > 
> YOU ARE OBVIOUSLY MISSING MY MAIL!
> 
> I already said this is "mm, oom: task_will_free_mem(current) should ignore MMF_OOM_SKIP for once."
> problem which you are refusing at https://www.spinics.net/lists/linux-mm/msg133774.html .
> And you again ignored my mail. Very sad...

Your suggestion simply didn't make much sense. There is nothing like
first check is different from the rest.
-- 
Michal Hocko
SUSE Labs
