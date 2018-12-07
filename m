Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3E8C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99E420837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99E420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLGGUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:20:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:25308 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLGGUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:20:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 22:20:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="301798591"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.130])
  by fmsmga005.fm.intel.com with ESMTP; 06 Dec 2018 22:20:32 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -V8 00/21] swap: Swapout/swapin THP in one piece
References: <20181207054122.27822-1-ying.huang@intel.com>
Date:   Fri, 07 Dec 2018 14:20:32 +0800
In-Reply-To: <20181207054122.27822-1-ying.huang@intel.com> (Huang Ying's
        message of "Fri, 7 Dec 2018 13:41:00 +0800")
Message-ID: <871s6tluxb.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang Ying <ying.huang@intel.com> writes:

> Hi, Andrew, could you help me to check whether the overall design is
> reasonable?
>
> Hi, Hugh, Shaohua, Minchan and Rik, could you help me to review the
> swap part of the patchset?  Especially [02/21], [03/21], [04/21],
> [05/21], [06/21], [07/21], [08/21], [09/21], [10/21], [11/21],
> [12/21], [20/21], [21/21].
>
> Hi, Andrea and Kirill, could you help me to review the THP part of the
> patchset?  Especially [01/21], [07/21], [09/21], [11/21], [13/21],
> [15/21], [16/21], [17/21], [18/21], [19/21], [20/21].
>
> Hi, Johannes and Michal, could you help me to review the cgroup part
> of the patchset?  Especially [14/21].
>
> And for all, Any comment is welcome!
>
> This patchset is based on the 2018-11-29 head of mmotm/master.

Sorry, just after sending this patchset out, I found there is a new
version of mmotm/master (2018-12-04), and the swapoff() implementation
is changed much.  I will rebase this patchset on the new version,
especially the swapoff() support.

So, please ignore this patchset, I will send out a new version soon.
Sorry again for bothering.

Best Regards,
Huang, Ying
