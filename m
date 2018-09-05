Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C793CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7538220857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFzEpAaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7538220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIEPNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:13:32 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40220 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIEPNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:13:32 -0400
Received: by mail-io0-f195.google.com with SMTP id l14-v6so5535280iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 03:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MOqtys68aikvUfdhExivNVmFR1GMtTIRn9oHCu3f1mE=;
        b=NFzEpAazIP9Mu9X+OW7gfPdpjEVeGEjFhnWwuGOlcIpbwsqpVMHa76Kl2urU8SPIw7
         GKaKwVjDeFYITTlb4E2CSsQMwIPQSO8+qgCeB2cWak6FDFDs290Ta9SR81xxScJ04QrO
         JCFknmrdnsTeyVrrr45oqsBZ0lsBS6Agj6eHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MOqtys68aikvUfdhExivNVmFR1GMtTIRn9oHCu3f1mE=;
        b=Naxcc307uYqOQx4m8XJMhDRjMbhjKdw3IYtSNUjzkxU7KxQHqlPXI3khVvyo/uJ8JV
         7SxpLgqXdMkKa0jbWP62zDd9kwyQEfLdRJaqObByoyhg5BkWIutZkcL8LeGj6LCyltgp
         gXA6Xe3FyiwBlSzK8vN+Kov7zV7YnCOBMr95NwrR/e6zvJAOh694Ul11l90BHpxj712j
         CSC1HjXGJ7P8iHihT4sRXjatB8fy60Guf+/nVy2KRaK4M8rZA5ucPiY0On9adqiQloFG
         ldESgzzhfWHQElF5WFfHgPMpei3dR+i36IkLuM7neIh43UWh9sYXyd0RcMeFOs3Urtsm
         7UuA==
X-Gm-Message-State: APzg51CkoFeUe6ctVfNW5PGO2eIoha3gdnAOKGqkURRwgWknTMCxkZ/d
        FbyzQD+hLK0xSnIUUM55p0Y1aHuqW3tbYvKD2QkVaw==
X-Google-Smtp-Source: ANB0VdZBcEOgi8ZLCanFWi5nF8I/K8A7KxZmQHdyGQ3STzdbMa7XjMva+AvGAwu9/XckQOZT4jxZR5R52yV1sjSo9pY=
X-Received: by 2002:a6b:e317:: with SMTP id u23-v6mr7139243ioc.131.1536144232294;
 Wed, 05 Sep 2018 03:43:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:4f9a:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 03:43:51 -0700 (PDT)
