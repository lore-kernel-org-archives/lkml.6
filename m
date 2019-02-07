Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E51C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393102083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2jpRUgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfBGRn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:43:57 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39148 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGRn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:43:56 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so1775095itl.4;
        Thu, 07 Feb 2019 09:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WhjpOCaRGJ47Jru+1Y0Y9pBWdlzLAEjZyKH9CjcaAFU=;
        b=G2jpRUgjBx3m+6omUpc3AnoC923ff5wg3f9M7QrvYsunfLJ9/3isc4WcnhzquH8ui6
         24KAJ3vyqzrOLvZx66CgJjPsCMZehLQhXeHc/YoOihGei7VNL0oMtY+35+lSSNwfnp0L
         DsyxdmJamOlelPMk9Msxvy3H3zg6Hr7qw8Vkb+BNdMR3qpHVSudYe6Vtwv2tdEuEXerq
         ZHlS8WxJ9wuRjE3UBmbVzHvcsMZSGQStFNxdOiv/5CJ5uRVkY8pMsufTxFuhhiBnYaA3
         dIqxsuV++nHIw3QqM+2NGHD/ShHWN2KSNndVWxQKYHYakfG4ybIyLUqfB0SgvNbviNIS
         5nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhjpOCaRGJ47Jru+1Y0Y9pBWdlzLAEjZyKH9CjcaAFU=;
        b=ZOzGeDNg85rEXbQ6uLiOgbvYkmbYj/1gHYiK67pY3MA5tgVc3Zc2510qq1Vt/33F9i
         hvOwTKCy9p1Hb5ATylLhoWaZ5MYhRdPFU9n1G8HHmlCWFoA/okxeBUdXTuxf5UvUoNmZ
         SgSci3ZJxQB+/j9Uq1Wes0Wpo06x7EuNg3sjY4is+nFRQIzA2M4ukQI7be+zQxF5Df+w
         Mwj5Cfp/1TMhHkmIzLNr8lIyKEfp17X7UrR5O58ksA7vjTd6pDXI8D434cvx9Zo5INsr
         M9Yxlqh4sZ0aVToYhMWkFYuB07KQOcXbe7YU9SsQJU4pJN9Lkl/UwlbUefrm7weg6u6f
         bV1Q==
X-Gm-Message-State: AHQUAuYAgtpfv6fNlh8ihVGQ+mM7LOCyXTWKGaKR7kHWHFGlzo/bz1ct
        A1ChWMQgj8caslerwif9/gNtowvslsc4LJan8+U=
X-Google-Smtp-Source: AHgI3IZrF6BB+2mC2ckm1TlhBHWaFrB9/xgXMK1K0Xz/cr+pKIJmRYznaplHap8GBtVJGLbIKL5UQ+HiEO81rQNX/KQ=
X-Received: by 2002:a24:2ed3:: with SMTP id i202mr5363608ita.89.1549561435408;
 Thu, 07 Feb 2019 09:43:55 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org> <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190205165514-mutt-send-email-mst@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 7 Feb 2019 09:43:44 -0800
Message-ID: <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report
 free pages
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>, riel@surriel.com,
        david@redhat.com, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Feb 05, 2019 at 04:54:03PM -0500, Nitesh Narayan Lal wrote:
> >
> > On 2/5/19 3:45 PM, Michael S. Tsirkin wrote:
> > > On Mon, Feb 04, 2019 at 03:18:53PM -0500, Nitesh Narayan Lal wrote:
> > >> This patch enables the kernel to scan the per cpu array and
> > >> compress it by removing the repetitive/re-allocated pages.
> > >> Once the per cpu array is completely filled with pages in the
> > >> buddy it wakes up the kernel per cpu thread which re-scans the
> > >> entire per cpu array by acquiring a zone lock corresponding to
> > >> the page which is being scanned. If the page is still free and
> > >> present in the buddy it tries to isolate the page and adds it
> > >> to another per cpu array.
> > >>
> > >> Once this scanning process is complete and if there are any
> > >> isolated pages added to the new per cpu array kernel thread
> > >> invokes hyperlist_ready().
> > >>
> > >> In hyperlist_ready() a hypercall is made to report these pages to
> > >> the host using the virtio-balloon framework. In order to do so
> > >> another virtqueue 'hinting_vq' is added to the balloon framework.
> > >> As the host frees all the reported pages, the kernel thread returns
> > >> them back to the buddy.
> > >>
> > >> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > >
> > > This looks kind of like what early iterations of Wei's patches did.
> > >
> > > But this has lots of issues, for example you might end up with
> > > a hypercall per a 4K page.
> > > So in the end, he switched over to just reporting only
> > > MAX_ORDER - 1 pages.
> > You mean that I should only capture/attempt to isolate pages with order
> > MAX_ORDER - 1?
> > >
> > > Would that be a good idea for you too?
> > Will it help if we have a threshold value based on the amount of memory
> > captured instead of the number of entries/pages in the array?
>
> This is what Wei's patches do at least.

So in the solution I had posted I was looking more at
HUGETLB_PAGE_ORDER and above as the size of pages to provide the hints
on [1]. The advantage to doing that is that you can also avoid
fragmenting huge pages which in turn can cause what looks like a
memory leak as the memory subsystem attempts to reassemble huge
pages[2]. In my mind a 2MB page makes good sense in terms of the size
of things to be performing hints on as anything smaller than that is
going to just end up being a bunch of extra work and end up causing a
bunch of fragmentation.

The only issue with limiting things on an arbitrary boundary like that
is that you have to hook into the buddy allocator to catch the cases
where a page has been merged up into that range.

[1] https://lkml.org/lkml/2019/2/4/903
[2] https://blog.digitalocean.com/transparent-huge-pages-and-alternative-memory-allocators/
