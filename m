Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E195C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B6A2407E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B6A2407E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933953AbeGCPOI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:14:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:37524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933181AbeGCPOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:14:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2EB3EAD30;
        Tue,  3 Jul 2018 15:14:03 +0000 (UTC)
Date:   Tue, 3 Jul 2018 17:14:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] m68k/page_no.h: force __va argument to be unsigned
 long
Message-ID: <20180703151401.GQ16767@dhcp22.suse.cz>
References: <1530613795-6956-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530613795-6956-3-git-send-email-rppt@linux.vnet.ibm.com>
 <20180703142054.GL16767@dhcp22.suse.cz>
 <20180703150315.GC4809@rapoport-lnx>
 <20180703150535.GA21590@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703150535.GA21590@bombadil.infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-07-18 08:05:35, Matthew Wilcox wrote:
> On Tue, Jul 03, 2018 at 06:03:16PM +0300, Mike Rapoport wrote:
> > On Tue, Jul 03, 2018 at 04:20:54PM +0200, Michal Hocko wrote:
> > > On Tue 03-07-18 13:29:54, Mike Rapoport wrote:
> > > > Add explicit casting to unsigned long to the __va() parameter
> > > 
> > > Why is this needed?
> > 
> > To make it consitent with other architecures and asm-generic :)
> > 
> > But more importantly, __memblock_free_late() passes u64 to page_to_pfn().
> 
> Why does memblock work in terms of u64 instead of phys_addr_t?

Yes, phys_addr_t was exactly that came to my mind as well. Casting
physical address to unsigned long just screams for potential problems.

-- 
Michal Hocko
SUSE Labs
