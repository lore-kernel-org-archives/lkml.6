Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeAaIBR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:01:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:47307 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeAaIBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:01:16 -0500
Date: Wed, 31 Jan 2018 09:01:14 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] Lock mmap_sem when calling migrate_pages() in
 do_move_pages_to_node()
Message-ID: <20180131080114.GM21609@dhcp22.suse.cz>
References: <20180130030011.4310-1-zi.yan@sent.com>
 <20180130081415.GO21609@dhcp22.suse.cz>
 <5A7094DA.4000804@cs.rutgers.edu>
 <20180130161025.GH21609@dhcp22.suse.cz>
 <F3D5C6AC-78B6-4443-9BE1-575831F238E2@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F3D5C6AC-78B6-4443-9BE1-575831F238E2@cs.rutgers.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-01-18 14:12:28, Zi Yan wrote:
> On 30 Jan 2018, at 11:10, Michal Hocko wrote:
[...]
> I think the question is whether we need to hold mmap_sem for
> migrate_pages(). Hugh also agrees it is not necessary on a separate
> email. But it is held in the original code.

I would be really surprised if we really needed the lock. If we do,
however, then we really need a very good explanation why. The code used
to do so is not a valid reason.

-- 
Michal Hocko
SUSE Labs
