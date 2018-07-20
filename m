Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D618ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7022084E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7022084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbeGTBNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:13:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:35206 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730279AbeGTBNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:13:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 17:27:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,376,1526367600"; 
   d="scan'208";a="58287692"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2018 17:27:23 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v3 1/8] swap: Add comments to lock_cluster_or_swap_info()
References: <20180719084842.11385-1-ying.huang@intel.com>
        <20180719084842.11385-2-ying.huang@intel.com>
        <20180719123908.GA28522@infradead.org>
Date:   Fri, 20 Jul 2018 08:27:22 +0800
In-Reply-To: <20180719123908.GA28522@infradead.org> (Christoph Hellwig's
        message of "Thu, 19 Jul 2018 05:39:08 -0700")
Message-ID: <87wotqvjit.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Jul 19, 2018 at 04:48:35PM +0800, Huang Ying wrote:
>> +/*
>> + * Determine the locking method in use for this device.  Return
>> + * swap_cluster_info if SSD-style cluster-based locking is in place.
>> + */
>>  static inline struct swap_cluster_info *lock_cluster_or_swap_info(
>>  	struct swap_info_struct *si,
>>  	unsigned long offset)
>>  {
>>  	struct swap_cluster_info *ci;
>>  
>> +	/* Try to use fine-grained SSD-style locking if available: */
>
> Once you touch this are can you also please use standard two-tab
> alignment for the spill-over function arguments:
>
> static inline struct swap_cluster_info *lock_cluster_or_swap_info(
> 		struct swap_info_struct *si, unsigned long offset)

Sure.  Will change this in next version.

Best Regards,
Huang, Ying
