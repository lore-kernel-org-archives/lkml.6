Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C44FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBC42081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBC42081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLDU7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:59:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeLDU7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:59:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41A7C3099FC9;
        Tue,  4 Dec 2018 20:59:06 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67FAD5C237;
        Tue,  4 Dec 2018 20:59:04 +0000 (UTC)
Date:   Tue, 4 Dec 2018 15:59:02 -0500
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
Message-ID: <20181204205902.GM2937@redhat.com>
References: <20181203233509.20671-3-jglisse@redhat.com>
 <875zw98bm4.fsf@linux.intel.com>
 <20181204182421.GC2937@redhat.com>
 <CAPcyv4gtv7eUc1_3Yhz-f-B3Lct=Vq7zqUJKOqCtWYb4BS6i9g@mail.gmail.com>
 <20181204185725.GE2937@redhat.com>
 <de7c1099-2717-6396-bf56-c4ab4085ee83@deltatee.com>
 <20181204192221.GG2937@redhat.com>
 <f759cc28-309d-930c-da7d-34144a4d5517@deltatee.com>
 <20181204201347.GK2937@redhat.com>
 <2f146730-1bf9-db75-911d-67809fc7afef@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f146730-1bf9-db75-911d-67809fc7afef@deltatee.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 04 Dec 2018 20:59:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:30:01PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-12-04 1:13 p.m., Jerome Glisse wrote:
> > You are right many are non exclusive. It is just my feeling that having
> > a mask as a file inside the target directory might be overlook by the
> > application which might start using things it should not. At same time
> > i guess if i write the userspace library that abstract this kernel API
> > then i can enforce application to properly select thing.
> 
> I think this is just evidence that this is not a good API. If the user
> has the option to just ignore things or do it wrong that's a problem
> with the API. Using a prefix for the name doesn't change that fact.

How to expose harmful memory to userspace then ? How can i expose
non cache coherent memory because yes they are application out there
that use that today and would like to be able to migrate to and from
that memory dynamicly during lifetime of the application as the data
set progress through the application processing pipeline.

They are kind of memory that violate the memory model you expect from
the architecture. This memory is still useful nonetheless and it has
other enticing properties (like bandwidth or latency). The whole point
my proposal is to allow to expose this memory in a generic way so that
application that today rely on a gazillion of device specific API can
move over to common kernel API and consolidate their memory management
on top of a common kernel layers.

The dilema i am facing is exposing this memory while avoiding the non
aware application to accidently use it just because it is there without
understanding the implication that comes with it.

If you have any idea on how to expose this to userspace in a common
API i would happily take any suggestion :) My idea is this patchset
and i agree they are many thing to improve and i have already taken
many of the suggestion given so far.


> 
> > I do not think there is a way to answer that question. I am siding on the
> > side of this API can be dumb down in userspace by a common library. So let
> > expose the topology and let userspace dumb it down.
> 
> I fundamentally disagree with this approach to designing APIs. Saying
> "we'll give you the kitchen sink, add another layer to deal with the
> complexity" is actually just eschewing API design and makes it harder
> for kernel folks to know what userspace actually requires because they
> are multiple layers away.

Note that i do not expose things like physical address or even splits
memory in a node into individual device, in fact in expose less
information that the existing NUMA (no zone, phys index, ...). As i do
not think those have any value to userspace. What matter to userspace
is where is this memory is in my topology so i can look at all the
initiators node that are close by. Or the reverse, i have a set of
initiators what is the set of closest targets to all those initiators.

I feel this is simple enough to understand for anyone. It allows to
describe any topology, a libhms can dumb it down for average application
and more advance application can use the full description. They are
example of such application today. I argue that if we provide a common
API we might see more application but i won't pretend that i know that
for a fact. I am just making assumption here.


> 
> > If we dumb it down in the kernel i see few pitfalls:
> >     - kernel dumbing it down badly
> >     - kernel dumbing down code can grow out of control with gotcha
> >       for platform
> 
> This is just a matter of designing the APIs well. Don't do it badly.

I am talking about the inevitable fact that at some point some system
firmware will miss-represent their platform. System firmware writer
usualy copy and paste thing with little regards to what have change
from one platform to the new. So their will be inevitable workaround
and i would rather see those piling up inside a userspace library than
inside the kernel.

Note that i expec that the error won't be fatal but more along the
line of reporting wrong value for bandwidth, latency, ... So kernel
will most likely unaffected by system firmware error but those will
affect the performance of application that are told innaccurate
informations.


> >     - it is still harder to fix kernel than userspace in commercial
> >       user space (the whole RHEL business of slow moving and long
> >       supported kernel). So on those being able to fix thing in
> >       userspace sounds pretty enticing
> 
> I hear this argument a lot and it's not compelling to me. I don't think
> we should make decisions in upstream code to allow RHEL to bypass the
> kernel simply because it would be easier for them to distribute code
> changes.

Ok i will not bring it up, i have suffer enough on that front so i have
a trauma on this ;)

Cheers,
Jérôme
