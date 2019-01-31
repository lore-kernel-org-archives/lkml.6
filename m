Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BE9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0D52087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="PR2k4Xk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfAaFo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:44:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46408 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfAaFo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:44:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so1721916oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 21:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVfDndj6VBemYhBkReB2Uec5tndDqGkXjCOoMo2dZuw=;
        b=PR2k4Xk24Uu0hY9vI11raPfjPlpQR/1DbwvGdcqc9Ji235UUD02vPNRnnfbV1ewGqF
         pfG2x7fyuQRyAG/KlFrk3UuVA7jEWPvGuLSqm94wBx5OoWlt8fmSQmVb7S5LLVt+zq+M
         yPq+uhM4RNb25S7qyojwqQoY7ITU/TeEUiZOKtMAvz7XxaD0XXbYRa56bEdMbrxbQqug
         6VU1aC0ec7ydUH4LONZmN+L9aXCqBYOZ32eAZEzdtmyXGm3nmGkgTZbhrsGFKwnLhT6W
         qK9MEuI5gu1iYroCBKq/4y2slXff32YcFTpmCJNlgMeyazl+lkCTbB8E2/IVNIA81QVC
         DouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVfDndj6VBemYhBkReB2Uec5tndDqGkXjCOoMo2dZuw=;
        b=E2sfo9fYMYc3Ii4srEemsMtllsImGv05hjYVPMzRj2Gp93w3KWffUw69u4LiSZ8+uX
         Mth0w7fYcTF8lzVeru9YKdkbccm3TyR9w2qal+YXh2nXm0Vk+802gE3t7MFQ6iXxVMbn
         7010+w1TMr/Ib1TfNhchgZiaN7457WsH1w1xn2F8v7URNZeW4ZBsrEfriNeVbS2woPug
         k4W62pgD6dhe6ymdk0PXVF2PtdMmkPC7L8xA5oBrOO9CcBINZX6dF53MvfjGHPWFgovc
         2tkdHDl+j0iFzLJ/czGsW2WeSQukfgK+S9jpxE8fXB37yJlDAeODPpn6tb39P7EnGzyL
         85ww==
X-Gm-Message-State: AHQUAuaqHZp6j5DdGbPyMB41y6y76Ofqsk/7uu83IIzVGHNM1XJLUFwl
        iRlsnphiK4M00+4KEyHVxuvsOVm8stX9njP7W+F87g==
X-Google-Smtp-Source: AHgI3IbT1tV5Ek4hn71MgwttuV/sQt+vNX3jhl11o5tP1/xzowAV9Sz3tedqeKSjtRCjW8TBufjcOWZ+uGIbDEQGz0g=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr14845265oih.244.1548913498259;
 Wed, 30 Jan 2019 21:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20190129165428.3931-10-jglisse@redhat.com> <CAPcyv4gNtDQf0mHwhZ8g3nX6ShsjA1tx2KLU_ZzTH1Z1AeA_CA@mail.gmail.com>
 <20190129193123.GF3176@redhat.com> <CAPcyv4gkYTZ-_Et1ZriAcoHwhtPEftOt2LnR_kW+hQM5-0G4HA@mail.gmail.com>
 <20190129212150.GP3176@redhat.com> <CAPcyv4hZMcJ6r0Pw5aJsx37+YKx4qAY0rV4Ascc9LX6eFY8GJg@mail.gmail.com>
 <20190130030317.GC10462@redhat.com> <CAPcyv4jS7Y=DLOjRHbdRfwBEpxe_r7wpv0ixTGmL7kL_ThaQFA@mail.gmail.com>
 <20190130183616.GB5061@redhat.com> <CAPcyv4hB4p6po1+-hJ4Podxoan35w+T6uZJzqbw=zvj5XdeNVQ@mail.gmail.com>
 <20190131041641.GK5061@redhat.com>
In-Reply-To: <20190131041641.GK5061@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 30 Jan 2019 21:44:46 -0800
Message-ID: <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 8:17 PM Jerome Glisse <jglisse@redhat.com> wrote:
> On Wed, Jan 30, 2019 at 07:28:12PM -0800, Dan Williams wrote:
[..]
> > > Again HMM API can evolve, i am happy to help with any such change, given
> > > it provides benefit to either mm or device driver (ie changing the HMM
> > > just for the sake of changing the HMM API would not make much sense to
> > > me).
> > >
> > > So if after converting driver A, B and C we see that it would be nicer
> > > to change HMM in someway then i will definitly do that and this patchset
> > > is a testimony of that. Converting ODP to use HMM is easier after this
> > > patchset and this patchset changes the HMM API. I will be updating the
> > > nouveau driver to the new API and use the new API for the other driver
> > > patchset i am working on.
> > >
> > > If i bump again into something that would be better done any differently
> > > i will definitly change the HMM API and update all upstream driver
> > > accordingly.
> > >
> > > I am a strong believer in full freedom for internal kernel API changes
> > > and my intention have always been to help and facilitate such process.
> > > I am sorry this was unclear to any body :( and i am hopping that this
> > > email make my intention clear.''
> >
> > A simple way to ensure that out-of-tree consumers don't come beat us
> > up over a backwards incompatible HMM change is to mark all the exports
> > with _GPL. I'm not requiring that, the devm_memremap_pages() fight was
> > hard enough, but the pace of new exports vs arrival of consumers for
> > those exports has me worried that this arrangement will fall over at
> > some point.
>
> I was reluctant with the devm_memremap_pages() GPL changes because i
> think we should not change symbol export after an initial choice have
> been made on those.
>
> I don't think GPL or non GPL export change one bit in respect to out
> of tree user. They know they can not make any legitimate regression
> claim, nor should we care. So i fail to see how GPL export would make
> it any different.

It does matter. It's a perennial fight. For a recent example see the
discussion around: "x86/fpu: Don't export __kernel_fpu_{begin,end}()".
If you're not sure you can keep an api trivially stable it should have
a GPL export to minimize the exposure surface of out-of-tree users
that might grow attached to it.

>
> > Another way to help allay these worries is commit to no new exports
> > without in-tree users. In general, that should go without saying for
> > any core changes for new or future hardware.
>
> I always intend to have an upstream user the issue is that the device
> driver tree and the mm tree move a different pace and there is always
> a chicken and egg problem. I do not think Andrew wants to have to
> merge driver patches through its tree, nor Linus want to have to merge
> drivers and mm trees in specific order. So it is easier to introduce
> mm change in one release and driver change in the next. This is what
> i am doing with ODP. Adding things necessary in 5.1 and working with
> Mellanox to have the ODP HMM patch fully tested and ready to go in
> 5.2 (the patch is available today and Mellanox have begin testing it
> AFAIK). So this is the guideline i will be following. Post mm bits
> with driver patches, push to merge mm bits one release and have the
> driver bits in the next. I do hope this sound fine to everyone.

The track record to date has not been "merge HMM patch in one release
and merge the driver updates the next". If that is the plan going
forward that's great, and I do appreciate that this set came with
driver changes, and maintain hope the existing exports don't go
user-less for too much longer.

> It is also easier for the driver folks as then they do not need to
> have a special tree just to test my changes. They can integrate it
> in their regular workflow ie merge the new kernel release in their
> tree and then start pilling up changes to their driver for the next
> kernel release.

Everyone agrees that coordinating cross-tree updates is hard, but it's
managaeble. HMM as far I can see is taking an unprecedented approach
to early merging of core infrastructure.
