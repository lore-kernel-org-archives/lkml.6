Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004D3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D372084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6gRoITN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeLQIuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:50:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46976 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeLQIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:50:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so8786980lfc.13;
        Mon, 17 Dec 2018 00:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvxAbEnQmhD6O7pfOq+xyox5zauNKn8x4r7NjMwfiTk=;
        b=X6gRoITNt3/Nno5QnkTE2609YHgWgr/GaIr6anzjMKKru+EfKCSH875qzlcrqDDBFb
         ZmJKlbJ8IxDi83dWQAq1hwQj4g6PtH8XUAkWN8X7r03iraYezHwpjV7P899V9yYyGyQ9
         H/t0/hB+aIl675WQ/u+N2KCRDq7HM9SnCxobedje5yccy9t7M8C5bKfZIJzrkFABMrfL
         pULI6z4LGewz3rUQ0c240v3WdklvtezXCFeqzwb3U5Cb3lMLCnPsNVC474zaVCXxIAWL
         tI5zjKZ8YQsLiwJV/qZQE8ovunMqPsXVd613wc0feFpuUH4eRgxNFo9AZZtz+K3SD3PR
         XFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvxAbEnQmhD6O7pfOq+xyox5zauNKn8x4r7NjMwfiTk=;
        b=d7Eyci8q8yTPlosPleLo9E6z9MGvtD+Sbx0m7HEKdqt3sXudwSJTyoRwYhzw7g2+e4
         gm63mHL+IxTJ49BUzSFH2JebHR/FV1Q9zdWuIwgFfx7igVyheRnfUT/pj1U1qwk+elZ9
         bo3BxSkByW0kMw4xBCqNguIfQpzzZ9+ccNBNHbZVheuzDV5hQ+wgJ8lWOyzpwpXZATyL
         80HKPnaIL6x9olcUcE82U55fZVedpgK9z6+/Bed/1lY7v5MKu2Qg1joBKZBvghrQgP7Y
         Dy1iReAtL4Y8y3m0RAb0shMIrl28m+slVRshvKbuib8C3mLQDphLgrpKYkBLdbQf/zob
         vxvg==
X-Gm-Message-State: AA+aEWY8oXG3bGFcXrZi3twY3LdUjvKlxd2joRhwRbO32NOm8krC7ROt
        dmRQ3sjBKyvL80UWsmZG0uvekk5cP3Q/8wIZRqc=
X-Google-Smtp-Source: AFSGD/V+fPXlggixcBqnnAzgxmII8ihsMB8RiuIaasAKyzTTg7GoXWQ2+qyoqeZgvki253HB0cTa10YnjkXavgLtrD0=
X-Received: by 2002:a19:8096:: with SMTP id b144mr7317813lfd.8.1545036649586;
 Mon, 17 Dec 2018 00:50:49 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
In-Reply-To: <20181216101858.9585-7-starnight@g.ncu.edu.tw>
From:   Xue Liu <liuxuenetmail@gmail.com>
Date:   Mon, 17 Dec 2018 09:50:13 +0100
Message-ID: <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jian-Hong,

Thanks for your work in LoRaWAN.
I have a question about the architecture of your module. AFAIK LoRaWAN
is already the MAC Layer above the LoRa technology. Why do you want to
make a new layer called "maclorawan" ?

Regards,

Xue Liu


On Sun, 16 Dec 2018 at 11:20, Jian-Hong Pan <starnight@g.ncu.edu.tw> wrote:
>
> List LORAWAN and MACLORAWAN in menuconfig and make they can be built.
>
> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> ---
> V2:
> - Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
>   LoRaWAN Soft MAC modules
>
>  net/Kconfig  | 2 ++
>  net/Makefile | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/net/Kconfig b/net/Kconfig
> index cf2e651ee31d..03b3ff306778 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -224,6 +224,8 @@ source "net/6lowpan/Kconfig"
>  source "net/ieee802154/Kconfig"
>  source "net/mac802154/Kconfig"
>  source "net/lora/Kconfig"
> +source "net/lorawan/Kconfig"
> +source "net/maclorawan/Kconfig"
>  source "net/sched/Kconfig"
>  source "net/dcb/Kconfig"
>  source "net/dns_resolver/Kconfig"
> diff --git a/net/Makefile b/net/Makefile
> index e80b84313851..9d5515965a8f 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -63,6 +63,8 @@ obj-$(CONFIG_6LOWPAN)         += 6lowpan/
>  obj-$(CONFIG_IEEE802154)       += ieee802154/
>  obj-$(CONFIG_MAC802154)                += mac802154/
>  obj-$(CONFIG_LORA)             += lora/
> +obj-$(CONFIG_LORAWAN)          += lorawan/
> +obj-$(CONFIG_MACLORAWAN)       += maclorawan/
>
>  ifeq ($(CONFIG_NET),y)
>  obj-$(CONFIG_SYSCTL)           += sysctl_net.o
> --
> 2.20.0
>


--
