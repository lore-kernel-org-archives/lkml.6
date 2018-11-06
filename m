Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A60C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC7F20818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC7F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbeKFWvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:51:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:57316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387804AbeKFWvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:51:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95778B65F;
        Tue,  6 Nov 2018 13:26:32 +0000 (UTC)
Date:   Tue, 6 Nov 2018 14:26:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Oded Gabbay <oded.gabbay@amd.com>
Subject: Re: [PATCH] mm/mmu_notifier: rename mmu_notifier_synchronize() to
 <...>_barrier()
Message-ID: <20181106132632.GD2453@dhcp22.suse.cz>
References: <20181105192955.26305-1-sean.j.christopherson@intel.com>
 <20181105121833.200d5b53300a7ef4df7d349d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105121833.200d5b53300a7ef4df7d349d@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-11-18 12:18:33, Andrew Morton wrote:
> On Mon,  5 Nov 2018 11:29:55 -0800 Sean Christopherson <sean.j.christopherson@intel.com> wrote:
[...]
> > -EXPORT_SYMBOL_GPL(mmu_notifier_synchronize);
> > +EXPORT_SYMBOL_GPL(mmu_notifier_barrier);
> >  
> >  /*
> >   * This function can't run concurrently against mmu_notifier_register
> 
> But as it has no callers, why retain it?

Exported symbols are not freed and if this is not used by any in-kernel
code then I would just remove it.

-- 
Michal Hocko
SUSE Labs
