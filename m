Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBE1C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E334F20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E334F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbeGZTKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:10:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:46358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730764AbeGZTKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:10:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7551BAE86;
        Thu, 26 Jul 2018 17:52:18 +0000 (UTC)
Date:   Thu, 26 Jul 2018 19:52:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     osalvador@techadventures.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, mgorman@techsingularity.net,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.j.williams@intel.com,
        osalvador@suse.de
Subject: Re: [PATCH v3 2/5] mm: access zone->node via zone_to_nid() and
 zone_set_nid()
Message-ID: <20180726175212.GQ28386@dhcp22.suse.cz>
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-3-osalvador@techadventures.net>
 <20180726080500.GX28386@dhcp22.suse.cz>
 <20180726081215.GC22028@techadventures.net>
 <20180726151420.uigttpoclcka6h4h@xakep.localdomain>
 <20180726164304.GP28386@dhcp22.suse.cz>
 <CAGM2reatUAekg=e9FQM1-UVLOSBKb74-FYo7FcPqO_WaR7AmOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reatUAekg=e9FQM1-UVLOSBKb74-FYo7FcPqO_WaR7AmOQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-07-18 13:18:46, Pavel Tatashin wrote:
> > > OpenGrok was used to find places where zone->node is accessed. A public one
> > > is available here: http://src.illumos.org/source/
> >
> > I assume that tool uses some pattern matching or similar so steps to use
> > the tool to get your results would be more helpful. This is basically
> > the same thing as coccinelle generated patches.
> 
> OpenGrok is very easy to use, it is source browser, similar to cscope
> except obviously you can't edit the browsed code. I could have used
> cscope just as well here.

OK, then I misunderstood. I thought it was some kind of c aware grep
that found all the usage for you. If this is cscope like then it is not
worth mentioning in the changelog. 
-- 
Michal Hocko
SUSE Labs
