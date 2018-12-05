Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA0FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70143214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70143214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeLESID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:08:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeLESIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:08:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39BB1307D860;
        Wed,  5 Dec 2018 18:08:01 +0000 (UTC)
Received: from redhat.com (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC0F26109E;
        Wed,  5 Dec 2018 18:07:58 +0000 (UTC)
Date:   Wed, 5 Dec 2018 13:07:57 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
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
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS)
 documentation
Message-ID: <20181205180756.GI3536@redhat.com>
References: <20181204201347.GK2937@redhat.com>
 <2f146730-1bf9-db75-911d-67809fc7afef@deltatee.com>
 <20181204205902.GM2937@redhat.com>
 <e4d8bf6b-5b2c-58a5-577b-66d02f2342c1@deltatee.com>
 <20181204215146.GO2937@redhat.com>
 <c5cf87e8-9104-c2e6-9646-188f66fec581@deltatee.com>
 <20181204235630.GQ2937@redhat.com>
 <b77849e1-e05a-1071-7c48-ac93191e3134@deltatee.com>
 <20181205023116.GD3045@redhat.com>
 <a5ae63ff-a913-25af-4648-4ebf91775412@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5ae63ff-a913-25af-4648-4ebf91775412@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 05 Dec 2018 18:08:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:41:56AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-12-04 7:31 p.m., Jerome Glisse wrote:
> > How can i express multiple link, or memory that is only accessible
> > by a subset of the devices/CPUs. In today model they are back in
> > assumption like everyone can access all the node which do not hold
> > in what i am trying to do.
> 
> Well multiple links are easy when you have a 'link' bus. Just add
> another link device under the bus.

So you are telling do what i am doing in this patchset but not under
HMS directory ?

> 
> Technically, the accessibility issue is already encoded in sysfs. For
> example, through the PCI tree you can determine which ACS bits are set
> and determine which devices are behind the same root bridge the same way
> we do in the kernel p2pdma subsystem. This is all bus specific which is
> fine, but if we want to change that, we should have a common way for
> existing buses to describe these attributes in the existing tree. The
> new 'link' bus devices would have to have some way to describe cases if
> memory isn't accessible in some way across it.

What i am looking at is much more complex than just access bit. It
is a whole set of properties attach to each path (can it be cache
coherent ? can it do atomic ? what is the access granularity ? what
is the bandwidth ? is it dedicated link ? ...)

> 
> But really, I would say the kernel is responsible for telling you when
> memory is accessible to a list of initiators, so it should be part of
> the checks in a theoretical hbind api. This is already the approach
> p2pdma takes in-kernel: we have functions that tell you if two PCI
> devices can talk to each other and we have functions to give you memory
> accessible by a set of devices. What we don't have is a special tree
> that p2pdma users have to walk through to determine accessibility.

You do not need it, but i do need it they are user out there that are
already depending on the information by getting it through non standard
way. I do want to provide a standard way for userspace to get this.
They are real user out there and i believe their would be more user
if we had a standard way to provide it. You do not believe in it fine.
I will do more work in userspace and more example and i will come back
with more hard evidence until i convince enough people.

> 
> In my eye's, you are just conflating a bunch of different issues that
> are better solved independently in the existing frameworks we have. And
> if they were tackled individually, you'd have a much easier time getting
> them merged one by one.

I don't think i can convince you otherwise. They are user that use topology
please looks at the links i provided, those folks have running program
_today_ they rely on non standard API and would like to move toward standard
API it would improve their life.

On top of that i argue that more people would use that information if it
were available to them. I agree that i have no hard evidence to back that
up and that it is just a feeling but you can not disprove me either as
this is a chicken and egg problem, you can not prove people will not use
an API if the API is not there to be use.

Cheers,
Jérôme
