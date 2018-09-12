Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4CBC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7722520896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2NmMXM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7722520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeILLCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:02:39 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38695 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeILLCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:02:39 -0400
Received: by mail-yb1-f196.google.com with SMTP id e18-v6so550833ybq.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWBz5DaLJ36DUrzyNAIpS24Feak8l8whZ2l05V66wBA=;
        b=i2NmMXM+SxCecLal6Ey2KeRFlqxTEvMKQt0l01z+R7NltmQJiPBj8kjTC3RVJvkIwn
         zcviN7eAW3hnaua0fFpOSsbhekqNF7iB9axu4y4sVE5rzmAhYlnDSqOedzG/vUmfJ4tj
         jKKDmE1Mze8jMkuJIIlxcqpu9BlI0SdpoKJZh0oe1ZaUK0Me94PLhX+Tf+yTGz9CH+Zd
         4fKZN8lp8wfrXJsJYP7iBG+Vu06qE5owCbrv6FRiYMwwe9MAqXv5gNB7P5MX5YHoZMJN
         msUcYlAG4vDwIAVMXqiuABKjc4pdGIm8f7Y2E77o5fJ7keELbrxTENDSzRcNopSxTJsS
         xfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWBz5DaLJ36DUrzyNAIpS24Feak8l8whZ2l05V66wBA=;
        b=tgiZY1CI2cjSfULKQicapwXFp723AwqiLzoBL5kNozNJy6pzXVbZmUmpLM0n3J8n0U
         +Xakd+zg+OEpMvralkKtCsWU+xQfspOL+zWnx1v4d0u1W0BaedwrFquJRa+IQOw9qNjC
         bdShMoGM+kxY+SgyhEn07jpcoNujkYjG1HgymY1ZdKtsR9Q3v0yzJUUlFQ2vxOl/ezdq
         prxe4z/gV/Zkm0g7B3lSGYdZXNeeVJKcxZOt9RLqB758VplIJ15SfahcYcLMYA0YHR6A
         LRNCXszhF2Zkod3Xifxn1VpqxhhjgBDOBf+9f0g0WUlq19xT2Neg9lvsCRsYUxMDdRy5
         KimA==
X-Gm-Message-State: APzg51DHTK2Urm9f4P60/kKod38V3qhFn/975HW8s+i32Z505Hso3EXI
        a1vnWQefmzP2x9n4Gf9DaAdIi2S66K3tHIskptU=
X-Google-Smtp-Source: ANB0Vdaz41x1t7dhE4M23QdosHKbPFH9XrpOtFHeHMk8PhwDbHePgxSVoXquGBhQ4i0SdYjogj1luMzpQ6IxTho4594=
X-Received: by 2002:a25:9b06:: with SMTP id y6-v6mr113656ybn.86.1536731984044;
 Tue, 11 Sep 2018 22:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <1536723628-50914-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536723628-50914-1-git-send-email-zhongjiang@huawei.com>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Wed, 12 Sep 2018 11:29:31 +0530
Message-ID: <CAAs364_nffauHCKdzpvb5+n01FtkKHRCj4DL=MC7oworXgOSTw@mail.gmail.com>
Subject: Re: [PATCH] staging: remove unneeded static set .owner field in platform_driver
To:     zhongjiang@huawei.com
Cc:     Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 9:22 AM zhong jiang <zhongjiang@huawei.com> wrote:
>
> platform_driver_register will set the .owner field. So it is safe
> to remove the redundant assignment.
>
> The issue is detected with the help of Coccinelle.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/staging/greybus/audio_codec.c    | 1 -
>  drivers/staging/mt7621-eth/gsw_mt7621.c  | 1 -
>  drivers/staging/mt7621-eth/mtk_eth_soc.c | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index 35acd55..08746c8 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -1087,7 +1087,6 @@ static int gbaudio_codec_remove(struct platform_device *pdev)
>  static struct platform_driver gbaudio_codec_driver = {
>         .driver = {
>                 .name = "apb-dummy-codec",
> -               .owner = THIS_MODULE,
>  #ifdef CONFIG_PM
>                 .pm = &gbaudio_codec_pm_ops,
>  #endif
> diff --git a/drivers/staging/mt7621-eth/gsw_mt7621.c b/drivers/staging/mt7621-eth/gsw_mt7621.c
> index 2c07b55..53767b1 100644
> --- a/drivers/staging/mt7621-eth/gsw_mt7621.c
> +++ b/drivers/staging/mt7621-eth/gsw_mt7621.c
> @@ -286,7 +286,6 @@ static int mt7621_gsw_remove(struct platform_device *pdev)
>         .remove = mt7621_gsw_remove,
>         .driver = {
>                 .name = "mt7621-gsw",
> -               .owner = THIS_MODULE,
>                 .of_match_table = mediatek_gsw_match,
>         },
>  };
> diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
> index 7135075..363d3c9 100644
> --- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
> +++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
> @@ -2167,7 +2167,6 @@ static int mtk_remove(struct platform_device *pdev)
>         .remove = mtk_remove,
>         .driver = {
>                 .name = "mtk_soc_eth",
> -               .owner = THIS_MODULE,
>                 .of_match_table = of_mtk_match,
>         },
>  };
> --
> 1.7.12.4
>

Acked-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
