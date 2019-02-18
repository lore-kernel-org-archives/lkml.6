Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5826DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289A42177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAg6isBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbfBRRb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:31:26 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:34825 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbfBRRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:31:26 -0500
Received: by mail-it1-f172.google.com with SMTP id v72so42891607itc.0;
        Mon, 18 Feb 2019 09:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3wtV9x8WwtibXlrIbtzCrPtsaSbB2nRdqOFFQxgs+k=;
        b=OAg6isBlHO0GMUeTJ+GjtG6LaoQX80DhcYuF6NVZNw0ODCjTDdpliJhirfj7gRqt6w
         VKqkz8ZlXAHfibRXAPugNO9T88FZc4qIRDBJ5sOVBGj6BVhz1isq8GnCokpwtc8N8kCp
         amZ3OBVpOGu2vYCwVoa3/9Z4fbRL0QMv7jANkZ/2ZGx/yVhFwkVGeg9D2nkhGDynCoTK
         Q/VGR0jzQLACnLFMv0WGsv+IOyhc4rPcOW33wwVAwJxbwNlGafz6lCLduOOcJPXxcgVp
         3BQjwuKnNASxxqMznWBj0nf6t5vL0gLidReIZdRaZRsO8BaoKwOrFJYicSMKzMC9KBBw
         HVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3wtV9x8WwtibXlrIbtzCrPtsaSbB2nRdqOFFQxgs+k=;
        b=FvRS3afkkubxb2fThNQZJ0MvkAAU8hp0pojA6+V7XJHhle+e2A9LdtLy6J1R5LdnzA
         CZLGQ1vvKl3Hh2Iam41pOMmIcdMBdFzbF3n/vC4yuKAwxr6X1qF8smZp1pVeVpDItug9
         X8lak85bDe8k5TIuPMky2rN6DZ2X3Kr8ZJflWTWBOm564j//sX44hZpfXMyT4aiC5tcH
         ZTxMfDTUcQ7pTLKvvUhX9jcU72Rvqa7DbGcXIzW8nNe+q8L/kEigYa6sLIdtNE4t3Fgs
         9Z2j45pHOiBFnI34W8+NkxSG/2etC3HIvpL2oDVTTSiT+l9AI6CVw1AwmYuEHRLKa3Yc
         Vcyg==
X-Gm-Message-State: AHQUAuY7pIVKn/yLm/C7H3PKZCkIGGYT80uFtXsWEA5tmM3gaHwtAfF/
        uIBmF0sen4UkhmH8iIQ5cokI7GWe/Pd5ON6naFRBiQ==
X-Google-Smtp-Source: AHgI3IYlVsxYlO/miQE7bImyrKNz3jNrgI3qb+YKIzN/2gdY9S9l5DCuvtKsuUWMP6rOeFmd1oA6CzV6t8AF89VEGdg=
X-Received: by 2002:a24:45e3:: with SMTP id c96mr3121645itd.89.1550511084578;
 Mon, 18 Feb 2019 09:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org> <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
In-Reply-To: <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 18 Feb 2019 09:31:13 -0800
Message-ID: <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 8:59 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 18.02.19 17:49, Michael S. Tsirkin wrote:
> > On Sat, Feb 16, 2019 at 10:40:15AM +0100, David Hildenbrand wrote:
> >> It would be worth a try. My feeling is that a synchronous report after
> >> e.g. 512 frees should be acceptable, as it seems to be acceptable on
> >> s390x. (basically always enabled, nobody complains).
> >
> > What slips under the radar on an arch like s390 might
> > raise issues for a popular arch like x86. My fear would be
> > if it's only a problem e.g. for realtime. Then you get
> > a condition that's very hard to trigger and affects
> > worst case latencies.
>
> Realtime should never use free page hinting. Just like it should never
> use ballooning. Just like it should pin all pages in the hypervisor.
>
> >
> > But really what business has something that is supposedly
> > an optimization blocking a VCPU? We are just freeing up
> > lots of memory why is it a good idea to slow that
> > process down?
>
> I first want to know that it is a problem before we declare it a
> problem. I provided an example (s390x) where it does not seem to be a
> problem. One hypercall ~every 512 frees. As simple as it can get.
>
> No trying to deny that it could be a problem on x86, but then I assume
> it is only a problem in specific setups.
>
> I would much rather prefer a simple solution that can eventually be
> disabled in selected setup than a complicated solution that tries to fit
> all possible setups. Realtime is one of the examples where such stuff is
> to be disabled either way.
>
> Optimization of space comes with a price (here: execution time).

One thing to keep in mind though is that if you are already having to
pull pages in and out of swap on the host in order be able to provide
enough memory for the guests the free page hinting should be a
significant win in terms of performance.

So far with my patch set that hints at the PMD level w/ THP enabled I
am not really seeing that much overhead for the hypercalls. The bigger
piece that is eating up CPU time is all the page faults and page
zeroing that is going on as we are cycling the memory in and out of
the guest. Some of that could probably be resolved by using MADV_FREE,
but if we are under actual memory pressure I suspect it would behave
similar to MADV_DONTNEED.
