Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78EAC43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 05:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9FF20883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 05:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfACFEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 00:04:52 -0500
Received: from foss.arm.com ([217.140.101.70]:42742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfACFEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 00:04:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 132CBEBD;
        Wed,  2 Jan 2019 21:04:51 -0800 (PST)
Received: from [10.163.1.51] (unknown [10.163.1.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A431C3F5D4;
        Wed,  2 Jan 2019 21:04:43 -0800 (PST)
Subject: Re: [RESEND PATCH V3 0/5] arm64/mm: Enable HugeTLB migration
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        steve.capper@arm.com, catalin.marinas@arm.com, mhocko@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
References: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c2fbd55e-4413-1bcf-769c-fd1064e74a2c@arm.com>
Date:   Thu, 3 Jan 2019 10:34:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/2018 01:54 PM, Anshuman Khandual wrote:
> This patch series enables HugeTLB migration support for all supported
> huge page sizes at all levels including contiguous bit implementation.
> Following HugeTLB migration support matrix has been enabled with this
> patch series. All permutations have been tested except for the 16GB.
> 
>          CONT PTE    PMD    CONT PMD    PUD
>          --------    ---    --------    ---
> 4K:         64K     2M         32M     1G
> 16K:         2M    32M          1G
> 64K:         2M   512M         16G
> 
> First the series adds migration support for PUD based huge pages. It
> then adds a platform specific hook to query an architecture if a
> given huge page size is supported for migration while also providing
> a default fallback option preserving the existing semantics which just
> checks for (PMD|PUD|PGDIR)_SHIFT macros. The last two patches enables
> HugeTLB migration on arm64 and subscribe to this new platform specific
> hook by defining an override.
> 
> The second patch differentiates between movability and migratability
> aspects of huge pages and implements hugepage_movable_supported() which
> can then be used during allocation to decide whether to place the huge
> page in movable zone or not.
> 
> This is just a resend for the previous version (V3) after the rebase
> on current mainline kernel. Also added all the tags previous version
> had received.
> 
> Changes in V3:
> 
> - Re-ordered patches 1 and 2 per Michal
> - s/Movability/Migratability/ in unmap_and_move_huge_page() per Naoya
> 
> Changes in V2: (https://lkml.org/lkml/2018/10/12/190)
> 
> - Added a new patch which differentiates migratability and movability
>   of huge pages and implements hugepage_movable_supported() function
>   as suggested by Michal Hocko.
> 
> Anshuman Khandual (5):
>   mm/hugetlb: Distinguish between migratability and movability
>   mm/hugetlb: Enable PUD level huge page migration
>   mm/hugetlb: Enable arch specific huge page size support for migration
>   arm64/mm: Enable HugeTLB migration
>   arm64/mm: Enable HugeTLB migration for contiguous bit HugeTLB pages
> 

Hello Andrew,

Just wondering if there are any updates on this series ? Is there something we need to
improve or fix some where in this series for it to get merged. Please do let us know.
Thank you.

- Anshuman
