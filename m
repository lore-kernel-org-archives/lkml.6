Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482E124CF8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482E124CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbeGBFTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:19:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:62481 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbeGBFTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:19:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2018 22:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,298,1526367600"; 
   d="scan'208";a="63709654"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2018 22:19:20 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 00/21] mm, THP, swap: Swapout/swapin THP in one piece
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
        <87r2krfpi2.fsf@yhuang-dev.intel.com>
        <20180627223118.dd2f52d87f53e7e002ed0153@linux-foundation.org>
        <87muvffp7w.fsf@yhuang-dev.intel.com>
        <20180627231839.e5ac2f38e0397979d3db7765@linux-foundation.org>
        <20180628090301.GC7646@bombadil.infradead.org>
        <87woui9ysj.fsf@yhuang-dev.intel.com>
        <20180629055754.GH7646@bombadil.infradead.org>
Date:   Mon, 02 Jul 2018 13:19:19 +0800
In-Reply-To: <20180629055754.GH7646@bombadil.infradead.org> (Matthew Wilcox's
        message of "Thu, 28 Jun 2018 22:57:54 -0700")
Message-ID: <87o9fqxlig.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Jun 29, 2018 at 09:17:16AM +0800, Huang, Ying wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> > I'll take a look.  Honestly, my biggest problem with this patch set is
>> > overuse of tagging:
>> >
>> > 59832     Jun 22 Huang, Ying     ( 131) [PATCH -mm -v4 00/21] mm, THP, swap: Swa
>> > There's literally zero useful information displayed in the patch subjects.
>> 
>> Thanks!  What's your suggestion on tagging?  Only keep "mm" or "swap"?
>
> Subject: [PATCH v14 10/74] xarray: Add XArray tags
>
> I'm not sure where the extra '-' in front of '-v4' comes from.  I also
> wouldn't put the '-mm' in front of it -- that information can live in
> the cover letter's body rather than any patch's subject.
>
> I think 'swap:' implies "mm:", so yeah I'd just go with that.
>
> Subject: [PATCH v4 00/21] swap: Useful information here
>
> I'd see that as:
>
> 59832     Jun 22 Huang, Ying     ( 131) [PATCH v4 00/21] swap: Useful informatio

Looks good!  I will use this naming convention in the future.

> I had a quick look at your patches.  I think only two are affected by
> the XArray, and I'll make some general comments about them soon.

Thanks!

Best Regards,
Huang, Ying
