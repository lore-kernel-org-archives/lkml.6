Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C477C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 09:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942DA2080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 09:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Rprn+lFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942DA2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKRTwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 14:52:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40676 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeKRTwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 14:52:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so2440200wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 01:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=5piY5NeBYTHD7VfP0XkIRZSk8MmU++fiKJd7y65fHKg=;
        b=Rprn+lFA9HFbjXhskbHbLLa2Bmks4hKdWcWaJiwq0KgVYHFYm1wckv+q78ZO8FwY9/
         7l4wGpMVQBsaVJ8BdLKv9vfNwLHR4ZXAsHQdbkFFFOQWqrndI5Tz0IZfvOpNwXUHoCKL
         /N18AmfB+vtGDAsYaBoqClquUTJ/5VPcYS32Spdos44D7lGselcPnBBhYihly8QytTPf
         7vrQxP093LEqDlV7ueRiiA70IKRhLg39ZX+Ffi9l+olRLMGFDcg6TO8zJCfOizC3Zwkn
         XBxT8ejCVAjJwzqhmmO+cClqMshHZ6RUS7b+rqbiTobpvKsqE3M/BDYFkXRf41absDyJ
         kk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=5piY5NeBYTHD7VfP0XkIRZSk8MmU++fiKJd7y65fHKg=;
        b=BVAlGqy+DA5owRDPr36ezUafTwR/diosw9NFsroTh8RwH52GIEFPZl5uXRois53vnZ
         wQmN4Y2orQd0zfgO40OiR+qoUD32MH24wSvc/GYjimNE0d2DjcUsHSNzERykgamxVBNf
         S/A+TlLnmnqRZlDuPmOwlcre3C3sWkZgQZeVsKDr3hqUlp9RITP5Z78RCtxcCrUKkNdK
         7V4dgYYP6Cj+uzgkU++7xYQ6058oGS3/i5L/TFViPNoWkB8rLMULUIaIAg/mfZjtNGM4
         q78M1ai4KFpjww8w+nCzCwl1dbJzoT1TJyygRTPBJsjetSqdcoB+mjSgvxmevM31W0Vk
         l+aA==
X-Gm-Message-State: AA+aEWbiYVWd9JYbhnJKekMpUIEOSSh8LOcrf6Clzuk2lnNNIqsL6sPF
        wxW7M/3nHw791JnmDLljTRxdmQ==
X-Google-Smtp-Source: AFSGD/Vx7OSZwjc+k04ysmjb9qJcQXEN4pGUYEqigqHCHQzyTgeI2uLnIPgHTHlZcUz12FcvVY2rjQ==
X-Received: by 2002:a1c:2c03:: with SMTP id s3-v6mr3679200wms.38.1542533572892;
        Sun, 18 Nov 2018 01:32:52 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([2a01:cb1d:4ce:ea00:693b:677a:1628:d8ff])
        by smtp.gmail.com with ESMTPSA id 197-v6sm26659507wmh.44.2018.11.18.01.32.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 01:32:52 -0800 (PST)
Message-ID: <5BF131C3.9040808@baylibre.com>
Date:   Sun, 18 Nov 2018 10:32:51 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     khilman@baylibre.com
CC:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
References: <20181114131627.17766-1-narmstrong@baylibre.com> <75ca31ca-82f4-c9e9-0d73-29fde405c47c@baylibre.com>
In-Reply-To: <75ca31ca-82f4-c9e9-0d73-29fde405c47c@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/11/2018 14:17, Neil Armstrong a écrit :
> On 14/11/2018 14:16, Neil Armstrong wrote:
>> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
>> clocks frequencyies.
>> The precision is determined by stepping into the divider until the counter
>> overflows.
>> The debugfs slows a pretty summary and each clock can be measured
>> individually aswell.
>>
>> Thsi patchset includes the dt-bindings, driver and the DT node added to the
>> meson-gx dtsi.

I'll respin a v3 with the comments from Martin and Meson8 & Meson8b support !

Neil

