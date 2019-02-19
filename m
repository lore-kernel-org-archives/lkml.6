Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3E1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF83C21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGgoTITO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbfBSAB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:01:27 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:34368 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBSAB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:01:27 -0500
Received: by mail-it1-f182.google.com with SMTP id d125so1245140ith.1;
        Mon, 18 Feb 2019 16:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OA+PAlFZtUT7rt0EjGW0XkBIYQn4M/+fu8mlYx4KbIo=;
        b=HGgoTITOh2AuKVoLi/tDWtSoOgIdYp4C/zdomTeLlaWi8hBLlNp+uEDK2DDTdqU6Ex
         LQwVFexMvbXJGK7j8XmVs5KfZwJQQdJ9HuUCEKZuyioCPI8Z4kzPW12QtO9eKaVhXjK1
         BJ67Vi4JqUet7/FhoMhtTV8lUddf9Q6HfeFRJMmBLEsdieFxWkl1pWAuQEnCGh//98ZO
         E5z42fPUpIoOD5MeCQ7DOn0VfFDFVCnZlSQYxLMFxVe8njfc+nlYMYDGns3hAQrKCYHa
         2yLKzAqy23okOVi/6KdFOfdpiHEc73XNQAEi8YRpynu3+tqNQiN/xgGxbJTlZYiESNUE
         w7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OA+PAlFZtUT7rt0EjGW0XkBIYQn4M/+fu8mlYx4KbIo=;
        b=IsuuAMnqpRqAOBGS9k14t1V15opVj4VX+pSiZceIyzdADgHkBMPAts0N+YSJz7G32z
         Zxub1yxcW2CFKne11a3jgXwuk8eh8/EBnEjhaYXN7NI6xo/crXb/7ipSO+aYZJrIKSqd
         wAXDoyBM3SndOoCVo9GWx8zx0ibia2B3CzchmN6d+EIqlrExy+mByJEAlF2GGLB3aMqX
         V/v8PhJZTa2OJYi3DZCEr2dEmh402jEuD96vDp2fX2JIS2btt829uRedGuk5cJ4Jr5+r
         yOohnO335fFWWP0AwjlTumnmVUJMreOhDFFEsYXU2AZdnIVoeE8k9gdlAzoSaFp8fP+n
         wbTQ==
X-Gm-Message-State: AHQUAuZN2afrt/3XT4bdUWnGZ5BBMMQNRzzRobvmdXPMlj1el8X1w8F3
        RkIPghXmJxVKUxC8jy4sLsIcsR1JcsYP2RLrhtc=
X-Google-Smtp-Source: AHgI3IaENMkw0JOrVF+UxH1G8y3WJBMI9c1SSbL1cqLKT+YGUkfD0hvdhwHaBvAwv8nASOqustAAta9BmKm9WdBEYw8=
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr867698itl.146.1550534485497;
 Mon, 18 Feb 2019 16:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org> <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <20190218122636-mutt-send-email-mst@kernel.org> <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
 <20190218140947-mutt-send-email-mst@kernel.org> <4039c2e8-5db4-cddd-b997-2fdbcc6f529f@redhat.com>
 <20190218143819-mutt-send-email-mst@kernel.org> <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
 <20190218152021-mutt-send-email-mst@kernel.org> <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
In-Reply-To: <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 18 Feb 2019 16:01:14 -0800
Message-ID: <CAKgT0UfEeDJOYmm5L0Q9QSNrEm=w39_+5Js5CEx=0o2_fhkaGQ@mail.gmail.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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

