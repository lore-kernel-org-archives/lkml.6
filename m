Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB883C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6632081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EZphzzcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6632081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeKBMjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 08:39:42 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34830 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeKBMjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 08:39:42 -0400
Received: by mail-vs1-f67.google.com with SMTP id d62so351893vsd.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 20:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e24YLQth++gDxulNFB9pkEQ2Gw5zX6UqlSG87FZPec4=;
        b=EZphzzcG5+7CuPeuxQKRHUDJa89gQi3geVFwCQS8RUTlPplfZwSRk2ENNphpVIWfm1
         4CuF8jh1oRGK2FHhCsDODYanLyct4CmaRMC28POjnUgDjatJUgKp4jLlBzL2fs49J+uP
         UYzPIrXMYRD+SR9KYrqdpnLL1SdwrpDk44NGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e24YLQth++gDxulNFB9pkEQ2Gw5zX6UqlSG87FZPec4=;
        b=FLN4QQHdbyAiqLC9a6PFRcuU8q6lmPPcX8Bf0R1D27RvOWZUyn+D6pyseyPOMrQE96
         jQnHhxZvopefb6rhEmnGoCl5iplTLPzzGmuEuqv3+taJEtOe3pVxEeReHtUSYretDRyd
         OD4/4Yk9f04N+aGH2gEHCIcsKZFj2WsG6W2C7IUe8+PPKL0Ls6DKNj7ONIf7/L9uEGq5
         SCeL4vTPI1ROeZg1VQt8T1IgAVRIV+3Es9NibRSimF0ploDK2oq1qg7G1Q6/6rFitFq5
         UiKxOkLBYEWly0KeiTD03Z8lCZJgZ1DuLUWore60iJJyDSK05zQMSz7lx4Ag8L2qQcrJ
         X+NA==
X-Gm-Message-State: AGRZ1gJEFEJrqpzEnJN7/+DBBALEph9AE39eyQP3Uxu0ZmAYaGG3ZK1L
        N+6DDfgFmRj2g6fvP5XMeYB8aQRHUUQwWTdq4ICBaL9L
X-Google-Smtp-Source: AJdET5ffIgx+h5wqdaLPfrNUG2RG1K4daKpTXIvavlOBedQLei+BEwOP7smRasvUUXhwkWRbS1poPdo72BrscCGqdV8=
X-Received: by 2002:a67:a205:: with SMTP id l5mr4132897vse.9.1541129644475;
 Thu, 01 Nov 2018 20:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181101124007.243258-1-cychiang@chromium.org>
In-Reply-To: <20181101124007.243258-1-cychiang@chromium.org>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Fri, 2 Nov 2018 11:33:37 +0800
Message-ID: <CAFv8NwJuTkth_xvPpWok_O9v9TXdGEj9ow+NCvnMiJqRJTrLvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] CHROMIUM: ASoC: rt5663: Add documentation for power
 supply support
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry! I made a mistake in the title.
I will fix them and re-post.
On Thu, Nov 1, 2018 at 8:40 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> rt5663 codec driver will support setting CPVDD and AVDD power supply
> from device tree.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  Documentation/devicetree/bindings/sound/rt5663.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
> index 23386446c63d6..d4058dfde0392 100644
> --- a/Documentation/devicetree/bindings/sound/rt5663.txt
> +++ b/Documentation/devicetree/bindings/sound/rt5663.txt
> @@ -36,6 +36,9 @@ Optional properties:
>    "realtek,impedance_sensing_num" is 2. It means that there are 2 ranges of
>    impedance in the impedance sensing function.
>
> +- avdd-supply: Power supply for AVDD, providing 1.8V.
> +- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
> +
>  Pins on the device (for linking into audio routes) for RT5663:
>
>    * IN1P
> @@ -51,4 +54,6 @@ rt5663: codec@12 {
>         compatible = "realtek,rt5663";
>         reg = <0x12>;
>         interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +       avdd-supply = <&pp1800_a_alc5662>;
> +       cpvdd-supply = <&pp3500_a_alc5662>;
>  };
> --
> 2.19.1.568.g152ad8e336-goog
>
