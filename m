Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9876EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4817F25D2A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rhVMtmV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4817F25D2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeFYPrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:47:41 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:24276 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeFYPrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:47:39 -0400
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5PFlacs008739;
        Tue, 26 Jun 2018 00:47:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5PFlacs008739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529941657;
        bh=0LA+WL7GlnRsGRxgEpEjM4q8aMgkaYa9oRfFkczhNhI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rhVMtmV9LIrL7Wo7SISxy48hTgnp6x6i93Tu0vS6Hz48bPKiQw3C/1L0VanGtzrBp
         PQFDN6P+CPnReRJbHkmzouvqFsfBIvRHi9325vAdhMEfztj3FLeFbj6X+fLruuk6Q/
         EcEiSNde8qKA8Bdzojm5Fw0JOdBUJeQ4wXNPoSkdBdT8kQCEst9GQEo4cW6Yt+4Fyu
         gzshIY5VVuqFBPPFQe4FHJ5EQKcQgr04ZJ5vB7jVBFUdix9mH2xjyEaYodR19CSnv0
         6HmiUUCCEljwKJWl5UE15ZyKI8UPrAFaDAoWNKnvQh+L+2uAeDRmMa4UXWZnTsGfAB
         Mk05m7SC6tUgw==
X-Nifty-SrcIP: [209.85.213.50]
Received: by mail-vk0-f50.google.com with SMTP id o138-v6so8134719vkd.3;
        Mon, 25 Jun 2018 08:47:37 -0700 (PDT)
X-Gm-Message-State: APt69E2TzhSc+DEA0IFaTA/QTNeEHzJlPxIPOU1YVtLGGyBuWhujBN4J
        2FV+TMAunBUsK/z2as7B2kIg+yZbCxAIiEiHgqk=
X-Google-Smtp-Source: ADUXVKL6zJo+9bLtKx28b3M1NF9WF2FN1fHKVYwzQkjEYPtoEw3tWf/PTxch6k4X4+o5QvuRkhj3pFLaTbLz6dZUlwo=
X-Received: by 2002:a1f:2348:: with SMTP id j69-v6mr7723421vkj.160.1529941656295;
 Mon, 25 Jun 2018 08:47:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 08:46:55
 -0700 (PDT)
In-Reply-To: <20180625034505.1404-1-suzuki.katsuhiro@socionext.com>
References: <20180625034505.1404-1-suzuki.katsuhiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 26 Jun 2018 00:46:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNARnMkTj3i=P80uiikhuD8xnX1wD85S9RRyFZzQ1BafpEA@mail.gmail.com>
Message-ID: <CAK7LNARnMkTj3i=P80uiikhuD8xnX1wD85S9RRyFZzQ1BafpEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: uniphier: add headphone detect gpio
 for LD20 global board
To:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-25 12:45 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch adds GPIO for headphone detection on LD20 global board.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

Applied.  Thanks!

> ---
>  arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> index 6a074a20c924..8aeb59486ff2 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> @@ -60,6 +60,7 @@
>                         &i2s_port4
>                         &spdif_port0
>                         &comp_spdif_port0>;
> +               hp-det-gpio = <&gpio UNIPHIER_GPIO_IRQ(0) GPIO_ACTIVE_LOW>;
>         };
>
>         spdif-out {
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