On Mon, Feb 18, 2019 at 1:04 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 18.02.19 21:40, Nitesh Narayan Lal wrote:
> > On 2/18/19 3:31 PM, Michael S. Tsirkin wrote:
> >> On Mon, Feb 18, 2019 at 09:04:57PM +0100, David Hildenbrand wrote:
> >>>>>>>> So I'm fine with a simple implementation but the interface needs to
> >>>>>>>> allow the hypervisor to process hints in parallel while guest is
> >>>>>>>> running.  We can then fix any issues on hypervisor without breaking
> >>>>>>>> guests.
> >>>>>>> Yes, I am fine with defining an interface that theoretically let's us
> >>>>>>> change the implementation in the guest later.
> >>>>>>> I consider this even a
> >>>>>>> prerequisite. IMHO the interface shouldn't be different, it will be
> >>>>>>> exactly the same.
> >>>>>>>
> >>>>>>> It is just "who" calls the batch freeing and waits for it. And as I
> >>>>>>> outlined here, doing it without additional threads at least avoids us
> >>>>>>> for now having to think about dynamic data structures and that we can
> >>>>>>> sometimes not report "because the thread is still busy reporting or
> >>>>>>> wasn't scheduled yet".
> >>>>>> Sorry I wasn't clear. I think we need ability to change the
> >>>>>> implementation in the *host* later. IOW don't rely on
> >>>>>> host being synchronous.
> >>>>>>
> >>>>>>
> >>>>> I actually misread it :) . In any way, there has to be a mechanism to
> >>>>> synchronize.
> >>>>>
> >>>>> If we are going via a bare hypercall (like s390x, like what Alexander
> >>>>> proposes), it is going to be a synchronous interface either way. Just a
> >>>>> bare hypercall, there will not really be any blocking on the guest side.
> >>>> It bothers me that we are now tied to interface being synchronous. We
> >>>> won't be able to fix it if there's an issue as that would break guests.
> >>> I assume with "fix it" you mean "fix kfree taking longer on every X call"?
> >>>
> >>> Yes, as I initially wrote, this mimics s390x. That might be good (we
> >>> know it has been working for years) and bad (we are inheriting the same
> >>> problem class, if it exists). And being synchronous is part of the
> >>> approach for now.
> >> BTW on s390 are these hypercalls handled by Linux?
> >>
> >>> I tend to focus on the first part (we don't know anything besides it is
> >>> working) while you focus on the second part (there could be a potential
> >>> problem). Having a real problem at hand would be great, then we would
> >>> know what exactly we actually have to fix. But read below.
> >> If we end up doing a hypercall per THP, maybe we could at least
> >> not block with interrupts disabled? Poll in guest until
> >> hypervisor reports its done?  That would already be an
> >> improvement IMHO. E.g. perf within guest will point you
> >> in the right direction and towards disabling hinting.
> >>
> >>
> >>>>> Via virtio, I guess it is waiting for a response to a requests, right?
> >>>> For the buffer to be used, yes. And it could mean putting some pages
> >>>> aside until hypervisor is done with them. Then you don't need timers or
> >>>> tricks like this, you can get an interrupt and start using the memory.
> >>> I am very open to such an approach as long as we can make it work and it
> >>> is not too complicated. (-> simple)
> >>>
> >>> This would mean for example
> >>>
> >>> 1. Collect entries to be reported per VCPU in a buffer. Say magic number
> >>> 256/512.
> >>>
> >>> 2. Once the buffer is full, do crazy "take pages out of the balloon
> >>> action" and report them to the hypervisor via virtio. Let the VCPU
> >>> continue. This will require some memory to store the request. Small
> >>> hickup for the VCPU to kick of the reporting to the hypervisor.
> >>>
> >>> 3. On interrupt/response, go over the response and put the pages back to
> >>> the buddy.
> >>>
> >>> (assuming that reporting a bulk of frees is better than reporting every
> >>> single free obviously)
> >>>
> >>> This could allow nice things like "when OOM gets trigger, see if pages
> >>> are currently being reported and wait until they have been put back to
> >>> the buddy, return "new pages available", so in a real "low on memory"
> >>> scenario, no OOM killer would get involved. This could address the issue
> >>> Wei had with reporting when low on memory.
> >>>
> >>> Is that something you have in mind?
> >> Yes that seems more future proof I think.
> >>
> >>> I assume we would have to allocate
> >>> memory when crafting the new requests. This is the only reason I tend to
> >>> prefer a synchronous interface for now. But if allocation is not a
> >>> problem, great.
> >> There are two main ways to avoid allocation:
> >> 1. do not add extra data on top of each chunk passed
> > If I am not wrong then this is close to what we have right now.
>
> Yes, minus the kthread(s) and eventually with some sort of memory
> allocation for the request. Once you're asynchronous via a notification
> mechanisnm, there is no real need for a thread anymore, hopefully.
>
> > One issue I see right now is that I am polling while host is freeing the
> > memory.
> > In the next version I could tie the logic which returns pages to the
> > buddy and resets the per cpu array index value to 0 with the callback.
> > (i.e.., it happens once we receive an response from the host)
>
> The question is, what happens when freeing pages and the array is not
> ready to be reused yet. In that case, you want to somehow continue
> freeing pages without busy waiting or eventually not reporting pages.
>
> The callback should put the pages back to the buddy and free the request
> eventually to have a fully asynchronous mechanism.
>
> > Other change which I am testing right now is to only capture 'MAX_ORDER
>
> I am not sure if this is an arbitrary number we came up with here. We
> should really play with different orders to find a hot spot. I wouldn't
> consider this high priority, though. Getting the whole concept right to
> be able to deal with any magic number we come up should be the ultimate
> goal. (stuff that only works with huge pages I consider not future
> proof, especially regarding fragmented guests which can happen easily)

This essentially just ends up being another trade-off of CPU versus
memory though. Assuming we aren't using THP we are going to take a
penalty in terms of performance but could then free individual pages
less than HUGETLB_PAGE_ORDER, but the CPU utilization is going to be
much higher in general even without the hinting. I figure for x86 we
probably don't have too many options since if I am not mistaken
MAX_ORDER is just one or two more than HUGETLB_PAGE_ORDER.

As far as fragmentation my thought is that we may want to look into
adding support to the guest for prioritizing defragmentation on pages
lower than THP size. Then that way we could maintain the higher
overall performance with or without the hinting since shuffling lower
order pages around between guests would start to get expensive pretty
quick.
