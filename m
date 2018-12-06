Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF99CC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB59420868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB59420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLFXtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:49:18 -0500
Received: from ale.deltatee.com ([207.54.116.67]:47318 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeLFXtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:49:18 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gV3O8-0006ni-SI; Thu, 06 Dec 2018 16:49:01 -0700
To:     Dave Hansen <dave.hansen@intel.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Vivek Kini <vkini@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Ben Woodard <woodard@redhat.com>, linux-acpi@vger.kernel.org
References: <20181205001544.GR2937@redhat.com>
 <42006749-7912-1e97-8ccd-945e82cebdde@intel.com>
 <20181205021334.GB3045@redhat.com>
 <b3122fdf-02c3-2e9c-1da6-fb873b824d59@intel.com>
 <20181205175357.GG3536@redhat.com>
 <b8fab9a7-62ed-5d8d-3cb1-aea6aacf77fe@intel.com>
 <20181206192050.GC3544@redhat.com>
 <d6508932-377c-a4d1-d4d8-01d0f55b9190@intel.com>
 <c583be1b-17db-1ed3-0f5a-bd119edc8bfe@deltatee.com>
 <f7eb9939-d550-706a-946d-acbb7383172e@intel.com>
 <20181206223935.GG3544@redhat.com>
 <c1126d60-95c0-ed34-6314-fcec17ac1c29@intel.com>
 <935fc14d-91f2-bc2a-f8b5-665e4145e148@deltatee.com>
 <5e6c87d5-e4ef-12e7-32bf-c163f7ff58d7@intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cd5cf2a6-7415-eae7-0305-004cc7db994b@deltatee.com>
Date:   Thu, 6 Dec 2018 16:48:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <5e6c87d5-e4ef-12e7-32bf-c163f7ff58d7@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-acpi@vger.kernel.org, woodard@redhat.com, riel@surriel.com, aarcange@redhat.com, bskeggs@redhat.com, airlied@redhat.com, mgorman@techsingularity.net, vkini@nvidia.com, mhairgrove@nvidia.com, jonathan.cameron@huawei.com, mhocko@kernel.org, rcampbell@nvidia.com, jhubbard@nvidia.com, Paul.Blinzer@amd.com, christian.koenig@amd.com, Philip.Yang@amd.com, felix.kuehling@amd.com, benh@kernel.crashing.org, aneesh.kumar@linux.ibm.com, bsingharora@gmail.com, haggaie@mellanox.com, dan.j.williams@intel.com, keith.busch@intel.com, ross.zwisler@linux.intel.com, willy@infradead.org, rafael@kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, jglisse@redhat.com, dave.hansen@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-12-06 4:38 p.m., Dave Hansen wrote:
> On 12/6/18 3:28 PM, Logan Gunthorpe wrote:
>> I didn't think this was meant to describe actual real world performance
>> between all of the links. If that's the case all of this seems like a
>> pipe dream to me.
> 
> The HMAT discussions (that I was a part of at least) settled on just
> trying to describe what we called "sticker speed".  Nobody had an
> expectation that you *really* had to measure everything.
> 
> The best we can do for any of these approaches is approximate things.

Yes, though there's a lot of caveats in this assumption alone.
Specifically with PCI: the bus may run at however many GB/s but P2P
through a CPU's root complexes can slow down significantly (like down to
MB/s).

I've seen similar things across QPI: I can sometimes do P2P from
PCI->QPI->PCI but the performance doesn't even come close to the sticker
speed of any of those buses.

I'm not sure how anyone is going to deal with those issues, but it does
firmly place us in world view #2 instead of #1. But, yes, I agree
exposing information like in #2 full out to userspace, especially
through sysfs, seems like a nightmare and I don't see anything in HMS to
help with that. Providing an API to ask for memory (or another resource)
that's accessible by a set of initiators and with a set of requirements
for capabilities seems more manageable.

Logan
