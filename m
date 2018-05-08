Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755288AbeEHROZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:14:25 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:49872 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754775AbeEHROY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:14:24 -0400
Date: Tue, 8 May 2018 13:16:10 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <guro@fb.com>
Cc: kernel-team@fb.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: fix oom_kill event handling
Message-ID: <20180508171610.GA24175@cmpxchg.org>
References: <20180508124637.29984-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508124637.29984-1-guro@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 01:46:37PM +0100, Roman Gushchin wrote:
> Commit e27be240df53 ("mm: memcg: make sure memory.events is
> uptodate when waking pollers") converted most of memcg event
> counters to per-memcg atomics, which made them less confusing
> for a user. The "oom_kill" counter remained untouched, so now
> it behaves differently than other counters (including "oom").
> This adds nothing but confusion.
> 
> Let's fix this by adding the MEMCG_OOM_KILL event, and follow
> the MEMCG_OOM approach. This also removes a hack from
> count_memcg_event_mm(), introduced earlier specially for the
> OOM_KILL counter.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
