Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6537C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC77A21852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbeLTNtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:49:04 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:33927 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387421AbeLTNtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:49:02 -0500
Received: by suse.de (Postfix, from userid 1000)
        id AF5733CA9; Thu, 20 Dec 2018 14:49:00 +0100 (CET)
Date:   Thu, 20 Dec 2018 14:49:00 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        vbabka@suse.cz, pavel.tatashin@microsoft.com,
        rppt@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181220134900.zk4djsoenspltdx6@d104.suse.de>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181219142528.yx6ravdyzcqp5wtd@master>
 <20181219233914.2fxe26pih26ifvmt@d104.suse.de>
 <20181220091228.GB14234@dhcp22.suse.cz>
 <20181220124925.itwuuacgztpgsk7s@d104.suse.de>
 <20181220130857.yrzv5wzmiw7jbycb@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220130857.yrzv5wzmiw7jbycb@master>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 01:08:57PM +0000, Wei Yang wrote:
> This complicated the calculation. 
> 
> The original code is correct.
> 
> iter = round_up(iter + 1, 1<<compound_order(head)) - 1;

I think it would be correct if we know for sure that everthing
is pageblock aligned.
Because 2mb-hugepages fit in one pageblock, and 1gb-hugepages expands
512 pageblocks exactly.

But I think that it is better if we leave the assumption behind.
-- 
Oscar Salvador
SUSE L3