In-Reply-To: <5e9e5114-40d0-d178-4fdc-edfd5963c170@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqArwShaUZAit4fHa7F6UNC_z7Yc1GMpBuQcrkkwrB84g@mail.gmail.com> <5e9e5114-40d0-d178-4fdc-edfd5963c170@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Sep 2018 12:43:51 +0200
Message-ID: <CAPDyKFpgJmDy-UE9Uri2XT7rQpVFAxwEVO7i7qNcJtfhHRU2og@mail.gmail.com>
Subject: Re: [PATCH 00/14] mmc: mmci: prepare dma callbacks with mmci_host_ops
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 September 2018 at 11:13, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
> On 09/04/2018 12:00 PM, Ulf Hansson wrote:
>>
>> On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> This patch series prepares and adds callbacks for dma transfert at
>>> mmci_host_ops. This series is composed of 3 parts:
>>> -Internalize specific needs of legacy dmaengine.
>>> -Create and setup dma_priv pointer
>>> -Create generic callbacks  which share some features
>>> (like cookie...) and call specific needs
>>
>>
>> I have now reviewed part of this series and provided you with some
>> comments, but will stop at this point.
>
>
> thanks for your review
>
>>
>> Overall, the comments are about renaming and picking better function
>> names. Those comments should be easy to address in a new version.
>
>
> yes, there is no problem for the naming, I will change following your
> recommendations.
>
>>
>> However, the other more important point is the number of variant
>> callbacks you are adding. It's of course a balance to pick the right
>> level, to get both flexibility but also to avoid open coding. In the
>> end we don't want to get too many callbacks, but then it's better to
>> share common mmci code for variants, through mmci.h.
>>
>> Finally, I would like to see a patch on top adding the support for the
>> new ST variant, so I can see how the callbacks and changes really are
>> being used. Can you please add that?
>>
>
> yes, I prepare a patch with sdmmc variant to show how callbacks are used.
>
> About comment on patch 07/14:
>> So, having callbacks for dealing with dma_map|unmap() kind of
>> operations, becomes rather fine-grained and not very flexible.
>> Instead, what do you think of allowing the variant init function to
>> dynamically assign the ->pre_req() and the ->post_req() callbacks in
>> the struct mmc_host_ops. Common mmci functions to manage these
>> operations can instead be shared via mmci.h and called by the
>> variants.
>
> I think we have the same goal or idea, regroup the common needs to avoid
> too much specific drift.
>
> I will try to describe the functions which are commons and the link to
> specific mmci_host_ops callbacks.
>
> (I use function names of this series, but it's just for this example)
>
> commons function used by mmci core:
> -mmci_pre_request:
>  check data and cookie, call common mmci_validate_data
>  and mmci_prepare_data.
>
> -mmci_post_request:
>  check data and cookie then call common mmci_unprepare_data
>
> -mmci_validate_data:
>  check the common constraint of variants, call specific
>  validate_data if defined.
>
> -mmci_prepare_data:
>  setup common next cookie, call specific prepare data if defined
>
> -mmci_unprepare_data:
>  clear the common cookie, call specific unprepare data if defined
>
> -mmci_get_next_data:
>  check cookie, call specific get_next_data if defined
>
> -mmci_dma_setup:
>  initialize common next_cookie, call specific dma_setup if defined
>
> -mmci_dma_release
>  just call dma_release if defined
>
> -mmci_dma_start
>  call common prepare data if not yet done (by next)
>  call specific dma_start
>  write common registers to start transfer and setup mmci mask
>
> -mmci_dma_finalize:
>  just call dma_finalize if defined
>
> -mmci_dma_error
>  just call dma_error if defined
>
> mmci_host_ops specific:
> struct mmci_host_ops
> validate_data:  could be use to check specific constraint of variant.
>                 sdmmc has constraints on base & size for each element
>                 excepted the last element which has no constraint on
>                 size.
> prepare_data:   specific needs to prepare current or next data request.
>                 mmci: dma_map_sg on channel, use dmaengine api
>                 "dmaengine_prep_slave_sg" to queue a transfer
>                 sdmmc: dma_map_sg on sdmmc device and prepare the link
>                 list of internal dma
>
> unprepare_data: specific needs to unprepare the data of request
>                 mmci: dma_unmap_sg on channel, use dmaengine api to
>                 terminate transfert.
>                 sdmmc: just unmap on sdmmc device.
>
> get_next_data:  manage specific needs to move on next data
>                 mmci: get next dmaengine descriptor and channel
>                 sdmmc: today, nothing
>
> dma_setup:      setup specific need if you use a Direct Memory Access
>                 mmci: use dmaengine api to request slave channel.
>                 sdmmc: alloc memory for link list, and define specific
>                 mmc->max_segs and mmc->max_seg_size.
>
> dma_release:    release specific resource if you use a Direct Memory
>                 access.
>                 mmci: use dmaengine api to release channel
>                 sdmmc: nothing
>
> dma_start:      set specific needs to start dma request
>                 mmci: use dmaengine api to submit and pending a dma
>                 transfert.
>                 sdmmc: set specific sdmmc registers to start an internal
>                 dma transfert
>
> dma_finalize:   set specific needs to finalize a request
>                 mmci: specific check on fifo status and
>                 channel/descriptor management.
>                 sdmmc: just clear a specific register of sdmmc
>
> dma_error:      specific error management.
>                 mmci: dmaengine api to terminate a transfer
>                 sdmmc: nothing

Ludo, thanks for the detailed explanation and summary!

Following this, it looks like it makes sense to keep the callbacks as
on the level you have suggested. At least, I don't want to delay you
from getting this upstream, by just giving some vague ideas of how to
change the number of callbacks.

So, I am fine if you stick to the existing approach! Then, if we later
on realizes that it makes sense to share more common code through
mmci.h, to get rid of some callback, we can always do that on top.

[...]

Kind regards
Uffe
