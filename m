Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC96C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3222C2403B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jKme/eOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3222C2403B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeGEJut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:50:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33680 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeGEJus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:50:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so2117322wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mQhbdJJ2E6DLfIcdlNPeTGQeYnucTnDlTNpkusjZ684=;
        b=jKme/eOE4iQ6Z/68klSXNL0ri5rBobur5cTjak5w9c+0iGHORDbYC4rdnkmnGNETjX
         sEjC3Dbxl+6PgU0uaRLpq60PCPqvphzeNGaoTugx/BvD9eT/MyZmZg93e5/vLUG+H0aZ
         ck9qQp5bTJ6bVW6ZHX9SuNc+tR4Ht84Fy9eU5RwhPJKEumloHMjYSjqHG12guA7+TfBv
         jUYK8rm3EHUEwfCaO4z6pQJLk1IPZb/RgqRtrFBWf0VR1OjrMSnKb6Igwqwq7ivSicUd
         F6UUDyfXrVtZkPNuiNiR9KH6ldvdAC/t1jA2ob53VX2WZv3fTKIwe/NclwhkUM67qDg8
         eczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mQhbdJJ2E6DLfIcdlNPeTGQeYnucTnDlTNpkusjZ684=;
        b=HpPifNmPaleE0GnUZYuPFfaNzmnkcIq9FeyTac6BP2uwIxpU5FBwUH1JvbeA49jvl9
         z9CN5dQJCnpggcw6q/DlaJnLr+N3Xr1Ce7V6hx3E2I0phVMC6WxcZiF3V3rr5tipxulN
         pH4i2uh1U+NAUCZMLMRf1n40GCLrm8W6yRBqOUAIvTdNUwvuEGdkgMAdqo63I+3HGxwL
         1yoBXAP2N17m7MhUpOYo03zusIGoDEOUAHkgJ3kCHY3V2IOWE0CTWOe8xLKfD9v/rCp3
         9CdRv44sQIP84vu9F5ijcNpbx+Ip2ZghgVNNYUwp0qmBluOhCggaEXE5tDvwMJw4dd/L
         k52A==
X-Gm-Message-State: APt69E3iQZ+CT2A7Z8TivGfOlTLJfjCtu+aFlekr5EpJgufG8jvcNUi5
        2ApiXWM48Q4C5/kOXWyBC47VJg==
X-Google-Smtp-Source: AAOMgpeGHs+0kv7HCfeZY6o/GUCVJujDYQ6jjjycPEiT1kH78g8DXFOA8eqf3BxYuXwBHr80BuAJvw==
X-Received: by 2002:adf:8486:: with SMTP id 6-v6mr4119207wrg.56.1530784246633;
        Thu, 05 Jul 2018 02:50:46 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h18-v6sm6967590wrq.36.2018.07.05.02.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 02:50:45 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com
Subject: [PATCH 0/2] Add support for S805X based P241 Reference Design board
Date:   Thu,  5 Jul 2018 11:50:41 +0200
Message-Id: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic P241 board is the Reference Design board for the S805X
variant of the Amlogic Meson GXL SoC family.

The S805X is a variant of the Amlogic Meson GXL SoC family with the
following physical limitations :
- No SDCard interface
- No GPIOCLK pins
- No USB OTG ID pin (but Gadget feature can stil be forced)
- No 5V regulator
- Reduced ADC inputs (only ADC0 and ADC1)
- GPIODV_26, GPIOAO_3, GPIOAO_4, GPIOAO_5, GPIOAO_6, GPIOX_14,
  GPIOX_15, GPIOH_3 are no more exposed on the package

Amlogic exposes the following SW limitations :
- HDMI max resolution should be 1080p60, VPU clock should be downgraded
- Video Decoding should be limited to 1080p60, VDEC clock should be downgraded
- CPU speed should be limited by SCPI OPP table to 1.2GHz
- DRAM interface is limited to DDR4 16bit up to 1GiB

The P241 board has the following features :
- 1GiB DDR4 Memory
- HDMI Connector with CEC
- A/V jack with Stereo Audio and CVBS
- 10/100 Ethernet
- 2x USB2.0 Type-A
- On-board WiFi SDIO Module
- On-board eMMC storage
- Infraread Received
- Factory Reset button
- UART connector

Neil Armstrong (2):
  dt-bindings: amlogic: Add support for GXL S805X and the P241 board
  ARM64: dts: add S805X based P241 board

 Documentation/devicetree/bindings/arm/amlogic.txt  |   6 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts      | 218 +++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts

-- 
2.7.4

