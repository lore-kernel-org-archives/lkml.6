Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A7DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736D020652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dp/56gKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736D020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJOVBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:01:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33135 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeJOVBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:01:39 -0400
Received: by mail-it1-f196.google.com with SMTP id h6-v6so27569603ith.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZDGwDgjZ9JwN9cQiAYwz0Is+icJtR1LqnDxLDlWZij4=;
        b=Dp/56gKHOruk1DW1td3BidwTQsJe1IGNCat7R0LeJ0duLAl6j2ctHHbu/Fq3OfLiUQ
         zCvDy8p7SjYMtuSo1DXwL8EAb81bzLYLjp1AevRKRJ3MHSLDen1w3IZoHAH0vJoH1TYM
         LRIHQV+OSj1f5UapQvPMwEFCk8Ht+CbChp1og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZDGwDgjZ9JwN9cQiAYwz0Is+icJtR1LqnDxLDlWZij4=;
        b=X3PBXPnqwNhQTiXMZCROiB1uSc9C3CdTMV8B4X/CMT+krKuAfNjlGew0xru1cY9U4H
         Iu+Z4VOeaEumWKSLYpb3lk/RtZV4A9wqYivX7LyKQIHJ5gnNvveAP1AWO9wofLE7ILiI
         sUZU5UACj5xeQafZjTan35Thu6GA5Zvykd5gu8WL1rgT+cR4KBDPdBs3ILDCFNiOPW02
         FIpIq+GVUHHJks1UtdmMcejwNa+GyDa4HTe13aqFA5g9TQfE0XFylMFuaiahbq8VOXXe
         8OfSSSjL3oy9Dn+rW0hbcctzG4SibYagddnZzWtRvIKj0Wz1Daif1pZsS9yku/IyE0TG
         r9Aw==
X-Gm-Message-State: ABuFfojnLMr/k2BpccWA/GRfTYMMtYITSPggAOxQydaNgdIMhX0CrJow
        rhr0FM7RSleTfUFW0kXN/SDxq7S9nMctZm9Sq5XoVQ==
X-Google-Smtp-Source: ACcGV614BrhY9T5HCRx2KON0AlF0bO+hD+NyJZxqmjCGnsrhYMUMaZKAngynvJWKMmTOgG7c+gjGc6065T2T+yA7680=
X-Received: by 2002:a24:554c:: with SMTP id e73-v6mr12383816itb.157.1539609383377;
 Mon, 15 Oct 2018 06:16:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 06:15:43
 -0700 (PDT)
In-Reply-To: <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com> <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Oct 2018 15:15:43 +0200
Message-ID: <CAPDyKFqa__C+34=tFRnysEz0R2Xy-ZAZSHp1JEv=pOEsfK2VWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: uniphier-sd: fix DMA disabling
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
> Once DMA is enabled, it is not possible to disable it because
> uniphier_sd_dma_endisable() always sets the DMA_ENABLE_DMASDRW bit
> regardless of the argument 'enable'. It should disable DMA when
> 'enable' is false.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/uniphier-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 10e7b30..10d49aa 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -78,7 +78,7 @@ static void *uniphier_sd_priv(struct tmio_mmc_host *host)
>
>  static void uniphier_sd_dma_endisable(struct tmio_mmc_host *host, int enable)
>  {
> -       sd_ctrl_write16(host, CTL_DMA_ENABLE, DMA_ENABLE_DMASDRW);
> +       sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? DMA_ENABLE_DMASDRW : 0);
>  }
>
>  /* external DMA engine */
> --
> 2.7.4
>
