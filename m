Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E1AFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A81720890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXEAy2fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A81720890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeG3Qum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:50:42 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42096 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeG3Qum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:50:42 -0400
Received: by mail-io0-f195.google.com with SMTP id g11-v6so10141350ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BhQxubR4utH8PUra/z+1u4E0IGAC3yxZZN4uT0Isgsw=;
        b=LXEAy2fJHWFsbp6Mnh4VvlVVlSixg8uf6i/yF3ytWox9vWg24RlvZxyJ5swL0K8LMx
         j8ym051E3zwpTpJBASpg1uRfyBXctlQchIvtiN7ZgDJpf3hioUxbXrjDlNtQobfcAefO
         3Mb2kkaDsrF2aqt4xKpkn3HtB7WYOtzqbd0Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BhQxubR4utH8PUra/z+1u4E0IGAC3yxZZN4uT0Isgsw=;
        b=NcuJpN/Wsb8bVS7hdRncmGOwOdAQE24zSoegFtiIgWLdu11OfaoA4zkJ2WkWlzl04g
         IFDiWi+Haqk7Y9uv++TYV+Cc0PQaoIfmCSB05hhpS8Z1xLipaS93ZX6SX2jFtj9b0YpA
         MdBR1eYvVBQU3GL/VgKZUl6KPmnqN/dmTUZIOzv4TUjGnVWyFbV2vMPkOvSgjWMTYxaV
         u4YRB8Cr5uf+wPpNRN+8cC5Z9BIZkJoMoG38IUHggxmQjWJvTas/odfnbpEbqvknw8yv
         JLI1W+K6YjG//RsRHbLWcbnI+bIQKF4P0tRkaa4clE98Zfpcl0iGk7K9iMPHphz93Gex
         4Wsg==
X-Gm-Message-State: AOUpUlH5ed/VKX0fE893vuz8WdF1i08SXDZGV4XQGLkAb5RAo5n4IdDt
        fUbzxVjoi6EVkyxJg3mEfhk+rRpdl9PJ0/y5Pmx8NeTs
X-Google-Smtp-Source: AAOMgpeI7LCePKtyl02DHlRDaEySLm1WgXEpoZ2U5PW/SYLOhRwvorKMZRbZpAsDs0LfDBu6I7wz4r2lypG76fOXNgg=
X-Received: by 2002:a6b:e403:: with SMTP id u3-v6mr13428349iog.131.1532963715318;
 Mon, 30 Jul 2018 08:15:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:15:14
 -0700 (PDT)
In-Reply-To: <ed45398d-552c-7bae-d77a-4e0d99b21759@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-3-git-send-email-ludovic.Barre@st.com> <CAPDyKFqOOvbNc79hdWhdS4pxkYrh48At-BLuGmX0jDMER3Akdw@mail.gmail.com>
 <c09e8f7a-3bf7-abb3-b49c-011ae29f8d67@st.com> <CAPDyKFrN3GMez1vyc6xQUH_Qp7UrDj88rG9pAP_oTLHOB6k91g@mail.gmail.com>
 <ed45398d-552c-7bae-d77a-4e0d99b21759@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Jul 2018 17:15:14 +0200
Message-ID: <CAPDyKFqqj8muP4r2U8rB9rf7f3oB_US+R-oA-PxE26KYxx-j3g@mail.gmail.com>
Subject: Re: [PATCH 02/19] mmc: mmci: merge qcom dml feature into mmci dma
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 July 2018 at 15:08, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
> On 07/13/2018 01:17 PM, Ulf Hansson wrote:
>>
>> On 11 July 2018 at 17:19, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>>
>>>
>>>
>>> On 07/05/2018 05:26 PM, Ulf Hansson wrote:
>>>>
>>>>
>>>> On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>>>
>>>>>
>>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>>
>>>>> This patch integrates qcom dml feature into mmci_dma file.
>>>>> Qualcomm Data Mover lite/local is already a variant of mmci dmaengine.
>>>>>
>>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>>> ---
>>>>>    drivers/mmc/host/Makefile        |   1 -
>>>>>    drivers/mmc/host/mmci.c          |   1 -
>>>>>    drivers/mmc/host/mmci.h          |  35 ++++++++
>>>>>    drivers/mmc/host/mmci_dma.c      | 135 ++++++++++++++++++++++++++++-
>>>>>    drivers/mmc/host/mmci_qcom_dml.c | 177
>>>>> ---------------------------------------
>>>>>    drivers/mmc/host/mmci_qcom_dml.h |  31 -------
>>>>>    6 files changed, 169 insertions(+), 211 deletions(-)
>>>>>    delete mode 100644 drivers/mmc/host/mmci_qcom_dml.c
>>>>>    delete mode 100644 drivers/mmc/host/mmci_qcom_dml.h
>>>>
>>>>
>>>>
>>>> No, this is not the way to go. Instead I I think there are two options.
>>>>
>>>> 1) Keep mmci_qcom_dml.c|h and thus add new files for the stm32 dma
>>>> variant.
>>>>
>>>> 2) Start by renaming mmci_qcom_dml.* to mmc_dma.* and then in the next
>>>> step add the code for stm32 dma into the renamed files.
>>>>
>>>> I guess if there is some overlap in functionality, 2) may be best as
>>>> it could easier avoid open coding. However, I am fine with whatever
>>>> option and I expect that you knows what is best.
>>>
>>>
>>>
>>> After patch 01 & 05 comments:
>>> I will try to define a mmci_ops which contain some functions pointer
>>> called by mmci.c (core).
>>> A variant defines its mmci_ops.
>>> where do you define the specific function:
>>> -in a single file, mmci-ops.c or other (for the name, I'm not inspirated)
>>> -or in specific file for each variant mmci-qcom.c or mmci-stm32.c
>>>
>>> following the comment (above), I think we define a single file?
>>
>>
>> If I understand the question, the problem is how we should assign the
>> mmc host ops, which corresponds to the probed variant data!?
>>
>> I took a stub at it and posted two patches which I think you should be
>> able to build upon. Please have a look.
>
>
> I review your patch on mmci_host_ops and init, I agree with your series,
> I was going in the same direction.
> The comment above was on file organization, what do you prefer?
> -a single file with: all callback and all mmci_host_ops of each variant
> -or each variant in specific file (like sdhci): mmci-qcom.c | mmci-stm32.c

The latter seems better.

Kind regards
Uffe
