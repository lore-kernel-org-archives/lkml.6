Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FA5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB27C213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWrH+m0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB27C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeGLHxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:53:45 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45791 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeGLHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:53:44 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so28532058oic.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6MHKfnu2vhpngdyTa36QjKgIWuWjrDFMPbstN1nfsfo=;
        b=lWrH+m0m1bpSGfjp1XGLXbSyBPNtYvPqipflmXH7wDqoVwsdDue4tJoDWnBe6oFas5
         sCoo/aDB4UffXONKt2EJglo1c95UT9k400YBI5ZUx4iKPqdxkdxi7B3V6aWwT5VGo8wN
         8yrJDksYd66w5ctvfnP4q5QTkCWNZeHMilriBEx8GuJJKZUAme80h73AEsF0UkCvz7tE
         1HYevT9TcrTpW+EoD3+gCFsFT4pKR62yCn/SOU8ZPviInDrSU3EKRA/N8/i4AUzuC2/U
         iUBn+V5PjJN9+8RotJav6nDkuauL1CZsIjYSHmbyxgeJGPS75PG4trSPFagmtQQnnyOo
         1gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6MHKfnu2vhpngdyTa36QjKgIWuWjrDFMPbstN1nfsfo=;
        b=HWEyy7htEJnxlJlKZBeunJgM9V+ToxXBs1Npe9JSQVw8jtLk8yUycwqmzQF3Gz9g1u
         Xkewxs9K0IFS5uzcJke2gooiozYzGWPPopqfI6PZ3W8VCSHH+d01YxOJEWEPxqYTYN9g
         Ujt+m6mUVUeo1uHusHM0qwGCVSwzpSuegYg2CEsJVNXkVoeiH3szCXG0RukrTFcXrKTq
         6ewp7VBr552K7Z6nUBTqYpMGD7+vQVK94uUJ32MqIb+x9BAqWJqn8CDP2RgxuT/6rFc1
         ePOKZyNVdzFSaWJhQaRexvaUimCktUs66LbAp0KwsdstFQm5lT7pOf5fMxjopw+Pn4em
         Ynkg==
X-Gm-Message-State: AOUpUlFqpcVw3Mj+T8B0IixDk7ELgPd5gPdkH85ITV6k1sqsCSuYVE6E
        2lsEY2Yezn2KmRTiTlhaazdTl1pAKRDYa03Y6Lc=
X-Google-Smtp-Source: AAOMgpeOhgw3E/ukF2Ss2jAusOrWryPZ9nqULuGfhLgNhAolAz/7Tem1tL7Nfrd3XIdblwxdfVAC4fTd3jaaOevY38k=
X-Received: by 2002:aca:ed57:: with SMTP id l84-v6mr1288777oih.62.1531381522518;
 Thu, 12 Jul 2018 00:45:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:d37:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 00:45:22 -0700 (PDT)
In-Reply-To: <CAKTKpr694WntjTB+pbXN--wthH+sw1mrr=JWjDfddG4bHdLwjw@mail.gmail.com>
References: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
 <c6c3655b-cef2-1112-e8a7-79c99f9ddac6@arm.com> <CAKTKpr67gqCK5y6atsterc7kCAg9fK_NKx2yMD3OjY+1L=j0sQ@mail.gmail.com>
 <CAKTKpr4skf3=Aw1YJNPppSjUT7w7_CF6QhefeHZDQXzENCfm5g@mail.gmail.com>
 <CAKTKpr7BmaR-rwqf=z8JiNpaoQNhpSXuUp8sZogUgSLpfcCe0A@mail.gmail.com> <CAKTKpr694WntjTB+pbXN--wthH+sw1mrr=JWjDfddG4bHdLwjw@mail.gmail.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Thu, 12 Jul 2018 13:15:22 +0530
Message-ID: <CAKTKpr74X9e2X-deraxFQzeoTio09LqoZoLDgod4J5AOn+vPMg@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: Update cached node pointer when current node
 fails to get any free IOVA
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, tomasz.nowicki@cavium.com,
        jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,


