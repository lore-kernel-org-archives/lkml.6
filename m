Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679EDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373E320672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373E320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391469AbeKWATU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:19:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:54294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391372AbeKWATU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:19:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3890EAD33;
        Thu, 22 Nov 2018 13:39:55 +0000 (UTC)
Date:   Thu, 22 Nov 2018 14:39:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     ufo19890607@gmail.com
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com
Subject: Re: [PATCH v15 2/2] Add oom victim's memcg to the oom context
 information
Message-ID: <20181122133954.GI18011@dhcp22.suse.cz>
References: <1542799799-36184-1-git-send-email-ufo19890607@gmail.com>
 <1542799799-36184-2-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542799799-36184-2-git-send-email-ufo19890607@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-11-18 19:29:59, ufo19890607@gmail.com wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> The current oom report doesn't display victim's memcg context during the
> global OOM situation. While this information is not strictly needed, it
> can be really helpful for containerized environments to locate which
> container has lost a process. Now that we have a single line for the oom
> context, we can trivially add both the oom memcg (this can be either
> global_oom or a specific memcg which hits its hard limits) and task_memcg
> which is the victim's memcg.
> 
> Below is the single line output in the oom report after this patch.
> - global oom context information:
> oom-kill:constraint=<constraint>,nodemask=<nodemask>,cpuset=<cpuset>,mems_allowed=<mems_allowed>,global_oom,task_memcg=<memcg>,task=<comm>,pid=<pid>,uid=<uid>
> - memcg oom context information:
> oom-kill:constraint=<constraint>,nodemask=<nodemask>,cpuset=<cpuset>,mems_allowed=<mems_allowed>,oom_memcg=<memcg>,task_memcg=<memcg>,task=<comm>,pid=<pid>,uid=<uid>
> 
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>

I thought I have acked this one already.
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
