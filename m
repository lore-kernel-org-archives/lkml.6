Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0C72075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0C72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeIHBsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:48:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:63834 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeIHBsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:48:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 14:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="89900762"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.20])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2018 14:06:00 -0700
Message-ID: <1536354360.11460.29.camel@intel.com>
Subject: Re: [RFC][PATCH 2/8] x86/mm: break out kernel address space handling
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        luto@kernel.org
Date:   Fri, 07 Sep 2018 14:06:00 -0700
In-Reply-To: <20180907194855.74E03836@viggo.jf.intel.com>
References: <20180907194852.3C351B82@viggo.jf.intel.com>
         <20180907194855.74E03836@viggo.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-07 at 12:48 -0700, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The page fault handler (__do_page_fault())  basically has two sections:
> one for handling faults in the kernel porttion of the address space
> and another for faults in the user porttion of the address space.

%s/porttion/portion

> But, these two parts don't stick out that well.  Let's make that more
> clear from code separation and naming.  Pull kernel fault
> handling into its own helper, and reflect that naming by renaming
> spurious_fault() -> spurious_kernel_fault().
> 
> Also, rewrite the vmalloc handling comment a bit.  It was a bit
> stale and also glossed over the reserved bit handling.

