Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8B8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62116206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm9cbxBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62116206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeK2FsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:48:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51301 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeK2FsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:48:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so3499908wmh.1;
        Wed, 28 Nov 2018 10:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kA0EaRVco4/yVtEHc7rLURp/z2b/HxSi3M+1DLjPSII=;
        b=Qm9cbxBS5epTU2LP6B6bQ2LJABOXpifNR7CpYwlxMs0FFbnvnW99UxLtX1yxpeXfKc
         bEmf8N2woIWkSBg8ZoUZzR/NBvZ0jhu+2P3hXWfm7T9GumEv7qUZx6ouAOXVQOHOE0fF
         keuqGl9U/8oOM3Vj0lMnl5ODMEQgsv8mRdtbv3UAjQ8eoplbkSAJTVgxmDHGUBioLT2c
         s/qgXC/s0AAwsScXmgg1g6RrQMVC5UDknm5hnR5On2XmxpcmS6+LMtXHTuth23+zmhq8
         SYDTKg+2HacAuymjf1ybo3mUQtIR9jc6gaK0BhRDDa5GoiFlHkN9X4K3F6eueQCLYNWg
         kw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kA0EaRVco4/yVtEHc7rLURp/z2b/HxSi3M+1DLjPSII=;
        b=ncSa3ESO6BzL+U/d2cZJGgXVBFajasBVKSfV7j/xWmjrry3rkqPigKEzjZ/unQ6pBm
         i2Wd2MJGJDfL3e//syyFzyqnWp2nK312HsFDKLsrWS2gUlx/mCQOMYz+IOBLYwjC9oac
         otteRUWIjjtePqFGWVZNBjs+Vh19/MKoFBoBKmRZsOASfQ1y0AV6lmSVoEI/eKWtdwvk
         nKmUhSpmZXov0Plpx9oktXiSkT808+ybOx5rry8CgJM/m+dprNB6f5w7XXmKjNdL41lX
         6T+0ogWD/fkZBsiDi09496XIeN6SXs+GuiwGyl1lPSFfQGGNzLJZXgAbKZvXjaznRIVl
         xQYA==
X-Gm-Message-State: AA+aEWbQFtAZ952wKdinwnrK0VGXAWekVy29uameR/Yl553hBs0WSSuv
        F3NnKJfFkGhDGT4Iq/XVFcE=
X-Google-Smtp-Source: AFSGD/XxOUKIwxAmkRcQZklzja3iUyoNqyO4Z5BZcH3XgsI9rtpXH3uGXeIuKYwdL2nZ6oDsRh8teg==
X-Received: by 2002:a1c:3a8d:: with SMTP id h135-v6mr3808575wma.92.1543430732246;
        Wed, 28 Nov 2018 10:45:32 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id v19sm11818698wrd.46.2018.11.28.10.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 10:45:31 -0800 (PST)
Date:   Wed, 28 Nov 2018 19:45:28 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH 00/15] rtc: sun6i: clock rework and pre-H6
 SoC support
Message-ID: <20181128184528.GA22504@Red>
References: <20181128093013.24442-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 05:29:57PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This series was started as part of enabling Bluetooth on various
> Allwinner SBCs. The bluetooth controller requires a precise 32.768 kHz
> clock fed to it to correctly detect the frequency of its main oscillator.
> This clock signal is provided by the RTC, either directly from a special
> pin on the SoC, or some clock output function from the clock controllers.
> I found that the clock-related properties of the RTC on later SoCs were
> incorrect or missing.
> 
> This series reworks the compatible strings and clock parts of the device
> tree bindings for sun6i-rtc. Currently we assume most Allwinner SoCs use
> the same sun6i-rtc variant, when in fact they do not. The differences
> that matter with regards to clocks are a) the A31 does not have an extra
> external output for the RTC 32K clock, while most of the others do;
> b) the clock frequency of the internal RC oscillator is different on
> some SoCs; c) on the H6 the RTC also handles the 24 MHz DCXO, which
> feeds the system HOSC. The last difference, and by extension the H6, are
> not covered in this series.
> 
> Patch 1 cleans up the clock-related section of the RTC device tree
> binding. This would make it easier to read and easier to add additional
> clocks.
> 
> Patch 2 adds compatible strings for all identified variants introduced
> prior to the H6.
> 
> Patch 3 deprecates the external clock output for the A31. The A31 does
> not have this output, so it's introduction and usage was an error.
> 
> Patch 4 adds a clock output for the RTC's internal oscillator to the
> device tree binding. This feeds the PRCM in some SoCs.
> 
> Patch 5 adds a default clock name for the LOSC to the RTC driver.
> 
> Patch 6 adds support for different hardware variants to the RTC driver.
> 
> Patch 7 adds support for all known pre-H6 variants.
> 
> Patch 8 exposes the RTC's internal oscillator through the device tree.
> 
> Patch 9 makes the R40's CCU use the LOSC from the RTC module, instead of
> its own internal oscillator.
> 
> Patch 10 through 15 adds an RTC node or fixes up the RTC device node
> address ranges, clock properties, names of existing clocks, and adds
> accuracy properties for the external fixed oscillators.
> 
> The clock names require fixing because the sunxi clock driver implicitly
> depends on the HOSC and LOSC being named "osc24M" and "osc32k". The
> "fixes" to the clock hierarchy introduced in this series means the names
> must also be shuffled around or the in kernel representation would be
> incorrect. This has been the case since the sunxi-ng drivers were
> introduced. There are plans to address this, but the code is still in its
> early stages.
> 
> Please have a look.
> 
> Thanks
> ChenYu
> 
> Chen-Yu Tsai (15):
>   dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
>   dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6
>     variants
>   dt-bindings: rtc: sun6i-rtc: Deprecate external clock output for A31
>   dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
>   rtc: sun6i: Add default clock name for LOSC
>   rtc: sun6i: Add support for different variants
>   rtc: sun6i: Add support for all known pre-H6 variants
>   rtc: sun6i: Expose internal oscillator through device tree
>   clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC output
>   ARM: dts: sun8i: a23/a33: Fix up RTC device node
>   ARM: dts: sunxi: h3/h5: Add clock accuracy for external oscillators
>   ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock references
>   ARM: dts: sun8i: r40: Add clock accuracy for external oscillators
>   ARM: dts: sun8i: r40: Add RTC device node
>   arm64: dts: allwinner: a64: Fix up RTC device node and clock
>     references
> 
>  .../devicetree/bindings/rtc/sun6i-rtc.txt     |  31 ++++-
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi          |   6 +-
>  arch/arm/boot/dts/sun8i-h3.dtsi               |   4 +
>  arch/arm/boot/dts/sun8i-r40.dtsi              |  18 ++-
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  28 ++---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  22 ++--
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |   4 +
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c          |  11 ++
>  drivers/rtc/rtc-sun6i.c                       | 117 ++++++++++++++++--
>  9 files changed, 188 insertions(+), 53 deletions(-)
> 
> -- 

Hello

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun8i-r40-bananapi-m2-ultra
Tested-on: sun50i-h5-nanopi-neo-plus2

Regards
