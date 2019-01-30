Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B619C282C7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2182175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zkMOIG0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfA3CdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:33:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35200 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfA3CdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:33:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id v6so18037074oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 18:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DFk4DyEvclK+8w2TnSvj0LqgeUXFJr8aVANymRD6ZfM=;
        b=zkMOIG0vjevsi9Mv0WqU+3yNvs++6SBvK/B14pG0FHHXcbYzUeCQ3QttFBaK5rUBZ0
         Jyfx8A838fitn9Me2M7zCnpUe23jgl8gfmtB+fWUn57YMJTTq8+1lUezsWVoA7ZzJG8f
         r6Brd1sMZBX/xsaurHSYVVicYUSy3+TYN3wW4g1J26lF0o+yD93Q7z/TaF7zdpVEG6DF
         Xyx+mVKsEmoaMQj4gvUk09T7Yee66tGwb5H1B+Z1kBbL3bOktgklUoGe4JmrBFuAJ8Xj
         PBt3WMtPS4rqQ0WNsisNe9HqxVVMuld9rDGy9TIDPRZzSlfSAIfRrkBQeIR2p44E+tYf
         qv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DFk4DyEvclK+8w2TnSvj0LqgeUXFJr8aVANymRD6ZfM=;
        b=J7FkJsUgpzzag9SufjtJvANiHXCerSr1wlM1+c0Qkggid0U47ue4OcFCKr+gDc/Ldd
         kiaQi7oZarMGgBV3btYDWGkmPq7xfXnTZsjQxQHlnFziclqnhZeUlbus9+VVGlPaqBnW
         abEDh1QJxWUcLhPEK7zuI20ms/GxVhtax7DkOsaofWdmwfQuWgKT71TPY0lsw6tG9B82
         7uFYc92dd6lMAkIEQiw2Amxh1lrn+4+IKQh/WqZF4vjYg63xxrG70e1Vei9hczvQeXq6
         86TwzRhjuECXFyKsU9fY06hvKZGGGkwWVRr98V5iROYuCXJ6j1oR3YTfP+wQYC6yeQbs
         kd3A==
X-Gm-Message-State: AJcUukchlE6QlJJl8p/EEu7BM8Fyn14LSDzSyyEx9GqrQJ7rC02waCA9
        81CqEMgxsRT6L3eBYz8nXwUdIPivK+YLsgxEd4xdZQ==
X-Google-Smtp-Source: AHgI3IZp4QvEu7bsDnw9bu9Us3x/gXp2eB+1jym2+L1ygp3eKt/9CT7Qbye3IL6MOH/8+9Npp3ecTea8M8P9XeKv80M=
X-Received: by 2002:aca:b804:: with SMTP id i4mr10776538oif.280.1548815587948;
 Tue, 29 Jan 2019 18:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190129165428.3931-10-jglisse@redhat.com>
 <CAPcyv4gNtDQf0mHwhZ8g3nX6ShsjA1tx2KLU_ZzTH1Z1AeA_CA@mail.gmail.com>
 <20190129193123.GF3176@redhat.com> <CAPcyv4gkYTZ-_Et1ZriAcoHwhtPEftOt2LnR_kW+hQM5-0G4HA@mail.gmail.com>
 <20190129212150.GP3176@redhat.com>
