Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeEBM27 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:28:59 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:48788 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbeEBM25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:28:57 -0400
Date: Wed, 2 May 2018 08:30:40 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@fb.com,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] mm: introduce memory.min
Message-ID: <20180502123040.GA16060@cmpxchg.org>
References: <20180423123610.27988-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423123610.27988-1-guro@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 01:36:10PM +0100, Roman Gushchin wrote:
> @@ -59,6 +59,12 @@ enum memcg_memory_event {
>  	MEMCG_NR_MEMORY_EVENTS,
>  };
>  
> +enum mem_cgroup_protection {
> +	MEMCG_PROT_NONE,
> +	MEMCG_PROT_LOW,
> +	MEMCG_PROT_HIGH,

Ha, HIGH doesn't make much sense, but I went back and it's indeed what
I suggested. Must have been a brainfart. This should be

MEMCG_PROT_NONE,
MEMCG_PROT_LOW,
MEMCG_PROT_MIN

right? To indicate which type of protection is applying.

The rest of the patch looks good:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
