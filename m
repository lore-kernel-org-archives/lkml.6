Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeFEUBB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:01:01 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:36420 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751950AbeFEUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:01:00 -0400
Date: Tue, 5 Jun 2018 21:00:58 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org,
        vbabka@suse.cz, Aaron Lu <aaron.lu@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mremap: Avoid TLB flushing anonymous pages that are not
 in swap cache
Message-ID: <20180605200058.fy4oy5znf6j4pckj@techsingularity.net>
References: <20180605171319.uc5jxdkxopio6kg3@techsingularity.net>
 <bfc2e579-915f-24db-0ff0-29bd9148b8c0@intel.com>
 <20180605191245.3owve7gfut22tyob@techsingularity.net>
 <ecb75c29-3d1b-3b5e-ec9d-59c4f6c1ef08@intel.com>
 <20180605195140.afc7xzgbre26m76l@techsingularity.net>
 <9dc03a4b-d359-8817-a950-b98e246dcd95@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <9dc03a4b-d359-8817-a950-b98e246dcd95@intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:54:27PM -0700, Dave Hansen wrote:
> On 06/05/2018 12:51 PM, Mel Gorman wrote:
> > Using another testcase that simply calls mremap heavily with varying number
> > of threads, it was found that very broadly speaking that TLB shootdowns
> > were reduced by 31% on average throughout the entire test case but your
> > milage will vary.
> 
> Looks good to me.  Feel free to add my Reviewed-by.

Thanks, I'll send a proper v2 when I hear back from the customer on what
the impact on the real workload is.

-- 
Mel Gorman
SUSE Labs
