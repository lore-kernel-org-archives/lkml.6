Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63934C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFEB206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFEB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeKUAzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:55:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:33860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbeKUAzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:55:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E348AFC3;
        Tue, 20 Nov 2018 14:26:00 +0000 (UTC)
Date:   Tue, 20 Nov 2018 15:25:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a
 locked page
Message-ID: <20181120142559.GM22247@dhcp22.suse.cz>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-4-mhocko@kernel.org>
 <20181120140715.mouc7okin3ht5krr@kshutemo-mobl1>
 <20181120141207.GK22247@dhcp22.suse.cz>
 <20181120141700.pwoaxatx3v5xnwos@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120141700.pwoaxatx3v5xnwos@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 17:17:00, Kirill A. Shutemov wrote:
> On Tue, Nov 20, 2018 at 03:12:07PM +0100, Michal Hocko wrote:
> > On Tue 20-11-18 17:07:15, Kirill A. Shutemov wrote:
> > > On Tue, Nov 20, 2018 at 02:43:23PM +0100, Michal Hocko wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > filemap_map_pages takes a speculative reference to each page in the
> > > > range before it tries to lock that page. While this is correct it
> > > > also can influence page migration which will bail out when seeing
> > > > an elevated reference count. The faultaround code would bail on
> > > > seeing a locked page so we can pro-actively check the PageLocked
> > > > bit before page_cache_get_speculative and prevent from pointless
> > > > reference count churn.
> > > 
> > > Looks fine to me.
> > 
> > Thanks for the review.
> > 
> > > But please drop a line of comment in the code. As is it might be confusing
> > > for a reader.
> > 
> > This?
> 
> Yep.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Cool, thanks! I will wait some more time for review feedback for other
patches and then repost with this folded in.

-- 
Michal Hocko
SUSE Labs
