Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E13208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElSuW9H2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E13208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeGaESP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:18:15 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39623 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeGaESP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:18:15 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so25125752oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cFzDcwMjZG2ZzJMg2AtfILCv5wpRbPB59m5fVb5bT1A=;
        b=ElSuW9H25r2nbqPy1oNQnxPFlD2ZLS77Bj66yKGNkt1VncUc/Ul14SYju3268AcUX+
         YcY+iYqvmN0lBAYoEPJZEYFMyJN/RZWq2DoS9EPvkm/KXJGgSYXSt1+Pv1FjpICY518D
         qQ48wPdQwqkQsrzOtLgr9BiBUJXL89mnnc6UCvDq1zBECl0efOHjwHpFbKyeIGqsIUYN
         0zKYFbzwvFL/jMYcqjIcSfIhb21hgkTY57ImZT6zYMoZWXk1F6JgSOJ1wGL0UaFezHKo
         rM3X4dGbkguvZ7EtXgie+oQMGlmGdOz6KqQUQYMYC64Lcd98sXBVY4UFfP6SWRJY3Z5y
         fVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cFzDcwMjZG2ZzJMg2AtfILCv5wpRbPB59m5fVb5bT1A=;
        b=CFbuoNkvCYdWDugdMCrUAs0ah8+OvpQV34FGyeN0N8MacJ3MXgpm3C8ctuKvVUzRry
         V74zzr6oc+o7JAUYuIKcbpHCT1w/HdtHw4C2oTWjvuZwrG5o1WbIm01hOEP0AM/aEL2x
         FlxDs9sm2xby/3sa6TNuLfJ+TywNlJhJLH+LTCK0WsfXaV2je0aZ0VherGfW2sYWx4KL
         kqRNB4D5yKmt4PZ1MFrggPbkKYaXXMRpRE0utu6mate5JGY2k/yDWyIrr5sqbhm40kOr
         LEQfnK4XVTryl9oB4fls9mSKJpOnqJ9WitFjPm391om+Sz4LQa84QW69DhGZurtB5wRR
         eGyA==
X-Gm-Message-State: AOUpUlG2lkR29iyTEm7MuZkESJoYFTCpw2Y+X+N7GYodAP+JbCy6zcOY
        OezCsga9FX2Z9gtryUAJtw73tr2gai1ClYw9+p8=
X-Google-Smtp-Source: AAOMgpctC81kG+Bqt3Uq1CUs0n3YiObM/Ifkp6M7MGBtkCOoxaW36PH9TUr1XkXb5HvJdfTkDBbLXsM4lCfgc7imV3Q=
X-Received: by 2002:aca:3ad4:: with SMTP id h203-v6mr19791188oia.294.1533004817425;
 Mon, 30 Jul 2018 19:40:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7702:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 19:40:16
 -0700 (PDT)
In-Reply-To: <CAKTKpr5HWUoJL0TcCMmUadtY_Z4p-RnwH7ZNjSxQppw-_=qdOw@mail.gmail.com>
References: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
 <c6c3655b-cef2-1112-e8a7-79c99f9ddac6@arm.com> <CAKTKpr67gqCK5y6atsterc7kCAg9fK_NKx2yMD3OjY+1L=j0sQ@mail.gmail.com>
 <CAKTKpr4skf3=Aw1YJNPppSjUT7w7_CF6QhefeHZDQXzENCfm5g@mail.gmail.com>
 <CAKTKpr7BmaR-rwqf=z8JiNpaoQNhpSXuUp8sZogUgSLpfcCe0A@mail.gmail.com>
 <CAKTKpr694WntjTB+pbXN--wthH+sw1mrr=JWjDfddG4bHdLwjw@mail.gmail.com>
 <CAKTKpr74X9e2X-deraxFQzeoTio09LqoZoLDgod4J5AOn+vPMg@mail.gmail.com>
 <3ed2046c-6912-9380-7ea4-4d921981c64c@arm.com> <CAKTKpr5eERRzxDcH5cno5kDQ10XO9nHXbLTmk=ShEi8HK05fsg@mail.gmail.com>
 <642cefaf-9ce7-bf0f-e6b6-e2e520e2427b@arm.com> <CAKTKpr5HWUoJL0TcCMmUadtY_Z4p-RnwH7ZNjSxQppw-_=qdOw@mail.gmail.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Tue, 31 Jul 2018 08:10:16 +0530
