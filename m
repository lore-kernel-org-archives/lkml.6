Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594BCC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBDA20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBDA20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbeLETKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:10:23 -0500
Received: from ale.deltatee.com ([207.54.116.67]:35036 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeLETKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:10:23 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gUcYn-0001BO-Jp; Wed, 05 Dec 2018 12:10:14 -0700
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
References: <20181204215146.GO2937@redhat.com>
 <c5cf87e8-9104-c2e6-9646-188f66fec581@deltatee.com>
 <20181204235630.GQ2937@redhat.com>
 <b77849e1-e05a-1071-7c48-ac93191e3134@deltatee.com>
 <20181205023116.GD3045@redhat.com>
 <a5ae63ff-a913-25af-4648-4ebf91775412@deltatee.com>
 <20181205180756.GI3536@redhat.com>
 <e5c740fd-0256-8b70-cd06-6d6fee19806d@deltatee.com>
 <20181205183314.GJ3536@redhat.com>
 <0ddb2620-ecbd-4b7b-aeb7-3f4ae7746e83@deltatee.com>
 <20181205185550.GK3536@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7ab26ea6-d16d-8d71-78ca-4266a864f8d3@deltatee.com>
Date:   Wed, 5 Dec 2018 12:10:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205185550.GK3536@redhat.com>
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



On 2018-12-05 11:55 a.m., Jerome Glisse wrote:
> So now once next type of device shows up with the exact same thing
> let say FPGA, we have to create a new subsystem for them too. Also
> this make the userspace life much much harder. Now userspace must
> go parse PCIE, subsystem1, subsystem2, subsystemN, NUMA, ... and
> merge all that different information together and rebuild the
> representation i am putting forward in this patchset in userspace.

Yes. But seeing such FPGA links aren't common yet and there isn't really
much in terms of common FPGA infrastructure in the kernel (which are
hard seeing the hardware is infinitely customization) you can let the
people developing FPGA code worry about it and come up with their own
solution. Buses between FPGAs may end up never being common enough for
people to care, or they may end up being so weird that they need their
own description independent of GPUS, or maybe when they become common
they find a way to use the GPU link subsystem -- who knows. Don't try to
design for use cases that don't exist yet.

Yes, userspace will have to know about all the buses it cares to find
links over. Sounds like a perfect thing for libhms to do.

> There is no telling that kernel won't be able to provide quirk and
> workaround because some merging is actually illegal on a given
> platform (like some link from a subsystem is not accessible through
> the PCI connection of one of the device connected to that link).

These are all just different individual problems which need different
solutions not grand new design concepts.

> So it means userspace will have to grow its own database or work-
> around and quirk and i am back in the situation i am in today.

No, as I've said, quirks are firmly the responsibility of kernels.
Userspace will need to know how to work with the different buses and
CPU/node information but there really isn't that many of these to deal
with and this is a much easier approach than trying to come up with a
new API that can wrap the nuances of all existing and potential future
bus types we may have to deal with.

Logan
