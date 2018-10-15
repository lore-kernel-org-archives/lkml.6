Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6028C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FB020853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FB020853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeJOP10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:27:26 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44696 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:27:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so17975804otf.11;
        Mon, 15 Oct 2018 00:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBq2rN2ny0NQ/6TjHO0DVqb9QWC5/7npaAC7DHfzhDo=;
        b=OxHcShYn+M48cpWf48jXDm4zIABkHJJl6LM4ctyBpxX5Mmga8Q9jyyj1A9fV6Rsv/j
         op+4PhXoblIPSGxPf1TVnA7yaCI58j7fpojwtsobBxdnfWNbgqsqxp/J5kEobYNkoH+p
         InrpKXAs0mF3/GTjJJhknrY0PDknbTeTsR5/Ie2MBxlNGo8XKVoqR9nVinApcW9a7PRy
         cIdFstC5HbluuREgJZuHrlY5ZTxS4CktipU6bOGqDjtYF2BJpEwfeGDnT0vJJT49Bj87
         XLmkL0CdSOTDq40GxH1MqkOZ2CNHCUmKxQ70lNvoOoOCASKQlnAHhPnR/0YCjv8kKlC8
         bwEw==
X-Gm-Message-State: ABuFfojJMOAgZGjCf05i5JlZ+n61qtE/Ow6eQqcRnH127kxfGM2N0ca6
        5Y8i8nbZT4Mjkf4RbBr8Ni+Jl/YyBOxiAKd3fV4=
X-Google-Smtp-Source: ACcGV62NxO+xbw7l3gLEf0obNm2yqru52HSxTuafLrSV/rotXoD157coA+KCPo7CxjTj93xttT+2U06N/fsQLhfll4U=
X-Received: by 2002:a9d:538c:: with SMTP id w12mr10732308otg.139.1539589399738;
 Mon, 15 Oct 2018 00:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-2-hch@lst.de>
In-Reply-To: <20181013151707.32210-2-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Oct 2018 09:43:04 +0200
Message-ID: <CAJZ5v0ju2Y=yQn9uz6HpYGw5BZovxYh2YbYD7Ujq8kajJfvLSQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] cpufreq: tegra186: don't pass GFP_DMA32 to dma_alloc_coherent
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-tegra@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 5:17 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The DMA API does its own zone decisions based on the coherent_dma_mask.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
> index 1f59966573aa..f1e09022b819 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -121,7 +121,7 @@ static struct cpufreq_frequency_table *init_vhint_table(
>         void *virt;
>
>         virt = dma_alloc_coherent(bpmp->dev, sizeof(*data), &phys,
> -                                 GFP_KERNEL | GFP_DMA32);
> +                                 GFP_KERNEL);
>         if (!virt)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.19.1
>
