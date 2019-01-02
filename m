Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F344C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A0E218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYMwdb6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfABSAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:00:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41624 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfABSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:00:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so31285057wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 10:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crmJ+Hige/rGqRrSYyXt9V+tTDSuqc5vu0JbeeQ95MI=;
        b=HYMwdb6REUv9VQ3hvyMZy0tsSLP6CdaJOuBwX++M85lGTQ2t3GkXHAIV5qLwDNo/jM
         2Tp6AmrO9AzF2yEhbTEHinlUMem78yJcQ1XmgtMLaDX3emfPsJkIIAkgEWBT5k5V1VMO
         SUdErX1uC3HkxLcFbsbWr3OXrBooMoz4dVjwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crmJ+Hige/rGqRrSYyXt9V+tTDSuqc5vu0JbeeQ95MI=;
        b=dYO1a0Fmx5rxU215hgFlEFDEVVKKAzj79eO1zKXRk4xqcMv452mNFZsMRoV+4vkxRC
         NaNsuSyIsk1wfOZAVmyL0tWIWX0clKP/Ry9GwHOCN5XAz7z2+yvZxZLCnNzn4e6++pD4
         Twh+LAKz/I9F8tUN9XuD4ncZI3UEq/Q0Qq2wNMcI7wnjYjw7IztTLvn6OGCsTna+eeAD
         B/v3UbG2b81+C/0/xjOBEay/ItOOHepUacx3s2Bkhg3kyOYkxIsr3yL0Eq2X/y3HxIXz
         qlKgLYezsSuuIO2vjjcTRiYrnJODqTVQxf2a4FS8a7HueRQ57/68hPfiGn0nzG4wZfo6
         uo+w==
X-Gm-Message-State: AJcUukeBrC6DSOhN3jvkyPlrmSWoMNYrn6i7lv92OrUkWUoUhgq2/0Hr
        kszTg73sho6+1VwqZxQ31LGPaZ7YdJaQhIkhGbS2yg==
X-Google-Smtp-Source: ALg8bN7EppCifOtzPEcN8dpB/+i2dd9Gmj/20uw6E369/AIGGqNL9aUG0sPXilgQhF8JkwUf/7SV/AHrb7C4NJKsgJU=
X-Received: by 2002:a5d:6988:: with SMTP id g8mr37231230wru.33.1546452027972;
 Wed, 02 Jan 2019 10:00:27 -0800 (PST)
MIME-Version: 1.0
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com> <1545978983-124360-2-git-send-email-hutenghui@huawei.com>
In-Reply-To: <1545978983-124360-2-git-send-email-hutenghui@huawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 2 Jan 2019 10:00:15 -0800
Message-ID: <CALAqxLW_eGX25sZKVCpGwoq94QdYj9K2nJg6buh=FAZZt_Cuhg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dmaengine: Extend the k3dma driver binding
To:     h00249924 <hutenghui@huawei.com>
Cc:     dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        wwx575822@notesmail.huawei.com, hanxiaolong3@hisilicon.com,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Hantanglei <hantanglei@huawei.com>,
        Kongfei <kongfei@hisilicon.com>,
        ninggaoyu <ninggaoyu@hisilicon.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liyuequan <liyuequan@hisilicon.com>,
        "huangli (I)" <huangli295@hisilicon.com>,
        wangyoulin <wangyoulin1@hisilicon.com>,
        "Qianli (A)" <cash.qianli@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 10:39 PM h00249924 <hutenghui@huawei.com> wrote:
>
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
>
> Extend the k3dma driver binding to support hisi-asp hardware variants.
>
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt | 33 ++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> index 4945aea..cd21b82 100644
> --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> @@ -3,7 +3,9 @@
>  See dma.txt first
>
>  Required properties:
> -- compatible: Should be "hisilicon,k3-dma-1.0"
> +- compatible: Must be one of
> +-              "hisilicon,k3-dma-1.0"
> +-              "hisilicon,hisi-pcm-asp-dma-1.0"
>  - reg: Should contain DMA registers location and length.
>  - interrupts: Should contain one interrupt shared by all channel
>  - #dma-cells: see dma.txt, should be 1, para number
> @@ -43,3 +45,32 @@ For example, i2c0 read channel request line is 18, while write channel use 19
>                         dma-names = "rx", "tx";
>                 };
>
> +
> +
> +
> +Controller:
> +               asp_dmac: asp_dmac@E804B000 {
> +                       compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
> +                       reg = <0x0 0xe804b000 0x0 0x1000>;
> +                       #dma-cells = <1>;
> +                       dma-channels = <16>;
> +                       dma-requests = <32>;
> +                       dma-min-chan = <0>;
> +                       dma-used-chans = <0xFFFE>;
> +                       dma-share;

Thanks for sending this out!

So min-chan, used-chans and dma-share aren't in the existing binding
document. So they probably should be removed from this example, or the
binding document needs to be updated first.

thanks
-john
