Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935923AbeE3ICS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:02:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:34115 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935619AbeE3ICO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:02:14 -0400
Date: Wed, 30 May 2018 10:02:12 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, libhugetlbfs@googlegroups.com
Subject: Re: [PATCH 2/2] fs, elf: drop MAP_FIXED usage from elf_map
Message-ID: <20180530080212.GA27180@dhcp22.suse.cz>
References: <20171129144219.22867-1-mhocko@kernel.org>
 <20171129144219.22867-3-mhocko@kernel.org>
 <93ce964b-e352-1905-c2b6-deedf2ea06f8@oracle.com>
 <c0e447b3-4ba7-239e-6550-64de7721ad28@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0e447b3-4ba7-239e-6550-64de7721ad28@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-05-18 15:21:14, Mike Kravetz wrote:
> Just a quick heads up.  I noticed a change in libhugetlbfs testing starting
> with v4.17-rc1.
> 
> V4.16 libhugetlbfs test results
> ********** TEST SUMMARY
> *                      2M            
> *                      32-bit 64-bit 
> *     Total testcases:   110    113   
> *             Skipped:     0      0   
> *                PASS:   105    111   
> *                FAIL:     0      0   
> *    Killed by signal:     4      1   
> *   Bad configuration:     1      1   
> *       Expected FAIL:     0      0   
> *     Unexpected PASS:     0      0   
> *    Test not present:     0      0   
> * Strange test result:     0      0   
> **********
> 
> v4.17-rc1 (and later) libhugetlbfs test results
> ********** TEST SUMMARY
> *                      2M            
> *                      32-bit 64-bit 
> *     Total testcases:   110    113   
> *             Skipped:     0      0   
> *                PASS:    98    111   
> *                FAIL:     0      0   
> *    Killed by signal:    11      1   
> *   Bad configuration:     1      1   
> *       Expected FAIL:     0      0   
> *     Unexpected PASS:     0      0   
> *    Test not present:     0      0   
> * Strange test result:     0      0   
> **********
> 
> I traced the 7 additional (32-bit) killed by signal results to this
> commit 4ed28639519c fs, elf: drop MAP_FIXED usage from elf_map.
> 
> libhugetlbfs does unusual things and even provides custom linker scripts.
> So, in hindsight this change in behavior does not seem too unexpected.  I
> JUST discovered this while running libhugetlbfs tests for an unrelated
> issue/change and, will do some analysis to see exactly what is happening.

I am definitely interested about further details. Are there any messages
in the kernel log?

-- 
Michal Hocko
SUSE Labs
