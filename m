Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F5CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E232147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBSScU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:32:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfBSScT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:32:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF25E81F1B;
        Tue, 19 Feb 2019 18:32:18 +0000 (UTC)
Received: from [10.36.117.212] (ovpn-117-212.ams2.redhat.com [10.36.117.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F4295EDE0;
        Tue, 19 Feb 2019 18:31:58 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     Alexander Duyck <alexander.duyck@gmail.com>
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
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <20190218122636-mutt-send-email-mst@kernel.org>
 <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
 <20190218140947-mutt-send-email-mst@kernel.org>
 <4039c2e8-5db4-cddd-b997-2fdbcc6f529f@redhat.com>
 <20190218143819-mutt-send-email-mst@kernel.org>
 <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
 <20190218152021-mutt-send-email-mst@kernel.org>
 <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
 <CAKgT0UfEeDJOYmm5L0Q9QSNrEm=w39_+5Js5CEx=0o2_fhkaGQ@mail.gmail.com>
 <77e71dc3-640b-bbf6-6a47-bb2371c06172@redhat.com>
 <CAKgT0UfqSQoBehg7JZ=tzmk7wqSF=h9aMnsk_wpQXqh0NyRCHA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <eadcb5c5-2252-80f4-e396-0d2bbbd53694@redhat.com>
Date:   Tue, 19 Feb 2019 19:31:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfqSQoBehg7JZ=tzmk7wqSF=h9aMnsk_wpQXqh0NyRCHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 18:32:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> This essentially just ends up being another trade-off of CPU versus
>>> memory though. Assuming we aren't using THP we are going to take a
>>> penalty in terms of performance but could then free individual pages
>>> less than HUGETLB_PAGE_ORDER, but the CPU utilization is going to be
>>> much higher in general even without the hinting. I figure for x86 we
>>> probably don't have too many options since if I am not mistaken
>>> MAX_ORDER is just one or two more than HUGETLB_PAGE_ORDER.
>>
>> THP is an implementation detail in the hypervisor. Yes, it is the common
>> case on x86. But it is e.g. not available on s390x yet. And we also want
>> this mechanism to work on s390x (e.g. for nested virtualization setups
>> as discussed).
>>
>> If we e.g. report any granularity after merging was done in the buddy,
>> we could end up reporting everything from page size up to MAX_SIZE - 1,
>> the hypervisor could ignore hints below a certain magic number, if it
>> makes its life easier.
> 
> For each architecture we can do a separate implementation of what to
> hint on. We already do that for bare metal so why would we have guests
> do the same type of hinting in the virtualization case when there are
> fundamental differences in page size and features in each
> architecture?
> 
> This is another reason why I think the hypercall approach is a better
> idea since each architecture is likely going to want to handle things
> differently and it would be a pain to try and sort that all out in a
> virtio driver.

I can't follow. We are talking about something as simple as a minimum
page granularity here that can easily be configured. Nothing that
screams for different implementations. But I get your point, we could
tune for different architectures.

> 
>>>
>>> As far as fragmentation my thought is that we may want to look into
>>> adding support to the guest for prioritizing defragmentation on pages
>>> lower than THP size. Then that way we could maintain the higher
>>> overall performance with or without the hinting since shuffling lower
>>> order pages around between guests would start to get expensive pretty
>>> quick.
>>
>> My take would be, design an interface/mechanism that allows any kind of
>> granularity. You can than balance between cpu overead and space shifting.
> 
> The problem with using "any kind of granularity" is that in the case
> of memory we are already having problems with 4K pages being deemed
> too small of a granularity to be useful for anything and making
> operations too expensive.

No, sorry, s390x does it. And via batch reporting it could work. Not
saying we should do page granularity, but "to be useful for anything" is
just wrong.

> 
> I'm open to using other page orders for other architectures. Nothing
> says we have to stick with THP sized pages for all architectures. I
> have just been focused on x86 and this seems like the best fit for the
> balance between CPU and freeing of memory for now on that
> architecture.
> 
>> I feel like repeating myself, but on s390x hinting is done on page
>> granularity, and I have never heard somebody say "how can I turn it off,
>> this is slowing down my system too much.". All we know is that one
>> hypercall per free is most probably not acceptable. We really have to
>> play with the numbers.
> 
> My thought was we could look at doing different implementations for
> other architectures such as s390 and powerPC. Odds are the
> implementations would be similar but have slight differences where
> appropriate such as what order we should start hinting on, or if we
> bypass the hypercall/virtio-balloon for a host native approach if
> available.
> 
>> I tend to like an asynchronous reporting approach as discussed in this
>> thread, we would have to see if Nitesh could get it implemented.
> 
> I agree it would be great if it could work. However I have concerns
> given that work on this patch set dates back to 2017, major issues
> such as working around device assignment have yet to be addressed, and
> it seems like most of the effort is being focused on things that in my
> opinion are being over-engineered for little to no benefit.

I can understand that you are trying to push your solution. I would do
the same. Again, I don't like a pure synchronous approach that works on
one-element-at-a-time. Period. Other people might have other opinions.
This is mine - luckily I don't have anything to say here :)

MST also voted for an asynchronous solution if we can make it work.
Nitesh made significant improvements since the 2017. Complicated stuff
needs time. No need to rush. People have been talking about free page
hinting since 2006. I talked to various people that experimented with
bitmap based solutions two years ago.

So much to that, if you think your solution is the way to go, please
follow up on it. Nitesh seems to have decided to look into the
asynchronous approach you also called "great if it could work". As long
as we don't run into elementary blockers there, to me it all looks like
we are making progress, which is good. If we find out asynchronous
doesn't work, synchronous is the only alternative.

And just so you don't get me wrong: Thanks for looking and working on
this. And thanks for sharing your opinions and insights! However making
a decision about going your way at this point does not seem reasonable
to me. We have plenty of time.

-- 

Thanks,

David / dhildenb
