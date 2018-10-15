Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F81C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AD920652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOkR3+s0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AD920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeJOVBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:01:44 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55453 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeJOVBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:01:44 -0400
Received: by mail-it1-f193.google.com with SMTP id c23-v6so28524709itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SWFovABLKIUUE6zBWgAygUyuiGf3v9aJ3MdNALxV98w=;
        b=jOkR3+s0iys4cftSJFpoADzZCwDh7SFru/UFwCd/n0FJbXdBcrwVqcImC8sgMekQZU
         M0rqDJZJVaHD8apUDhzTarUuID7JaP6HwpZqTDYNytHrw/DPxd6xyAaCclfuuFB1M2eQ
         iRKDtIwOFIDNXAFV3/YVhiA51AiZa+3/5ZNyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SWFovABLKIUUE6zBWgAygUyuiGf3v9aJ3MdNALxV98w=;
        b=C+RQlMPdd50ZdwCTV17vEEDqlBmuU1Y9K9fkddFR5oiYu9gl2McZkSIXI5jMZ9uOjY
         0QIhVQxlg6joZCNDzCdvzGetlPjBGmm38GfOnx/cEoj2/NI524n8NkPnKajbde9Dzjz+
         T7PX0GlCAU9xl9Twv8s/YPr6O85meD0wo77TfqqPca4J6cXqgP7c5NGPAdbOLsjH+Z5t
         356Ij0qbKon1Y1tMKWSNFZvmaEf+OoQwVtQ8txAw1cqIok2iJZtBa6rnv/BxJKKXtCAf
         WGHD9uDvIujiBTGA+S6munT9ptKAZBqqaDVsPdO8SA26TgZL94umIbS7bx18ykLqYMcj
         0PQQ==
X-Gm-Message-State: ABuFfoiMHOojJbbFSzCO5/3IOJWMukqM/uGDuAekZ1lTuM3HlAqlXJYy
        DZ2hiqlO1bCKPDYXAj1lWyg+7YEyxLWtAq6XdskJUg==
X-Google-Smtp-Source: ACcGV613s7m+5quwzPOkXcRdpWlgPSy9Cenl7P6fkWY2g723/JXaDl+NcRPZwYq2SatBuNARp9ZA65aMHyvtM+cGScI=
X-Received: by 2002:a24:4795:: with SMTP id t143-v6mr11905484itb.78.1539609388055;
 Mon, 15 Oct 2018 06:16:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 06:15:47
 -0700 (PDT)
In-Reply-To: <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com> <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Oct 2018 15:15:47 +0200
Message-ID: <CAPDyKFpYggUu2WDsR1CENKJDyCpZ1Nh+DrO3=oT1euGLNurxBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: uniphier-sd: avoid using broken DMA RX channel
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 16:57, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> host->chan_rx is NULL when UNIPHIER_SD_CAP_BROKEN_DMA_RX quirk flag
> is set. In this case, it should not set up DMA.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/uniphier-sd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 10d49aa..1ee9fd0 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -251,6 +251,9 @@ static void uniphier_sd_internal_dma_start(struct tmio_mmc_host *host,
>         u32 dma_mode;
>         int sg_len;
>
> +       if ((data->flags & MMC_DATA_READ) && !host->chan_rx)
> +               goto force_pio;
> +
>         if (WARN_ON(host->sg_len != 1))
>                 goto force_pio;
>
> --
> 2.7.4
>
