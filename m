Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbeDJMjB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:39:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752927AbeDJMi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:38:59 -0400
Date: Tue, 10 Apr 2018 14:38:57 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Chris Fries <cfries@google.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Message-ID: <20180410123857.GJ21835@dhcp22.suse.cz>
References: <20180409112514.GA195937@rodete-laptop-imager.corp.google.com>
 <7706245c-2661-f28b-f7f9-8f11e1ae932b@huawei.com>
 <20180409144958.GA211679@rodete-laptop-imager.corp.google.com>
 <20180409152032.GB11756@bombadil.infradead.org>
 <20180409230409.GA214542@rodete-desktop-imager.corp.google.com>
 <20180410011211.GA31282@bombadil.infradead.org>
 <20180410023339.GB214542@rodete-desktop-imager.corp.google.com>
 <20180410024152.GC31282@bombadil.infradead.org>
 <20180410025903.GA38000@rodete-desktop-imager.corp.google.com>
 <20180410115651.GA22118@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410115651.GA22118@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-04-18 04:56:51, Matthew Wilcox wrote:
> On Tue, Apr 10, 2018 at 11:59:03AM +0900, Minchan Kim wrote:
> > Okay, I hope this version clear current concerns.
> 
> It doesn't.  The right place to warn about GFP_ZERO used with a
> constructor is _slab_, like the patch I already sent.  We have no idea
> what other places might have the same bug, and slab is the only place
> to catch that.

I agree with that. Radix tree shouldn't be really that special. I would
rather get rid of the ctor subtle thingy but if we absolutely have to
keep it then the GFP_RECLAIM_MASK filtering and a warning in slab for
__GFP_ZERO looks like a reasonable step forward.
-- 
Michal Hocko
SUSE Labs
