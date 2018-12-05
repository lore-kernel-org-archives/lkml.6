Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6699C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7023C206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7023C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeLERa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:30:58 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34016 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbeLERa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:30:56 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gUavY-00086E-Dt; Wed, 05 Dec 2018 10:25:37 -0700
To:     Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Linux MM <linux-mm@kvack.org>,
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
References: <f759cc28-309d-930c-da7d-34144a4d5517@deltatee.com>
 <20181204201347.GK2937@redhat.com>
 <2f146730-1bf9-db75-911d-67809fc7afef@deltatee.com>
 <20181204205902.GM2937@redhat.com>
 <e4d8bf6b-5b2c-58a5-577b-66d02f2342c1@deltatee.com>
 <20181204215146.GO2937@redhat.com>
 <c5cf87e8-9104-c2e6-9646-188f66fec581@deltatee.com>
 <20181204235630.GQ2937@redhat.com>
 <b77849e1-e05a-1071-7c48-ac93191e3134@deltatee.com>
 <CAPcyv4ihEesx1G1on6JA8qZ6RooOsgO2CL_=1gXVMXpMJW_N9w@mail.gmail.com>
 <20181205023724.GF3045@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2f53e0c0-a8af-b003-5bd7-a341431908df@deltatee.com>
Date:   Wed, 5 Dec 2018 10:25:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205023724.GF3045@redhat.com>
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



On 2018-12-04 7:37 p.m., Jerome Glisse wrote:
>>
>> This came up before for apis even better defined than HMS as well as
>> more limited scope, i.e. experimental ABI availability only for -rc
>> kernels. Linus said this:
>>
>> "There are no loopholes. No "but it's been only one release". No, no,
>> no. The whole point is that users are supposed to be able to *trust*
>> the kernel. If we do something, we keep on doing it.
>>
>> And if it makes it harder to add new user-visible interfaces, then
>> that's a *good* thing." [1]
>>
>> The takeaway being don't land work-in-progress ABIs in the kernel.
>> Once an application depends on it, there are no more incompatible
>> changes possible regardless of the warnings, experimental notices, or
>> "staging" designation. DAX is experimental because there are cases
>> where it currently does not work with respect to another kernel
>> feature like xfs-reflink, RDMA. The plan is to fix those, not continue
>> to hide behind an experimental designation, and fix them in a way that
>> preserves the user visible behavior that has already been exposed,
>> i.e. no regressions.
>>
>> [1]: https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2017-August/004742.html
> 
> So i guess i am heading down the vXX road ... such is my life :)

I recommend against it. I really haven't been convinced by any of your
arguments for having a second topology tree. The existing topology tree
in sysfs already better describes the links between hardware right now,
except for the missing GPU links (and those should be addressable within
the GPU community). Plus, maybe, some other enhancements to sockets/numa
node descriptions if there's something missing there.

Then, 'hbind' is another issue but I suspect it would be better
implemented as an ioctl on existing GPU interfaces. I certainly can't
see any benefit in using it myself.

It's better to take an approach that would be less controversial with
the community than to brow beat them with a patch set 20+ times until
they take it.

Logan

