Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE6EC64EB2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543F720652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EI9UCWUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543F720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbeJAQIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:08:31 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37857 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbeJAQIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:08:30 -0400
Received: by mail-it1-f195.google.com with SMTP id m9-v6so10472433ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B2uwAe7owLlekMWJ20nqwBIP27KWq8M/DXVcusnvDq0=;
        b=EI9UCWUlNg1anm0yx3ePxhk1KSBLOZSDoPXjNCUVZqWnScRr68KpEBh7qK8hZQjuSJ
         WTj6YspCMbOfzWrtUA5mAzT3OAVJbZEZpgitj/TKAqvD0XYIFYeqIfxIpF+0chQvWslk
         95PRtCuYVgtSkITk04nAStL25sZx4DixuXwao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B2uwAe7owLlekMWJ20nqwBIP27KWq8M/DXVcusnvDq0=;
        b=UwLXNNEzBQeA2h68ms1weQ1cpmVM8VXPNJx4eIvg2O3ahS4tUmml/bKkv/+uXmjnvh
         eAcwv5PDirTAdRVmNVSWg4ZQTTKm7Zc48Zs5Y0SWd9gfxlHTt/lSfTEgP5xg6RAoFnpY
         8AWmdDetMZziVSVwFBLP4yPSTqmiSg94A+CY1O8bUQ0ogbEagAkrSqnN7tnJFezEi1W9
         rUwQHfMwIwMHE6MhwOb17xCPr9IByisC3S4Vi4EcBXMNHO2vVsbLHqGh4vWR2IyqJWRo
         4Ue2E53pSfsBaPp2Ss+7BRsP/Igg280JztHGKtDlMop+tn9Cc+1vfe/73KgwbDW8JpoF
         4GMA==
X-Gm-Message-State: ABuFfojVvfP6WMSBcYq3golJd6dMyileJYJl6ImL1GUbRZAsUUpDaV8Z
        IIS5R3NiNhcLY/BKjGXEw2ztUSQdsLIsm5HNRt95aQ==
X-Google-Smtp-Source: ACcGV63izPKotTm5XkQLe9Nr/De7uhyUF1SEVZagezQuRqewN24ohjPJbPKUA5peM6RSbu3329VOBOcm5Itah4xN050=
X-Received: by 2002:a24:3fc6:: with SMTP id d189-v6mr9005129ita.64.1538386298554;
 Mon, 01 Oct 2018 02:31:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 02:30:58 -0700 (PDT)
In-Reply-To: <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com> <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Oct 2018 11:30:58 +0200
Message-ID: <CAPDyKFoiZMnYqtp_FofYEV=xKD+Azb2qKf=R=LdRsE+doxqW+A@mail.gmail.com>
Subject: Re: [PATCH V2 26/27] mmc: mmci: add DT bindings for STM32 sdmmc
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
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

On 21 September 2018 at 11:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> STM32 sdmmc variant has support to:
> -Indicate signal directions (only one property
> for d0dir, d123dir, cmd_dir)
> -Select command and data phase relation.
> -Select "clock in" from an external driver.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
> change v3:
> -remove space at end of "st,use-ckin "
>
>  Documentation/devicetree/bindings/mmc/mmci.txt | 9 +++++++++

Please split this. DT doc changes should be separate patches.

>  drivers/mmc/host/mmci.c                        | 6 ++++++
>  drivers/mmc/host/mmci.h                        | 1 +
>  3 files changed, 16 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
> index e952707..d678933 100644
> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
> @@ -19,6 +19,7 @@ Optional properties:
>                             the ID provided by the HW
>  - vqmmc-supply           : phandle to the regulator device tree node, mentioned
>                             as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> +specific for ux500 variant:
>  - st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
>  - st,sig-dir-dat2        : bus signal direction pin used for DAT[2].
>  - st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and DAT[1].
> @@ -26,6 +27,14 @@ Optional properties:
>  - st,sig-dir-cmd         : cmd signal direction pin used for CMD.
>  - st,sig-pin-fbclk       : feedback clock signal pin used.
>
> +specific for sdmmc variant:
> +- st,sig-dir             : signal direction polarity used for cmd, dat0 dat123.
> +- st,neg-edge            : data & command phase relation, generated on
> +                           sd clock falling edge.
> +- st,use-ckin            : use ckin pin from an external driver to sample
> +                           the receive data (example: with voltage
> +                          switch transceiver).

[...]

Kind regards
Uffe