On Mon, Jun 4, 2018 at 9:36 AM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
> ping??
>
> On Mon, May 21, 2018 at 6:45 AM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>> On Thu, Apr 26, 2018 at 3:15 PM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>>> Hi Robin,
>>>
>>> On Mon, Apr 23, 2018 at 11:11 PM, Ganapatrao Kulkarni
>>> <gklkml16@gmail.com> wrote:
>>>> On Mon, Apr 23, 2018 at 10:07 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>> On 19/04/18 18:12, Ganapatrao Kulkarni wrote:
>>>>>>
>>>>>> The performance drop is observed with long hours iperf testing using 40G
>>>>>> cards. This is mainly due to long iterations in finding the free iova
>>>>>> range in 32bit address space.
>>>>>>
>>>>>> In current implementation for 64bit PCI devices, there is always first
>>>>>> attempt to allocate iova from 32bit(SAC preferred over DAC) address
>>>>>> range. Once we run out 32bit range, there is allocation from higher range,
>>>>>> however due to cached32_node optimization it does not suppose to be
>>>>>> painful. cached32_node always points to recently allocated 32-bit node.
>>>>>> When address range is full, it will be pointing to last allocated node
>>>>>> (leaf node), so walking rbtree to find the available range is not
>>>>>> expensive affair. However this optimization does not behave well when
>>>>>> one of the middle node is freed. In that case cached32_node is updated
>>>>>> to point to next iova range. The next iova allocation will consume free
>>>>>> range and again update cached32_node to itself. From now on, walking
>>>>>> over 32-bit range is more expensive.
>>>>>>
>>>>>> This patch adds fix to update cached node to leaf node when there are no
>>>>>> iova free range left, which avoids unnecessary long iterations.
>>>>>
>>>>>
>>>>> The only trouble with this is that "allocation failed" doesn't uniquely mean
>>>>> "space full". Say that after some time the 32-bit space ends up empty except
>>>>> for one page at 0x1000 and one at 0x80000000, then somebody tries to
>>>>> allocate 2GB. If we move the cached node down to the leftmost entry when
>>>>> that fails, all subsequent allocation attempts are now going to fail despite
>>>>> the space being 99.9999% free!
>>>>>
>>>>> I can see a couple of ways to solve that general problem of free space above
>>>>> the cached node getting lost, but neither of them helps with the case where
>>>>> there is genuinely insufficient space (and if anything would make it even
>>>>> slower). In terms of the optimisation you want here, i.e. fail fast when an
>>>>> allocation cannot possibly succeed, the only reliable idea which comes to
>>>>> mind is free-PFN accounting. I might give that a go myself to see how ugly
>>>>> it looks.

did you get any chance to look in to this issue?
i am waiting for your suggestion/patch for this issue!

>>>
>>> For this testing, dual port intel 40G card(XL710) used and both ports
>>> were connected in loop-back. Ran iperf server and clients on both
>>> ports(used NAT to route packets out on intended ports).There were 10
>>> iperf clients invoked every 60 seconds in loop for hours for each
>>> port. Initially the performance on both ports is seen close to line
>>> rate, however after test ran about 4 to 6 hours, the performance
>>> started dropping  to very low (to few hundred Mbps) on both
>>> connections.
>>>
>>> IMO,  this is common bug and should happen on any other platforms too
>>> and needs to be fixed at the earliest.
>>> Please let me know if you have better way to fix this,  i am happy to
>>> test your patch!
>>
>> any update on this issue?
>>>
>>>>
>>>> i see 2 problems in current implementation,
>>>> 1. We don't replenish the 32 bits range, until first attempt of second
>>>> allocation(64 bit) fails.
>>>> 2. Having  per cpu cache might not yield good hit on platforms with
>>>> more number of CPUs.
>>>>
>>>> however irrespective of current issues, It makes sense to update
>>>> cached node as done in this patch , when there is failure to get iova
>>>> range using current cached pointer which is forcing for the
>>>> unnecessary time consuming do-while iterations until any replenish
>>>> happens!
>>>>
>>>> thanks
>>>> Ganapat
>>>>
>>>>>
>>>>> Robin.
>>>>>
>>>>>
>>>>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>>>> ---
>>>>>>   drivers/iommu/iova.c | 6 ++++++
>>>>>>   1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>>>>> index 83fe262..e6ee2ea 100644
>>>>>> --- a/drivers/iommu/iova.c
>>>>>> +++ b/drivers/iommu/iova.c
>>>>>> @@ -201,6 +201,12 @@ static int __alloc_and_insert_iova_range(struct
>>>>>> iova_domain *iovad,
>>>>>>         } while (curr && new_pfn <= curr_iova->pfn_hi);
>>>>>>         if (limit_pfn < size || new_pfn < iovad->start_pfn) {
>>>>>> +               /* No more cached node points to free hole, update to leaf
>>>>>> node.
>>>>>> +                */
>>>>>> +               struct iova *prev_iova;
>>>>>> +
>>>>>> +               prev_iova = rb_entry(prev, struct iova, node);
>>>>>> +               __cached_rbnode_insert_update(iovad, prev_iova);
>>>>>>                 spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>>>>>>                 return -ENOMEM;
>>>>>>         }
>>>>>>
>>>>>
>>>
>>> thanks
>>> Ganapat

thanks
Ganapat
