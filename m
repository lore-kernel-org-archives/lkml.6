Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE71C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342A3217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOQz9m8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBSSGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:06:52 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51258 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSSGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:06:51 -0500
Received: by mail-it1-f196.google.com with SMTP id y184so8295502itc.1;
        Tue, 19 Feb 2019 10:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SglYwDqeQYaed9Fi0dzq8yR1K3oL04YR1eMifUSGgag=;
        b=jOQz9m8OoBnbllgYZiVIk1mxBtDAzkBcoIrwK4qEkDpDqOzcFd66Zas/2Mymu+YEL3
         S3fIlxXzj054WNW4lx6ugcx8NMkkB4KVMRMJbWYM80UwSSmJ8PWhkQRAFGZOJyKbElGn
         hSPVcH/v3IfK56UBkq6dTztEhsPC2loAsMGguIVSs0y3NqoqkPs6PM40+bsrRPHW80x4
         y2aOSUpoQMoC+v3BhzJtXJp4CfxhKinhQBQf4ehdvOgaVPqXMBAU6sdnjxuPmVBlx85A
         Y8JKuYSZELnZ03VjyLktnyERUFRY0BTy1y8v4DIPYJ1wgHZLJ4ghgITktoqGgmG1SCcX
         GOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SglYwDqeQYaed9Fi0dzq8yR1K3oL04YR1eMifUSGgag=;
        b=pi2IKp0GNJXcPdczVo4mdb+pBxBvTlDyVR/b0WkfTyRliqqHdqo5UU4gNv81tyGmZ/
         fl8ULnYm5Hnn/D293GEmNmj5szl8PMn3RrVbGsrDfTxUGpeACvlRheNTI60XugXtvQxM
         Ne4jlUtDbPrlo8grmVljeOLTPM/VSLHCs7Xy5nNDgX/N2cyFZf2gcMfq2OTfJLMQdG2I
         CBJ4mZn3JVUPnUO2nNggBo3H6LZO0sKHraWgD0R93FdnPVvyFaZsew1lhR4NYHxdbiSS
         kPN2iB6MwLAUWbG4yDos9KdxKJVNROWtu1SozniBo++8HdWzU65IQxw7K8JAF4gzC7qF
         NKxw==
X-Gm-Message-State: AHQUAua1TKWdADtDYRyVeyI0zKKRcjlkiMafZQqgP2ad/JmOU+628fDG
        E81/SCsTZwmB19wiRAWLlhskSiBJodtq7vtsC/8=
X-Google-Smtp-Source: AHgI3IaiUgtSahQyYLGol3Dn1hHrvAr6nyCZKVQ04zjirn/A2PHlpIcmpZ+BM9fcHY+4UVvIC41ZPVlKHgKhkbhEAvk=
X-Received: by 2002:a24:5989:: with SMTP id p131mr3153744itb.6.1550599607243;
 Tue, 19 Feb 2019 10:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org> <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <20190218122636-mutt-send-email-mst@kernel.org> <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
 <20190218140947-mutt-send-email-mst@kernel.org> <4039c2e8-5db4-cddd-b997-2fdbcc6f529f@redhat.com>
 <20190218143819-mutt-send-email-mst@kernel.org> <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
 <20190218152021-mutt-send-email-mst@kernel.org> <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com> <CAKgT0UfEeDJOYmm5L0Q9QSNrEm=w39_+5Js5CEx=0o2_fhkaGQ@mail.gmail.com>
 <77e71dc3-640b-bbf6-6a47-bb2371c06172@redhat.com>
In-Reply-To: <77e71dc3-640b-bbf6-6a47-bb2371c06172@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 19 Feb 2019 10:06:35 -0800
Message-ID: <CAKgT0UfqSQoBehg7JZ=tzmk7wqSF=h9aMnsk_wpQXqh0NyRCHA@mail.gmail.com>
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

