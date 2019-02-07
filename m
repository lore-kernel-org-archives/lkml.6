Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E585C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FB02175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="v5W5j5qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBGCsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 21:48:31 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44330 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfBGCsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 21:48:30 -0500
Received: by mail-ot1-f46.google.com with SMTP id e24so6525440otp.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 18:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1gfzfUI9BE0fAwOfXXQyL9WoxcMnzqN0DkgLCe8v/4=;
        b=v5W5j5qRfGbhnpQve2Z6iJunE7ux98b4KIYF8viNI4KQwF9TOOnUr3ZR7jS6SP0Tpz
         s8WCvWE+hD7y+UQmg2GPEVh3uC/qek6B4BN6omMyKvu/J2SI0r+3JVgL573ELXy0t+lQ
         5s0o7SrutnzM3tEFqld2te87jGnQWKpi01oKQnxeoajrAe6lEMXFKjLqZEPm4ZCGMJYT
         ooHNkORg17gyjYN+WoIo0Ny4/h4bEG1ozw9S3orIPCuoKRH3Hsp2FrZ1fifkzv66yoN0
         8l7c6svrwcr/CGhewZ2YH5SrJLwSYqVMAhXPa0QiK+DY0s+137eyziz56Z41qVMwXs1h
         bNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1gfzfUI9BE0fAwOfXXQyL9WoxcMnzqN0DkgLCe8v/4=;
        b=i9bcUpuCt12KYlPywfZEHSJ6la7tRTAsGT9J52sbCukebwNK7or86+uPhWQxGhmlEK
         blkD6hgYDPssNeFCP/w8rSZJzE4ssVbyLth9eFilq2haO/UD5eCN8/b/gXTrYmVWLzvR
         T9APZz+A8mQ/4g0d9YOW1qRIynrXiPHG2AMiOo2AovVkNgrDjyKk1e6AXiljw0aj25vZ
         rvBhV6EkA6tjVAlDtAWk7Fqh5LDsK5ubDN+KznWwttjLfL+N8vkiXX1I9DhmRb47qyjx
         w5/mMK7kSr59/14w5U6jVcomgfUNqtGeUhRb8QJXm6KnosKR7cquD9ldINO9glVnLd4w
         2fcA==
X-Gm-Message-State: AHQUAuZZ0VrqMYgWBGkk2AgBoT2TQbAq4bZpMZVQFDcwGOF85B7NZ9RC
        6lSZ8PNTmSwJKXf6RchccF9yvBgGAreK/xPf58NtoA==
X-Google-Smtp-Source: AHgI3IYHdPDAfXO42UmaIzX1oz8WtVXjlhhrABCRynQ0OiT8MNXsNAJzAdRff2iHvJIptHd2Vf4LciWVb1NliENIU4Q=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr7512480oti.367.1549507709581;
 Wed, 06 Feb 2019 18:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com> <645c5e11b28ff10d354ae17ed3016bc895c9028b.camel@redhat.com>
In-Reply-To: <645c5e11b28ff10d354ae17ed3016bc895c9028b.camel@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Feb 2019 18:48:18 -0800
Message-ID: <CAPcyv4i-sW9gu4nrRvvb24=uAUQms9=+Yx5=EQSj+CxpmoNkSw@mail.gmail.com>
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
        Michal Hocko <mhocko@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 5:57 PM Doug Ledford <dledford@redhat.com> wrote:
