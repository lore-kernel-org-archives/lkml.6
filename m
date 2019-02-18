Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D722C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A402176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZSWts1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfBRXrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:47:36 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36489 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBRXrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:47:35 -0500
Received: by mail-it1-f195.google.com with SMTP id h6so2102682itl.1;
        Mon, 18 Feb 2019 15:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bazOElXxPWM/KyV2b0IKbAoHsLiv1vxTLyw6dsA1+0=;
        b=uZSWts1t/px1UbmGGrmUr4Dqpro+q3ENRgloUXTOQlFT0+TAIWjIV2HCdpCEK2q9Zs
         RuUpwqLkTljbpuLmt3oJI2Ob9uimoMOCtMbIs3SZbKh4k1QQUwxQtG5QS996NXuiP6oS
         FS/qA6bJ9Q4+pQt0+char6MmDdKzQOAj7u67vbjWBUAC7YiYnU8cZ4EjtEsjI2x4A0DZ
         IfeSOzpBihkzAZWwh5WpPs1rEbaQm7uy5wiYkWs8dp3ClD5KKWlnomGnb2xDQwumRCti
         269ui5vv9MEOMRaaVyFWp2QLcJmWzzgRNKLg+jbhLFSRUll9h44ZcYy71RvbioLB801h
         slWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bazOElXxPWM/KyV2b0IKbAoHsLiv1vxTLyw6dsA1+0=;
        b=gjbGcwnOsXYtCYlu20IStMRFGj0jfS2ZLHAlnEDC+8LqOuM/lHcF60Yo2VztsNEYvU
         70M67W0oWpSg2RHdSrqgxtgVRkx/2IKWZNgJqs4SV2VXnDySQVs/aMmFgGYNSj45y8p9
         C/oHnagDhM5/x4YIEjyp/byV3IHIQPWQULVMQ1zl3UE8R3gI+wzJAePsVCb4niwfU227
         s0a8Ku5piPGvHrrM+79yu0FFWCH2efmT/7BL7hdXQMFHRBLgjYvY5C4C2x4Lqvb3mi5K
         TOFvhPqMJ85cVRDFydf01LnHyRaCT/bOqDZtlm+B1CmVNy5qkFNRvp8kEpDma6zL9yEb
         4lBA==
X-Gm-Message-State: AHQUAuYWyHMvTJ8XVKOebULp2S3cI3eKrr7MzjUQvcrA7CjoBDVOfWTx
        QrIdVhs1RJUxQBrTcl4bYGs3XjTN+gZJZ6N/8x0=
X-Google-Smtp-Source: AHgI3IazOqwMLGUnnJxeCR5c5J5eKAI2rAYO2w4j4CNFs0Q7dajmK4uVf8Ky6X7iLzCnE8JQ6ddP7t7MauizDosEGNc=
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr847021itl.146.1550533654417;
 Mon, 18 Feb 2019 15:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org> <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com> <a3b64b60-a745-0ac1-574d-e5904c1bf161@redhat.com>
In-Reply-To: <a3b64b60-a745-0ac1-574d-e5904c1bf161@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 18 Feb 2019 15:47:22 -0800
Message-ID: <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
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

On Mon, Feb 18, 2019 at 9:42 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 18.02.19 18:31, Alexander Duyck wrote:
> > On Mon, Feb 18, 2019 at 8:59 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 18.02.19 17:49, Michael S. Tsirkin wrote:
> >>> On Sat, Feb 16, 2019 at 10:40:15AM +0100, David Hildenbrand wrote:
> >>>> It would be worth a try. My feeling is that a synchronous report after
> >>>> e.g. 512 frees should be acceptable, as it seems to be acceptable on
> >>>> s390x. (basically always enabled, nobody complains).
> >>>
> >>> What slips under the radar on an arch like s390 might
> >>> raise issues for a popular arch like x86. My fear would be
> >>> if it's only a problem e.g. for realtime. Then you get
> >>> a condition that's very hard to trigger and affects
> >>> worst case latencies.
> >>
> >> Realtime should never use free page hinting. Just like it should never
> >> use ballooning. Just like it should pin all pages in the hypervisor.
> >>
> >>>
> >>> But really what business has something that is supposedly
> >>> an optimization blocking a VCPU? We are just freeing up
> >>> lots of memory why is it a good idea to slow that
> >>> process down?
> >>
> >> I first want to know that it is a problem before we declare it a
> >> problem. I provided an example (s390x) where it does not seem to be a
> >> problem. One hypercall ~every 512 frees. As simple as it can get.
> >>
> >> No trying to deny that it could be a problem on x86, but then I assume
> >> it is only a problem in specific setups.
> >>
> >> I would much rather prefer a simple solution that can eventually be
> >> disabled in selected setup than a complicated solution that tries to fit
> >> all possible setups. Realtime is one of the examples where such stuff is
> >> to be disabled either way.
> >>
> >> Optimization of space comes with a price (here: execution time).
> >
> > One thing to keep in mind though is that if you are already having to
> > pull pages in and out of swap on the host in order be able to provide
> > enough memory for the guests the free page hinting should be a
> > significant win in terms of performance.
>
> Indeed. And also we are in a virtualized environment already, we can
> have any kind of sudden hickups. (again, realtime has special
> requirements on the setup)
>
> Side note: I like your approach because it is simple. I don't like your
> approach because it cannot deal with fragmented memory. And that can
> happen easily.
>
> The idea I described here can be similarly be an extension of your
> approach, merging in a "batched reporting" Nitesh proposed, so we can
> report on something < MAX_ORDER, similar to s390x. In the end it boils
> down to reporting via hypercall vs. reporting via virtio. The main point
> is that it is synchronous and batched. (and that we properly take care
> of the race between host freeing and guest allocation)

I'd say the discussion is even simpler then that. My concern is more
synchronous versus asynchronous. I honestly think the cost for a
synchronous call is being overblown and we are likely to see the fault
and zeroing of pages cost more than the hypercall or virtio
transaction itself.

Also one reason why I am not a fan of working with anything less than
PMD order is because there have been issues in the past with false
memory leaks being created when hints were provided on THP pages that
essentially fragmented them. I guess hugepaged went through and
started trying to reassemble the huge pages and as a result there have
been apps that ended up consuming more memory than they would have
otherwise since they were using fragments of THP pages after doing an
MADV_DONTNEED on sections of the page.

> >
> > So far with my patch set that hints at the PMD level w/ THP enabled I
> > am not really seeing that much overhead for the hypercalls. The bigger
> > piece that is eating up CPU time is all the page faults and page
> > zeroing that is going on as we are cycling the memory in and out of
> > the guest. Some of that could probably be resolved by using MADV_FREE,
> > but if we are under actual memory pressure I suspect it would behave
> > similar to MADV_DONTNEED.
> >
>
> MADV_FREE is certainly the better thing to do for hinting in my opinion.
> It should result in even less overhead. Thanks for the comment about the
> hypercall overhead.

Yeah, no problem. The only thing I don't like about MADV_FREE is that
you have to have memory pressure before the pages really start getting
scrubbed with is both a benefit and a drawback. Basically it defers
the freeing until you are under actual memory pressure so when you hit
that case things start feeling much slower, that and it limits your
allocations since the kernel doesn't recognize the pages as free until
it would have to start trying to push memory to swap.
