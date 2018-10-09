Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB46C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630C521479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fT3KjC3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630C521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeJIOq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:46:56 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54025 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeJIOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:46:55 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so1234488itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iwucvk/3zPnT3tEdEHqgQxvJSq9CXa7yh8gF93fxGH8=;
        b=fT3KjC3jk0xNw8YKiRmPUPbR1knviiB2uhOyuuizZY+7PQqIDkHPmhs2HCtiCOt0iu
         +n1nQ1O2caXh2FpVFXcTBdhN9FmsRA1opqxo9rYp6tpf2rsbziNPqk3TkLfGFmH/51H0
         xpycK+gkaGOhp3ky9y96rG8lhhy3sJCJToimM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iwucvk/3zPnT3tEdEHqgQxvJSq9CXa7yh8gF93fxGH8=;
        b=TIia2OHyDEANJUxk/OYTHqu2EzOgK977l2Om3xJOncQSFPYyq05lxv1m24BwU4IYAu
         a7cY+9xmoAflqC95ycAS8O5Dm9BUC2jB0GAb+YRtshySsX6W81Nq0+VrPNlkvu3pW5iY
         wVvLnANShBj8IddH9uPRl5uHTYZqRVJ6OISS4/ZyRLzxj6ipKRey0moCbDbyCqa02mGR
         oovWFc+WNlI5WLuIWxzxad+V5v2kY1Tm+vzdQ87+qgiHUkajTKfY/VxOcVe9KWgVpI4h
         8bgB1tVsF2HfnR+QBzgNxPpxX7NXmsnkTa6MNAL4dcg0fPlbSNKYk8nzSlIXXsbDtLCC
         F08A==
X-Gm-Message-State: ABuFfoi3EJUSkbyzn9//74kymi18nOSDkNaQUj7B/3jyiz2lLC8od0c5
        F89eToNJuvk0509Wx/IBprgp+3oxTrKblP9MTqyz1Q==
X-Google-Smtp-Source: ACcGV62elQ2ZSoexP6OAEM7/rQprGX0iZBn8ipd41iYiFPguA11icQ61GyQ2Kq6/rlFGvusBCZ5/6yK30Qr7nd6bJxc=
X-Received: by 2002:a24:6b4d:: with SMTP id v74-v6mr856527itc.26.1539070281374;
 Tue, 09 Oct 2018 00:31:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Tue, 9 Oct 2018 00:30:41 -0700 (PDT)
In-Reply-To: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Oct 2018 09:30:41 +0200
Message-ID: <CAPDyKFp0oHHS=bkXj_AbiLmbNxW07pFnk-4m9kwQtYkh_ogKgw@mail.gmail.com>
Subject: Re: [PATCH V6 00/23] mmc: mmci: add sdmmc variant for stm32
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 October 2018 at 14:08, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> The goal of this serie is to add support of sdmmc for stm32.
> Be to able to add this new variant it is needed to do some changes in
> mmci core:
> -Internalize specific needs of legacy dmaengine.
> -Create and setup dma_priv pointer.
> -Create generic callbacks which share some features (like cookie...)
>  and call specific needs.
>
> change v6:
> -move mmci_variant_init in mmci.c
> -dma_setup/release: let the variants clean up themselves.
>
> change v5:
> -error management in mmci_dmae_setup and qcom_dma_setup
>  mmci_dmae_setup: fail when tx & rx are not defined.
>  qcom_dma_setup: faill if one of channels is not defined.
> -define mmci_variant_init following CONFIG_DMA_ENGINE state.
> -squash dma_setup/dma_release callback.
>
> change v4:
> -checkpatch fix bool to u8
> -add use_dma variable to fallback to pio mode
> -move to optional reset with dt binding note for sdmmc
> -separate patch for DT doc
>
> change v3:
> -remove __dma_inprogress rename
> -remove bad space at end of "st,use-ckin"
>
> change v2:
> -rename to mmci_prep/unprep_data
> -rename specific dma engine structure to mmci_dmae_next/priv
> -follow "_" recommandation
> -remove dma prefixe of mmci_dmae_priv fields
>
> Ludovic Barre (23):
>   mmc: mmci: create common mmci_dma_setup/release
>   mmc: mmci: introduce dma_priv pointer to mmci_host
>   mmc: mmci: merge prepare data functions
>   mmc: mmci: add prepare/unprepare_data callbacks
>   mmc: mmci: add get_next_data callback
>   mmc: mmci: add dma_start callback
>   mmc: mmci: add dma_finalize callback
>   mmc: mmci: add dma_error callback
>   mmc: mmci: add validate_data callback
>   mmc: mmci: add set_clk/pwrreg callbacks
>   mmc: mmci: add datactrl block size variant property
>   mmc: mmci: expand startbiterr to irqmask and error check
>   mmc: mmci: add variant properties to define cpsm & cmdresp bits
>   mmc: mmci: add variant property to define dpsm bit
>   mmc: mmci: add variant property to define irq pio mask
>   mmc: mmci: add variant property to write datactrl before command
>   mmc: mmci: add variant property to not read datacnt
>   dt-bindings: mmci: add optional reset property
>   mmc: mmci: add optional reset property
>   mmc: mmci: add clock divider for stm32 sdmmc
>   mmc: mmci: add stm32 sdmmc registers
>   dt-bindings: mmci: add stm32 sdmmc variant
>   mmc: mmci: add stm32 sdmmc variant
>
>  Documentation/devicetree/bindings/mmc/mmci.txt |  11 +
>  drivers/mmc/host/Kconfig                       |  10 +
>  drivers/mmc/host/Makefile                      |   1 +
>  drivers/mmc/host/mmci.c                        | 628 ++++++++++++++++++-------
>  drivers/mmc/host/mmci.h                        | 140 +++++-
>  drivers/mmc/host/mmci_qcom_dml.c               |  17 +-
>  drivers/mmc/host/mmci_stm32_sdmmc.c            | 282 +++++++++++
>  7 files changed, 886 insertions(+), 203 deletions(-)
>  create mode 100644 drivers/mmc/host/mmci_stm32_sdmmc.c
>
> --
> 2.7.4
>

Applied for next, thanks!

FYI, I made little fixup of the help text in the Kconfig for the last patch.

Kind regards
Uffe
