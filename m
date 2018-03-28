Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeC1NKr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:54364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753148AbeC1NKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:10:45 -0400
Date: Wed, 28 Mar 2018 15:10:42 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        willy@infradead.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180328131042.GL9275@dhcp22.suse.cz>
References: <1522088439-105930-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180327062939.GV5652@dhcp22.suse.cz>
 <95a107ac-5e5b-92d7-dbde-2e961d85de28@linux.alibaba.com>
 <20180327185217.GK2236@uranus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327185217.GK2236@uranus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-03-18 21:52:17, Cyrill Gorcunov wrote:
> On Tue, Mar 27, 2018 at 02:38:11PM -0400, Yang Shi wrote:
> > > Why do we need to hold mmap_sem here and call find_vma, when only
> > > PR_SET_MM_ENV_END: is consuming it? I guess we can replace it wit the
> > > new lock and take the mmap_sem only for PR_SET_MM_ENV_END.
> > 
> > Actually, I didn't think of why. It looks prctl_set_mm() checks if vma does
> > exist when it tries to set stack_start, argv_* and env_*, btw not only
> > env_end.
> > 
> > Cyrill may be able to give us some hint since C/R is the main user of this
> > API.
> 
> First and most important it makes code smaller. This prctl call is really
> rarely used. Of course we can optimize it, but as I said I would prefer
> to simply deprecate this old interface (and I gonne to do so once time
> permit).

Ohh, it would be really great if we can remove this thingy altogether. I
cannot say it has a wee bit of my sympathy.

-- 
Michal Hocko
SUSE Labs
