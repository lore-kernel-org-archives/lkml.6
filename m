Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A7AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2807E2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeLRVv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:51:27 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:60301 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbeLRVv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:51:27 -0500
Received: by suse.de (Postfix, from userid 1000)
        id A289B3C70; Tue, 18 Dec 2018 22:51:25 +0100 (CET)
Date:   Tue, 18 Dec 2018 22:51:25 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.com, vbabka@suse.cz, pavel.tatashin@microsoft.com,
        rppt@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181218215118.smplwk4qhptsoyer@d104.suse.de>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181217150726.6eea4942005516d565dae488@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217150726.6eea4942005516d565dae488@linux-foundation.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:07:26PM -0800, Andrew Morton wrote:
> On Mon, 17 Dec 2018 23:51:13 +0100 Oscar Salvador <osalvador@suse.de> wrote:
> 
> > v1 -> v2:
> > 	- Fix the logic for skipping pages by Michal
> > 
> > ---
> 
> Please be careful with the "^---$".  It signifies end-of-changelog, so
> I ended up without a changelog!

Sorry Andrew, somehow I screwed it up!
I will be more careful next time.

> 
> > >From e346b151037d3c37feb10a981a4d2a25018acf81 Mon Sep 17 00:00:00 2001
> > From: Oscar Salvador <osalvador@suse.de>
> > Date: Mon, 17 Dec 2018 14:53:35 +0100
> > Subject: [PATCH] mm, page_alloc: Fix has_unmovable_pages for HugePages
> > 
> > While playing with gigantic hugepages and memory_hotplug, I triggered
> > the following #PF when "cat memoryX/removable":
> > 
> > ...
> >
> > Also, since gigantic pages span several pageblocks, re-adjust the logic
> > for skipping pages.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> cc:stable?
> 

-- 
Oscar Salvador
SUSE L3
