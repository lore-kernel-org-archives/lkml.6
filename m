Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeDRJDR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:03:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753215AbeDRJDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:03:16 -0400
Date: Wed, 18 Apr 2018 11:03:14 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        willy@infradead.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180418090314.GU17484@dhcp22.suse.cz>
References: <1523730291-109696-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180418080555.GR17484@dhcp22.suse.cz>
 <20180418090217.GG19578@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418090217.GG19578@uranus.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-04-18 12:02:17, Cyrill Gorcunov wrote:
> On Wed, Apr 18, 2018 at 10:05:55AM +0200, Michal Hocko wrote:
> > 
> > Yes, looks good to me. As mentioned in other emails prctl_set_mm_map
> > really deserves a comment explaining why we are doing the down_read
> > 
> > What about something like the following?
> > "
> > arg_lock protects concurent updates but we still need mmap_sem for read
> > to exclude races with do_brk.
> > "
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Yes, thanks! Andrew, could you slightly update the changelog please?

No, I meant it to be a comment in the _code_.

-- 
Michal Hocko
SUSE Labs
