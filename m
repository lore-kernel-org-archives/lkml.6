Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933010AbeDXMaJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:30:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34398 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757144AbeDXMaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:30:07 -0400
X-Google-Smtp-Source: AB8JxZoXG9rZVjqTgAzGi1ZnWGvxCrxxVmhc7ACh4+0r/ZBuzVZmracWbBA/D9GsJmMlC5bp069STA==
Date: Tue, 24 Apr 2018 15:30:02 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] mm: introduce memory.min
Message-ID: <20180424123002.utwbm54mu46q6aqs@esperanza>
References: <20180423123610.27988-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423123610.27988-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Mon, Apr 23, 2018 at 01:36:10PM +0100, Roman Gushchin wrote:
> +  memory.min
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "0".
> +
> +	Hard memory protection.  If the memory usage of a cgroup
> +	is within its effective min boundary, the cgroup's memory
> +	won't be reclaimed under any conditions. If there is no
> +	unprotected reclaimable memory available, OOM killer
> +	is invoked.

What will happen if all tasks attached to a cgroup are killed by OOM,
but its memory usage is still within memory.min? Will memory.min be
ignored then?

> +
> +	Effective low boundary is limited by memory.min values of
> +	all ancestor cgroups. If there is memory.min overcommitment
> +	(child cgroup or cgroups are requiring more protected memory
> +	than parent will allow), then each child cgroup will get
> +	the part of parent's protection proportional to its
> +	actual memory usage below memory.min.
> +
> +	Putting more memory than generally available under this
> +	protection is discouraged and may lead to constant OOMs.
