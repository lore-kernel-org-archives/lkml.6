Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C9C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1E4208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5iC2apw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1E4208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJPAPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:15:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35721 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeJPAPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:15:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so22082743wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xYRy9SRnULVc3qiQzz/PbPzMeHic+kzBhHSg8coo4qg=;
        b=H5iC2apwzMq3+3ynCf4vggdbyhrQhqlNWpDVqMAA7inmzIGGCpbCkIyd52jFmYvW+e
         H48M/dY98ezD1fhQjekOSqrGo9JAGQOKOLYtcApiklaSyxQxFyMIKBEbpuL1MksXS+Do
         wq+qTDk8j8tD7N1Mai5vcMTgatzJkOiXweE4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xYRy9SRnULVc3qiQzz/PbPzMeHic+kzBhHSg8coo4qg=;
        b=tSESJzI2xKk9brfsPZYXD2KAeYCvqeO2ZjFmBYGbOYN2jPR/WyGnVPJqGvxjPGOpIi
         rY+37F8RSlEE9mpkk68U2HCsZPY5ehHbHM6EB3s/Vmi2uD6aLN+1IJSYAqb9NEoxXZxy
         4pVwQcSIXsiiT6q0HcLfvKR7ZfzXFFKEDVKzgDBX5TYTxGAtkxdwaEGEkk6Lt/XO/KhQ
         T5wR2pEi/4MUvxqFqO2W2dO0hYGZw7frg9LHNB3PxPZUP8luWmjAU8UHa7Je6uRiQcLC
         SXYwe2mTh0HNHVdjfBXN7bn4EodvWYFqTTH3gOvXa1qEQ2IbeNoYhyrL0nV5M+DtZIXJ
         /eNA==
X-Gm-Message-State: ABuFfoiC20H4CwN2eiZ0pGevGH+zaKOnRq+s6BX93FqQEL/DWt1Ggnml
        SoHRahhi9fYKmHxULAbscQbGa2wviWQrkFC/Ez20Dw==
X-Google-Smtp-Source: ACcGV63eyddwWWNP3oFzcptmzRDj8nNQggoRPOY0q5mXsXsITMb1bagH5GZdqsL21AUUqBVarwH8DtLkL3t/tgyvp6s=
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr15268457wrx.271.1539620945458;
 Mon, 15 Oct 2018 09:29:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 09:29:04
 -0700 (PDT)
In-Reply-To: <7534ca1d-f874-7809-6125-d9fc72f70e39@redhat.com>
References: <1539214413-26173-1-git-send-email-john.stultz@linaro.org> <7534ca1d-f874-7809-6125-d9fc72f70e39@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 15 Oct 2018 09:29:04 -0700
Message-ID: <CALAqxLUnz_z1uA=g36RGW4eS0jhFRets2EwMYo+yBe=19ExZ4g@mail.gmail.com>
Subject: Re: [PATCH] staging: ion: Rework ion_map_dma_buf() to minimize re-mapping
To:     Laura Abbott <labbott@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Matt Szczesiak <matt.szczesiak@arm.com>,
        Anders Pedersen <Anders.Pedersen@arm.com>,
        John Reitan <John.Reitan@arm.com>,
        Liam Mark <lmark@codeaurora.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:51 AM, Laura Abbott <labbott@redhat.com> wrote:
> On 10/10/2018 04:33 PM, John Stultz wrote:
>>
>> Since 4.12, much later narrowed down to commit 2a55e7b5e544
>> ("staging: android: ion: Call dma_map_sg for syncing and mapping"),
>> we have seen graphics performance issues on the HiKey960.
>>
>> This was initially confounded by the fact that the out-of-tree
>> DRM driver was using HiSi custom ION heap which broke with the
>> 4.12 ION abi changes, so there was lots of suspicion that the
>> performance problems were due to switching to a somewhat simple
>> cma based DRM driver for HiKey960. Additionally, as no
>> performance regression was seen w/ the original HiKey board
>> (which is SMP, not big.LITTLE as w/ HiKey960), there was some
>> thought that the out-of-tree EAS code wasn't quite optimized.
>>
>> But after chasing a number of other leads, I found that
>> reverting the ION code to 4.11-era got the majority of the
>> graphics performance back (there may yet be further EAS tweaks
>> needed), which lead me to the dma_map_sg change.
>>
>> In talking w/ Laura and Liam, it was suspected that the extra
>> cache operations were causing the trouble. Additionally, I found
>> that part of the reason we didn't see this w/ the original
>> HiKey board is that its (proprietary blob) GL code uses ion_mmap
>> and ion_map_dma_buf is called very rarely, where as with
>> HiKey960, the (also proprietary blob) GL code calls
>> ion_map_dma_buf much more frequently via the kernel driver.
>>
>> Anyway, with the cause of the performance regression isolated,
>> I've tried to find a way to improve the performance of the
>> current code.
>>
>> This approach, which I've mostly copied from the drm_prime
>> implementation is to try to track the direction we're mapping
>> the buffers so we can avoid calling dma_map/unmap_sg on every
>> ion_map_dma_buf/ion_unmap_dma_buf call, and instead try to do
>> the work in attach/detach paths.
>>
>> I'm not 100% sure of the correctness here, so close review would
>> be good, but it gets the performance back to being similar to
>> reverting the ION code to the 4.11-era.
>>
>> Feedback would be greatly appreciated!
>>
...
>>   @@ -264,7 +291,6 @@ static void ion_unmap_dma_buf(struct
>> dma_buf_attachment *attachment,
>>                               struct sg_table *table,
>>                               enum dma_data_direction direction)
>>   {
>> -       dma_unmap_sg(attachment->dev, table->sgl, table->nents,
>> direction);
>
>
> This changes the semantics so that the only time a buffer
> gets unmapped is on detach. I don't think we want to restrict
> Ion to that behavior but I also don't know if anyone else
> is relying on that. I thought there might have been some Qualcomm
> stuff that did that (Liam? Todd?)
>
> I suspect most of the cost of the dma_map/dma_unmap is from the
> cache flushing and not the actual mapping operations. If this
> is the case, another option might be to figure out how to
> incorporate dma_attrs so drivers can use DMA_ATTR_SKIP_CPU_SYNC
> to decide when they actually want to sync.

Ok. Thanks so much for the feedback and the suggestion. I'll try to
look into dma_attrs here shortly.

thanks
-john
