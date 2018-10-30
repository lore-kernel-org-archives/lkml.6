Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DBAC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D082080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D082080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJ3RKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:10:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:35898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbeJ3RKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:10:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3AFCAF3F;
        Tue, 30 Oct 2018 08:17:57 +0000 (UTC)
Date:   Tue, 30 Oct 2018 09:17:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     alexander.h.duyck@linux.intel.com, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        osalvador@techadventures.net
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20181030081757.GX32673@dhcp22.suse.cz>
References: <20181029141210.GJ32673@dhcp22.suse.cz>
 <84f09883c16608ddd2ba88103f43ec6a1c649e97.camel@linux.intel.com>
 <20181029163528.GL32673@dhcp22.suse.cz>
 <18dfc5a0db11650ff31433311da32c95e19944d9.camel@linux.intel.com>
 <20181029172415.GM32673@dhcp22.suse.cz>
 <8e7a4311a240b241822945c0bb4095c9ffe5a14d.camel@linux.intel.com>
 <20181029181827.GO32673@dhcp22.suse.cz>
 <3281f3044fa231bbc1b02d5c5efca3502a0d05a8.camel@linux.intel.com>
 <20181030062915.GT32673@dhcp22.suse.cz>
 <CAPcyv4itSde5oiW2j5uK8PCqdpXkHKz=kS8NBk2Ge+Ldb=yLUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4itSde5oiW2j5uK8PCqdpXkHKz=kS8NBk2Ge+Ldb=yLUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-10-18 23:55:12, Dan Williams wrote:
> On Mon, Oct 29, 2018 at 11:29 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 29-10-18 12:59:11, Alexander Duyck wrote:
> > > On Mon, 2018-10-29 at 19:18 +0100, Michal Hocko wrote:
> [..]
> > > The patches Andrew pushed addressed the immediate issue so that now
> > > systems with nvdimm/DAX memory can at least initialize quick enough
> > > that systemd doesn't refuse to mount the root file system due to a
> > > timeout.
> >
> > This is about the first time you actually mention that. I have re-read
> > the cover letter and all changelogs of patches in this serious. Unless I
> > have missed something there is nothing about real users hitting issues
> > out there. nvdimm is still considered a toy because there is no real HW
> > users can play with.
> 
> Yes, you have missed something, because that's incorrect. There's been
> public articles about these parts sampling since May.
> 
>     https://www.anandtech.com/show/12828/intel-launches-optane-dimms-up-to-512gb-apache-pass-is-here

indeed!

> That testing identified this initialization performance problem and
> thankfully got it addressed in time for the current merge window.

And I still cannot see a word about that in changelogs.

-- 
Michal Hocko
SUSE Labs
