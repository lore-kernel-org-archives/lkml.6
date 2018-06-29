Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69E7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFB027E8E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iiXuQVks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFB027E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936466AbeF2PSR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:18:17 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35788 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754681AbeF2PSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:18:15 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so8770097iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YGiYrVHsaqEVh/wCw9ukRBRw79LQDGpL1mWE/BeCD6Y=;
        b=iiXuQVkscE0qdZp/lcTTcGQZSidTJP5Om3H/ihuYj41RKzQqojnklpx3c8ttyiXn6t
         uGJX3yOp9Uc5l7NebrnZl2G/zA5+u39JRloYMfNCWocyYbu6HyrhAo8lYWt/RGD5aiEb
         TMpTB4foNO5RpjHXYqxAs8z2FtkEXQqfcDUBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YGiYrVHsaqEVh/wCw9ukRBRw79LQDGpL1mWE/BeCD6Y=;
        b=pthKVfknJE3KXNersDARwaesKingph8u6r2K37WTp6JTHssveZ2V1Sklpm74p5vyOT
         yWflDLTx1mxDMyE6/c8jOOgSKCUoJW0icEqbV0kT6JXnK0KHUoK15tltGHtzdWA5yfTg
         R59tFmkBMrkDgM0l/BHaKFE4P+2czX+updjJ4zyIF4+ybZocXMENBZk6vaRaW2zwlHMP
         mk18990mWKaMajw4HwQ+VWM0UemXSZaP53/WBKKHFLYnW6pNh9pJ7ZlIqyQ9ZXGosfIp
         OUFF1NgXz2FVIw9GQRsEL2Q6ei/yyvnJNyQzWADZu3W/KJ1siIEjuOBjLMIUpFhZ7v7g
         f+VQ==
X-Gm-Message-State: APt69E2z80zPI1tiO6XzoqX7xz84KHkRFPjLM5OHDqICwhbq8chpaXmW
        I3eV81LzWE4o1tTPtTrUf/uAXMUxBJIyLbh0znbCBQ==
X-Google-Smtp-Source: AAOMgpfQK29wmbC4JCLFhlJVGd4UK5DwSyDm4FUxBZAKmY7PU5DY8knTkvLR2shlrbRUT/DUVcOrFcVx2P7wQ3ppKOM=
X-Received: by 2002:a6b:e403:: with SMTP id u3-v6mr12217270iog.131.1530285494811;
 Fri, 29 Jun 2018 08:18:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 08:18:14
 -0700 (PDT)
In-Reply-To: <f475a8c7-5a48-bf40-bbd9-a7a513f8a70f@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <f475a8c7-5a48-bf40-bbd9-a7a513f8a70f@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 29 Jun 2018 17:18:14 +0200
Message-ID: <CAPDyKFrYBLQDbtTgeuwCjpr5+2Y4+BUcYAmxT0AKj_-SvvGGQg@mail.gmail.com>
Subject: Re: [PATCH 00/19] mmc: mmci: add stm32 sdmmc variant
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

On 29 June 2018 at 15:51, Ludovic BARRE <ludovic.barre@st.com> wrote:
> hi Ulf
>
> I know that you very busy on other task,
> but did you have time to look my serie.
> do you have first feedback ?

Apologize for the delay. I am going to catch up on mmc next week.

At first glance, this looks reasonable.

Kind regards
Uffe

>
> BR
> Ludo
>
>
> On 06/12/2018 03:14 PM, Ludovic Barre wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch series adapts mmci driver to add support for stm32
>> sdmmc variant. stm32h7 SoC integrates the first revision of
>> stm32 sdmmc.
>>
>> This series is composed of 3 parts:
>> -Prepare mmci driver to manage dma interfaces by adding property.
>>   New mmci dma API is defined according to the legacy needs.
>> -Adapt mmci driver to dedicated constraints of stm32 sdmmc variant,
>>   defined under some specific properties.
>> -Add stm32 sdmmc variant. As Internal DMA way satisfies data
>> transfer, the mmci driver hasn't been modified for pio_read/write.
>> Specific adds-ons to stm32 sdmmc:
>>   + registers
>>   + clk/power functions
>>   + idma interface
>>
>> Ludovic Barre (19):
>>    mmc: mmci: regroup and define dma operations
>>    mmc: mmci: merge qcom dml feature into mmci dma
>>    mmc: mmci: add datactrl block size variant property
>>    mmc: mmci: expand startbiterr to irqmask and error check
>>    mmc: mmci: allow to overwrite clock/power procedure to specific
>>      variant
>>    mmc: mmci: add variant properties to define cpsm & cmdresp bits
>>    mmc: mmci: add variant property to define dpsm bit
>>    mmc: mmci: add variant property to define irq pio mask
>>    mmc: mmci: add variant property to write datactrl before command
>>    mmc: mmci: add variant property to allow remain data
>>    mmc: mmci: add variant property to check specific data constraint
>>    mmc: mmci: add variant property to request a reset
>>    mmc: mmci: send stop cmd if a data command fail
>>    mmc: mmci: add clock divider for stm32 sdmmc
>>    mmc: mmci: add stm32 sdmmc registers
>>    mmc: mmci: add DT bindings for STM32 sdmmc
>>    mmc: mmci: add stm32 sdmmc idma support
>>    mmc: mmci: add specific clk/pwr procedure for stm32 sdmmc
>>    mmc: mmci: add stm32 sdmmc variant
>>
>>   Documentation/devicetree/bindings/mmc/mmci.txt |  11 +
>>   drivers/mmc/host/Makefile                      |   3 +-
>>   drivers/mmc/host/mmci.c                        | 846
>> +++++++++++--------------
>>   drivers/mmc/host/mmci.h                        | 237 ++++++-
>>   drivers/mmc/host/mmci_dma.c                    | 780
>> +++++++++++++++++++++++
>>   drivers/mmc/host/mmci_dma.h                    |  33 +
>>   drivers/mmc/host/mmci_qcom_dml.c               | 177 ------
>>   drivers/mmc/host/mmci_qcom_dml.h               |  31 -
>>   8 files changed, 1410 insertions(+), 708 deletions(-)
>>   create mode 100644 drivers/mmc/host/mmci_dma.c
>>   create mode 100644 drivers/mmc/host/mmci_dma.h
>>   delete mode 100644 drivers/mmc/host/mmci_qcom_dml.c
>>   delete mode 100644 drivers/mmc/host/mmci_qcom_dml.h
>>
>
