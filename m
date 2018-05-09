Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934008AbeEIISd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:18:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40120 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933860AbeEIISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:18:30 -0400
X-Google-Smtp-Source: AB8JxZqWhD5kyDj0oEk1b8qV5RySvxTXGxNkQKy0Ubo6EwizjLOr0RYqAULcrZq/NLU3JmuFVcL4kA==
Date: Wed, 9 May 2018 17:18:25 +0900
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/memblock: print memblock_remove
Message-ID: <20180509081825.GA220810@rodete-desktop-imager.corp.google.com>
References: <20180508104223.8028-1-minchan@kernel.org>
 <20180509081214.GE32366@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509081214.GE32366@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 10:12:14AM +0200, Michal Hocko wrote:
> On Tue 08-05-18 19:42:23, Minchan Kim wrote:
> > memblock_remove report is useful to see why MemTotal of /proc/meminfo
> > between two kernels makes difference.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/memblock.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 5228f594b13c..03d48d8835ba 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -697,6 +697,11 @@ static int __init_memblock memblock_remove_range(struct memblock_type *type,
> >  
> >  int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
> >  {
> > +	phys_addr_t end = base + size - 1;
> > +
> > +	memblock_dbg("memblock_remove: [%pa-%pa] %pS\n",
> > +		     &base, &end, (void *)_RET_IP_);
> 
> Other callers of memblock_dbg use %pF. Is there any reason to be
> different here?

checkpatch hit me.

WARNING: Deprecated vsprintf pointer extension '%pF' - use %pS instead
#24: FILE: mm/memblock.c:702:
+       memblock_dbg("memblock_remove: [%pa-%pa] %pF\n",
+                    &base, &end, (void *)_RET_IP_);

> 
> Other that that looks ok to me.

Thanks, Michal.
