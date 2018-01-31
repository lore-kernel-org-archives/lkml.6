Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeAaN0B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 08:26:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:52910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbeAaN0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 08:26:00 -0500
Date: Wed, 31 Jan 2018 14:25:58 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] mm/swap.c: make functions and their kernel-doc agree
Message-ID: <20180131132558.GU21609@dhcp22.suse.cz>
References: <3b42ee3e-04a9-a6ca-6be4-f00752a114fe@infradead.org>
 <20180130123400.GD26445@dhcp22.suse.cz>
 <20180131075848.GB28275@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131075848.GB28275@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-01-18 23:58:48, Matthew Wilcox wrote:
> On Tue, Jan 30, 2018 at 01:34:00PM +0100, Michal Hocko wrote:
> > On Mon 29-01-18 16:43:55, Randy Dunlap wrote:
> > > - for function pagevec_lookup_entries(), change the function parameter
> > >   name from nr_pages to nr_entries since that is more descriptive of
> > >   what the parameter actually is and then it matches the kernel-doc
> > >   comments also
> > 
> > I know what is nr_pages because I do expect pages to be returned. What
> > are entries? Can it be something different from pages?
> 
> entries are any page cache entries -- pages or exceptional entries.

Fair point.

> calling this parameter nr_pages tricks you into thinking that you'll
> only get pages back.

Well, the data structure we are using is a pagevec and that operates on
top of struct pages. It is true that this is quite confusing especially
for those who are not familiar with exceptional entries. Hopefully the
associated documentation helps.

-- 
Michal Hocko
SUSE Labs
