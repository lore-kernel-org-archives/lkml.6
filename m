Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF2AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618A921776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618A921776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeHXPJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:09:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:19472 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeHXPJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:09:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2018 04:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,281,1531810800"; 
   d="scan'208";a="78034793"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Aug 2018 04:35:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 55BF4E1; Fri, 24 Aug 2018 14:35:29 +0300 (EEST)
Date:   Fri, 24 Aug 2018 14:35:29 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 0/2] huge_pmd_unshare migration and flushing
Message-ID: <20180824113529.os4sx6ls5vbz4gwi@black.fi.intel.com>
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823205917.16297-1-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 08:59:15PM +0000, Mike Kravetz wrote:
> Correct a data corruption issue caused by improper handling of shared
> huge PMDs during page migration.  This issue was observed in a customer
> environment and can be recreated fairly easily with a test program.
> Patch 0001 addresses this issue only and is copied to stable with the
> intention that this will go to stable releases.  It has existed since
> the addition of shared huge PMD support.
> 
> While considering the issue above, Kirill Shutemov noticed that other
> callers of huge_pmd_unshare have potential issues with cache and TLB
> flushing.  A separate patch (0002) takes advantage of the new routine
> adjust_range_if_pmd_sharing_possible() to adjust flushing ranges in
> the cases where huge PMD sharing is possible.  There is no copy to
> stable for this patch as it has not been reported as an issue and
> discovered only via code inspection.

Looks good to me.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
