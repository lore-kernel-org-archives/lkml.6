Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F094BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91692087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfAaIDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:03:17 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:36418 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfAaIDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:03:16 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 9B27A40EC; Thu, 31 Jan 2019 09:03:14 +0100 (CET)
Date:   Thu, 31 Jan 2019 09:03:14 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, dan.j.williams@intel.com,
        Pavel.Tatashin@microsoft.com, david@redhat.com,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: Re: [RFC PATCH v2 0/4] mm, memory_hotplug: allocate memmap from
 hotadded memory
Message-ID: <20190131080311.qiqi2tj4iromzzap@d104.suse.de>
References: <20190122103708.11043-1-osalvador@suse.de>
 <20190130215159.culyc2wcgocp5l2p@d104.suse.de>
 <20190131072319.GN18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131072319.GN18811@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 08:23:19AM +0100, Michal Hocko wrote:
> On Wed 30-01-19 22:52:04, Oscar Salvador wrote:
> > On Tue, Jan 22, 2019 at 11:37:04AM +0100, Oscar Salvador wrote:
> > > I yet have to check a couple of things like creating an accounting item
> > > like VMEMMAP_PAGES to show in /proc/meminfo to ease to spot the memory that
> > > went in there, testing Hyper-V/Xen to see how they react to the fact that
> > > we are using the beginning of the memory-range for our own purposes, and to
> > > check the thing about gigantic pages + hotplug.
> > > I also have to check that there is no compilation/runtime errors when
> > > CONFIG_SPARSEMEM but !CONFIG_SPARSEMEM_VMEMMAP.
> > > But before that, I would like to get people's feedback about the overall
> > > design, and ideas/suggestions.
> > 
> > just a friendly reminder if some feedback is possible :-)
> 
> I will be off next week and will not get to this this week.

Sure, it can wait.
In the meantime I will take the chance to clean up a couple of things.

Thanks
-- 
Oscar Salvador
SUSE L3
