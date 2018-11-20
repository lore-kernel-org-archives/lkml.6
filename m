Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1AFC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32982087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32982087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeKUBaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:30:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:40438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbeKUBaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:30:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 528CBAFC8;
        Tue, 20 Nov 2018 15:00:36 +0000 (UTC)
Date:   Tue, 20 Nov 2018 16:00:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador <osalvador@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [RFC PATCH 1/3] mm, memory_hotplug: try to migrate full section
 worth of pages
Message-ID: <20181120150035.GP22247@dhcp22.suse.cz>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-2-mhocko@kernel.org>
 <1542725492.6817.3.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542725492.6817.3.camel@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 15:51:32, Oscar Salvador wrote:
> On Tue, 2018-11-20 at 14:43 +0100, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > do_migrate_range has been limiting the number of pages to migrate to
> > 256
> > for some reason which is not documented. 
> 
> When looking back at old memory-hotplug commits one feels pretty sad
> about the brevity of the changelogs.

Well, things evolve and we've become much more careful about changelogs
over time. It still gets quite a lot of time to push back on changelogs
even these days though. People still keep forgetting that "what" is not
as important as "why" because the former is usually quite easy to
understand from reading the diff. The intention behind is usually what
gets forgotten after years. I guess people realize this much more after
few excavation git blame tours.

> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!
-- 
Michal Hocko
SUSE Labs
