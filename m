Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeCZOzJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:55:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:50083 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751127AbeCZOzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:55:08 -0400
Date: Mon, 26 Mar 2018 16:55:05 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>, adobriyan@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180326145505.GM5652@dhcp22.suse.cz>
References: <1521851771-108673-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180324043044.GA22733@bombadil.infradead.org>
 <aed7f679-a32f-d8d7-eb59-ec05fc49a70e@linux.alibaba.com>
 <a766b98b-80b4-5f1b-9588-dd1c5506cbdc@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a766b98b-80b4-5f1b-9588-dd1c5506cbdc@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-03-18 23:49:18, Tetsuo Handa wrote:
[...]
> Also, even if we succeeded to avoid mmap_sem contention at that location,
> won't we after all get mmap_sem contention messages a bit later, for
> access_remote_vm() holds mmap_sem which would lead to traces like above
> if mmap_sem is already contended?

Yes, but at least we get rid of the mmap_sem for something that can use
a more fine grained locking.

Maybe we can get a finer grained range locking for mmap_sem one day and
not having the full range locked section will be a plus.

-- 
Michal Hocko
SUSE Labs
