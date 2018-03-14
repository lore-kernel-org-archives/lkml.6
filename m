Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeCNOyy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbeCNOyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:54:53 -0400
Date: Wed, 14 Mar 2018 15:54:50 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>, Daniel Vacek <neelx@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Revert "mm/page_alloc: fix memmap_init_zone pageblock
 alignment"
Message-ID: <20180314145450.GI23100@dhcp22.suse.cz>
References: <20180314134431.13241-1-ard.biesheuvel@linaro.org>
 <20180314141323.GD23100@dhcp22.suse.cz>
 <CAKv+Gu9hrZnX6pmiCaT=S30KQ11tY4kv=qvdSPPZ2nYDC7P7eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9hrZnX6pmiCaT=S30KQ11tY4kv=qvdSPPZ2nYDC7P7eQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-03-18 14:35:12, Ard Biesheuvel wrote:
> On 14 March 2018 at 14:13, Michal Hocko <mhocko@kernel.org> wrote:
> > Does http://lkml.kernel.org/r/20180313224240.25295-1-neelx@redhat.com
> > fix your issue? From the debugging info you provided it should because
> > the patch prevents jumping backwards.
> >
> 
> The patch does fix the boot hang.
> 
> But I am concerned that we are papering over a fundamental flaw in
> memblock_next_valid_pfn().

It seems that memblock_next_valid_pfn is doing the right thing here. It
is the alignment which moves the pfn back AFAICS. I am not really
impressed about the original patch either, to be completely honest.
It just looks awfully tricky. I still didn't manage to wrap my head
around the original issue though so I do not have much better ideas to
be honest.
-- 
Michal Hocko
SUSE Labs
