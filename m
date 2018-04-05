Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeDEPFv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:05:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50103 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeDEPFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:05:50 -0400
Date: Thu, 5 Apr 2018 17:05:47 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm: consider non-anonymous thp as unmovable page
Message-ID: <20180405150547.GN6312@dhcp22.suse.cz>
References: <1522730788-24530-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180403075928.GC5501@dhcp22.suse.cz>
 <20180403082405.GA23809@hori1.linux.bs1.fc.nec.co.jp>
 <20180403083451.GG5501@dhcp22.suse.cz>
 <20180403105411.hknofkbn6rzs26oz@node.shutemov.name>
 <20180405085927.GC6312@dhcp22.suse.cz>
 <20180405122838.6a6b35psizem4tcy@node.shutemov.name>
 <20180405124830.GJ6312@dhcp22.suse.cz>
 <20180405134045.7axuun6d7ufobzj4@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405134045.7axuun6d7ufobzj4@node.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-04-18 16:40:45, Kirill A. Shutemov wrote:
> On Thu, Apr 05, 2018 at 02:48:30PM +0200, Michal Hocko wrote:
[...]
> > RIght, I confused the two. What is the proper layer to fix that then?
> > rmap_walk_file?
> 
> Maybe something like this? Totally untested.

This looks way too complex. Why cannot we simply split THP page cache
during migration?
-- 
Michal Hocko
SUSE Labs
