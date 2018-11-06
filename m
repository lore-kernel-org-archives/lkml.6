Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF3AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499152086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499152086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbeKFXAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:00:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:36554 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388029AbeKFXAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:00:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 05:34:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="98034221"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga003.jf.intel.com with ESMTP; 06 Nov 2018 05:34:50 -0800
Message-ID: <1541511290.7839.9.camel@intel.com>
Subject: Re: [PATCH] mm/mmu_notifier: rename mmu_notifier_synchronize() to
 <...>_barrier()
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Oded Gabbay <oded.gabbay@amd.com>
Date:   Tue, 06 Nov 2018 05:34:50 -0800
In-Reply-To: <20181105211455.GB3074@bombadil.infradead.org>
References: <20181105192955.26305-1-sean.j.christopherson@intel.com>
         <20181105121833.200d5b53300a7ef4df7d349d@linux-foundation.org>
         <20181105211455.GB3074@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:14 -0800, Matthew Wilcox wrote:
> On Mon, Nov 05, 2018 at 12:18:33PM -0800, Andrew Morton wrote:
> > 
> > > 
> > > +++ b/mm/mmu_notifier.c
> > But as it has no callers, why retain it?
> ... and this patch missed the declaration of mmu_notifier_synchronize
> in include/linux/mmu_notifier.h (whether we delete it or rename it,
> that mention of it needs to be fixed)

Doh.  I'll remove the function and send v2.
