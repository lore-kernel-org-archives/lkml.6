Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B05C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B436B2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ob+cFF2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfBVRMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:12:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38430 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVRMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:12:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id m1so2476557otf.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCy2TmrFrn4FdoGZB4ffQHIWsmcBtIU1to+2B1lop8k=;
        b=ob+cFF2IiGDD3i3c+AWY8o2klmU+SaeSrFvlZgghTkfRkxp9Cw5oItRHWEkV+n8Rx8
         KN19QrxBwdMhiI4ylHSFD7TzjnfQYi1AjhgslFOvr91JxCZ02+9vFa+u5bCx/RrVxjq6
         x5k1rfdWHHHIvzA7eASgGq259HUmF1DbZFGpRcCVx+WEUpltaRQAg6FpJlPtDya2HiGa
         oJhAJ0I2wYHYDDfKA9zLXmSNKattz+WiUMjhmEzzGLpq8CMDl09SN1Jskj7y3vpXyg6T
         riv7J3uLpjU4voMyVI5y4TD3L+BEnsRqqW9W/zkn3Rx+sL9CPv+Fx86lYjxhEZOYJRt0
         FOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCy2TmrFrn4FdoGZB4ffQHIWsmcBtIU1to+2B1lop8k=;
        b=KeMaRlW+ixWxfQn8Q0ukpqA6crjS9NO2+ihMm+PMnSgdmiDofcg+pFhcEboNXso9B6
         LepNC/sIOoSKZT3wUep8CYbnMIZ2e3tBVMWK7RQ3EE2erna6tlUaQD6lnDbBD2DeBuqW
         bEbTgrLrAXb3uDFRmtBM/cJh5DB3c+ofliFWu4UWXA5qaQ2F2l/n6oEti8PVvx6A7hbc
         GdJqKrZkb/+pCKS9/SbrFAEZzc4aVRUt5aD2QnxJ1Q4Qrd/aWgkydCKqllS5XNBckLuE
         7MBN+lO5RqJBUzUPqixezl/NqhzKPPuyEljqIpwrJejQuwOhjP87ID+HpMQXVKK6zj8x
         IMLA==
X-Gm-Message-State: AHQUAubWR7XHSxnH8sHMYGOi5H8GNq31+NQahm+hI1Q4YgKdH77l9ot/
        SCnNaKwcZYjYjc071UiOMzj8mchOorGoWd2T3L7lLg==
X-Google-Smtp-Source: AHgI3IZQ5U/QCli5IOcPCUie+xzIXLZp3AhFa0uDbSeoevQ+nGv8bVvzWjwrfadoTy5tRS+h2TL86cWNoMjBzeHWRSw=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr3170557otl.353.1550855567968;
 Fri, 22 Feb 2019 09:12:47 -0800 (PST)
MIME-Version: 1.0
References: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49ftsgsnzp.fsf@segfault.boston.devel.redhat.com> <CAPcyv4h9s1jYROGqkMfKk0MNBUedP=vQ1nJObLRwFiTB405nOg@mail.gmail.com>
 <x49imxbx22d.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49imxbx22d.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Feb 2019 09:12:37 -0800
Message-ID: <CAPcyv4jweuVTm6D2OTaAMGvUXfxqZMDPfaASJ=QL9=8SdGUZqg@mail.gmail.com>
Subject: Re: [PATCH 7/7] libnvdimm/pfn: Fix 'start_pad' implementation
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 7:42 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> >> > However, to fix this situation a non-backwards compatible change
> >> > needs to be made to the interpretation of the nd_pfn info-block.
> >> > ->start_pad needs to be accounted in ->map.map_offset (formerly
> >> > ->data_offset), and ->map.map_base (formerly ->phys_addr) needs to be
> >> > adjusted to the section aligned resource base used to establish
> >> > ->map.map formerly (formerly ->virt_addr).
> >> >
> >> > The guiding principles of the info-block compatibility fixup is to
> >> > maintain the interpretation of ->data_offset for implementations like
> >> > the EFI driver that only care about data_access not dax, but cause older
> >> > Linux implementations that care about the mode and dax to fail to parse
> >> > the new info-block.
> >>
> >> What if the core mm grew support for hotplug on sub-section boundaries?
> >> Would't that fix this problem (and others)?
> >
> > Yes, I think it would, and I had patches along these lines [2]. Last
> > time I looked at this I was asked by core-mm folks to await some
> > general refactoring of hotplug [3], and I wasn't proud about some of
> > the hacks I used to make it work. In general I'm less confident about
> > being able to get sub-section-hotplug over the goal line (core-mm
> > resistance to hotplug complexity) vs the local hacks in nvdimm to deal
> > with this breakage.
>
> You first posted that patch series in December of 2016.  How long do we
> wait for this refactoring to happen?
>
> Meanwhile, we've been kicking this can down the road for far too long.
> Simple namespace creation fails to work.  For example:
>
> # ndctl create-namespace -m fsdax -s 128m
>   Error: '--size=' must align to interleave-width: 6 and alignment: 2097152
>   did you intend --size=132M?
>
> failed to create namespace: Invalid argument
>
> ok, I can't actually create a small, section-aligned namespace.  Let's
> bump it up:
>
> # ndctl create-namespace -m fsdax -s 132m
> {
>   "dev":"namespace1.0",
>   "mode":"fsdax",
>   "map":"dev",
>   "size":"126.00 MiB (132.12 MB)",
>   "uuid":"2a5f8fe0-69e2-46bf-98bc-0f5667cd810a",
>   "raw_uuid":"f7324317-5cd2-491e-8cd1-ad03770593f2",
>   "sector_size":512,
>   "blockdev":"pmem1",
>   "numa_node":1
> }
>
> Great!  Now let's create another one.
>
> # ndctl create-namespace -m fsdax -s 132m
> libndctl: ndctl_pfn_enable: pfn1.1: failed to enable
>   Error: namespace1.2: failed to enable
>
> failed to create namespace: No such device or address
>
> (along with a kernel warning spew)

I assume you're seeing this on the libnvdimm-pending branch?

> And at this point, all further ndctl create-namespace commands fail.
> Lovely.  This is a wart that was acceptable only because a fix was
> coming.  2+ years later, and we're still adding hacks to work around it
> (and there have been *several* hacks).

True.

>
> > Local hacks are always a sad choice, but I think leaving these
> > configurations stranded for another kernel cycle is not tenable. It
> > wasn't until the github issue did I realize that the problem was
> > happening in the wild on NVDIMM-N platforms.
>
> I understand the desire for expediency.  At some point, though, we have
> to address the root of the problem.

Well, you've defibrillated me back to reality. We've suffered the
incomplete broken hacks for 2 years, what's another 10 weeks? I'll
dust off the sub-section patches and take another run at it.
