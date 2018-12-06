Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE93C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB1F20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB1F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLFX3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:29:33 -0500
Received: from ale.deltatee.com ([207.54.116.67]:47074 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLFX3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:29:33 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gV34j-0006Wc-Cs; Thu, 06 Dec 2018 16:28:58 -0700
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <935fc14d-91f2-bc2a-f8b5-665e4145e148@deltatee.com>
Date:   Thu, 6 Dec 2018 16:28:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <c1126d60-95c0-ed34-6314-fcec17ac1c29@intel.com>
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



On 2018-12-06 4:09 p.m., Dave Hansen wrote:
> This looks great.  But, we don't _have_ this kind of information for any
> system that I know about or any system available in the near future.
> 
> We basically have two different world views:
> 1. The system is described point-to-point.  A connects to B @
>    100GB/s.  B connects to C at 50GB/s.  Thus, C->A should be
>    50GB/s.
>    * Less information to convey
>    * Potentially less precise if the properties are not perfectly
>      additive.  If A->B=10ns and B->C=20ns, A->C might be >30ns.
>    * Costs must be calculated instead of being explicitly specified
> 2. The system is described endpoint-to-endpoint.  A->B @ 100GB/s
>    B->C @ 50GB/s, A->C @ 50GB/s.
>    * A *lot* more information to convey O(N^2)?
>    * Potentially more precise.
>    * Costs are explicitly specified, not calculated
> 
> These patches are really tied to world view #1.  But, the HMAT is really
> tied to world view #1.

I didn't think this was meant to describe actual real world performance
between all of the links. If that's the case all of this seems like a
pipe dream to me.

Attributes like cache coherency, atomics, etc should fit well in world
view #1... and, at best, some kind of flag saying whether or not to use
a particular link if you care about transfer speed. -- But we don't need
special "link" directories to describe the properties of existing buses.

You're not *really* going to know bandwidth or latency for any of this
unless you actually measure it on the system in question.

Logan
