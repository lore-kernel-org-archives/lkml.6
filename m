Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EA7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2D420850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2D420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeLEXJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:09:46 -0500
Received: from ale.deltatee.com ([207.54.116.67]:37014 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbeLEXJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:09:45 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gUgIO-0004EQ-LG; Wed, 05 Dec 2018 16:09:33 -0700
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>, balbirs@au1.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Kuehling, Felix" <felix.kuehling@amd.com>, Philip.Yang@amd.com,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Blinzer, Paul" <Paul.Blinzer@amd.com>,
        John Hubbard <jhubbard@nvidia.com>, rcampbell@nvidia.com
References: <20181204235630.GQ2937@redhat.com>
 <b77849e1-e05a-1071-7c48-ac93191e3134@deltatee.com>
 <20181205023116.GD3045@redhat.com>
 <a5ae63ff-a913-25af-4648-4ebf91775412@deltatee.com>
 <20181205180756.GI3536@redhat.com>
 <e5c740fd-0256-8b70-cd06-6d6fee19806d@deltatee.com>
 <20181205183314.GJ3536@redhat.com>
 <0ddb2620-ecbd-4b7b-aeb7-3f4ae7746e83@deltatee.com>
 <20181205185550.GK3536@redhat.com>
 <7ab26ea6-d16d-8d71-78ca-4266a864f8d3@deltatee.com>
 <20181205225828.GL3536@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a0240f08-68ab-5167-c2c7-2f930aa0a54b@deltatee.com>
Date:   Wed, 5 Dec 2018 16:09:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205225828.GL3536@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: rcampbell@nvidia.com, jhubbard@nvidia.com, Paul.Blinzer@amd.com, christian.koenig@amd.com, Philip.Yang@amd.com, felix.kuehling@amd.com, benh@kernel.crashing.org, aneesh.kumar@linux.ibm.com, balbirs@au1.ibm.com, haggaie@mellanox.com, dave.hansen@intel.com, rafael@kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, ak@linux.intel.com, dan.j.williams@intel.com, jglisse@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS)
 documentation
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-12-05 3:58 p.m., Jerome Glisse wrote:
> So just to be clear here is how i understand your position:
> "Single coherent sysfs hierarchy to describe something is useless
>  let's git rm drivers/base/"

I have no idea what you're talking about. I'm saying the existing sysfs
hierarchy *should* be used for this application -- we shouldn't be
creating another hierarchy.

> While i am arguing that "hey the /sys/bus/node/devices/* is nice
> but it just does not cut it for all this new hardware platform
> if i add new nodes there for my new memory i will break tons of
> existing application. So what about a new hierarchy that allow
> to describe those new hardware platform in a single place like
> today node thing"

I'm talking about /sys/bus and all the bus information under there; not
just the node hierarchy. With this information, you can figure out how
any struct device is connected to another struct device. This has little
to do with a hypothetical memory device and what it might expose. You're
conflating memory devices with links between devices (ie. buses).


> No can do that is what i am trying to explain. So if i bus 1 in a
> sub-system A and usualy that kind of bus can serve a bridge for
> PCIE ie a CPU can access device behind it by going through a PCIE
> device first. So now the userspace libary have this knowledge
> bake in. Now if a platform has a bug for whatever reasons where
> that does not hold, the kernel has no way to tell userspace that
> there is an exception there. It is up to userspace to have a data
> base of quirks.

> Kernel see all those objects in isolation in your scheme. While in
> what i am proposing there is only one place and any device that
> participate in this common place can report any quirks so that a
> coherent view is given to user space.

The above makes no sense to me.


> If we have gazillion of places where all this informations is spread
> around than we have no way to fix weird inter-action between any
> of those.

So work to standardize it so that all buses present a consistent view of
what guarantees they provide for bus accesses. Quirks could then adjust
that information for systems that may be broken.

Logan
