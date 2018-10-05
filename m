Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417ACC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17A4206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikqcjNUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17A4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbeJEUxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:53:40 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36655 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbeJEUxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:53:39 -0400
Received: by mail-it1-f194.google.com with SMTP id c85-v6so2828890itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7nfceMikU08L+HXMtD2676viK6okIVpTVlS66oQ5N8w=;
        b=ikqcjNUhfl7F3YaJOdKzTMobm+2USpOKgB07z3ifX8W8LZ3AK8VNpnqMyYh/oQSq2n
         cR4s/3Mp27RmW6EfzBGp3vs8pjs0IdgPcdZswnfxWxsM9UkFPZq0tv9vN/6ZMCH3vGLl
         yxC0YVa2ZEOXRpSAsKoNIwEkV42He6idIGD/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7nfceMikU08L+HXMtD2676viK6okIVpTVlS66oQ5N8w=;
        b=lxM3e7TN0MEDg4R8GEpG7pYWSrIWUW1M5IDWxsIjEG7V/ydzZBfk94Ueiy0azkQYiH
         3xcTfDs/g1HBdOywTEDzVzdm0YvYK0E/x99GrFatsy2/Bj6sB/pjdWgLc0dtozWTHQkx
         +feFkO5PTukjLaFn4DPQ22ayuMAHFVuomo5SsnuEcW9Tmu9dKcqDd9lxlPcu3dPk0+8B
         IxRxioEXdeaQJ7Z4GaoqiD5lV5kfU8gZwvZj5XGg7wY7nJpYpacIc8rSAktYxm3tlwzc
         9iYz5W04wwQnYsYzJmNYMw4LdWPKcrV14f6ExfmuesgxNHG6UtyM5DGFvkzwipgUSY7z
         2aDA==
X-Gm-Message-State: ABuFfohcrVCwCoWw6uudRCHS8WbmTPZIJZ/yCNEp2NRa/fMBWe2kCG7n
        z4xLRqbU7ddnKusP2LVpD6crNGBwe8WpofvP/X01fQ==
X-Google-Smtp-Source: ACcGV63Sm2+GZpThSPrr74fCrOPXwYZ3w174BPNpR1RukjkZjF9xhQJJ+VQFf1z0mHrfmAwMxfs9Il4MRDRNSKdyfvI=
X-Received: by 2002:a02:c909:: with SMTP id t9-v6mr80162jao.95.1538747688702;
 Fri, 05 Oct 2018 06:54:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 06:54:08 -0700 (PDT)
In-Reply-To: <1538745782-27446-2-git-send-email-ludovic.Barre@st.com>
References: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com> <1538745782-27446-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Oct 2018 15:54:08 +0200
Message-ID: <CAPDyKFrohvfQ7NhaX9J4ntJO6rPXg=p5GDkEq3u1_9NV0cM1mg@mail.gmail.com>
Subject: Re: [PATCH V5 01/24] mmc: mmci: Change struct members from bool to u8
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

On 5 October 2018 at 15:22, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> Recent versions of checkpatch have a new warning based on a documented
> preference of Linus to not use bool in structures due to wasted space and
> the size of bool is implementation dependent.  For more information, see
> the email thread at https://lkml.org/lkml/2017/11/21/384
>
> fix checkpatch --strict issues:
> -CHECK: Avoid using bool structure members because of possible alignment
>  issues - see: https://lkml.org/lkml/2017/11/21/384
> -WARNING: Avoid using bool as bitfield. Prefer bool bitfields as
>  unsigned int or u<8|16|32>
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 21aaf9a..01e6c6b 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -248,24 +248,24 @@ struct variant_data {
>         unsigned int            data_cmd_enable;
>         unsigned int            datactrl_mask_ddrmode;
>         unsigned int            datactrl_mask_sdio;
> -       bool                    st_sdio;
> -       bool                    st_clkdiv;
> -       bool                    blksz_datactrl16;
> -       bool                    blksz_datactrl4;
> +       u8                      st_sdio:1;
> +       u8                      st_clkdiv:1;
> +       u8                      blksz_datactrl16:1;
> +       u8                      blksz_datactrl4:1;
>         u32                     pwrreg_powerup;
>         u32                     f_max;
> -       bool                    signal_direction;
> -       bool                    pwrreg_clkgate;
> -       bool                    busy_detect;
> +       u8                      signal_direction:1;
> +       u8                      pwrreg_clkgate:1;
> +       u8                      busy_detect:1;
>         u32                     busy_dpsm_flag;
>         u32                     busy_detect_flag;
>         u32                     busy_detect_mask;
> -       bool                    pwrreg_nopower;
> -       bool                    explicit_mclk_control;
> -       bool                    qcom_fifo;
> -       bool                    qcom_dml;
> -       bool                    reversed_irq_handling;
> -       bool                    mmcimask1;
> +       u8                      pwrreg_nopower:1;
> +       u8                      explicit_mclk_control:1;
> +       u8                      qcom_fifo:1;
> +       u8                      qcom_dml:1;
> +       u8                      reversed_irq_handling:1;
> +       u8                      mmcimask1:1;
>         u32                     start_err;
>         u32                     opendrain;
>         void (*init)(struct mmci_host *host);
> @@ -290,7 +290,7 @@ struct mmci_host {
>         struct mmc_data         *data;
>         struct mmc_host         *mmc;
>         struct clk              *clk;
> -       bool                    singleirq;
> +       u8                      singleirq:1;
>
>         spinlock_t              lock;
>
> @@ -304,7 +304,7 @@ struct mmci_host {
>         u32                     datactrl_reg;
>         u32                     busy_status;
>         u32                     mask1_reg;
> -       bool                    vqmmc_enabled;
> +       u8                      vqmmc_enabled:1;
>         struct mmci_platform_data *plat;
>         struct mmci_host_ops    *ops;
>         struct variant_data     *variant;
> @@ -330,7 +330,7 @@ struct mmci_host {
>         struct dma_chan         *dma_tx_channel;
>         struct dma_async_tx_descriptor  *dma_desc_current;
>         struct mmci_host_next   next_data;
> -       bool                    dma_in_progress;
> +       u8                      dma_in_progress:1;
>
>  #define dma_inprogress(host)   ((host)->dma_in_progress)
>  #endif
> --
> 2.7.4
>
