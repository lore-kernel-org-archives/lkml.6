Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeDFQgk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:36:40 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:50434 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeDFQgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:36:38 -0400
Date: Fri, 6 Apr 2018 12:38:02 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mm: treat memory.low value inclusive
Message-ID: <20180406163802.GA16383@cmpxchg.org>
References: <20180405185921.4942-1-guro@fb.com>
 <20180405185921.4942-3-guro@fb.com>
 <20180405194526.GC27918@cmpxchg.org>
 <20180406122132.GA7185@castle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406122132.GA7185@castle>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 01:21:38PM +0100, Roman Gushchin wrote:
> Updated version below.
> 
> --
> 
> From 466c35c36cae392cfee5e54a2884792972e789ee Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Thu, 5 Apr 2018 19:31:35 +0100
> Subject: [PATCH v4 3/4] mm: treat memory.low value inclusive
> 
> If memcg's usage is equal to the memory.low value, avoid reclaiming
> from this cgroup while there is a surplus of reclaimable memory.
> 
> This sounds more logical and also matches memory.high and memory.max
> behavior: both are inclusive.
> 
> Empty cgroups are not considered protected, so MEMCG_LOW events
> are not emitted for empty cgroups, if there is no more reclaimable
> memory in the system.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: kernel-team@fb.com
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Looks good, thanks!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
