Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4BAC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7837020C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7837020C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeHBJul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:50:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:58826 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbeHBJul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:50:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB1A7AD26;
        Thu,  2 Aug 2018 08:00:42 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:00:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] introduce memory.oom.group
Message-ID: <20180802080041.GB10808@dhcp22.suse.cz>
References: <20180730180100.25079-1-guro@fb.com>
 <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
 <20180731235135.GA23436@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-08-18 14:51:25, David Rientjes wrote:
> On Tue, 31 Jul 2018, Roman Gushchin wrote:
> 
> > > What's the plan with the cgroup aware oom killer?  It has been sitting in 
> > > the -mm tree for ages with no clear path to being merged.
> > 
> > It's because your nack, isn't it?
> > Everybody else seem to be fine with it.
> > 
> 
> If they are fine with it, I'm not sure they have tested it :)  Killing 
> entire cgroups needlessly for mempolicy oom kills that will not free 
> memory on target nodes is the first regression they may notice.

I do not remember you would be mentioning this previously. Anyway the
older implementation has considered the nodemask in memcg_oom_badness.
You are right that a cpuset allocation could needlessly select a memcg
with small or no memory from the target nodemask which is something I
could have noticed during the review. If only I didn't have to spend all
my energy to go through repetitive arguments of yours. Anyway this would
be quite trivial to resolve in the same function by checking
node_isset(node, current->mems_allowed).

Thanks for your productive feedback again.

Skipping the rest which is yet again repeating same arguments and it
doesn't add anything new to the table.
-- 
Michal Hocko
SUSE Labs
