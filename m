Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA307C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C912054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C912054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeJYQRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:17:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:58406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbeJYQRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:17:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB611AF9F;
        Thu, 25 Oct 2018 07:45:32 +0000 (UTC)
Date:   Thu, 25 Oct 2018 09:45:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        punit.agrawal@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        steve.capper@arm.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH V3 3/5] mm/hugetlb: Enable arch specific huge page size
 support for migration
Message-ID: <20181025074532.GM18839@dhcp22.suse.cz>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-4-git-send-email-anshuman.khandual@arm.com>
 <20181024135639.GH18839@dhcp22.suse.cz>
 <20181024135859.GI18839@dhcp22.suse.cz>
 <bf5e636c-9cc4-50d6-4160-78a1a7703860@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf5e636c-9cc4-50d6-4160-78a1a7703860@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-10-18 11:53:34, Anshuman Khandual wrote:
> 
> 
> On 10/24/2018 07:28 PM, Michal Hocko wrote:
> > On Wed 24-10-18 15:56:39, Michal Hocko wrote:
> >> On Tue 23-10-18 18:31:59, Anshuman Khandual wrote:
> >>> Architectures like arm64 have HugeTLB page sizes which are different than
> >>> generic sizes at PMD, PUD, PGD level and implemented via contiguous bits.
> >>> At present these special size HugeTLB pages cannot be identified through
> >>> macros like (PMD|PUD|PGDIR)_SHIFT and hence chosen not be migrated.
> >>>
> >>> Enabling migration support for these special HugeTLB page sizes along with
> >>> the generic ones (PMD|PUD|PGD) would require identifying all of them on a
> >>> given platform. A platform specific hook can precisely enumerate all huge
> >>> page sizes supported for migration. Instead of comparing against standard
> >>> huge page orders let hugetlb_migration_support() function call a platform
> >>> hook arch_hugetlb_migration_support(). Default definition for the platform
> >>> hook maintains existing semantics which checks standard huge page order.
> >>> But an architecture can choose to override the default and provide support
> >>> for a comprehensive set of huge page sizes.
> >>>
> >>> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> >>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >>
> >> Acked-by: Michal Hocko <mhocko@use.com>
> > 
> > fat fingers here, should be mhocko@suse.com of course.
> 
> Sure no problems. As we had discussed earlier and agreed to keep the previous
> patch "mm/hugetlb: Enable PUD level huge page migration" separate and not fold
> into this one, I will assume your ACK on it as well unless your disagree.

OK with me.

-- 
Michal Hocko
SUSE Labs
