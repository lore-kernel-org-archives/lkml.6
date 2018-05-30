Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeE3NJz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:09:55 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:52754 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751820AbeE3NJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:09:52 -0400
Date: Wed, 30 May 2018 09:11:59 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 06/13] blkcg: add generic throttling mechanism
Message-ID: <20180530131159.GB4035@cmpxchg.org>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-7-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529211724.4531-7-josef@toxicpanda.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 05:17:17PM -0400, Josef Bacik wrote:
> @@ -1099,6 +1099,11 @@ struct task_struct {
>  	unsigned int			memcg_nr_pages_over_high;
>  #endif
>  
> +#ifdef CONFIG_BLK_CGROUP
> +	struct request_queue		*throttle_queue;
> +	bool				use_memdelay;
> +#endif

Since you only touch use_memdelay from current, you can make this a
single bit and pack it with the other task flags farther up;
memcg_may_oom, no_cgroup_migration and friends.
