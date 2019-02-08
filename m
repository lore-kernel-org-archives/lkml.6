Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E80C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02BE218DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="i/4TQT+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBHUuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:50:51 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36019 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBHUuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:50:51 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so8148397otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 12:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYemvo/5t1MOtWOwE583j782fTMXN2hNeBA7xbWMF9U=;
        b=i/4TQT+fwabfyYsgo4Y5jOfGloT5rDwGaQAM9q/H5WwL1kSOYwzM/fG80v41weOUET
         yGlkmPrCpte1BDtX9n+RGFLkxO2cjNpKmlVD7cLnuhSQPIHtBVcYrCv0wF0G/F8JHdpU
         dY2XKodFBG8KVdIDKnt/xPACAh3MKMN+JNyTXuXCmeX+gsjJKmj05dvwbIbfsxwQU8iI
         4KQPyj3LrmdqJVdLR6GtQs0wgV+T6LQU8knkGBbiTxOlPDsB8BT7DgMoJFNsNqMmr6xq
         W1dNc+d9fw8jBMbCncMn3ZMSjaMpucCe6dRKdPaRo6VRtMPsA7gSpwVirMECn1iEtb4p
         C4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYemvo/5t1MOtWOwE583j782fTMXN2hNeBA7xbWMF9U=;
        b=rs81oLO5yWSwe/JQy3uybezPMZ//W6ewUmJ4mj5MePUqsOyH/1glfdpSiRAtA43qu+
         RpN476iKRu1p27/co+PMWPq25QGI0z5u/Yu1yteyxQC613jmtX8DDYbNESjtFv5ZSt/P
         UTPEIx63+tK30X71iwKbAawlvVfzeZGOg8nIshi6zeRMvBMmHHCT2Rbe5aHaoGJTUIqq
         45k+8Iq6CYGo7b5JUvGS3hJqOhGn0ckT5yLaJjcHDSUN1KRcRjkaE9zbnckaSOa58K6g
         bTi1E7E751jt2Ynfr7zl9mQV8UsdI3eNNOeUP/NxV2HsiOZSQyqIHh69sJZQZv/f+Xgy
         t4mg==
X-Gm-Message-State: AHQUAuZtQGwSeg6nIxNHIdu3tfXpmGa5TfPydJxxeaa3LLVEAXfLDMYZ
        D7SRxa4ZUcoYqgXuOLMqnQRDFYqRtBZghas3BJeGAg==
X-Google-Smtp-Source: AHgI3IbxNCM6UhOk1OpWVxUvg07ioYW6oEVU3RYmPPPgAPOzHZ5LzJxfPbfmWzPOBTLnXOjr7fkjaTid6gn1yz3bEHM=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr6527340otq.353.1549659050034;
 Fri, 08 Feb 2019 12:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard> <20190208111028.GD6353@quack2.suse.cz>
In-Reply-To: <20190208111028.GD6353@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 8 Feb 2019 12:50:37 -0800
Message-ID: <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 3:11 AM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 08-02-19 15:43:02, Dave Chinner wrote:
> > On Thu, Feb 07, 2019 at 04:55:37PM +0000, Christopher Lameter wrote:
> > > One approach that may be a clean way to solve this:
> > > 3. Filesystems that allow bypass of the page cache (like XFS / DAX) will
> > >    provide the virtual mapping when the PIN is done and DO NO OPERATIONS
> > >    on the longterm pinned range until the long term pin is removed.
> >
> > So, ummm, how do we do block allocation then, which is done on
> > demand during writes?
> >
> > IOWs, this requires the application to set up the file in the
> > correct state for the filesystem to lock it down so somebody else
> > can write to it.  That means the file can't be sparse, it can't be
> > preallocated (i.e. can't contain unwritten extents), it must have zeroes
> > written to it's full size before being shared because otherwise it
> > exposes stale data to the remote client (secure sites are going to
> > love that!), they can't be extended, etc.
> >
> > IOWs, once the file is prepped and leased out for RDMA, it becomes
> > an immutable for the purposes of local access.
> >
> > Which, essentially we can already do. Prep the file, map it
> > read/write, mark it immutable, then pin it via the longterm gup
> > interface which can do the necessary checks.
>
> Hum, and what will you do if the immutable file that is target for RDMA
> will be a source of reflink? That seems to be currently allowed for
> immutable files but RDMA store would be effectively corrupting the data of
> the target inode. But we could treat it similarly as swapfiles - those also
> have to deal with writes to blocks beyond filesystem control. In fact the
> similarity seems to be quite large there. What do you think?

This sounds so familiar...

    https://lwn.net/Articles/726481/

I'm not opposed to trying again, but leases was what crawled out
smoking crater when this last proposal was nuked.
