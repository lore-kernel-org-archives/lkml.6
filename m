Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeBUURS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:17:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35458 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBUURQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:17:16 -0500
Date: Wed, 21 Feb 2018 12:17:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v5 2/2] mm/memcontrol.c: Reduce reclaim retries in
 mem_cgroup_resize_limit()
Message-Id: <20180221121715.0233d34dda330c56e1a9db5f@linux-foundation.org>
In-Reply-To: <20180119151118.GE6584@dhcp22.suse.cz>
References: <20171220102429.31601-1-aryabinin@virtuozzo.com>
        <20180119132544.19569-1-aryabinin@virtuozzo.com>
        <20180119132544.19569-2-aryabinin@virtuozzo.com>
        <20180119133510.GD6584@dhcp22.suse.cz>
        <CALvZod7HS6P0OU6Rps8JeMJycaPd4dF5NjxV8k1y2-yosF2bdA@mail.gmail.com>
        <20180119151118.GE6584@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2018 16:11:18 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> And to be honest, I do not really see why keeping retrying from
> mem_cgroup_resize_limit should be so much faster than keep retrying from
> the direct reclaim path. We are doing SWAP_CLUSTER_MAX batches anyway.
> mem_cgroup_resize_limit loop adds _some_ overhead but I am not really
> sure why it should be that large.

Maybe restarting the scan lots of times results in rescanning lots of
ineligible pages at the start of the list before doing useful work?

Andrey, are you able to determine where all that CPU time is being spent?

Thanks.
