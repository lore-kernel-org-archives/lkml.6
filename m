Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C5DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1906720665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1906720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeJXBZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:25:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:44674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727758AbeJXBZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:25:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34C92AF8E;
        Tue, 23 Oct 2018 17:01:39 +0000 (UTC)
Date:   Tue, 23 Oct 2018 19:01:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/7] mm, devm_memremap_pages: Mark
 devm_memremap_pages() EXPORT_SYMBOL_GPL
Message-ID: <20181023170136.GV18839@dhcp22.suse.cz>
References: <153936657159.1198040.4489957977352276272.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153936657702.1198040.119388737535638846.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181017081753.GG18839@dhcp22.suse.cz>
 <CAPcyv4hMFQYekvZWMzKYckuVLSGd3GizRtoDudFBQj5bfxD3Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hMFQYekvZWMzKYckuVLSGd3GizRtoDudFBQj5bfxD3Mw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-10-18 09:30:58, Dan Williams wrote:
> On Wed, Oct 17, 2018 at 1:18 AM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > > Again, devm_memremap_pagex() exposes and relies upon core kernel
> > > internal assumptions and will continue to evolve along with 'struct
> > > page', memory hotplug, and support for new memory types / topologies.
> > > Only an in-kernel GPL-only driver is expected to keep up with this
> > > ongoing evolution. This interface, and functionality derived from this
> > > interface, is not suitable for kernel-external drivers.
> >
> > I do not follow this line of argumentation though. We generally do not
> > care about out-of-tree modules and breaking them if the interface has to
> > be updated.
> 
> Exactly right. The EXPORT_SYMBOL_GPL is there to say that this api has
> deep enough ties into the core kernel to lower the confidence that the
> API will stay stable from one kernel revision to the next. It's also
> an api that is attracting widening and varied reuse and the long term
> health of the implementation depends on being able to peer deeply into
> its users and refactor the interface and the core kernel as a result.

I am sorry I do not follow. For in-tree modules you have to update users
whether the export is GPL or not and we do not care _at all_ about out
of tree because we do not guarantee _any_ kABI/API stability
(Documentation/process/stable-api-nonsense.rst).

Anyway, I do not really care much, but I find the way of the
argumentation dubious. I can clearly understand a simple line "me as the
author want this GPL - live with that".
-- 
Michal Hocko
SUSE Labs
