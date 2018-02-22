Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeBVOMX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:12:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:53333 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932581AbeBVOMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:12:21 -0500
Date: Thu, 22 Feb 2018 15:12:18 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180222141218.GM30681@dhcp22.suse.cz>
References: <20180222143057.3a1b3746@canb.auug.org.au>
 <20180222071100.GB30681@dhcp22.suse.cz>
 <20180223005626.79c471dd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223005626.79c471dd@canb.auug.org.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-02-18 00:56:26, Stephen Rothwell wrote:
> Hi Michal,
> 
> On Thu, 22 Feb 2018 08:11:00 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> >
> > This is interesting. I thought that IS_ENABLED(CONFIG_HAVE_MEMBLOCK)
> > would have the same meaning as ifdef CONFIG_HAVE_MEMBLOCK so the branch
> > will never be considered. If that is not the case then I would rather
> > reintroduce that ifdef. We already have those in the function anyway.
> 
> Actually, you don't need a definition of memblock_next_valid_pfn() in the
> !CONFIG_HAVE_MEMBLOCK case, just a declaration, so the minimal fix is
> to move the declaration out of the #ifdef CONFIG_HAVE_MEMBLOCK in the
> header file.

You are right.

> That way if there is any use of memblock_next_valid_pfn()
> introduced that is no guarded by IS_ENABLED(CONFIG_HAVE_MEMBLOCK) the
> build will fail to link.  I like IS_ENABLED() being used wherever
> possible because it allows us better compiler coverage (in the face of
> CONFIG options) even if the compiler then elides the actual code.  It
> also breaks the code up less than #ifdef's.
> 
> Your choice, of course.

The function already has those ugly ifdefs so I would keep it
consistent. Deuglyfying it would need a bigger stick.
-- 
Michal Hocko
SUSE Labs
