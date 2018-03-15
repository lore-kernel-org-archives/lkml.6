Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeCOM3s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:29:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37003 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbeCOM3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:29:47 -0400
Date: Thu, 15 Mar 2018 13:29:44 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>, Shaohua Li <shli@kernel.org>,
        jglisse@redhat.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -mm] mm, madvise, THP: Use THP aligned address in
 madvise_free_huge_pmd()
Message-ID: <20180315122944.GH23100@dhcp22.suse.cz>
References: <20180315011840.27599-1-ying.huang@intel.com>
 <869F4AAA-5BBA-40D6-916F-6919E515D271@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <869F4AAA-5BBA-40D6-916F-6919E515D271@cs.rutgers.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-03-18 21:39:54, Zi Yan wrote:
> This cannot happen.
> 
> Two address parameters are passed: addr and next.
> If “addr” is not aligned and “next” is aligned or the end of madvise range, which might not be aligned,
> either way next - addr < HPAGE_PMD_SIZE.
> 
> This means the code in “if (next - addr != HPAGE_PMD_SIZE)”, which is above your second hunk,
> will split the THP between “addr” and “next” and get out as long as “addr“ is not aligned.
> Thus, the code in your second hunk should always get aligned “addr”.

OK, so what would happen if the above doesn't hold anymore after some
change up the call chain? Is it critical? If yes, do we want VM_BUG_ON
to detect that? Or at least document the asumption?
-- 
Michal Hocko
SUSE Labs