In-Reply-To: <20190129212150.GP3176@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Jan 2019 18:32:56 -0800
Message-ID: <CAPcyv4hZMcJ6r0Pw5aJsx37+YKx4qAY0rV4Ascc9LX6eFY8GJg@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 1:21 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Jan 29, 2019 at 12:51:25PM -0800, Dan Williams wrote:
> > On Tue, Jan 29, 2019 at 11:32 AM Jerome Glisse <jglisse@redhat.com> wro=
te:
> > >
> > > On Tue, Jan 29, 2019 at 10:41:23AM -0800, Dan Williams wrote:
> > > > On Tue, Jan 29, 2019 at 8:54 AM <jglisse@redhat.com> wrote:
> > > > >
> > > > > From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > > > >
> > > > > This add support to mirror vma which is an mmap of a file which i=
s on
> > > > > a filesystem that using a DAX block device. There is no reason no=
t to
> > > > > support that case.
> > > > >
> > > >
> > > > The reason not to support it would be if it gets in the way of futu=
re
> > > > DAX development. How does this interact with MAP_SYNC? I'm also
> > > > concerned if this complicates DAX reflink support. In general I'd
> > > > rather prioritize fixing the places where DAX is broken today befor=
e
> > > > adding more cross-subsystem entanglements. The unit tests for
> > > > filesystems (xfstests) are readily accessible. How would I go about
> > > > regression testing DAX + HMM interactions?
> > >
> > > HMM mirror CPU page table so anything you do to CPU page table will
> > > be reflected to all HMM mirror user. So MAP_SYNC has no bearing here
> > > whatsoever as all HMM mirror user must do cache coherent access to
> > > range they mirror so from DAX point of view this is just _exactly_
> > > the same as CPU access.
> > >
> > > Note that you can not migrate DAX memory to GPU memory and thus for a
> > > mmap of a file on a filesystem that use a DAX block device then you c=
an
> > > not do migration to device memory. Also at this time migration of fil=
e
> > > back page is only supported for cache coherent device memory so for
> > > instance on OpenCAPI platform.
> >
> > Ok, this addresses the primary concern about maintenance burden. Thanks=
.
> >
> > However the changelog still amounts to a justification of "change
> > this, because we can". At least, that's how it reads to me. Is there
> > any positive benefit to merging this patch? Can you spell that out in
> > the changelog?
>
> There is 3 reasons for this:

Thanks for this.

>     1) Convert ODP to use HMM underneath so that we share code between
>     infiniband ODP and GPU drivers. ODP do support DAX today so i can
>     not convert ODP to HMM without also supporting DAX in HMM otherwise
>     i would regress the ODP features.
>
>     2) I expect people will be running GPGPU on computer with file that
>     use DAX and they will want to use HMM there too, in fact from user-
>     space point of view wether the file is DAX or not should only change
>     one thing ie for DAX file you will never be able to use GPU memory.
>
>     3) I want to convert as many user of GUP to HMM (already posted
>     several patchset to GPU mailing list for that and i intend to post
>     a v2 of those latter on). Using HMM avoids GUP and it will avoid
>     the GUP pin as here we abide by mmu notifier hence we do not want to
>     inhibit any of the filesystem regular operation. Some of those GPU
>     driver do allow GUP on DAX file. So again i can not regress them.

Is this really a GUP to HMM conversion, or a GUP to mmu_notifier
solution? It would be good to boil this conversion down to the base
building blocks. It seems "HMM" can mean several distinct pieces of
infrastructure. Is it possible to replace some GUP usage with an
mmu_notifier based solution without pulling in all of HMM?

> > > Bottom line is you just have to worry about the CPU page table. What
> > > ever you do there will be reflected properly. It does not add any
> > > burden to people working on DAX. Unless you want to modify CPU page
> > > table without calling mmu notifier but in that case you would not
> > > only break HMM mirror user but other thing like KVM ...
> > >
> > >
> > > For testing the issue is what do you want to test ? Do you want to te=
st
> > > that a device properly mirror some mmap of a file back by DAX ? ie
> > > device driver which use HMM mirror keep working after changes made to
> > > DAX.
> > >
> > > Or do you want to run filesystem test suite using the GPU to access
> > > mmap of the file (read or write) instead of the CPU ? In that case an=
y
> > > such test suite would need to be updated to be able to use something
> > > like OpenCL for. At this time i do not see much need for that but may=
be
> > > this is something people would like to see.
> >
> > In general, as HMM grows intercept points throughout the mm it would
> > be helpful to be able to sanity check the implementation.
>
> I usualy use a combination of simple OpenCL programs and hand tailor dire=
ct
> ioctl hack to force specific code path to happen. I should probably creat=
e
> a repository with a set of OpenCL tests so that other can also use them.
> I need to clean those up into something not too ugly so i am not ashame
> of them.

That would be great, even it is messy.

> Also at this time the OpenCL bits are not in any distro, most of the bits
> are in mesa and Karol and others are doing a great jobs at polishing thin=
gs
> and getting all the bits in. I do expect that in couple months the mainli=
ne
> of all projects (LLVM, Mesa, libdrm, ...) will have all the bits and then=
 it
> will trickle down to your favorite distribution (assuming they build mesa
> with OpenCL enabled).

Ok.