Message-ID: <CAKTKpr5YqVc8R7=Sorzx=fCVg0YphZUHFO7n1FAj2K2XMytQ=w@mail.gmail.com>
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


On Mon, Jul 30, 2018 at 12:40 PM, Ganapatrao Kulkarni
<gklkml16@gmail.com> wrote:
> On Fri, Jul 27, 2018 at 9:48 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 27/07/18 13:56, Ganapatrao Kulkarni wrote:
>> [...]
>>>>>
>>>>> did you get any chance to look in to this issue?
>>>>> i am waiting for your suggestion/patch for this issue!
>>>>
>>>>
>>>>
>>>> I got as far as [1], but I wasn't sure how much I liked it, since it
>>>> still
>>>> seems a little invasive for such a specific case (plus I can't remember
>>>> if
>>>> it's actually been debugged or not). I think in the end I started
>>>> wondering
>>>> whether it's even worth bothering with the 32-bit optimisation for PCIe
>>>> devices - 4 extra bytes worth of TLP is surely a lot less significant
>>>> than
>>>> every transaction taking up to 50% more bus cycles was for legacy PCI.
>>>
>>>
>>> how about tracking previous attempt to get 32bit range iova and avoid
>>> further attempts, if it was failed. Later Resume attempts once
>>> replenish happens.
>>> Created patch for the same [2]
>>
>>
>> Ooh, that's a much neater implementation of essentially the same concept -
>> now why couldn't I think of that? :)
>>
>> Looks like it should be possible to make it entirely self-contained too,
>> since alloc_iova() is in a position to both test and update the flag based
>> on the limit_pfn passed in.
>
> is below patch much better?

testing with this diff looks ok, shall i send formal patch with your Acked-by?
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 83fe262..abb15d6 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned
> long granule,
>      iovad->granule = granule;
>      iovad->start_pfn = start_pfn;
>      iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
> +    iovad->free_32bit_pfns = true;
>      iovad->flush_cb = NULL;
>      iovad->fq = NULL;
>      iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
> @@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain
> *iovad, struct iova *free)
>
>      cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
>      if (free->pfn_hi < iovad->dma_32bit_pfn &&
> -        free->pfn_lo >= cached_iova->pfn_lo)
> +        free->pfn_lo >= cached_iova->pfn_lo) {
>          iovad->cached32_node = rb_next(&free->node);
> +        iovad->free_32bit_pfns = true;
> +    }
>
>      cached_iova = rb_entry(iovad->cached_node, struct iova, node);
>      if (free->pfn_lo >= cached_iova->pfn_lo)
> @@ -290,6 +293,10 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
>      struct iova *new_iova;
>      int ret;
>
> +    if (limit_pfn < iovad->dma_32bit_pfn &&
> +            !iovad->free_32bit_pfns)
> +        return NULL;
> +
>      new_iova = alloc_iova_mem();
>      if (!new_iova)
>          return NULL;
> @@ -299,6 +306,8 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
>
>      if (ret) {
>          free_iova_mem(new_iova);
> +        if (limit_pfn < iovad->dma_32bit_pfn)
> +            iovad->free_32bit_pfns = false;
>          return NULL;
>      }
>
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 928442d..3810ba9 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -96,6 +96,7 @@ struct iova_domain {
>                             flush-queues */
>      atomic_t fq_timer_on;            /* 1 when timer is active, 0
>                             when not */
> +    bool    free_32bit_pfns;
>  };
>
>  static inline unsigned long iova_size(struct iova *iova)
> --
> 2.9.4
>>
>> Robin.
>>
>>
>>>
>>> [2]
>>> https://github.com/gpkulkarni/linux/commit/e2343a3e1f55cdeb5694103dd354bcb881dc65c3
>>> note, the testing of this patch is in progress.
>>>
>>>>
>>>> Robin.
>>>>
>>>> [1]
>>>>
>>>> http://www.linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=a8e0e4af10ebebb3669750e05bf0028e5bd6afe8
>>>
>>>
>>> thanks
>>> Ganapat
>>>
>>
>
> thanks
> Ganapat

thanks
Ganapat