>>
>> Changes since v1 at [1]:
>> - fixed clock names
>> - added summary in debugfs and moved indivudual clocks into a subdirectory
>> - added the GX table to the match data
>>
>> Neil Armstrong (3):
>>   dt-bindings: amlogic: Add Internal Clock Measurer bindings
>>   soc: amlogic: Add Meson GX Clock Measure driver
>>   ARM64: dts: meson-gx: Add Internal Clock Measurer node
>>
>>  .../bindings/soc/amlogic/clk-measure.txt      |  15 +
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   5 +
>>  drivers/soc/amlogic/Kconfig                   |   8 +
>>  drivers/soc/amlogic/Makefile                  |   1 +
>>  drivers/soc/amlogic/meson-gx-clk-measure.c    | 293 ++++++++++++++++++
>>  5 files changed, 322 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
>>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
>>
> 
> For example, the debugfs summary looks like :
> 
> # cat /sys/kernel/debug/meson-clk-msr/measure_summary
>   clock                     rate    precision
> ---------------------------------------------
>  ring_osc_out_ee_0             0    +/-3125Hz
>  ring_osc_out_ee_1             0    +/-3125Hz
>  ring_osc_out_ee_2             0    +/-3125Hz
>  a53_ring_osc                  0    +/-3125Hz
>  gp0_pll                       0    +/-3125Hz
>  enci                   26998438    +/-3125Hz
>  clk81                 166661458    +/-5208Hz
>  encp                          0    +/-3125Hz
>  encl                          0    +/-3125Hz
>  vdac                   26998438    +/-3125Hz
>  rgmii_tx                      0    +/-3125Hz
>  pdm                           0    +/-3125Hz
>  amclk                         0    +/-3125Hz
>  fec_0                         0    +/-3125Hz
>  fec_1                         0    +/-3125Hz
>  fec_2                         0    +/-3125Hz
>  sys_pll_div16                 0    +/-3125Hz
>  sys_cpu_div16                 0    +/-3125Hz
>  hdmitx_sys             24000000    +/-3125Hz
>  rtc_osc_out               32813    +/-3125Hz
>  i2s_in_src0                   0    +/-3125Hz
>  eth_phy_ref                   0    +/-3125Hz
>  hdmi_todig                    0    +/-3125Hz
>  sc_int                        0    +/-3125Hz
>  sar_adc                 1195313    +/-3125Hz
>  mpll_test_out                 0    +/-3125Hz
>  vdec                          0    +/-3125Hz
>  mali                          0    +/-3125Hz
>  hdmi_tx_pixel                 0    +/-3125Hz
>  i958                          0    +/-3125Hz
>  vdin_meas            1484656250    +/-62500Hz
>  pcm_sclk                      0    +/-3125Hz
>  pcm_mclk                      0    +/-3125Hz
>  eth_rx_or_rmii         50000000    +/-3125Hz
>  mp0_out                       0    +/-3125Hz
>  fclk_div5                     0    +/-3125Hz
>  pwm_b                  24000000    +/-3125Hz
>  pwm_a                         0    +/-3125Hz
>  vpu                   666625000    +/-20833Hz
>  ddr_dpll_pt                   0    +/-3125Hz
>  mp1_out                       0    +/-3125Hz
>  mp2_out                       0    +/-3125Hz
>  mp3_out                       0    +/-3125Hz
>  nand_core              24000000    +/-3125Hz
>  sd_emmc_b                     0    +/-3125Hz
>  sd_emmc_a                     0    +/-3125Hz
>  vid_pll_div_out      1484843750    +/-62500Hz
>  cci                           0    +/-3125Hz
>  wave420l_c                    0    +/-3125Hz
>  wave420l_b                    0    +/-3125Hz
>  hcodec                        0    +/-3125Hz
>  alt_32k                       0    +/-3125Hz
>  gpio_msr                      0    +/-3125Hz
>  hevc                          0    +/-3125Hz
>  vid_lock                      0    +/-3125Hz
>  pwm_f                         0    +/-3125Hz
>  pwm_e                         0    +/-3125Hz
>  pwm_d                  23984375    +/-3125Hz
>  pwm_c                         0    +/-3125Hz
>  aoclkx2_int                   0    +/-3125Hz
>  aoclk_int                     0    +/-3125Hz
>  rng_ring_osc_0         66746875    +/-3125Hz
>  rng_ring_osc_1         58442188    +/-3125Hz
>  rng_ring_osc_2         52098438    +/-3125Hz
>  rng_ring_osc_3         46662500    +/-3125Hz
>  vapb                  249996094    +/-7812Hz
>  ge2d                  249992188    +/-7812Hz
> 
> On the AML-S905X-CC board.
> 
> Neil
> 