On Mon, Feb 18, 2019 at 11:55 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.02.19 01:01, Alexander Duyck wrote:
> > On Mon, Feb 18, 2019 at 1:04 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 18.02.19 21:40, Nitesh Narayan Lal wrote:
> >>> On 2/18/19 3:31 PM, Michael S. Tsirkin wrote:
> >>>> On Mon, Feb 18, 2019 at 09:04:57PM +0100, David Hildenbrand wrote:
> >>>>>>>>>> So I'm fine with a simple implementation but the interface needs to
> >>>>>>>>>> allow the hypervisor to process hints in parallel while guest is
> >>>>>>>>>> running.  We can then fix any issues on hypervisor without breaking
> >>>>>>>>>> guests.
> >>>>>>>>> Yes, I am fine with defining an interface that theoretically let's us
> >>>>>>>>> change the implementation in the guest later.
> >>>>>>>>> I consider this even a
> >>>>>>>>> prerequisite. IMHO the interface shouldn't be different, it will be
> >>>>>>>>> exactly the same.
> >>>>>>>>>
> >>>>>>>>> It is just "who" calls the batch freeing and waits for it. And as I
> >>>>>>>>> outlined here, doing it without additional threads at least avoids us
> >>>>>>>>> for now having to think about dynamic data structures and that we can
> >>>>>>>>> sometimes not report "because the thread is still busy reporting or
> >>>>>>>>> wasn't scheduled yet".
> >>>>>>>> Sorry I wasn't clear. I think we need ability to change the
> >>>>>>>> implementation in the *host* later. IOW don't rely on
> >>>>>>>> host being synchronous.
> >>>>>>>>
> >>>>>>>>
> >>>>>>> I actually misread it :) . In any way, there has to be a mechanism to
> >>>>>>> synchronize.
> >>>>>>>
> >>>>>>> If we are going via a bare hypercall (like s390x, like what Alexander
> >>>>>>> proposes), it is going to be a synchronous interface either way. Just a
> >>>>>>> bare hypercall, there will not really be any blocking on the guest side.
> >>>>>> It bothers me that we are now tied to interface being synchronous. We
> >>>>>> won't be able to fix it if there's an issue as that would break guests.
> >>>>> I assume with "fix it" you mean "fix kfree taking longer on every X call"?
> >>>>>
> >>>>> Yes, as I initially wrote, this mimics s390x. That might be good (we
> >>>>> know it has been working for years) and bad (we are inheriting the same
> >>>>> problem class, if it exists). And being synchronous is part of the
> >>>>> approach for now.
> >>>> BTW on s390 are these hypercalls handled by Linux?
> >>>>
> >>>>> I tend to focus on the first part (we don't know anything besides it is
> >>>>> working) while you focus on the second part (there could be a potential
> >>>>> problem). Having a real problem at hand would be great, then we would
> >>>>> know what exactly we actually have to fix. But read below.
> >>>> If we end up doing a hypercall per THP, maybe we could at least
> >>>> not block with interrupts disabled? Poll in guest until
> >>>> hypervisor reports its done?  That would already be an
> >>>> improvement IMHO. E.g. perf within guest will point you
> >>>> in the right direction and towards disabling hinting.
> >>>>
> >>>>
> >>>>>>> Via virtio, I guess it is waiting for a response to a requests, right?
> >>>>>> For the buffer to be used, yes. And it could mean putting some pages
> >>>>>> aside until hypervisor is done with them. Then you don't need timers or
> >>>>>> tricks like this, you can get an interrupt and start using the memory.
> >>>>> I am very open to such an approach as long as we can make it work and it
> >>>>> is not too complicated. (-> simple)
> >>>>>
> >>>>> This would mean for example
> >>>>>
> >>>>> 1. Collect entries to be reported per VCPU in a buffer. Say magic number
> >>>>> 256/512.
> >>>>>
> >>>>> 2. Once the buffer is full, do crazy "take pages out of the balloon
> >>>>> action" and report them to the hypervisor via virtio. Let the VCPU
> >>>>> continue. This will require some memory to store the request. Small
> >>>>> hickup for the VCPU to kick of the reporting to the hypervisor.
> >>>>>
> >>>>> 3. On interrupt/response, go over the response and put the pages back to
> >>>>> the buddy.
> >>>>>
> >>>>> (assuming that reporting a bulk of frees is better than reporting every
> >>>>> single free obviously)
> >>>>>
> >>>>> This could allow nice things like "when OOM gets trigger, see if pages
> >>>>> are currently being reported and wait until they have been put back to
> >>>>> the buddy, return "new pages available", so in a real "low on memory"
> >>>>> scenario, no OOM killer would get involved. This could address the issue
> >>>>> Wei had with reporting when low on memory.
> >>>>>
> >>>>> Is that something you have in mind?
> >>>> Yes that seems more future proof I think.
> >>>>
> >>>>> I assume we would have to allocate
> >>>>> memory when crafting the new requests. This is the only reason I tend to
> >>>>> prefer a synchronous interface for now. But if allocation is not a
> >>>>> problem, great.
> >>>> There are two main ways to avoid allocation:
> >>>> 1. do not add extra data on top of each chunk passed
> >>> If I am not wrong then this is close to what we have right now.
> >>
> >> Yes, minus the kthread(s) and eventually with some sort of memory
> >> allocation for the request. Once you're asynchronous via a notification
> >> mechanisnm, there is no real need for a thread anymore, hopefully.
> >>
> >>> One issue I see right now is that I am polling while host is freeing the
> >>> memory.
> >>> In the next version I could tie the logic which returns pages to the
> >>> buddy and resets the per cpu array index value to 0 with the callback.
> >>> (i.e.., it happens once we receive an response from the host)
> >>
> >> The question is, what happens when freeing pages and the array is not
> >> ready to be reused yet. In that case, you want to somehow continue
> >> freeing pages without busy waiting or eventually not reporting pages.
> >>
> >> The callback should put the pages back to the buddy and free the request
> >> eventually to have a fully asynchronous mechanism.
> >>
> >>> Other change which I am testing right now is to only capture 'MAX_ORDER
> >>
> >> I am not sure if this is an arbitrary number we came up with here. We
> >> should really play with different orders to find a hot spot. I wouldn't
> >> consider this high priority, though. Getting the whole concept right to
> >> be able to deal with any magic number we come up should be the ultimate
> >> goal. (stuff that only works with huge pages I consider not future
> >> proof, especially regarding fragmented guests which can happen easily)
> >
> > This essentially just ends up being another trade-off of CPU versus
> > memory though. Assuming we aren't using THP we are going to take a
> > penalty in terms of performance but could then free individual pages
> > less than HUGETLB_PAGE_ORDER, but the CPU utilization is going to be
> > much higher in general even without the hinting. I figure for x86 we
> > probably don't have too many options since if I am not mistaken
> > MAX_ORDER is just one or two more than HUGETLB_PAGE_ORDER.
>
> THP is an implementation detail in the hypervisor. Yes, it is the common
> case on x86. But it is e.g. not available on s390x yet. And we also want
> this mechanism to work on s390x (e.g. for nested virtualization setups
> as discussed).
>
> If we e.g. report any granularity after merging was done in the buddy,
> we could end up reporting everything from page size up to MAX_SIZE - 1,
> the hypervisor could ignore hints below a certain magic number, if it
> makes its life easier.

