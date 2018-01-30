Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbeA3JQE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:16:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:34147 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750959AbeA3JQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:16:02 -0500
Date: Tue, 30 Jan 2018 10:16:00 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pasha.tatashin@oracle.com
Subject: Re: Memory hotplug not increasing the total RAM
Message-ID: <20180130091600.GA26445@dhcp22.suse.cz>
References: <20180130083006.GB1245@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130083006.GB1245@in.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-01-18 14:00:06, Bharata B Rao wrote:
> Hi,
> 
> With the latest upstream, I see that memory hotplug is not working
> as expected. The hotplugged memory isn't seen to increase the total
> RAM pages. This has been observed with both x86 and Power guests.
> 
> 1. Memory hotplug code intially marks pages as PageReserved via
> __add_section().
> 2. Later the struct page gets cleared in __init_single_page().
> 3. Next online_pages_range() increments totalram_pages only when
>    PageReserved is set.

You are right. I have completely forgot about this late struct page
initialization during onlining. memory hotplug really doesn't want
zeroying. Let me think about a fix.
-- 
Michal Hocko
SUSE Labs
