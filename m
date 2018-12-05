Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522A2C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09758205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09758205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbeLEXUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:20:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbeLEXUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:20:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF90D308429A;
        Wed,  5 Dec 2018 23:20:32 +0000 (UTC)
Received: from redhat.com (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABDC06109E;
        Wed,  5 Dec 2018 23:20:30 +0000 (UTC)
Date:   Wed, 5 Dec 2018 18:20:28 -0500
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
Message-ID: <20181205232028.GO3536@redhat.com>
References: <20181205023116.GD3045@redhat.com>
 <a5ae63ff-a913-25af-4648-4ebf91775412@deltatee.com>
 <20181205180756.GI3536@redhat.com>
 <e5c740fd-0256-8b70-cd06-6d6fee19806d@deltatee.com>
 <20181205183314.GJ3536@redhat.com>
 <0ddb2620-ecbd-4b7b-aeb7-3f4ae7746e83@deltatee.com>
 <20181205185550.GK3536@redhat.com>
 <7ab26ea6-d16d-8d71-78ca-4266a864f8d3@deltatee.com>
 <20181205225828.GL3536@redhat.com>
 <a0240f08-68ab-5167-c2c7-2f930aa0a54b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0240f08-68ab-5167-c2c7-2f930aa0a54b@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 05 Dec 2018 23:20:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:09:29PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-12-05 3:58 p.m., Jerome Glisse wrote:
> > So just to be clear here is how i understand your position:
> > "Single coherent sysfs hierarchy to describe something is useless
> >  let's git rm drivers/base/"
> 
> I have no idea what you're talking about. I'm saying the existing sysfs
> hierarchy *should* be used for this application -- we shouldn't be
> creating another hierarchy.
> 
> > While i am arguing that "hey the /sys/bus/node/devices/* is nice
> > but it just does not cut it for all this new hardware platform
> > if i add new nodes there for my new memory i will break tons of
> > existing application. So what about a new hierarchy that allow
> > to describe those new hardware platform in a single place like
> > today node thing"
> 
> I'm talking about /sys/bus and all the bus information under there; not
> just the node hierarchy. With this information, you can figure out how
> any struct device is connected to another struct device. This has little
> to do with a hypothetical memory device and what it might expose. You're
> conflating memory devices with links between devices (ie. buses).


And my proposal is under /sys/bus and have symlink to all existing
device it agregate in there.

For device memory i explained why it does not make sense to expose
it as node. So now how do i expose it ? Yes i can expose it under
the device directory but then i can not present the properties of
that memory which depends on through which bus and through which
bridges it is accessed.

So i need bus and bridge objects so that i can express the properties
that depends on the path between the initiator and the target memory.

I argue it is better to expose all this under the same directory.
You say it is not. We NUMA as an example that shows everything under
a single hierarchy so to me you are saying it is useless and has no
value. I say the NUMA thing has value and i would like something like
it just with more stuff and with the capability of doing any kind of
graph.


I just do not see how i can achieve my objectives any differently.

I think we are just talking past each other and this is likely a
pointless conversation. I will keep working on this in the meantime.


> > No can do that is what i am trying to explain. So if i bus 1 in a
> > sub-system A and usualy that kind of bus can serve a bridge for
> > PCIE ie a CPU can access device behind it by going through a PCIE
> > device first. So now the userspace libary have this knowledge
> > bake in. Now if a platform has a bug for whatever reasons where
> > that does not hold, the kernel has no way to tell userspace that
> > there is an exception there. It is up to userspace to have a data
> > base of quirks.
> 
> > Kernel see all those objects in isolation in your scheme. While in
> > what i am proposing there is only one place and any device that
> > participate in this common place can report any quirks so that a
> > coherent view is given to user space.
> 
> The above makes no sense to me.
> 
> 
> > If we have gazillion of places where all this informations is spread
> > around than we have no way to fix weird inter-action between any
> > of those.
> 
> So work to standardize it so that all buses present a consistent view of
> what guarantees they provide for bus accesses. Quirks could then adjust
> that information for systems that may be broken.

So you agree with my proposal ? A sysfs directory in which all the
bus and how they are connected to each other and what is connected
to each of them (device, CPU, memory).

THis is really confusing.

Cheers,
Jérôme
