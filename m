Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B3C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91928235FB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QG5ag95t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91928235FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753816AbeGEOUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:20:47 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41472 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753591AbeGEOUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:20:45 -0400
Received: by mail-io0-f196.google.com with SMTP id q9-v6so7890398ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gTzL1Q3jUHS6ruP9SZrV+PC7rxK8dowebehtUkAgyvo=;
        b=QG5ag95tSiHlU23jCrjJmc1hBiOQBgjUl+PrjqXulFSI0pPx+2FGotKW/KX66+RwAV
         Vl9bKr3UCe1poeketv/v9yEbTIib6i7IJ2EkRC5gX+VvIlJVoGGYuEjZiOtIlzoJiSTC
         h0e5yF9fUICsDp0HPSz2iU9hX1eD6L5qJsnlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gTzL1Q3jUHS6ruP9SZrV+PC7rxK8dowebehtUkAgyvo=;
        b=me+BGTG5zac++5SMvNd23T4bVfYaHZuw6eSNpGfrIN42+XOSVfHWogQEtKjD8zNN32
         1OwJC3m7SnjlTTew16IvVSGAmY2vOUUd20mx/tBLmNlX5LGCE3LanSXQ0lIUbCwLEbe6
         S3U2I+SOzeBBcdDCdeWBxWZ+AB1vTrSJ0Tygx58/rzqEIqPaSfbAplxMOo0mguNnv0Qa
         /xYFnVxmtFghoatiZAjGdfb/9VT7dgyzNM9QegNbArd+OsTiHwngpPwzbPNkr9TCYyWr
         B0QLynU8g+wjiBVa0Vh3ix0YSIRc4Kl+sT9QyBByuOS10dIv6ndtH6TJNUAl0+8Q+IA+
         6TWQ==
X-Gm-Message-State: AOUpUlHIpI2ucyMIQZezOOKnEpZpeMEkePpUcj4XDCYnaMxZERQv+ku6
        j3nAGKnZUqJHqWT9h7u7VI38tbil0sBVCPUA9XgQWw==
X-Google-Smtp-Source: AAOMgpcpwjY8J+C6vhDyLH+Qh+dOESNosFsu/hOJSEaohT8eDLw78ruENOG7/RAmqdu/eJqU7wNyT72GGRyfOElP9TE=
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr5025478iou.218.1530800444579;
 Thu, 05 Jul 2018 07:20:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 07:20:43 -0700 (PDT)
In-Reply-To: <1528809280-31116-7-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <1528809280-31116-7-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 16:20:43 +0200
Message-ID: <CAPDyKFoFkfX=4znJL1z94kj9ZTojMe=t76xXUCAzYRX59=rpPQ@mail.gmail.com>
Subject: Re: [PATCH 06/19] mmc: mmci: add variant properties to define cpsm &
 cmdresp bits
To:     Ludovic Barre <ludovic.Barre@st.com>
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

On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds command variant properties to define
> cpsm enable bit and responses.
> Needed to support the STM32 variant (shift of cpsm bit,
> specific definition of commands response).
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
>  drivers/mmc/host/mmci.h |  8 ++++++++
>  2 files changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 801c86b..52562fc 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -51,6 +51,10 @@ static unsigned int fmax = 515633;
>  static struct variant_data variant_arm = {
>         .fifosize               = 16 * 4,
>         .fifohalfsize           = 8 * 4,
> +       .cmdreg_cpsm_enable     = MCI_CPSM_ENABLE,
> +       .cmdreg_lrsp_crc        = MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
> +       .cmdreg_srsp_crc        = MCI_CPSM_RESPONSE,
> +       .cmdreg_srsp            = MCI_CPSM_RESPONSE,

Do these really needs to be a superset of each other?

Maybe it becomes easier for the STM32 variant later though...

[...]

> @@ -603,16 +639,19 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)

While at it, would you mind folding in a cleanup patch removing the
"u32 c" as in-parameter? It's currently always set to "0" by the
caller, so it's not needed.

>         dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
>             cmd->opcode, cmd->arg, cmd->flags);
>
> -       if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
> +       if (readl(base + MMCICOMMAND) & host->variant->cmdreg_cpsm_enable) {
>                 writel(0, base + MMCICOMMAND);
>                 mmci_reg_delay(host);
>         }
>
> -       c |= cmd->opcode | MCI_CPSM_ENABLE;
> +       c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136)
> -                       c |= MCI_CPSM_LONGRSP;
> -               c |= MCI_CPSM_RESPONSE;
> +                       c |= host->variant->cmdreg_lrsp_crc;

This looks weird. Probably because of the naming of the variant data.

Perhaps rename to "cmdreg_lrsp", thus skipping the "_crc" suffix?

> +               else if (cmd->flags & MMC_RSP_CRC)
> +                       c |= host->variant->cmdreg_srsp_crc;

Why is here an else? We can have both MMC_RSP_136 and MMC_RSP_CRC bits
set, right!?

> +               else
> +                       c |= host->variant->cmdreg_srsp;

What do you think about using a switch-case, perhaps with fall-through
- and then adding those bits that are needed for each response
bit+variant instead? Could that make this more readable?

>         }
>         if (/*interrupt*/0)
>                 c |= MCI_CPSM_INTERRUPT;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 7265ca6..e173305 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -239,6 +239,10 @@ struct mmci_host;
>   * @clkreg_enable: enable value for MMCICLOCK register
>   * @clkreg_8bit_bus_enable: enable value for 8 bit bus
>   * @clkreg_neg_edge_enable: enable value for inverted data/cmd output
> + * @cmdreg_cpsm_enable: enable value for CPSM
> + * @cmdreg_lrsp_crc: enable value for long response with crc
> + * @cmdreg_srsp_crc: enable value for short response with crc
> + * @cmdreg_srsp: enable value for short response without crc
>   * @datalength_bits: number of bits in the MMCIDATALENGTH register
>   * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>   *           is asserted (likewise for RX)
> @@ -282,6 +286,10 @@ struct variant_data {
>         unsigned int            clkreg_enable;
>         unsigned int            clkreg_8bit_bus_enable;
>         unsigned int            clkreg_neg_edge_enable;
> +       unsigned int            cmdreg_cpsm_enable;
> +       unsigned int            cmdreg_lrsp_crc;
> +       unsigned int            cmdreg_srsp_crc;
> +       unsigned int            cmdreg_srsp;
>         unsigned int            datalength_bits;
>         unsigned int            fifosize;
>         unsigned int            fifohalfsize;
> --
> 2.7.4
>

Kind regards
Uffe
