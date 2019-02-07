Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99637C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B97218D9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="u0M4bGcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBGDN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:13:29 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:37014 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBGDN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 22:13:29 -0500
Received: by mail-ot1-f54.google.com with SMTP id s13so15925327otq.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 19:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJGn1wJcx1sUVcnHWCYzvVKZidnL377KOH3WegpZNcw=;
        b=u0M4bGcw7Gr265bgs8lzYG+W0Y0dEUfuTw9TX/NGqjkOVFRopFhriGytmZqkOJKETt
         B0SaRMR9BDwS9/PiraQLHycM0zoXw6lBxmFN+tsxY9XYIBgGZF+yGxpHEM5lSj6ZULUQ
         FrKSDLqS65OHhHobiNFfc7nnHN2xEPX5f0vdTP9NL0RA1xgW3nuxk002aAyKJjYwvZ5w
         n1cMLnPtLOTW5A0DYCpDQv8ehw5uAgp4e7ad5SBwdKUA4CEZZGPfDVWGDQdUguazLLwF
         oOsgmSBwNWj0T5lolrQugpOKOD/3szZb00E4xzN+D4SzKHtpcdZJCgU3lqR0lvxpLf6X
         itRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJGn1wJcx1sUVcnHWCYzvVKZidnL377KOH3WegpZNcw=;
        b=enXG1hu3Us32rjceAKs60QPrLLijZVTcOiqYv8IZK2sgSaTny7hZv1lXgfgrkg9UeK
         acXtr9o1Rh3WBLmW9Goy5ztgawhfzNS9U/l2zS50EdQyBe79yx7zZSRu30BwUIwni89v
         dnDx79VAiaWWXiswTepxPzRBZwhTixrnXw3ARlE793c4jKKyP92f/NHXEw+mx3K0Yg16
         mJtrvMD3Bw9J7U94cSZIvWTXSZbEPhhDRIzkZBRKaCsTPY7kgUNxBsPpZ96v7IoSD4GA
         /limHb0bMjhXF9CbJtr1PiYto66shmUdRTr+WuWKt4INOI6FbTBseQE/XblDgX9Wijox
         27AQ==
X-Gm-Message-State: AHQUAubcm1XRowQ5YFKvCs8olXZbsdIvFKS0bhXes1u0hhVz4J3aTAuE
        Tr2uUHXwXL8gPDHxuqzE6YxCmQ5Sn297MbU8mxgYcg==
X-Google-Smtp-Source: AHgI3IZ4Co/4mgFaH7uvLWdPVlBF4hsMLOafkliShAGWpKqScvMOYlhDAzRAowMuOE1X0hGj2bPWAJglK9Uw9UPyTyg=
X-Received: by 2002:aca:240a:: with SMTP id n10mr1318891oic.73.1549509208127;
 Wed, 06 Feb 2019 19:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com> <658363f418a6585a1ffc0038b86c8e95487e8130.camel@redhat.com>
In-Reply-To: <658363f418a6585a1ffc0038b86c8e95487e8130.camel@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Feb 2019 19:13:16 -0800
Message-ID: <CAPcyv4hPmwXv6xGpyWGs-zx3xswAnzF0HGX6Kx3t=LSysDRZog@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
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

On Wed, Feb 6, 2019 at 6:42 PM Doug Ledford <dledford@redhat.com> wrote:
>
> On Wed, 2019-02-06 at 14:44 -0800, Dan Williams wrote:
> > On Wed, Feb 6, 2019 at 2:25 PM Doug Ledford <dledford@redhat.com> wrote:
> > > Can someone give me a real world scenario that someone is *actually*
> > > asking for with this?
> >
> > I'll point to this example. At the 6:35 mark Kodi talks about the
> > Oracle use case for DAX + RDMA.
> >
> > https://youtu.be/ywKPPIE8JfQ?t=395
>
> I watched this, and I see that Oracle is all sorts of excited that their
> storage machines can scale out, and they can access the storage and it
> has basically no CPU load on the storage server while performing
> millions of queries.  What I didn't hear in there is why DAX has to be
> in the picture, or why Oracle couldn't do the same thing with a simple
> memory region exported directly to the RDMA subsystem, or why reflink or
> any of the other features you talk about are needed.  So, while these
> things may legitimately be needed, this video did not tell me about
> how/why they are needed, just that RDMA is really, *really* cool for
> their use case and gets them 0% CPU utilization on their storage
> servers.  I didn't watch the whole thing though.  Do they get into that
> later on?  Do they get to that level of technical discussion, or is this
> all higher level?

They don't. The point of sharing that video was illustrating that RDMA
to persistent memory use case. That 0% cpu utilization is because the
RDMA target is not page-cache / anonymous on the storage box it's
directly to a file offset in DAX / persistent memory. A solution to
truncate lets that use case use more than just Device-DAX or ODP
capable adapters. That said, I need to let Ira jump in here because
saying layout leases solves the problem is not true, it's just the
start of potentially solving the problem. It's not clear to me what
the long tail of work looks like once the filesystem raises a
notification to the RDMA target process.
