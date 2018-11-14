Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E07EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5E32145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5E32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbeKNUSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:18:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:43244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbeKNUSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:18:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF621AED4;
        Wed, 14 Nov 2018 10:16:05 +0000 (UTC)
Date:   Wed, 14 Nov 2018 11:16:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/3] oom: rework oom_reaper vs. exit_mmap handoff
Message-ID: <20181114101604.GM23419@dhcp22.suse.cz>
References: <20181025082403.3806-1-mhocko@kernel.org>
 <20181108093224.GS27423@dhcp22.suse.cz>
 <9dfd5c87-ae48-8ffb-fbc6-706d627658ff@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dfd5c87-ae48-8ffb-fbc6-706d627658ff@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-11-18 18:46:13, Tetsuo Handa wrote:
[...]
> There is always an invisible lock called "scheduling priority". You can't
> leave the MMF_OOM_SKIP to the exit path. Your approach is not ready for
> handling the worst case.

And that problem is all over the memory reclaim. You can get starved
to death and block other resources. And the memory reclaim is not the
only one. This is a fundamental issue of the locking without priority
inheritance and other real time techniques.

> Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

OK, if your whole point is to block any changes into this area unless
it is your solution to be merged then I guess I will just push patches
through with your explicit Nack on them. Your feedback was far fetched
at many times has distracted the discussion way too often. This is
especially sad because your testing and review was really helpful at
times. I do not really have energy to argue the same set of arguments
over and over again.

You have expressed unwillingness to understand the overall
picture several times. You do not care about a long term maintenance
burden of this code which is quite tricky already and refuse to
understand the cost/benefit part.

If this series works for the workload reported by David I will simply
push it through and let Andrew decide. If there is a lack of feedback
I will just keep it around because it seems that most users do not care
about these corner cases anyway.
-- 
Michal Hocko
SUSE Labs
