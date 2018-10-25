Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596F5ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE89207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE89207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeJYJgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:36:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:11812 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbeJYJgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:36:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 18:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="275380662"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.27])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2018 18:06:27 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -V6 14/21] swap: Support to move swap account for PMD swap mapping
References: <20181010071924.18767-1-ying.huang@intel.com>
        <20181010071924.18767-15-ying.huang@intel.com>
        <20181024172749.bila5pnfsqsu7th3@ca-dmjordan1.us.oracle.com>
Date:   Thu, 25 Oct 2018 09:06:26 +0800
In-Reply-To: <20181024172749.bila5pnfsqsu7th3@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Wed, 24 Oct 2018 10:27:49 -0700")
Message-ID: <877ei6vnql.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Wed, Oct 10, 2018 at 03:19:17PM +0800, Huang Ying wrote:
>> +static struct page *mc_handle_swap_pmd(struct vm_area_struct *vma,
>> +			pmd_t pmd, swp_entry_t *entry)
>> +{
>
> Got
> /home/dbbench/linux/mm/memcontrol.c:4719:21: warning: ‘mc_handle_swap_pmd’ defined but not used [-Wunused-function]
>  static struct page *mc_handle_swap_pmd(struct vm_area_struct *vma,
> when
> # CONFIG_TRANSPARENT_HUGEPAGE is not set

Thanks for pointing this out.  Will fix it in the next version.

Best Regards,
Huang, Ying
