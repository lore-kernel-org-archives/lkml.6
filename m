Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24D3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE74218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="QIuW9LI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfBFXal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:30:41 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44282 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBFXak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:30:40 -0500
Received: by mail-ot1-f41.google.com with SMTP id e24so5863281otp.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 15:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3b2MLi3MjpOPd5FBKE6OQ6jKVHgNeTR55d4ovo7XUQ=;
        b=QIuW9LI2AF2eWV3QLOhh/BbiJpeQBnZY6Fw1hbYkrfntghjEMg8J74FTfr3VGzkYwL
         tkBFB7QL04yqglF2EwKpiKRIkhgzqNXys8EkhZR3x1V7umOgeOCdkYq/dfIwVeCRf6TY
         GKWpOh6Jbw9MsTEcXtRuEybTalW8tangzSPI6EhzMHBbQdq+xRfdbTTRLFquF612HFCX
         Bu8KF7weUROBMdBc8JKyBoU91fhxlXg+DzUr5p2uBa+I6GyDLj5VgFHD0Iqkgeos1gX2
         GETWMRpFRGZQW0zS1OEBpZJwHuEDQXuNzHnUgHu9df5srbrJJDIGWqukdc9uVLMZ+bHM
         nu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3b2MLi3MjpOPd5FBKE6OQ6jKVHgNeTR55d4ovo7XUQ=;
        b=BF2TA1bmApgq3br3pR6JxVFXQ8UA3reosM1okiBpGqvJ2cePyS2ypnqK9rxmYxA0LS
         X9ChsWKKEw8elY367vLPNaxLxMfNBkMlsqoiMj6WJ5rpjaBnu97j23fRuC6DYFIoxdJ9
         e1K+AKhb4wvRbRMUAYH5m6ZpDYffNqjANYjKsiWg1xBZCR9/xgiMp2CWv9tvEUr0Xx/h
         pQeS39yuI7IFfq850eZwgVYetU7x4V/FXd0Qv2Iz8GZQl6+0hc7B1hkxhxNFo0QK2U2b
         JJnL3WxbCPw9R34DolpVZYys7yV3lVvHaNZLK1FE5FMFtYK/dxlGYK5uFl0Z7uOdtpH0
         94JQ==
X-Gm-Message-State: AHQUAuaLcIGhqSpwRSkJ4Z0eH07zgCy6opgN/HRgghsfafz/fSQc6P+x
        xReEWd6lK00TZT+a2YcKgzXC2LWpe/6fw4tb9fy9cg==
X-Google-Smtp-Source: AHgI3IayjFYRZY3pSXkyZVgC3dGVYY9+g7blthD7FrC9+B+OiT/qR4rquAdDecTZD2PeFpTHuQXbZDc47JNrCDAjntk=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr7268168otn.214.1549495839552;
 Wed, 06 Feb 2019 15:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com> <20190206232130.GK12227@ziepe.ca>
In-Reply-To: <20190206232130.GK12227@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Feb 2019 15:30:27 -0800
Message-ID: <CAPcyv4g2r=L3jfSDoRPt4VG7D_2CxCgv3s+JLu4FQRUSRWg+4Q@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
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

On Wed, Feb 6, 2019 at 3:21 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Feb 06, 2019 at 02:44:45PM -0800, Dan Williams wrote:
>
> > > Do they need to stick with xfs?
> >
> > Can you clarify the motivation for that question? This problem exists
> > for any filesystem that implements an mmap that where the physical
> > page backing the mapping is identical to the physical storage location
> > for the file data.
>
> .. and needs to dynamicaly change that mapping. Which is not really
> something inherent to the general idea of a filesystem. A file system
> that had *strictly static* block assignments would work fine.
>
> Not all filesystem even implement hole punch.
>
> Not all filesystem implement reflink.
>
> ftruncate doesn't *have* to instantly return the free blocks to
> allocation pool.
>
> ie this is not a DAX & RDMA issue but a XFS & RDMA issue.
>
> Replacing XFS is probably not be reasonable, but I wonder if a XFS--
> operating mode could exist that had enough features removed to be
> safe?

You're describing the current situation, i.e. Linux already implements
this, it's called Device-DAX and some users of RDMA find it
insufficient. The choices are to continue to tell them "no", or say
"yes, but you need to submit to lease coordination".

> Ie turn off REFLINK. Change the semantic of ftruncate to be more like
> ETXTBUSY. Turn off hole punch.
>
> > > Are they really trying to do COW backed mappings for the RDMA
> > > targets?  Or do they want a COW backed FS but are perfectly happy
> > > if the specific RDMA targets are *not* COW and are statically
> > > allocated?
> >
> > I would expect the COW to be broken at registration time. Only ODP
> > could possibly support reflink + RDMA. So I think this devolves the
> > problem back to just the "what to do about truncate/punch-hole"
> > problem in the specific case of non-ODP hardware combined with the
> > Filesystem-DAX facility.
>
> Usually the problem with COW is that you make a READ RDMA MR and on a
> COW'd file, and some other thread breaks the COW..
>
> This probably becomes a problem if the same process that has the MR
> triggers a COW break (ie by writing to the CPU mmap). This would cause
> the page to be reassigned but the MR would not be updated, which is
> not what the app expects.
>
> WRITE is simpler, once the COW is broken during GUP, the pages cannot
> be COW'd again until the DMA pin is released. So new reflinks would be
> blocked during the DMA pin period.
>
> To fix READ you'd have to treat it like WRITE and break the COW at GPU.

Right, that's what I'm proposing that any longterm-GUP break COW as if
it were a write.
