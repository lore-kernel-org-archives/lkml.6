Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF6F2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF6F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLFUMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:12:13 -0500
Received: from ale.deltatee.com ([207.54.116.67]:45344 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeLFUMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:12:12 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gUzzn-0003on-BS; Thu, 06 Dec 2018 13:11:40 -0700
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
References: <20181203233509.20671-1-jglisse@redhat.com>
 <6e2a1dba-80a8-42bf-127c-2f5c2441c248@intel.com>
 <20181205001544.GR2937@redhat.com>
 <42006749-7912-1e97-8ccd-945e82cebdde@intel.com>
 <20181205021334.GB3045@redhat.com>
 <b3122fdf-02c3-2e9c-1da6-fb873b824d59@intel.com>
 <20181205175357.GG3536@redhat.com>
 <b8fab9a7-62ed-5d8d-3cb1-aea6aacf77fe@intel.com>
 <20181206192050.GC3544@redhat.com>
 <d6508932-377c-a4d1-d4d8-01d0f55b9190@intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c583be1b-17db-1ed3-0f5a-bd119edc8bfe@deltatee.com>
Date:   Thu, 6 Dec 2018 13:11:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d6508932-377c-a4d1-d4d8-01d0f55b9190@intel.com>
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



On 2018-12-06 12:31 p.m., Dave Hansen wrote:
> On 12/6/18 11:20 AM, Jerome Glisse wrote:
>>>> For case 1 you can pre-parse stuff but this can be done by helper library
>>> How would that work?  Would each user/container/whatever do this once?
>>> Where would they keep the pre-parsed stuff?  How do they manage their
>>> cache if the topology changes?
>> Short answer i don't expect a cache, i expect that each program will have
>> a init function that query the topology and update the application codes
>> accordingly.
> 
> My concern with having folks do per-program parsing, *and* having a huge
> amount of data to parse makes it unusable.  The largest systems will
> literally have hundreds of thousands of objects in /sysfs, even in a
> single directory.  That makes readdir() basically impossible, and makes
> even open() (if you already know the path you want somehow) hard to do fast.

Is this actually realistic? I find it hard to imagine an actual hardware
bus that can have even thousands of devices under a single node, let
alone hundreds of thousands. At some point the laws of physics apply.
For example, in present hardware, the most ports a single PCI switch can
have these days is under one hundred. I'd imagine any such large systems
would have a hierarchy of devices (ie. layers of switch-like devices)
which implies the existing sysfs bus/devices  should have a path through
it without navigating a directory with that unreasonable a number of
objects in it. HMS, on the other hand, has all possible initiators
(,etc) under a single directory.

The caveat to this is, that to find an initial starting point in the bus
hierarchy you might have to go through /sys/dev/{block|char} or
/sys/class which may have directories with a large number of objects.
Though, such a system would necessarily have a similarly large number of
objects in /dev which means means you will probably never get around the
readdir/open bottleneck you mention... and, thus, this doesn't seem
overly realistic to me.

Logan
