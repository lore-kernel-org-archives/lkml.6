Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80135C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CF920851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CF920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeKUBrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:47:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:43320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbeKUBrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:47:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 338A0AF4D;
        Tue, 20 Nov 2018 15:18:07 +0000 (UTC)
Date:   Tue, 20 Nov 2018 16:18:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador <osalvador@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] mm, memory_hotplug: deobfuscate migration part
 of offlining
Message-ID: <20181120151806.GQ22247@dhcp22.suse.cz>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-3-mhocko@kernel.org>
 <1542726815.6817.8.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542726815.6817.8.camel@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 16:13:35, Oscar Salvador wrote:
> 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> [...]
> > +	do {
> > +		for (pfn = start_pfn; pfn;)
> > +		{
> > +			/* start memory hot removal */
> 
> Should we change thAT comment? I mean, this is not really the hot-
> removal stage.
> 
> Maybe "start memory migration" suits better? or memory offlining?

I will just drop it. It doesn't really explain anything.
[...]
> 
> This indeed looks much nicer and it is easier to follow.
> With the changes commented by David:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!

-- 
Michal Hocko
SUSE Labs
