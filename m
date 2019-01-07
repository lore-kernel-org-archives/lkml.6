Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EEFC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001752183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FHYh63dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfAGOgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:36:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41531 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbfAGOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:36:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so1072778edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=O2VPNPn3DSLCDcwGDDQnewrk+6t8gZb6lnFZBdvUIjE=;
        b=FHYh63dv94tyY7PjeLQlFH6NVBr7kgbD2Z+dPeucvAunuPEx6fMzNz0MKOJvSLnXX3
         khTgwAXO8hflp1wgAb3SwWm9rOmfU0NupnqAqfWnADCcdXO6xE0SUYauVTIi936qnEpe
         nBoMEFmg7sH0kAbJLN/AyaiY/LVa8W5oajWuKXJNztY8WC7rOkUl5dekTxDLm7O6eqI9
         yp6omT2JM1mlglxICT3XHOzMrz77slZU9xk29DVLiNbaJ+dQMuOKwMpi0iRET7gs0iem
         eqCn5wkb2x80A/NylVg1aLjEtfGVN1qm+6bx+9TG/C3ieYbN4zHguAdjpO4UynPnJTGK
         /ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=O2VPNPn3DSLCDcwGDDQnewrk+6t8gZb6lnFZBdvUIjE=;
        b=pwLOvlRrKVTip5a+K2Y3XedGLq0JXtoqP61GdBkpJxB/AdDa5Gh9Ijd0pVpBIhtbB8
         97t3qaUhAsPeJpOmTUowhb6am6EkMogMCgSU3+AEPCt3OEPiZqg/FC7U8Pv/89fUXKzS
         qs9IbzT/Urq3hX0CRQBDSzECK0Dq65Hy6/549/bVEYFTB7WrjMjWV46Tqu9Owv2Q6dC2
         2cUyBaRSGmii6Qw9SLz9aGgZcuUtzFV9Df2YUneePLboIzrJNaf89/44LKZS3rj6zMva
         4YNvrlsKPJNl9FPUTZW/rK8/InSkRqoMNGc1WKf2de7/3S2TAVcFsui1zZkBwE39hANy
         BXtg==
X-Gm-Message-State: AA+aEWa80wpo7i+3gwRrvsP8udqlS7F5lHx8dif6IaWekVlJaURGSALY
        ouSWqwi6k+c4c0m41y5ZtIVCAA==
X-Google-Smtp-Source: AFSGD/Vv+JGbWQwMgXLkvKMrD0jMh+S2sFjO0gZLs2qm7fTTXzT0lBSGmB07JYPTNvUFv0OJbya9mQ==
X-Received: by 2002:a17:906:7a18:: with SMTP id d24-v6mr47458645ejo.16.1546871779190;
        Mon, 07 Jan 2019 06:36:19 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k20sm31344034eda.71.2019.01.07.06.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 06:36:18 -0800 (PST)
Subject: Re: [PATCH 0/5] Meson (32-bit): add support for the Mali GPU
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, khilman@baylibre.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sboyd@kernel.org, mturquette@baylibre.com
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <13bd9d3a-3cbe-3952-03bb-ef5da6eec401@baylibre.com>
Date:   Mon, 7 Jan 2019 15:36:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2018 18:12, Martin Blumenstingl wrote:
> This series adds support for the Mali-450 GPU on Meson8 and Meson8b.
> Meson6 uses a Mali-400 GPU but since we don't have a clock driver (and
> I don't have a device for testing) Meson6 is left out in this series.
> 
> Meson8 uses a Mali-450 MP6 with six pixel processors. Meson8b (as
> cost-reduced SoC) uses a Mali-450 MP2 with two pixel processors.
> I tested both using the open source lima driver and a patched mesa
> from the lima project as well. Since we don't have display support
> on the 32-bit SoCs I used off-screen rendering as described in [0].
> The result is (for example): [1]
> 
> The bootloader (at least on my boards) leaves the Mali clock disabled
> by default. The board crashes when trying to access the Mali registers
> with the "core" clock disabled.
> Thus this series also implements the required clock driver changes. The
> Mali clock tree on Meson8b and Meson8m2 is almost identical to the one
> on GXBB (see the description of patch #3 for more details). Only Meson8
> is slightly different as it doesn't have a glitch-free mux. Patch #2
> prepares the meson8b clock driver so we can have different clocks per
> SoC.
> 
> Dependencies:
> - the .dts changes depend on my other series "ARM: dts: meson: add the
>   APB/APB2 busses" from [2]
> - the .dts changes from this series have no compile-time dependency on
>   the clock driver changes because CLKID_MALI was defined in the
>   dt-bindings since the first version of the clock driver (but it was
>   not used until now).
> - the .dts changes from this series have a runtime dependency on the
>   clock driver changes (also from this series) if you have a kernel
>   patched with the lima driver (without the lima driver there's no
>   runtime dependency)
> 
> Other notes:
> By default the GPU runs off the XTAL clock (24MHz). The lima driver
> currently does not update the GPU clock rate. Different frequencies
> have to be requested by adding the following properties to the Mali
> GPU node (to run it at 510MHz for example):
>   assigned-clocks = <&clkc CLKID_MALI>;
>   assigned-clock-rates = <510000000>;
> 
> 
> [0] https://gitlab.freedesktop.org/lima/web/wikis/home
> [1] https://abload.de/img/dump0myic0.png
> [2] https://patchwork.kernel.org/cover/10719445/
> 
> 
> Martin Blumenstingl (5):
>   dt-bindings: gpu: mali-utgard: add Amlogic Meson8 and Meson8b
>     compatible
>   clk: meson: meson8b: use a separate clock table for Meson8
>   clk: meson: meson8b: add the GPU clock tree
>   ARM: dts: meson8: add the Mali-450 MP6 GPU
>   ARM: dts: meson8b: add the Mali-450 MP2 GPU
> 
>  .../bindings/gpu/arm,mali-utgard.txt          |   6 +
>  arch/arm/boot/dts/meson8.dtsi                 |  58 +++
>  arch/arm/boot/dts/meson8b.dtsi                |  46 +++
>  drivers/clk/meson/meson8b.c                   | 349 +++++++++++++++++-
>  drivers/clk/meson/meson8b.h                   |   9 +-
>  5 files changed, 461 insertions(+), 7 deletions(-)
> 

Applied patches 2 & 3 to next/drivers for Linux 5.1

Kevin, have fun with the other patches !

Neil
