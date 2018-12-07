Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E713C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029B8208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029B8208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeLGPHF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:07:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbeLGPHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:07:05 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A387E33DB97E0;
        Fri,  7 Dec 2018 23:06:57 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Fri, 7 Dec 2018
 23:06:55 +0800
Date:   Fri, 7 Dec 2018 15:06:36 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Dave Hansen <dave.hansen@intel.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Ross Zwisler" <ross.zwisler@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        "Philip Yang" <Philip.Yang@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Vivek Kini <vkini@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Ben Woodard <woodard@redhat.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Message-ID: <20181207150636.00003dfa@huawei.com>
In-Reply-To: <20181207002044.GI3544@redhat.com>
References: <b8fab9a7-62ed-5d8d-3cb1-aea6aacf77fe@intel.com>
        <20181206192050.GC3544@redhat.com>
        <d6508932-377c-a4d1-d4d8-01d0f55b9190@intel.com>
        <c583be1b-17db-1ed3-0f5a-bd119edc8bfe@deltatee.com>
        <f7eb9939-d550-706a-946d-acbb7383172e@intel.com>
        <20181206223935.GG3544@redhat.com>
        <c1126d60-95c0-ed34-6314-fcec17ac1c29@intel.com>
        <935fc14d-91f2-bc2a-f8b5-665e4145e148@deltatee.com>
        <5e6c87d5-e4ef-12e7-32bf-c163f7ff58d7@intel.com>
        <cd5cf2a6-7415-eae7-0305-004cc7db994b@deltatee.com>
        <20181207002044.GI3544@redhat.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 19:20:45 -0500
Jerome Glisse <jglisse@redhat.com> wrote:

> On Thu, Dec 06, 2018 at 04:48:57PM -0700, Logan Gunthorpe wrote:
> > 
> > 
> > On 2018-12-06 4:38 p.m., Dave Hansen wrote:  
> > > On 12/6/18 3:28 PM, Logan Gunthorpe wrote:  
> > >> I didn't think this was meant to describe actual real world performance
> > >> between all of the links. If that's the case all of this seems like a
> > >> pipe dream to me.  
> > > 
> > > The HMAT discussions (that I was a part of at least) settled on just
> > > trying to describe what we called "sticker speed".  Nobody had an
> > > expectation that you *really* had to measure everything.
> > > 
> > > The best we can do for any of these approaches is approximate things.  
> > 
> > Yes, though there's a lot of caveats in this assumption alone.
> > Specifically with PCI: the bus may run at however many GB/s but P2P
> > through a CPU's root complexes can slow down significantly (like down to
> > MB/s).
> > 
> > I've seen similar things across QPI: I can sometimes do P2P from
> > PCI->QPI->PCI but the performance doesn't even come close to the sticker
> > speed of any of those buses.
> > 
> > I'm not sure how anyone is going to deal with those issues, but it does
> > firmly place us in world view #2 instead of #1. But, yes, I agree
> > exposing information like in #2 full out to userspace, especially
> > through sysfs, seems like a nightmare and I don't see anything in HMS to
> > help with that. Providing an API to ask for memory (or another resource)
> > that's accessible by a set of initiators and with a set of requirements
> > for capabilities seems more manageable.  
> 
> Note that in #1 you have bridge that fully allow to express those path
> limitation. So what you just describe can be fully reported to userspace.
> 
> I explained and given examples on how program adapt their computation to
> the system topology it does exist today and people are even developing new
> programming langage with some of those idea baked in.
> 
> So they are people out there that already rely on such information they
> just do not get it from the kernel but from a mix of various device specific
> API and they have to stich everything themself and develop a database of
> quirk and gotcha. My proposal is to provide a coherent kernel API where
> we can sanitize that informations and report it to userspace in a single
> and coherent description.
> 
> Cheers,
> Jérôme

I know it doesn't work everywhere, but I think it's worth enumerating what
cases we can get some of these numbers for and where the complexity lies.
I.e. What can the really determined user space library do today?

So one open question is how close can we get in a userspace only prototype.
At the end of the day userspace can often read HMAT directly if it wants to
/sys/firmware/acpi/tables/HMAT.  Obviously that gets us only the end to
end view (world 2).  I dislike the limitations of that as much as the next
person. It is slowly improving with the word "Auditable" being
kicked around - btw anyone interested in ACPI who works for a UEFI
member, there are efforts going on and more viewpoints would be great.
Expect some baby steps shortly.

For devices on PCIe (and protocols on top of it e.g. CCIX), a lot of
this is discoverable to some degree. 
* Link speed,
* Number of Lanes,
* Full topology.

What isn't there (I think)
* In component latency / bandwidth limitations (some activity going
  on to improve that long term)
* Effect of credit allocations etc on effectively bandwidth - interconnect
  performance is a whole load of black magic.

Presumably there is some information available from NVLink etc?

So whilst I really like the proposal in some ways, I wonder how much exploration
could be done of the usefulness of the data without touching the kernel at all.

The other aspect that is needed to actually make this 'dynamically' useful is
to be able to map whatever Performance Counters are available to the relevant
'links', bridges etc.   Ticket numbers are not all that useful unfortunately
except for small amounts of data on lightly loaded buses.

The kernel ultimately only needs to have a model of this topology if:
1) It's going to use it itself
2) Its going to do something automatic with it.
3) It needs to fix garbage info or supplement with things only the kernel knows.

Jonathan

