Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B54C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AF22133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AF22133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeLESdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:33:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeLESdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:33:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3864B30014AD;
        Wed,  5 Dec 2018 18:33:19 +0000 (UTC)
Received: from redhat.com (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2328D60BEE;
        Wed,  5 Dec 2018 18:33:17 +0000 (UTC)
Date:   Wed, 5 Dec 2018 13:33:15 -0500
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
Message-ID: <20181205183314.GJ3536@redhat.com>
References: <20181204205902.GM2937@redhat.com>
 <e4d8bf6b-5b2c-58a5-577b-66d02f2342c1@deltatee.com>
 <20181204215146.GO2937@redhat.com>
 <c5cf87e8-9104-c2e6-9646-188f66fec581@deltatee.com>
 <20181204235630.GQ2937@redhat.com>
 <b77849e1-e05a-1071-7c48-ac93191e3134@deltatee.com>
 <20181205023116.GD3045@redhat.com>
 <a5ae63ff-a913-25af-4648-4ebf91775412@deltatee.com>
 <20181205180756.GI3536@redhat.com>
 <e5c740fd-0256-8b70-cd06-6d6fee19806d@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5c740fd-0256-8b70-cd06-6d6fee19806d@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 05 Dec 2018 18:33:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:20:30AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-12-05 11:07 a.m., Jerome Glisse wrote:
> >> Well multiple links are easy when you have a 'link' bus. Just add
> >> another link device under the bus.
> > 
> > So you are telling do what i am doing in this patchset but not under
> > HMS directory ?
> 
> No, it's completely different. I'm talking about creating a bus to
> describe only the real hardware that links GPUs. Not creating a new
> virtual tree containing a bunch of duplicate bus and device information
> that already exists currently in sysfs.
> 
> >>
> >> Technically, the accessibility issue is already encoded in sysfs. For
> >> example, through the PCI tree you can determine which ACS bits are set
> >> and determine which devices are behind the same root bridge the same way
> >> we do in the kernel p2pdma subsystem. This is all bus specific which is
> >> fine, but if we want to change that, we should have a common way for
> >> existing buses to describe these attributes in the existing tree. The
> >> new 'link' bus devices would have to have some way to describe cases if
> >> memory isn't accessible in some way across it.
> > 
> > What i am looking at is much more complex than just access bit. It
> > is a whole set of properties attach to each path (can it be cache
> > coherent ? can it do atomic ? what is the access granularity ? what
> > is the bandwidth ? is it dedicated link ? ...)
> 
> I'm not talking about just an access bit. I'm talking about what you are
> describing: standard ways for *existing* buses in the sysfs hierarchy to
> describe things like cache coherency, atomics, granularity, etc without
> creating a new hierarchy.
> 
> > On top of that i argue that more people would use that information if it
> > were available to them. I agree that i have no hard evidence to back that
> > up and that it is just a feeling but you can not disprove me either as
> > this is a chicken and egg problem, you can not prove people will not use
> > an API if the API is not there to be use.
> 
> And you miss my point that much of this information is already available
> to them. And more can be added in the existing framework without
> creating any brand new concepts. I haven't said anything about
> chicken-and-egg problems -- I've given you a bunch of different
> suggestions to split this up into more managable problems and address
> many of them within the APIs and frameworks we have already.

The thing is that what i am considering is not in sysfs, it does not
even have linux kernel driver, it is just chips that connect device
between them and there is nothing to do with those chips it is all
hardware they do not need a driver. So there is nothing existing that
address what i need to represent.

If i add a a fake driver for those what would i do ? under which
sub-system i register them ? How i express the fact that they
connect device X,Y and Z with some properties ?

This is not PCIE ... you can not discover bridges and child, it
not a tree like structure, it is a random graph (which depends
on how the OEM wire port on the chips).


So i have not pre-existing driver, they are not in sysfs today and
they do not need a driver. Hence why i proposed what i proposed
a sysfs hierarchy where i can add those "virtual" object and shows
how they connect existing device for which we have a sysfs directory
to symlink.


Cheers,
Jérôme
