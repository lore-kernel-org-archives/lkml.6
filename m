Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755606AbeDWPEo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:04:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46911 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755419AbeDWPEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:04:42 -0400
Date: Mon, 23 Apr 2018 09:04:35 -0600
From: Michal Hocko <mhocko@kernel.org>
To: kirill.shutemov@linux.intel.com, Yang Shi <yang.shi@linux.alibaba.com>
Cc: hughd@google.com, hch@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 PATCH] mm: shmem: make stat.st_blksize return huge page
 size if THP is on
Message-ID: <20180423150435.GS17484@dhcp22.suse.cz>
References: <1524242039-64997-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180423004748.GP17484@dhcp22.suse.cz>
 <3c59a1d1-dc66-ae5f-452c-dd0adb047433@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c59a1d1-dc66-ae5f-452c-dd0adb047433@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 22-04-18 21:28:59, Yang Shi wrote:
> 
> 
> On 4/22/18 6:47 PM, Michal Hocko wrote:
[...]
> > will be used on the first aligned address even when the initial/last
> > portion of the mapping is not THP aligned.
> 
> No, my test shows it is not. And, transhuge_vma_suitable() does check the
> virtual address alignment. If it is not huge page size aligned, it will not
> set PMD for huge page.

It's been quite some time since I've looked at that code but I think you
are wrong. It just doesn't make sense to make the THP decision on the
VMA alignment much. Kirill, can you clarify please?

Please note that I have no objections to actually export the huge page
size as the max block size but your changelog just doesn't make any
sense to me.
-- 
Michal Hocko
SUSE Labs
