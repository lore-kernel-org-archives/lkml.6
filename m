Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401EAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154A420866
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154A420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbeKPVbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:31:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:34212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727715AbeKPVbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:31:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 006FBAF6D;
        Fri, 16 Nov 2018 11:19:55 +0000 (UTC)
Date:   Fri, 16 Nov 2018 12:19:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador <osalvador@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] mm, memory_hotplug: drop pointless block alignment
 checks from __offline_pages
Message-ID: <20181116111954.GG14706@dhcp22.suse.cz>
References: <20181116083020.20260-1-mhocko@kernel.org>
 <20181116083020.20260-4-mhocko@kernel.org>
 <1542364443.3020.3.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542364443.3020.3.camel@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-11-18 11:34:03, Oscar Salvador wrote:
> On Fri, 2018-11-16 at 09:30 +0100, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > This function is never called from a context which would provide
> > misaligned pfn range so drop the pointless check.
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> I vaguely remember that someone reported a problem about misaligned
> range on powerpc.
> Not sure at which stage was (online/offline).
> Although I am not sure if that was valid at all.

If we are talking about the same thing then this was about partial
memblock initialized (aka struct pages were not initialized).

> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!

-- 
Michal Hocko
SUSE Labs
