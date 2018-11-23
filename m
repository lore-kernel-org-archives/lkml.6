Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B801C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33E020672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SahMg6pM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33E020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408097AbeKWPIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 10:08:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39673 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbeKWPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 10:08:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so2516057pgl.6;
        Thu, 22 Nov 2018 20:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqEM8IQ5yjLEIdNNn7VUdZSj7uxrnCxQ+hAblpVMVvc=;
        b=SahMg6pMjZZOHW65QQvnJkgUPFFBzkGFDihHGs2fCNpOWBNqLntdb32265gXQVc7Er
         67MMhhyTRbpPYtVaGR0eIyFKyXsaPdK9qcymhZvJ/vMNfzFEt4+Q2b/KfrV3FqcBOGSa
         zxjGJtnPSX9DtglAMriq1GL14FRnDzTo1xRQLaeKoVXBSwMQIhUAXJcMXPN3ACSPSoGe
         /XmIvJE9jDwWEXkiTI+YvQLjMSju6QP/YsktZlqRj3wt0jmgfM5eyb3ESEdUpq+CSeNG
         WTq32VF2jCAfUZ206r1BqOU+6c0BFGQCLAW2w4fEKLKOvBF2SyPC4EQwgCSS1mAXvUxv
         yfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqEM8IQ5yjLEIdNNn7VUdZSj7uxrnCxQ+hAblpVMVvc=;
        b=AUx0PvYwksX0SSMiD0ZoERrxIRRcWGoi+ANm3e+tBaCl9o5/t3zUhSB40O2vH5Avs6
         Goxltd7olwKxsXNrjH3Kvg6az8RF3txRwD1EdJcDGSTJdKlbLu/Gq8JzdornM44OrPAf
         ioHP2zHoL1eG2El+CXdwGBf0Zux8WSPawj64SShJ4rsyxdhMYMRyqbCVN17cmoQDE94m
         YG5eN4jIMHQkmuNB/psDzcQOkCVD7QyTJM2Kwr1L80YqvxeTsENMsAntJV13NNFGPKkS
         HuSFa+40H9gQtVlr23sOWHjSjIDGW8E4RyWcAEIqNXfapotsjvQjP9b8Sp2JQ5d1GpIn
         oaCA==
X-Gm-Message-State: AGRZ1gJZ3yMuWaU6qQ10LRFEeftBpGUPXW7B9BHX8uj3PJwkWVQdA9ko
        zx6JV24KIq6vJZtICHjXTEC4TdoT
X-Google-Smtp-Source: AJdET5dl9TzD29g76rwMho7skFjkotYQuNw1z5I4xRdOMLT5ucPdp+bmcKUZwvMna+Vua5OCaWh0FA==
X-Received: by 2002:a62:ed09:: with SMTP id u9-v6mr14035955pfh.188.1542947175979;
        Thu, 22 Nov 2018 20:26:15 -0800 (PST)
Received: from anarsoul-thinkpad.localnet (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id z6-v6sm64109292pfb.77.2018.11.22.20.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 20:26:15 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v9 0/8] Add support for audiocodec in Allwinner A64
Date:   Thu, 22 Nov 2018 20:26:14 -0800
Message-ID: <2007258.VzpTJLJblp@anarsoul-thinkpad>
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 22, 2018 2:23:17 AM PST Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v9 of the A64 audio codec series, originally started by Vasily.
> These are the last changes to make the A64 audio codec work correctly,
> and be accurately represented in the device tree and in software.
> 
> Notably, the new driver changes cover regulator supplies for the simple
> audio amplifier, which is used in the Pinebook for the internal
> speakers, and the audio codec's internal headphone amp. There's also an
> extra patch that enables SDM fractional clock support for the audio PLL
> on the A64, which gives us accurate audio playback.
> 
> Patch 1 & 2 add the cpvdd regulator supply to the sun50i-codec-analog
> dt bindings & driver.
> 
> Patch 3 & 4 add a regulator supply to the simple-audio-amplifier dt
> bindings & driver.
> 
> Patch 5 adds SDM fractional clock support for the audio PLL on the A64.
> 
> Patch 6 ~ 8 add the device tree bits and enables audio on several
> boards.
> 
> I have one extra patch for the Bananapi M64 that's not included here,
> as I'm waiting for an accessory to test the microphone bias. I'll send
> that one out once it's tested.
> 
> As always, we'll take the clock and dts patches after Mark has merged
> the ASoC ones.
> 
> And a big thanks to Vasily for having worked on this for so long.

Thank you for picking it up!

Just a minor note: hpvcc-supply should be a property of codec_analog in 
sun50i-a64-pinebook.dts

Otherwise looks fine, tested on Pinebook and Pine64-LTS.

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com> 

> Regards
> ChenYu
> 
> v9: - Dropped simple amplifier headphone amp device tree changes
>     - Dropped "make enable-gpio optional for simple amplifier"
>     - Lowered oversampling rate from 512 to 128
>     - Add regulator supply for audio codec CPVDD (headphone amp charge pump)
> - Hook up CPVDD regulator in board device trees
>     - Add patch to enable SDM fractional clock support for audio PLL on A64
> v8: - drop merged patches
>     - add regulator property for simple amplifier, make enable-gpio
>       optional
>     - add regulator to speaker amp, introduce headphone amp
> v7: - drop 'Mic' and 'Headset Mic' from dtsi
>     - move AIF1 Slot 0 ADC to ADC route to sun8i-codec
>     - drop BIAS routes for Pine64 and SoPine
> v6: - driver patches has been merged through ASoC tree
>     - rebase onto 4.20-rc1
>     - Drop 'Speaker' from routes on sopine and pine64, they don't have
>       speaker.
> v5: - collect all the tags
> v4: - dts: don't use 'Mic' and 'Headset Mic' widgets from sun8i-codec,
>       define our board-level widgets instead.
> v3: - renamed sunxi-adda-pr-regmap to sun8i-adda-pr-regmap
>     - use ilog2() to calculate reg value for LRCK div instead of using a
>       table
> v2: - Use simple-amplifier for speaker amp on Pinebook
>     - Rename sun50i-a64-i2s to sun50i-a64-codec-i2s to preserve compatible
>       string for other 3 I2S modules in A64 in case if there's any
>       incompatibility with H3
> 
> Chen-Yu Tsai (3):
>   ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp regulator
>     supply
>   ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator
>     supply
>   clk: sunxi-ng: sun50i: a64: Use sigma-delta modulation for audio PLL
> 
> Vasily Khoruzhick (5):
>   ASoC: dt-bindings: add regulator property to simple amplifier
>   ASoC: simple-amplifier: add VCC regulator widget
>   arm64: dts: allwinner: a64: add nodes necessary for analog sound
>     support
>   arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
>   arm64: dts: allwinner: a64: enable sound on Pinebook
> 
>  .../bindings/sound/simple-amplifier.txt       |  5 ++
>  .../bindings/sound/sun50i-codec-analog.txt    |  2 +
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 27 ++++++++++
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 49 +++++++++++++++++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts | 26 +++++++++
>  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  4 ++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 54 +++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c         | 37 ++++++++-----
>  sound/soc/codecs/simple-amplifier.c           |  4 ++
>  sound/soc/sunxi/sun50i-codec-analog.c         |  2 +
>  10 files changed, 197 insertions(+), 13 deletions(-)




