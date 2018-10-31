Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8927CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423B22081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423B22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeKABlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:41:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729341AbeKABlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:41:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D60BEAE85;
        Wed, 31 Oct 2018 16:42:32 +0000 (UTC)
Date:   Wed, 31 Oct 2018 17:42:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuo-Hsin Yang <vovoy@chromium.org>, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
Message-ID: <20181031164231.GQ32673@dhcp22.suse.cz>
References: <20181031081945.207709-1-vovoy@chromium.org>
 <20181031142458.GP32673@dhcp22.suse.cz>
 <cc44aa53-8705-02ea-6c59-f311427d93af@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc44aa53-8705-02ea-6c59-f311427d93af@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-10-18 07:40:14, Dave Hansen wrote:
> On 10/31/18 7:24 AM, Michal Hocko wrote:
> > I am also wondering whether unevictable pages culling can be
> > really visible when we do the anon LRU reclaim because the swap path is
> > quite expensinve on its own.
> 
> Didn't we create the unevictable lists in the first place because
> scanning alone was observed to be so expensive in some scenarios?

Yes, that is the case. I might just misunderstood the code I thought
those pages were already on the LRU when unevictable flag was set and
we would only move these pages to the unevictable list lazy during the
reclaim. If the flag is set at the time when the page is added to the
LRU then it should get to the proper LRU list right away. But then I do
not understand the test results from previous run at all.
-- 
Michal Hocko
SUSE Labs
