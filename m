Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211D2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D0D206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D0D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeLDTdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:33:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbeLDTdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:33:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42C6F307D866;
        Tue,  4 Dec 2018 19:33:00 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 160C35C237;
        Tue,  4 Dec 2018 19:32:58 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:32:56 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>, balbirs@au1.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Kuehling, Felix" <felix.kuehling@amd.com>, Philip.Yang@amd.com,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Blinzer, Paul" <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>, rcampbell@nvidia.com
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS)
 documentation
Message-ID: <20181204193256.GH2937@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <20181203233509.20671-3-jglisse@redhat.com>
 <875zw98bm4.fsf@linux.intel.com>
 <20181204182421.GC2937@redhat.com>
 <CAPcyv4gtv7eUc1_3Yhz-f-B3Lct=Vq7zqUJKOqCtWYb4BS6i9g@mail.gmail.com>
 <20181204185725.GE2937@redhat.com>
 <CAPcyv4iddjvOvdRRRMrD5RtrVzLB13cPATbpE52ZcuPWWsyx-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4iddjvOvdRRRMrD5RtrVzLB13cPATbpE52ZcuPWWsyx-w@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 04 Dec 2018 19:33:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 11:19:23AM -0800, Dan Williams wrote:
> On Tue, Dec 4, 2018 at 10:58 AM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Tue, Dec 04, 2018 at 10:31:17AM -0800, Dan Williams wrote:
> > > On Tue, Dec 4, 2018 at 10:24 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > > >
> > > > On Tue, Dec 04, 2018 at 09:06:59AM -0800, Andi Kleen wrote:
> > > > > jglisse@redhat.com writes:
> > > > >
> > > > > > +
> > > > > > +To help with forward compatibility each object as a version value and
> > > > > > +it is mandatory for user space to only use target or initiator with
> > > > > > +version supported by the user space. For instance if user space only
> > > > > > +knows about what version 1 means and sees a target with version 2 then
> > > > > > +the user space must ignore that target as if it does not exist.
> > > > >
> > > > > So once v2 is introduced all applications that only support v1 break.
> > > > >
> > > > > That seems very un-Linux and will break Linus' "do not break existing
> > > > > applications" rule.
> > > > >
> > > > > The standard approach that if you add something incompatible is to
> > > > > add new field, but keep the old ones.
> > > >
> > > > No that's not how it is suppose to work. So let says it is 2018 and you
> > > > have v1 memory (like your regular main DDR memory for instance) then it
> > > > will always be expose a v1 memory.
> > > >
> > > > Fast forward 2020 and you have this new type of memory that is not cache
> > > > coherent and you want to expose this to userspace through HMS. What you
> > > > do is a kernel patch that introduce the v2 type for target and define a
> > > > set of new sysfs file to describe what v2 is. On this new computer you
> > > > report your usual main memory as v1 and your new memory as v2.
> > > >
> > > > So the application that only knew about v1 will keep using any v1 memory
> > > > on your new platform but it will not use any of the new memory v2 which
> > > > is what you want to happen. You do not have to break existing application
> > > > while allowing to add new type of memory.
> > >
> > > That sounds needlessly restrictive. Let the kernel arbitrate what
> > > memory an application gets, don't design a system where applications
> > > are hard coded to a memory type. Applications can hint, or optionally
> > > specify an override and the kernel can react accordingly.
> >
> > You do not want to randomly use non cache coherent memory inside your
> > application :)
> 
> The kernel arbitrates memory, it's a bug if it hands out something
> that exotic to an unaware application.

In some case and for some period of time some application would like
to use exotic memory for performance reasons. This does exist today.
Graphics API routinely expose uncache memory to application and it has
been doing so for many years.

Some compute folks would like to have some of the benefit of that
sometime. The idea is that you malloc() some memory in your application
do stuff on the CPU, business as usual, then you gonna use that memory
on some exotic device and for that device it would be best if you
migrated that memory to uncache/uncoherent memory. If application
knows its safe to do so then it can decide to pick such memory with
HMS and migrate its malloced stuff there.

This is not only happening in application, it can happen inside a
library that the application use and the application might be totaly
unaware of the library doing so. This is very common today in AI/ML
workload where all the various library in your AI/ML stacks do thing
to the memory you handed them over. It is all part of the library
API contract.

So they are legitimate use case for this hence why i would like to
be able to expose exotic memory to userspace so that it can migrate
regular allocation there when that make sense.

Cheers,
Jérôme
