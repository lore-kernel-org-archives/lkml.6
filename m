Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EF9C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D251206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWoPRi7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D251206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeGSJtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:49:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39086 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeGSJtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:49:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so7264630wre.6;
        Thu, 19 Jul 2018 02:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BjIFXAbeWILTYTFc9QyhQU1CLLgSZ9bQPdDjyWy40Gw=;
        b=SWoPRi7IgbfI/9iJLaMT7WEG0sg2PGtYudB/lj4Is3ldU1Z6+b796olhIf2tmkiksu
         xk6mhA8oAFO2S0BvG4Xe/XmhOfH/8Qn/oxq4FuGQb36xYTY81UZxB74GJF1c1GaeFJKe
         d+YeZ/RnwI1s/59Basm+kX/lCyv8CBiZwCNKPvX6GxztHJte+D3+zF/VvKKtsSfob74f
         zhklLA3H5y1FltJW4glold9NPsNFjWHngTmnaLgefNjo0/k5ZwxI4J2FHQupn/lp36Zt
         Co7MU0uqellaUnTUPctEhl/7hqPANLAUpyociTqYsNowjkb6Tv961TKM9bUnDJEmk472
         MnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BjIFXAbeWILTYTFc9QyhQU1CLLgSZ9bQPdDjyWy40Gw=;
        b=ZhghqU1nJ/ZOSrTOUS9r+ByBSNC35zdEiZ0sD2TWuty7h93a76oAbVCW1HTbw3MpEA
         bvCc0tZdgyfqtQz8wY+5eRyZU/8RLfe3HZJCgNE0Rmvz9JOKEdL5LWnZgEGIYDm82Juv
         5Ea+R84Q+P5fPBQ75Muw2+WWFby+pdVpH48ZLsjxEbZP4guTJZEVXMETM/gyZSX/LIKq
         2RHw87by9kABAKNmd0FYFKFbvs7cmPVF5ZS5GvkBMYZTG8Gjr+tCTF0aMaGSfhVOEsnC
         LR9DBcAzLXDFdO/MwdbGGoHjaDub0FyNMT6vCH4aMnHShasgpFoj0wP2N0vrPTpogEJZ
         wnUg==
X-Gm-Message-State: AOUpUlE+1ojqLQFNerx975t138Fh9p3PaZOM5IBEVBBeAZ9MLwz9O00R
        9e4EfaNIo7gm4RButY/dcYI=
X-Google-Smtp-Source: AAOMgpdkkhjkqzS3aPYxGY60L/TLur5NnsRVTIxxWBRL7Jv5LqDAjiXmtDOSujaio7iELDAIu4qiaA==
X-Received: by 2002:adf:8877:: with SMTP id e52-v6mr7216874wre.30.1531991230485;
        Thu, 19 Jul 2018 02:07:10 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id j11-v6sm8162160wrr.37.2018.07.19.02.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 02:07:09 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v7 0/5] Add clock driver for Actions S700 SoC
Date:   Thu, 19 Jul 2018 11:06:44 +0200
Message-Id: <20180719090649.12460-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for Actions Semi Owl series S700 SoC
with relevant clock bindings and device tree info. 

Changed the UART clock using CMU instance and changes are tested in
cubieboard7

Changelog v7:
- Moved cmu (clock controller) dts entry under soc node and
positioned based on address

Changelog v6:
- Adding Fixes tag for adding REGMAP dependency addition

Changelog v5:
- Commit message corrections
- Removed MMC_OWL_CLK_NANDPLL option, as no active consumer
- Device tree clock label name correction

Changelog v4:
- dt-bindings use absolute numbering for clocks
- Patch re-oredering

Changelog v3:
- Splitted uart clock DTS changes into separate patch
- Splitted REGMAP Kconfig selection into separate patch
- General naming convention as "Actions Semi" in dt-binding documentation
- Patch re-oredering
- Cleanup and fixed review findings

Changelog v2:
Fixed 0 day compilation warning
Modified existing dts Actions S900 clock bindings common to Actions
Soc family

Thanks and regards,
Saravanan,
Parthiban


Saravanan Sekar (5):
  clk: actions: Add missing REGMAP_MMIO dependency
  dt-bindings: clock: Add S700 support for Actions Semi Soc's
  clk: actions: Add S700 SoC clock support
  arm64: dts: actions: Add Clock Management Unit for S700
  arm64: dts: actions: Set UART clock reference from CMU

 .../{actions,s900-cmu.txt => actions,owl-cmu.txt}  |  20 +-
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |   8 +-
 arch/arm64/boot/dts/actions/s700.dtsi              |  14 +
 drivers/clk/actions/Kconfig                        |   7 +
 drivers/clk/actions/Makefile                       |   1 +
 drivers/clk/actions/owl-s700.c                     | 606 +++++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h       | 118 ++++
 7 files changed, 758 insertions(+), 16 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (68%)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.14.4

