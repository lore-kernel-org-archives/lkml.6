Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DAEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8142087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548919404;
	bh=JWLPRWqGtLxjX/ZjO4PGjMYRIPhHpSqw9/9GX/zuFvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D5mJPaNk8nupAJbgFrN0yjrG8ncYEQK7a9ozCK3NfF6twSxLsaXWMa0IwbRkPQ3dJ
	 KqVNzB+lEcoKN5W05qQRNncadW2Rm+kaGkSyqMxWBnxS5q7UzOIo2nPC3Vrpdxnb1V
	 gdNEtBIklmtzotF/loglExXfZc3jypPhT2YizuJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfAaHXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:23:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfAaHXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:23:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1502FAFC7;
        Thu, 31 Jan 2019 07:23:20 +0000 (UTC)
Date:   Thu, 31 Jan 2019 08:23:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, dan.j.williams@intel.com,
        Pavel.Tatashin@microsoft.com, david@redhat.com,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: Re: [RFC PATCH v2 0/4] mm, memory_hotplug: allocate memmap from
 hotadded memory
Message-ID: <20190131072319.GN18811@dhcp22.suse.cz>
References: <20190122103708.11043-1-osalvador@suse.de>
 <20190130215159.culyc2wcgocp5l2p@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130215159.culyc2wcgocp5l2p@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-01-19 22:52:04, Oscar Salvador wrote:
> On Tue, Jan 22, 2019 at 11:37:04AM +0100, Oscar Salvador wrote:
> > I yet have to check a couple of things like creating an accounting item
> > like VMEMMAP_PAGES to show in /proc/meminfo to ease to spot the memory that
> > went in there, testing Hyper-V/Xen to see how they react to the fact that
> > we are using the beginning of the memory-range for our own purposes, and to
> > check the thing about gigantic pages + hotplug.
> > I also have to check that there is no compilation/runtime errors when
> > CONFIG_SPARSEMEM but !CONFIG_SPARSEMEM_VMEMMAP.
> > But before that, I would like to get people's feedback about the overall
> > design, and ideas/suggestions.
> 
> just a friendly reminder if some feedback is possible :-)

I will be off next week and will not get to this this week.

-- 
Michal Hocko
SUSE Labs
