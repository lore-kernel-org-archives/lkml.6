Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565DDC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC7220673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC7220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbeGSOqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:46:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:60718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeGSOqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:46:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68E08ADB0;
        Thu, 19 Jul 2018 14:03:10 +0000 (UTC)
Date:   Thu, 19 Jul 2018 16:03:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 5/5] mm/page_alloc: Only call pgdat_set_deferred_range
 when the system boots
Message-ID: <20180719140308.GG7193@dhcp22.suse.cz>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-6-osalvador@techadventures.net>
 <20180719134622.GE7193@dhcp22.suse.cz>
 <20180719135859.GA10988@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719135859.GA10988@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 15:58:59, Oscar Salvador wrote:
> On Thu, Jul 19, 2018 at 03:46:22PM +0200, Michal Hocko wrote:
> > On Thu 19-07-18 15:27:40, osalvador@techadventures.net wrote:
> > > From: Oscar Salvador <osalvador@suse.de>
> > > 
> > > We should only care about deferred initialization when booting.
> > 
> > Again why is this worth doing?
> 
> Well, it is not a big win if that is what you meant.
> 
> Those two fields are only being used when dealing with deferred pages,
> which only happens at boot time.
> 
> If later on, free_area_init_node gets called from memhotplug code,
> we will also set the fields, although they will not be used.
> 
> Is this a problem? No, but I think it is more clear from the code if we
> see when this is called.
> So I would say it was only for code consistency.

Then put it to the changelog.

> If you think this this is not worth, I am ok with dropping it.

I am not really sure. I am not a big fan of SYSTEM_BOOTING global
thingy so I would rather not spread its usage.
-- 
Michal Hocko
SUSE Labs
