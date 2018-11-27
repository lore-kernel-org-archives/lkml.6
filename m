Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2044C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA96208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA96208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbeK0XKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:10:10 -0500
Received: from foss.arm.com ([217.140.101.70]:34876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeK0XKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:10:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D83E35FA;
        Tue, 27 Nov 2018 04:12:27 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DDF63F575;
        Tue, 27 Nov 2018 04:12:27 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CB5AE1AE0A0D; Tue, 27 Nov 2018 12:12:44 +0000 (GMT)
Date:   Tue, 27 Nov 2018 12:12:44 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cpandya@codeaurora.org, toshi.kani@hpe.com, tglx@linutronix.de,
        mhocko@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v4 4/5] lib/ioremap: Ensure phys_addr actually
 corresponds to a physical address
Message-ID: <20181127121244.GB4181@arm.com>
References: <1543252067-30831-1-git-send-email-will.deacon@arm.com>
 <1543252067-30831-5-git-send-email-will.deacon@arm.com>
 <20181126190009.GG25719@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126190009.GG25719@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:00:10AM -0800, Sean Christopherson wrote:
> On Mon, Nov 26, 2018 at 05:07:46PM +0000, Will Deacon wrote:
> > The current ioremap() code uses a phys_addr variable at each level of
> > page table, which is confusingly offset by subtracting the base virtual
> > address being mapped so that adding the current virtual address back on
> > when iterating through the page table entries gives back the corresponding
> > physical address.
> > 
> > This is fairly confusing and results in all users of phys_addr having to
> > add the current virtual address back on. Instead, this patch just updates
> > phys_addr when iterating over the page table entries, ensuring that it's
> > always up-to-date and doesn't require explicit offsetting.
> > 
> > Cc: Chintan Pandya <cpandya@codeaurora.org>
> > Cc: Toshi Kani <toshi.kani@hpe.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

Thanks, Sean. I think Andrew can queue these now.

Will
