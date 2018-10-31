Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F79EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F48120685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F48120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeJaTMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:12:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:50700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727865AbeJaTMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:12:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F308AE3E;
        Wed, 31 Oct 2018 10:15:03 +0000 (UTC)
Date:   Wed, 31 Oct 2018 11:15:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
Message-ID: <20181031101501.GL32673@dhcp22.suse.cz>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
 <20181029080708.GA32673@dhcp22.suse.cz>
 <20181029081706.GC32673@dhcp22.suse.cz>
 <1540862950.12374.40.camel@mtkswgap22>
 <20181030060601.GR32673@dhcp22.suse.cz>
 <1540882551.23278.12.camel@mtkswgap22>
 <20181030081537.GV32673@dhcp22.suse.cz>
 <1540975637.10275.10.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540975637.10275.10.camel@mtkswgap22>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-10-18 16:47:17, Miles Chen wrote:
> On Tue, 2018-10-30 at 09:15 +0100, Michal Hocko wrote:
> > On Tue 30-10-18 14:55:51, Miles Chen wrote:
> > [...]
> > > It's a real problem when using page_owner.
> > > I found this issue recently: I'm not able to read page_owner information
> > > during a overnight test. (error: read failed: Out of memory). I replace
> > > kmalloc() with vmalloc() and it worked well.
> > 
> > Is this with trimming the allocation to a single page and doing shorter
> > than requested reads?
> 
> 
> I printed out the allocate count on my device the request count is <=
> 4096. So I tested this scenario by trimming the count to from 4096 to
> 1024 bytes and it works fine. 
> 
> count = count > 1024? 1024: count;
> 
> It tested it on both 32bit and 64bit kernel.

Are you saying that you see OOMs for 4k size?

-- 
Michal Hocko
SUSE Labs
