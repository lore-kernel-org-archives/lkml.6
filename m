Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0344C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E3620855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS7fmfzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfBHR7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:59:00 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:38328 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfBHR7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:59:00 -0500
Received: by mail-it1-f177.google.com with SMTP id z20so11026923itc.3;
        Fri, 08 Feb 2019 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGq+a9Zq6pqKMQW/CyBwiTnl1V3Kzi4a9GU2pY3lPgk=;
        b=qS7fmfzriiQuhcdjGfMqC6/ER893+xXdt1ixstAtFoOICVVFLMdBLIkD3Z7cp/vaQb
         ++Pt8rt0DlG4xitVu5bX/JiZThptNqII4uWA3Df4jf3yBNQp8d6jw5yGrVgppeYdwkQZ
         70q9OMbQZwHfa5QLcrs2uY5xvrjV2YUZiNOXYchlXznWwjFVQvN+utAW7SRqrrppfxuP
         bKZB9qYrFg4lcPtt9BLSJeslI74ziUPwTYnm4Le8xn0zEf5Zu4dtB5OGMyrig7Xs1COt
         lT4SZyPwBlESZCoW9URTZQiibIVQMhTqP2uVkkrHW2uxYv2zvqmKI3zs6XAAiqU/OYtp
         a/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGq+a9Zq6pqKMQW/CyBwiTnl1V3Kzi4a9GU2pY3lPgk=;
        b=lufcK8IdGvvlM+aFqG4ak16lP2aKmuuuETQlqU/AUNJD7T5J8IdJ/q0PGwfMkhlQAJ
         T12xWcbQX3J6Smmjx5zKzUda/uTB+VHlBNYV0eqEQwTYYgDjXrBrHjusxf7aYtyRYDV5
         IUuuiuNa9WA5aTNgKrQiQjR4pPkqeeyA9kWIzA5ybXG0LY1ni8mDtsqJCvHWyQ8S2PeY
         psGAqcnSou/QPJ/pEKy3bA2ylS4YrsSE8SfCTAKV2qJvneZtz2QNf5RcrTWv4eeNlIMT
         GIXtPeIn6j+G0F6JHXau5bFqo32bwyvMhDSoJvNuaMOqfZV3XzRq7iuobQpR/GUFtbYg
         AJkA==
X-Gm-Message-State: AHQUAuaRybN/u3xpu5li6D2sFqFDWuju10QGIBMEp/Vcp0r125nK8Eob
        b0AGDund4YTFXnJ/XWiOA7Czrd+c03eKA0gDTVg=
X-Google-Smtp-Source: AHgI3IZXJ3tmnMcKfZqPA92MLUqvay4jpzbAruOEmloJVBVwQFFCklt6G9DBsvdgAyJlsV+M/wG1JY3JFg1BF6jMqqQ=
X-Received: by 2002:a24:5989:: with SMTP id p131mr9218699itb.6.1549648738874;
 Fri, 08 Feb 2019 09:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org> <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org> <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
 <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
In-Reply-To: <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 8 Feb 2019 09:58:47 -0800
Message-ID: <CAKgT0UcEFi7Rq9+EnLNNm61782QYRT6XZQDgbWFt2S8eMLf=qA@mail.gmail.com>
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report
 free pages
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, david@redhat.com,
        dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 12:50 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
>
> On 2/7/19 12:43 PM, Alexander Duyck wrote:
> > On Tue, Feb 5, 2019 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> On Tue, Feb 05, 2019 at 04:54:03PM -0500, Nitesh Narayan Lal wrote:
> >>> On 2/5/19 3:45 PM, Michael S. Tsirkin wrote:
> >>>> On Mon, Feb 04, 2019 at 03:18:53PM -0500, Nitesh Narayan Lal wrote:
> >>>>> This patch enables the kernel to scan the per cpu array and
> >>>>> compress it by removing the repetitive/re-allocated pages.
> >>>>> Once the per cpu array is completely filled with pages in the
> >>>>> buddy it wakes up the kernel per cpu thread which re-scans the
> >>>>> entire per cpu array by acquiring a zone lock corresponding to
> >>>>> the page which is being scanned. If the page is still free and
> >>>>> present in the buddy it tries to isolate the page and adds it
> >>>>> to another per cpu array.
> >>>>>
> >>>>> Once this scanning process is complete and if there are any
> >>>>> isolated pages added to the new per cpu array kernel thread
> >>>>> invokes hyperlist_ready().
> >>>>>
> >>>>> In hyperlist_ready() a hypercall is made to report these pages to
> >>>>> the host using the virtio-balloon framework. In order to do so
> >>>>> another virtqueue 'hinting_vq' is added to the balloon framework.
> >>>>> As the host frees all the reported pages, the kernel thread returns
> >>>>> them back to the buddy.
> >>>>>
> >>>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> >>>> This looks kind of like what early iterations of Wei's patches did.
> >>>>
> >>>> But this has lots of issues, for example you might end up with
> >>>> a hypercall per a 4K page.
> >>>> So in the end, he switched over to just reporting only
> >>>> MAX_ORDER - 1 pages.
> >>> You mean that I should only capture/attempt to isolate pages with order
> >>> MAX_ORDER - 1?
> >>>> Would that be a good idea for you too?
> >>> Will it help if we have a threshold value based on the amount of memory
> >>> captured instead of the number of entries/pages in the array?
> >> This is what Wei's patches do at least.
> > So in the solution I had posted I was looking more at
> > HUGETLB_PAGE_ORDER and above as the size of pages to provide the hints
> > on [1]. The advantage to doing that is that you can also avoid
> > fragmenting huge pages which in turn can cause what looks like a
> > memory leak as the memory subsystem attempts to reassemble huge
> > pages[2]. In my mind a 2MB page makes good sense in terms of the size
> > of things to be performing hints on as anything smaller than that is
> > going to just end up being a bunch of extra work and end up causing a
> > bunch of fragmentation.
> As per my opinion, in any implementation which page size to store before
> reporting depends on the allocation pattern of the workload running in
> the guest.

I suggest you take a look at item 2 that I had called out in the
previous email. There are known issues with providing hints smaller
than THP using MADV_DONTNEED or MADV_FREE. Specifically what will
happen is that you end up breaking up a higher order transparent huge
page, backfilling a few holes with other pages, but then the memory
allocation subsystem attempts to reassemble the larger THP page
resulting in an application exhibiting behavior similar to a memory
leak while not actually allocating memory since it is sitting on
fragments of THP pages.

Also while I am thinking of it I haven't noticed anywhere that you are
handling the case of a device assigned to the guest. That seems like a
spot where we are going to have to stop hinting as well aren't we?
Otherwise we would need to redo the memory mapping of the guest in the
IOMMU every time a page is evicted and replaced.

> I am also planning to try Michael's suggestion of using MAX_ORDER - 1.
> However I am still thinking about a workload which I can use to test its
> effectiveness.

You might want to look at doing something like min(MAX_ORDER - 1,
HUGETLB_PAGE_ORDER). I know for x86 a 2MB page is the upper limit for
THP which is the most likely to be used page size with the guest.

> >
> > The only issue with limiting things on an arbitrary boundary like that
> > is that you have to hook into the buddy allocator to catch the cases
> > where a page has been merged up into that range.
> I don't think, I understood your comment completely. In any case, we
> have to rely on the buddy for merging the pages.
> >
> > [1] https://lkml.org/lkml/2019/2/4/903
> > [2] https://blog.digitalocean.com/transparent-huge-pages-and-alternative-memory-allocators/
> --
> Regards
> Nitesh
>
