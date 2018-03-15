Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeCOUyO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:54:14 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45093 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbeCOUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:54:11 -0400
X-Google-Smtp-Source: AG47ELsdicoXQUnm8PgonAKfPVuLAHk9SbC5BKV9NzA0Y8oKLNYt2VhSuvqwHkE5sAMmRVKpsVbseA==
Date: Thu, 15 Mar 2018 13:54:09 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
cc: Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch -mm v3 0/3] mm, memcg: introduce oom policies
In-Reply-To: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.20.1803151351140.55261@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018, David Rientjes wrote:

> There are three significant concerns about the cgroup aware oom killer as
> it is implemented in -mm:
> 
>  (1) allows users to evade the oom killer by creating subcontainers or
>      using other controllers since scoring is done per cgroup and not
>      hierarchically,
> 
>  (2) unfairly compares the root mem cgroup using completely different
>      criteria than leaf mem cgroups and allows wildly inaccurate results
>      if oom_score_adj is used, and
> 
>  (3) does not allow the user to influence the decisionmaking, such that
>      important subtrees cannot be preferred or biased.
> 
> This patchset aims to fix (1) completely and, by doing so, introduces a
> completely extensible user interface that can be expanded in the future.
> 
> It preserves all functionality that currently exists in -mm and extends
> it to be generally useful outside of very specialized usecases.
> 
> It eliminates the mount option for the cgroup aware oom killer entirely
> since it is now enabled through the root mem cgroup's oom policy.

There are currently six patches in this series since additional patches on 
top of it have been proposed to fix the several issues with the current 
implementation in -mm.  The six patches address (1) and (2) above, as well 
as a couple other minor tweaks.  I believe (3) can be subsequently 
addressed after the feature has been merged since it builds upon what is 
already here and shouldn't hold it back from being merged itself.

I plan on sending out the entire series once feedback is received for the 
patches already sent.

Thanks.
