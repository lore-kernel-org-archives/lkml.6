Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C95ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3A22083A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OzI8O4tB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3A22083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeJSXIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:08:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48244 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJSXIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:08:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9JEsTfE065901;
        Fri, 19 Oct 2018 15:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=y3cYouPi3PtPv8jCD+2d3VGWQJY0aKfow3pqumR+ih8=;
 b=OzI8O4tB8I288iCnc+U7qEh5UAxkSfaGYxXXPj8DFhIxco9SUobncIqE5MWp4ieLUTMl
 C69ai2vHVlI/YW1IsNv5byEZOY/7TmszuuOHCOhz2KdKWqLlOBb7RLX9gHIqjS1UXjcC
 V0Zy+WJRsG5Fs3GwJd5zThsO5vUdpS+Yu9EDKaEMUq10UBhRPIDMj/6ubmzN35NWr1sl
 R3f8baISxD8sieuXa6P2zdj8QqXfI6eLjOS+yiJ0UaRPACNdPoxqzwykaS58Q0VVF+84
 dobQwUoh9tXTZhsI0FqENf7/oeCFRJ9Ak3435F204v9HHx0rkfmh8ULRjXmqAWyIl/Ju 8g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n38nqmgg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 15:00:56 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9JF0tY3018294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 15:00:56 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9JF0rWe027937;
        Fri, 19 Oct 2018 15:00:53 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Oct 2018 08:00:53 -0700
Date:   Fri, 19 Oct 2018 08:00:53 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Aaron Lu <aaron.lu@intel.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC v4 PATCH 2/5] mm/__free_one_page: skip merge for order-0
 page unless compaction failed
Message-ID: <20181019150053.iaubsdtcsi64mqb7@ca-dmjordan1.us.oracle.com>
References: <20181017063330.15384-1-aaron.lu@intel.com>
 <20181017063330.15384-3-aaron.lu@intel.com>
 <20181017104427.GJ5819@techsingularity.net>
 <20181017131059.GA9167@intel.com>
 <20181017135807.GL5819@techsingularity.net>
 <20181017145904.GC9167@intel.com>
 <20181018111632.GM5819@techsingularity.net>
 <20181019055703.GA2401@intel.com>
 <20181019085435.GR5819@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019085435.GR5819@techsingularity.net>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=661
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 09:54:35AM +0100, Mel Gorman wrote:
> On Fri, Oct 19, 2018 at 01:57:03PM +0800, Aaron Lu wrote:
> > > 
> > > I don't think this is the right way of thinking about it because it's
> > > possible to have the system split in such a way so that the migration
> > > scanner only encounters unmovable pages before it meets the free scanner
> > > where unmerged buddies were in the higher portion of the address space.
> > 
> > Yes it is possible unmerged pages are in the higher portion.
> > 
> > My understanding is, when the two scanners meet, all unmerged pages will
> > be either used by the free scanner as migrate targets or sent to merge
> > by the migration scanner.
> > 
> 
> It's not guaranteed if the lower portion of the address space consisted
> entirely of pages that cannot migrate (because they are unmovable or because
> migration failed due to pins). It's actually a fundamental limitation
> of compaction that it can miss migration and compaction opportunities
> due to how the scanners are implemented. It was designed that way to
> avoid pageblocks being migrated unnecessarily back and forth but the
> downside is missed opportunities.
> 
> > > You either need to keep unmerged buddies on a separate list or search
> > > the order-0 free list for merge candidates prior to compaction.
> > > 
> > > > > It's needed to form them efficiently but excessive reclaim or writing 3
> > > > > to drop_caches can also do it. Be careful of tying lazy buddy too
> > > > > closely to compaction.
> > > > 
> > > > That's the current design of this patchset, do you see any immediate
> > > > problem of this? Is it that you are worried about high-order allocation
> > > > success rate using this design?
> > > 
> > > I've pointed out what I see are the design flaws but yes, in general, I'm
> > > worried about the high order allocation success rate using this design,
> > > the reliance on compaction and the fact that the primary motivation is
> > > when THP is disabled.
> > 
> > When THP is in use, zone lock contention is pretty much nowhere :-)
> > 
> > I'll see what I can get with 'address space range' lock first and will
> > come back to 'lazy buddy' if it doesn't work out.

With the address space range idea, wouldn't the zone free_area require changes
too?  I can't see how locking by address range could synchronize it as it
exists now otherwise, with per order/mt list heads.

One idea is to further subdivide the free area according to how the locking
works and find some reasonable way to handle having to search for pages of a
given order/mt in multiple places.
