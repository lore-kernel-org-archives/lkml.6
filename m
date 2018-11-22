Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE5CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C200420866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h3Gam3Iv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C200420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405142AbeKVTo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:44:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45618 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbeKVTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:44:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so8416333wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 01:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/7Hi7w9d6cPQqqUvo11EA2xELq04YMXS0Q9lUj+4pz0=;
        b=h3Gam3Iv6TmQlPJzMubn39Ioj4dsFJJx5idXNLKSIpvXHOIVN7MRRedway6xsvyxgO
         UzzmxoPbcNeqOUjfllL9YaA0Tr4HUdu7KJAFuEbsKcXNmCU1awhPwvykk2TvKx4fIWIs
         pokNsR1BVKidM4NzBUh3JMJlOfowFlwyoDxPC3rPW3/FXuTKHKgfsc7yIvb6mLqTTph0
         t8A6x1RsjVER8nhQPf+H4qtXbKJnGzSMm7pAIGusGkhCykcMrzbuAENpJHW/LY6CDUEi
         Gy6liKXrfRlsGSUCSlSmwHoXaIYawzvelWX+Vj3vUv+3FclF/7qM7jf+oqtpj6PEo+T8
         3uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/7Hi7w9d6cPQqqUvo11EA2xELq04YMXS0Q9lUj+4pz0=;
        b=lOOpDZDcWIkcw3BlcYxs9Q3JQ47vPCaU623J4SdumMYyt7DMoWzjEjNGVTWfTpjjDK
         80poBuXuZsSbhlYJ4Qu84TfYsA0k7tpEmq/U5avA0oKlYv3Tbw3Fy9iznbyAGxtCVsyc
         FIlkx5jOH0vxKePhx1Xt6wWXx0eu9f8Y3RDlmDGI47ho+C2G+NM+ZvU1ssuJw9gZCgyS
         W0Idu+E9VLB1hLMW83OqIsFWOrUZd1p8nIJl2kBzgeHHmOsBZQLP2UStO8Z9a+PyN66Q
         IMiFQPuojxmj/HuayG1o/rPGh/deGlWjyXdzHano3bSWixdZaawxwMfJOOtgy6LuMQ4K
         Wodw==
X-Gm-Message-State: AA+aEWb23IOZ52dCYCnYb9xxGugHQN2WHPpKxQfbnq8/jQwb7uKBVKqt
        zMvJ2ZObp9eoTl2EtkOAz2JCDA==
X-Google-Smtp-Source: AFSGD/X853mP/Muo2A4bXKcQIgqCjikSpldHueUKs3Tk69n3VC/YKLWokVf3mi8A65sfXUjijCTN3g==
X-Received: by 2002:adf:c189:: with SMTP id x9-v6mr9200065wre.233.1542877550550;
        Thu, 22 Nov 2018 01:05:50 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id j16sm4379967wrr.97.2018.11.22.01.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 01:05:49 -0800 (PST)
Message-ID: <59801d61ba4e5d5fc8f0df1adffad1f9c7afb45c.camel@baylibre.com>
Subject: Re: [PATCH 0/3] Meson8b: add the CPU clock post-dividers
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 22 Nov 2018 10:05:48 +0100
In-Reply-To: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
References: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 21:53 +0100, Martin Blumenstingl wrote:
> This is the successor to my previous series "meson8b: add the CPU_DIV16
> clock for the ARM TWD" from [0]. I decided to not send this as v2 of
> the original series because the PERIPH clock is not the CPU_DIV16 clock.
> It's not clear whether a CPU_DIV16 clock exists.
> 
> With this series we get all the CPU_CLK post-dividers as listed in the
> public S805 datasheet [1] on pages 31 and 32:
> - ABP
> - PERIPH (used as input for the ARM global timer and ARM TWD timer)
> - AXI
> - L2 DRAM
> 
> Each of these clocks has a register called "..._CLK_DIS" which is
> documented as a "just in case" bit:
> "Set to 1 to manually disable the [...] clock when changing the mux
> selection. Typically this bit is set to 0 since the clock muxes can
> switch without glitches."
> Since we're not supposed to touch that register we're setting
> CLK_IS_CRITICAL for these clocks in the driver.

If we are not supposed to touch the register, I'd prefer if you used RO ops
instead of using CLK_IS_CRITICAL.

> 
> The result of this is that we can use the PERIPH clock which clocks
> the ARM TWD timer. I will send a separate series to add the TWD timer.
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html
> [1] 
> https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
> 
> Martin Blumenstingl (3):
>   dt-bindings: clock: meson8b: export the CPU post dividers
>   clk: meson: meson8b: rename cpu_div2/cpu_div3 to
>     cpu_in_div2/cpu_in_div3
>   clk: meson: meson8b: add the CPU clock post divider clocks
> 
>  drivers/clk/meson/meson8b.c              | 268 ++++++++++++++++++++++-
>  drivers/clk/meson/meson8b.h              |  17 +-
>  include/dt-bindings/clock/meson8b-clkc.h |   4 +
>  3 files changed, 276 insertions(+), 13 deletions(-)
> 

With CLK_IS_CRITICAL removed, looks good to me:

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

