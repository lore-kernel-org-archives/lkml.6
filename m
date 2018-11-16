Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82689C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D182086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D182086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389714AbeKPViE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:38:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:36912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727567AbeKPViE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:38:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3F6AAC4C;
        Fri, 16 Nov 2018 11:26:05 +0000 (UTC)
Date:   Fri, 16 Nov 2018 12:26:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use managed_zone() for more exact check in zone
 iteration
Message-ID: <20181116112603.GI14706@dhcp22.suse.cz>
References: <20181114235040.36180-1-richard.weiyang@gmail.com>
 <20181115133735.bb0313ec9293c415d08be550@linux-foundation.org>
 <20181116095720.GE14706@dhcp22.suse.cz>
 <1542366304.3020.15.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542366304.3020.15.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-11-18 12:05:04, osalvador wrote:
> On Fri, 2018-11-16 at 10:57 +0100, Michal Hocko wrote:
[...]
> > E.g. memory hotplug decreases both managed and present counters. I
> > am actually not sure that is 100% correct (put on my TODO list to
> > check). There is no consistency in that regards.
> 
> We can only offline non-reserved pages (so, managed pages).

Yes

> Since present pages holds reserved_pages + managed_pages, decreasing
> both should be fine unless I am mistaken.

Well, present_pages is defined as "physical pages existing within the zone"
and those pages are still existing but they are offline. But as I've
said I have to think about it some more
-- 
Michal Hocko
SUSE Labs
