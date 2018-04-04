Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeDDFfp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:35:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbeDDFfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:35:44 -0400
Date: Wed, 4 Apr 2018 07:35:41 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [RFC] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180404053541.GA6312@dhcp22.suse.cz>
References: <20180403223722.GA15783@uranus.lan>
 <48bcd917-4eb8-9da6-ec4b-e76a654695c4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48bcd917-4eb8-9da6-ec4b-e76a654695c4@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-04-18 16:15:20, Yang Shi wrote:
> 
> 
> On 4/3/18 3:37 PM, Cyrill Gorcunov wrote:
> > An ability to manipulate mm_struct fields was introduced in
> > sake of CRIU in first place. Later we provide more suitable
> > and safe operation PR_SET_MM_MAP where all fields to be modifed
> > are passed in one structure which allows us to make more detailed
> > verification.
> > 
> > Still old interface remains present for compatibility reason
> > though CRIU itself already switched to PR_SET_MM_MAP on its
> > own long ago.
> > 
> > Googling didn't reveal some other users of this operation
> > so I think it should be safe to issue deprecation warning
> > first time and get rid of this interface after a couple
> > of releases.
> > 
> > CC: Andrey Vagin <avagin@openvz.org>
> > CC: Andrew Morton <akpm@linuxfoundation.org>
> > CC: Pavel Emelyanov <xemul@virtuozzo.com>
> > CC: Michael Kerrisk <mtk.manpages@gmail.com>
> > CC: Yang Shi <yang.shi@linux.alibaba.com>
> > CC: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> > ---
> > Or we can simply drop it off because PR_SET_MM_MAP covers all needs,
> > and I would rather prefer to do that asap.
> 
> Thanks for making it deprecated. I'd prefer just drop it off if nobody
> objects. The change will get soaked in linux-next for a while , we will know
> if it breaks compatibility (it sounds very unlikely).

Yeah, let's just drop it and have the patch in linux-next (via mmotm)
for 2 release cycles and see whether somebody complains.

You can add
Acked-by: Michal Hocko <mhocko@suse.com>
for such a patch.
-- 
Michal Hocko
SUSE Labs
