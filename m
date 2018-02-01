Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeBANtV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:49:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:42971 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751585AbeBANtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:49:18 -0500
Date: Thu, 1 Feb 2018 14:49:16 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: jpoimboe@redhat.com, jikos@kernel.org, Jason Baron <jbaron@akamai.com>,
        jeyu@kernel.org, Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: PATCH v6 0/6] livepatch: Atomic replace feature
In-Reply-To: <20180125160203.28959-1-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802011350200.26656@pobox.suse.cz>
References: <20180125160203.28959-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2018, Petr Mladek wrote:

> Hi,
> 
> the atomic replace allows to create cumulative patches. They
> are useful when you maintain many livepatches and want to remove
> one that is lower on the stack. In addition it is very useful when
> more patches touch the same function and there are dependencies
> between them.
> 
> This is my rework based on Jason's v5 patchset[1]. My intention was:
> 
>      + reduce code duplication and nop-specific shortcuts
>      + split the huge patch for an easier review
>      + simplify the logic where possible
>      + add/update/clear comments
>      + better fit into the existing code
> 
> I am not supper happy with the result. But it took me much longer
> time than expected. It is high time, I shared the current state
> and get some feedback.
> 
> 
> Jason,
> 
> I used your code in most of the patches and kept you as the author.
> Please, let me know if you would prefer another solution.
> 
> Also I am sorry that I have done it this way. I was not able to
> suggest it out of head. I needed many iterations to end up with
> the current state. I needed to play with the code. Therefore
> it made sense to send what I got.
> 
> 
> [1] https://lkml.kernel.org/r/cover.1515786085.git.jbaron@akamai.com
 
Hi,

the series looks good to me (apart from the mentioned bugs and a couple 
of nits). I'll port my old kGraft testing modules and hopefully it will
survive.

Well, one more thing. I think there is a problem with shadow variables. 
Similar to callbacks situation. Shadow variables cannot be destroyed the 
way it is shown in our samples. Cumulative patches want to preserve 
everything as much as possible. If I'm right, it should be mentioned in 
the documentation.

Miroslav
