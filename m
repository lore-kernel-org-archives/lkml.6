Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9346C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8879A2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8879A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeLDWRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:17:04 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54976 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeLDWRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:17:03 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gUIzy-0001VV-2t; Tue, 04 Dec 2018 15:16:59 -0700
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
References: <20181204182421.GC2937@redhat.com>
 <CAPcyv4gtv7eUc1_3Yhz-f-B3Lct=Vq7zqUJKOqCtWYb4BS6i9g@mail.gmail.com>
 <20181204185725.GE2937@redhat.com>
 <de7c1099-2717-6396-bf56-c4ab4085ee83@deltatee.com>
 <20181204192221.GG2937@redhat.com>
 <f759cc28-309d-930c-da7d-34144a4d5517@deltatee.com>
 <20181204201347.GK2937@redhat.com>
 <2f146730-1bf9-db75-911d-67809fc7afef@deltatee.com>
 <20181204205902.GM2937@redhat.com>
 <e4d8bf6b-5b2c-58a5-577b-66d02f2342c1@deltatee.com>
 <20181204215146.GO2937@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c5cf87e8-9104-c2e6-9646-188f66fec581@deltatee.com>
Date:   Tue, 4 Dec 2018 15:16:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204215146.GO2937@redhat.com>
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



On 2018-12-04 2:51 p.m., Jerome Glisse wrote:
> Existing user would disagree in my cover letter i have given pointer
> to existing library and paper from HPC folks that do leverage system
> topology (among the few who are). So they are application _today_ that
> do use topology information to adapt their workload to maximize the
> performance for the platform they run on.

Well we need to give them what they actually need, not what they want to
shoot their foot with. And I imagine, much of what they actually do
right now belongs firmly in the kernel. Like I said, existing
applications are not justifications for bad API design or layering
violations.

You've even mentioned we'd need a simplified "libhms" interface for
applications. We should really just figure out what that needs to be and
make that the kernel interface.

> They are also some new platform that have much more complex topology
> that definitly can not be represented as a tree like today sysfs we
> have (i believe that even some of the HPC folks have _today_ topology
> that are not tree-like).

The sysfs tree already allows for a complex graph that describes
existing hardware very well. If there is hardware it cannot describe
then we should work to improve it and not just carve off a whole new
area for a special API. -- In fact, you are already using sysfs, just
under your own virtual/non-existent bus.

> Note that if it turn out to be a bad idea kernel can decide to dumb
> down thing in future version for new platform. So it could give a
> flat graph to userspace, there is nothing precluding that.

Uh... if it turns out to be a bad idea we are screwed because we have an
API existing applications are using. It's much easier to add features to
a simple (your word: "dumb") interface than it is to take options away
from one that is too broad.

> 
>>> I am talking about the inevitable fact that at some point some system
>>> firmware will miss-represent their platform. System firmware writer
>>> usualy copy and paste thing with little regards to what have change
>>> from one platform to the new. So their will be inevitable workaround
>>> and i would rather see those piling up inside a userspace library than
>>> inside the kernel.
>>
>> It's *absolutely* the kernel's responsibility to patch issues caused by
>> broken firmware. We have quirks all over the place for this. That's
>> never something userspace should be responsible for. Really, this is the
>> raison d'etre of the kernel: to provide userspace with a uniform
>> execution environment -- if every application had to deal with broken
>> firmware it would be a nightmare.
> 
> You cuted the other paragraph that explained why they will unlikely
> to be broken badly enough to break the kernel.

That was entirely beside the point. Just because it doesn't break the
kernel itself doesn't make it any less necessary for it to be fixed
inside the kernel. It must be done in a common place so every
application doesn't have to maintain a table of hardware quirks.

Logan