[..]
> > > > Dave, you said the FS is responsible to arbitrate access to the
> > > > physical pages..
> > > >
> > > > Is it possible to have a filesystem for DAX that is more suited to
> > > > this environment? Ie designed to not require block reallocation (no
> > > > COW, no reflinks, different approach to ftruncate, etc)
> > >
> > > Can someone give me a real world scenario that someone is *actually*
> > > asking for with this?
> >
> > I'll point to this example. At the 6:35 mark Kodi talks about the
> > Oracle use case for DAX + RDMA.
> >
> > https://youtu.be/ywKPPIE8JfQ?t=395
>
> Thanks for the link, I'll review the panel.
>
> > Currently the only way to get this to work is to use ODP capable
> > hardware, or Device-DAX. Device-DAX is a facility to map persistent
> > memory statically through device-file. It's great for statically
> > allocated use cases, but loses all the nice things (provisioning,
> > permissions, naming) that a filesystem gives you. This debate is what
> > to do about non-ODP capable hardware and Filesystem-DAX facility. The
> > current answer is "no RDMA for you".
> >
> > > Are DAX users demanding xfs, or is it just the
> > > filesystem of convenience?
> >
> > xfs is the only Linux filesystem that supports DAX and reflink.
>
> Is it going to be clear from the link above why reflink + DAX + RDMA is
> a good/desirable thing?
>

No, unfortunately it will only clarify the DAX + RDMA use case, but
you don't need to look very far to see that the trend for storage
management is more COW / reflink / thin-provisioning etc in more
places. Users want the flexibility to be able delay, change, and
consolidate physical storage allocation decisions, otherwise
device-dax would have solved all these problems and we would not be
having this conversation.

> > > Do they need to stick with xfs?
> >
> > Can you clarify the motivation for that question?
>
> I did a little googling and research before I asked that question.
> According to the documentation, other FSes can work with DAX too (namely
> ext2 and ext4).  The question was more or less pondering whether or not
> ext2 or ext4 + RDMA + DAX would solve people's problems without the
> issues that xfs brings.

No, ext4 also supports hole punch, and the ext2 support is a toy. We
went through quite a bit of work to solve this problem for the
O_DIRECT pinned page case.

6b2bb7265f0b sched/wait: Introduce wait_var_event()
d6dc57e251a4 xfs, dax: introduce xfs_break_dax_layouts()
69eb5fa10eb2 xfs: prepare xfs_break_layouts() for another layout type
c63a8eae63d3 xfs: prepare xfs_break_layouts() to be called with
XFS_MMAPLOCK_EXCL
5fac7408d828 mm, fs, dax: handle layout changes to pinned dax mappings
b1f382178d15 ext4: close race between direct IO and ext4_break_layouts()
430657b6be89 ext4: handle layout changes to pinned DAX mappings
cdbf8897cb09 dax: dax_layout_busy_page() warn on !exceptional

So the fs is prepared to notify RDMA applications of the need to
evacuate a mapping (layout change), and the timeout to respond to that
notification can be configured by the administrator. The debate is
about what to do when the platform owner needs to get a mapping out of
the way in bounded time.

> >  This problem exists
> > for any filesystem that implements an mmap that where the physical
> > page backing the mapping is identical to the physical storage location
> > for the file data. I don't see it as an xfs specific problem. Rather,
> > xfs is taking the lead in this space because it has already deployed
> > and demonstrated that leases work for the pnfs4 block-server case, so
> > it seems logical to attempt to extend that case for non-ODP-RDMA.
> >
> > > Are they
> > > really trying to do COW backed mappings for the RDMA targets?  Or do
> > > they want a COW backed FS but are perfectly happy if the specific RDMA
> > > targets are *not* COW and are statically allocated?
> >
> > I would expect the COW to be broken at registration time. Only ODP
> > could possibly support reflink + RDMA. So I think this devolves the
> > problem back to just the "what to do about truncate/punch-hole"
> > problem in the specific case of non-ODP hardware combined with the
> > Filesystem-DAX facility.
>
> If that's the case, then we are back to EBUSY *could* work (despite the
> objections made so far).

I linked it in my response to Jason [1], but the entire reason ext2,
ext4, and xfs scream "experimental" when DAX is enabled is because DAX
makes typical flows fail that used to work in the page-cache backed
mmap case. The failure of a data space management command like
fallocate(punch_hole) is more risky than just not allowing the memory
registration to happen in the first place. Leases result in a system
that has a chance at making forward progress.

The current state of disallowing RDMA for FS-DAX is one of the "if
(dax) goto fail;" conditions that needs to be solved before filesystem
developers graduate DAX from experimental status.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-February/019884.html
