Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592D1C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184D3217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PczSozFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfBDQ7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:59:18 -0500
Received: from a9-35.smtp-out.amazonses.com ([54.240.9.35]:35860 "EHLO
        a9-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727057AbfBDQ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549299557;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=dFVSi6eAG6s4EOjNzfgj7jQYa7+0xeruK9bRGAAvn/0=;
        b=PczSozFFqeRL7X+LTVq/x4SUbvHWdcH7f444zjDojJHuUSurhYyjMpazh91nqYfc
        IaVvmvTRYQS6v/LqWHm6LnWzaz3MZ89JxulkbSfH0GWidNhdvPRq1ddxLuTj2iYqGSM
        lkgO3lvUPBKUvTT6vy7WFXpTOY6Rt2jkSXfkysN8=
Date:   Mon, 4 Feb 2019 16:59:17 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Christoph Hellwig <hch@infradead.org>
cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/6] RFC v2: mm: gup/dma tracking
In-Reply-To: <20190204161201.GA6840@infradead.org>
Message-ID: <01000168b97322ff-7c681a52-566f-4de1-ba1e-0a045b7f3622-000000@email.amazonses.com>
References: <20190204052135.25784-1-jhubbard@nvidia.com> <01000168b94439c0-28d5e096-718d-4e39-a7af-20d0a6d7b768-000000@email.amazonses.com> <20190204161201.GA6840@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.04-54.240.9.35
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019, Christoph Hellwig wrote:

> On Mon, Feb 04, 2019 at 04:08:02PM +0000, Christopher Lameter wrote:
> > It may be worth noting a couple of times in this text that this was
> > designed for anonymous memory and that such use is/was ok. We are talking
> > about a use case here using mmapped access with a regular filesystem that
> > was not initially intended. The mmapping of from the hugepages filesystem
> > is special in that it is not a device that is actually writing things
> > back.
> >
> > Any use with a filesystem that actually writes data back to a medium
> > is something that is broken.
>
> Saying it was not intended seems rather odd, as it was supported
> since day 0 and people made use of it.

Well until last year I never thought there was a problem because I
considered it separate from regular filesystem I/O.