For each architecture we can do a separate implementation of what to
hint on. We already do that for bare metal so why would we have guests
do the same type of hinting in the virtualization case when there are
fundamental differences in page size and features in each
architecture?

This is another reason why I think the hypercall approach is a better
idea since each architecture is likely going to want to handle things
differently and it would be a pain to try and sort that all out in a
virtio driver.

> >
> > As far as fragmentation my thought is that we may want to look into
> > adding support to the guest for prioritizing defragmentation on pages
> > lower than THP size. Then that way we could maintain the higher
> > overall performance with or without the hinting since shuffling lower
> > order pages around between guests would start to get expensive pretty
> > quick.
>
> My take would be, design an interface/mechanism that allows any kind of
> granularity. You can than balance between cpu overead and space shifting.

The problem with using "any kind of granularity" is that in the case
of memory we are already having problems with 4K pages being deemed
too small of a granularity to be useful for anything and making
operations too expensive.

I'm open to using other page orders for other architectures. Nothing
says we have to stick with THP sized pages for all architectures. I
have just been focused on x86 and this seems like the best fit for the
balance between CPU and freeing of memory for now on that
architecture.

> I feel like repeating myself, but on s390x hinting is done on page
> granularity, and I have never heard somebody say "how can I turn it off,
> this is slowing down my system too much.". All we know is that one
> hypercall per free is most probably not acceptable. We really have to
> play with the numbers.

My thought was we could look at doing different implementations for
other architectures such as s390 and powerPC. Odds are the
implementations would be similar but have slight differences where
appropriate such as what order we should start hinting on, or if we
bypass the hypercall/virtio-balloon for a host native approach if
available.

> I tend to like an asynchronous reporting approach as discussed in this
> thread, we would have to see if Nitesh could get it implemented.

I agree it would be great if it could work. However I have concerns
given that work on this patch set dates back to 2017, major issues
such as working around device assignment have yet to be addressed, and
it seems like most of the effort is being focused on things that in my
opinion are being over-engineered for little to no benefit.

I really think that simpler would be much better in terms of design in
this case.

Thanks.

- Alex
