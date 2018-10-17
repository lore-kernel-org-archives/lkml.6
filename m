Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1791DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFABF21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFABF21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeJQQNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:13:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47358 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbeJQQNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:13:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 589C8EBD;
        Wed, 17 Oct 2018 01:19:23 -0700 (PDT)
Received: from [10.162.0.72] (unknown [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B22CB3F71C;
        Wed, 17 Oct 2018 01:19:19 -0700 (PDT)
Subject: Re: [PATCH V2 0/5] arm64/mm: Enable HugeTLB migration
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, punit.agrawal@arm.com, will.deacon@arm.com,
        Steven.Price@arm.com, steve.capper@arm.com,
        catalin.marinas@arm.com, mhocko@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e1703454-e500-3a1b-35cb-6368dff91f10@arm.com>
Date:   Wed, 17 Oct 2018 13:49:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 09:29 AM, Anshuman Khandual wrote:
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
> Changes in V2:
> 
> - Added a new patch which differentiates migratability and movability
>   of huge pages and implements hugepage_movable_supported() function
>   as suggested by Michal Hocko.

Hello Andrew/Michal/Mike/Naoya/Catalin,

Just checking for an update. Does this series looks okay ?

- Anshuman
