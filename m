Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeECRgy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:36:54 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:48978 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbeECRgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:36:51 -0400
Date: Thu, 3 May 2018 13:38:35 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/2] mm: ignore memory.min of abandoned memory cgroups
Message-ID: <20180503173835.GA28437@cmpxchg.org>
References: <20180503114358.7952-1-guro@fb.com>
 <20180503114358.7952-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503114358.7952-2-guro@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 12:43:58PM +0100, Roman Gushchin wrote:
> If a cgroup has no associated tasks, invoking the OOM killer
> won't help release any memory, so respecting the memory.min
> can lead to an infinite OOM loop or system stall.
> 
> Let's ignore memory.min of unpopulated cgroups.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I wouldn't mind merging this into the previous patch. It's fairly
small, and there is no reason to introduce an infinite OOM loop
scenario into the tree, even if it's just for one commit.
