Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D8ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1757220645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1757220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJSKGf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:06:35 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:56068 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJSKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:06:35 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w9J2252t012648
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Oct 2018 11:02:05 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w9J224tV019461;
        Fri, 19 Oct 2018 11:02:04 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w9J1qwIn028888;
        Fri, 19 Oct 2018 11:02:04 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-4732248; Fri, 19 Oct 2018 11:01:02 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0319.002; Fri,
 19 Oct 2018 11:01:02 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "punit.agrawal@arm.com" <punit.agrawal@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Steven.Price@arm.com" <Steven.Price@arm.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>
Subject: Re: [PATCH V2 0/5] arm64/mm: Enable HugeTLB migration
Thread-Topic: [PATCH V2 0/5] arm64/mm: Enable HugeTLB migration
Thread-Index: AQHUYeAfCnr00L61C0abRrirXwM8V6UiiZGAgAK6+oA=
Date:   Fri, 19 Oct 2018 02:01:01 +0000
Message-ID: <20181019020101.GB18973@hori1.linux.bs1.fc.nec.co.jp>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <e1703454-e500-3a1b-35cb-6368dff91f10@arm.com>
In-Reply-To: <e1703454-e500-3a1b-35cb-6368dff91f10@arm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <7EDDC048D50B7E4FA3D4ECCE61480856@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 01:49:17PM +0530, Anshuman Khandual wrote:
> 
> 
> On 10/12/2018 09:29 AM, Anshuman Khandual wrote:
> > This patch series enables HugeTLB migration support for all supported
> > huge page sizes at all levels including contiguous bit implementation.
> > Following HugeTLB migration support matrix has been enabled with this
> > patch series. All permutations have been tested except for the 16GB.
> > 
> >          CONT PTE    PMD    CONT PMD    PUD
> >          --------    ---    --------    ---
> > 4K:         64K     2M         32M     1G
> > 16K:         2M    32M          1G
> > 64K:         2M   512M         16G
> > 
> > First the series adds migration support for PUD based huge pages. It
> > then adds a platform specific hook to query an architecture if a
> > given huge page size is supported for migration while also providing
> > a default fallback option preserving the existing semantics which just
> > checks for (PMD|PUD|PGDIR)_SHIFT macros. The last two patches enables
> > HugeTLB migration on arm64 and subscribe to this new platform specific
> > hook by defining an override.
> > 
> > The second patch differentiates between movability and migratability
> > aspects of huge pages and implements hugepage_movable_supported() which
> > can then be used during allocation to decide whether to place the huge
> > page in movable zone or not.
> > 
> > Changes in V2:
> > 
> > - Added a new patch which differentiates migratability and movability
> >   of huge pages and implements hugepage_movable_supported() function
> >   as suggested by Michal Hocko.
> 
> Hello Andrew/Michal/Mike/Naoya/Catalin,
> 
> Just checking for an update. Does this series looks okay ?

Looks good to me. So for the series

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
