Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7E3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4932146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfBTXg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:36:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfBTXg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:36:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D847D308FC23;
        Wed, 20 Feb 2019 23:36:27 +0000 (UTC)
Received: from redhat.com (ovpn-120-249.rdu2.redhat.com [10.10.120.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F8F75D9D2;
        Wed, 20 Feb 2019 23:36:26 +0000 (UTC)
Date:   Wed, 20 Feb 2019 18:36:23 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Message-ID: <20190220233623.GC11325@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <0dbf7e99-7db4-4d8b-ecca-60893c83a2a9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dbf7e99-7db4-4d8b-ecca-60893c83a2a9@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 20 Feb 2019 23:36:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:17:58PM -0800, John Hubbard wrote:
> On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > This patchset improves the HMM driver API and add support for hugetlbfs
> > and DAX mirroring. The improvement motivation was to make the ODP to HMM
> > conversion easier [1]. Because we have nouveau bits schedule for 5.1 and
> > to avoid any multi-tree synchronization this patchset adds few lines of
> > inline function that wrap the existing HMM driver API to the improved
> > API. The nouveau driver was tested before and after this patchset and it
> > builds and works on both case so there is no merging issue [2]. The
> > nouveau bit are queue up for 5.1 so this is why i added those inline.
> > 
> > If this get merge in 5.1 the plans is to merge the HMM to ODP in 5.2 or
> > 5.3 if testing shows any issues (so far no issues has been found with
> > limited testing but Mellanox will be running heavier testing for longer
> > time).
> > 
> > To avoid spamming mm i would like to not cc mm on ODP or nouveau patches,
> > however if people prefer to see those on mm mailing list then i can keep
> > it cced.
> > 
> > This is also what i intend to use as a base for AMD and Intel patches
> > (v2 with more thing of some rfc which were already posted in the past).
> > 
> 
> Hi Jerome,
> 
> Although Ralph has been testing and looking at this patchset, I just now
> noticed that there hasn't been much public review of it, so I'm doing
> a bit of that now. I don't think it's *quite* too late, because we're
> still not at the 5.1 merge window...sorry for taking so long to get to
> this.
> 
> Ralph, you might want to add ACKs or Tested-by's to some of these
> patches (or even Reviewed-by, if you went that deep, which I suspect you
> did in some cases), according to what you feel comfortable with?

More eyes are always welcome, i tested with nouveau and with infinibanb
mlx5. It seemed to work properly in my testing but i might have miss-
something.

Cheers,
Jérôme
