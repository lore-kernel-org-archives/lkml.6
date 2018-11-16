Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E439C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B906E208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B906E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389548AbeKPVRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:17:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:57570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727630AbeKPVRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:17:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83ABBAF14;
        Fri, 16 Nov 2018 11:05:20 +0000 (UTC)
Message-ID: <1542366304.3020.15.camel@suse.de>
Subject: Re: [PATCH] mm: use managed_zone() for more exact check in zone
 iteration
From:   osalvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 16 Nov 2018 12:05:04 +0100
In-Reply-To: <20181116095720.GE14706@dhcp22.suse.cz>
References: <20181114235040.36180-1-richard.weiyang@gmail.com>
         <20181115133735.bb0313ec9293c415d08be550@linux-foundation.org>
         <20181116095720.GE14706@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 10:57 +0100, Michal Hocko wrote:
> On Thu 15-11-18 13:37:35, Andrew Morton wrote:
> [...]
> > Worse, the situations in which managed_zone() != populated_zone()
> > are
> > rare(?), so it will take a long time for problems to be discovered,
> > I
> > expect.
> 
> We would basically have to deplete the whole zone by the bootmem
> allocator or pull out all pages from the page allocator. E.g. memory
> hotplug decreases both managed and present counters. I am actually
> not
> sure that is 100% correct (put on my TODO list to check). There is no
> consistency in that regards.

We can only offline non-reserved pages (so, managed pages).
Since present pages holds reserved_pages + managed_pages, decreasing
both should be fine unless I am mistaken.

Oscar Salvador



