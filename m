Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D364AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E7E20896
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElitlSXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E7E20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeH1Ran (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:30:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37215 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH1Ran (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:30:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so1401028eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9L2+wm4Vw+O3wK6PJcZeEwdHckNDeo9RTUumAVxVvrI=;
        b=ElitlSXut2yyFgsQXB7SKsy2WiREa31GaIxv1gBWjF5yAGUhKtvyKEYXZSHTnIZeMv
         76yUOT3lD2wEVMb5mqvqvTZp8TR+B0LL8LAsCW80JPFJoWVoBkMMQwQIfyUlSDeNqd+r
         VZmk14gt/m8kmP2PLLqdZgm7lVH3WaV5GnbNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9L2+wm4Vw+O3wK6PJcZeEwdHckNDeo9RTUumAVxVvrI=;
        b=O5Opgo72iHGxGmPPdyYCkFp4Jjf1F0KDCyzUzC8SuVzJfX0EkDAMo5jzj7gUsGKGsm
         kCf3of+4UoM4wOoWNt20f/DGdcQs5xRF01q4EbHjc2RxHh7ineiq57lItgHFq3T+TgA5
         C8HprYEEm87J32slTYbBMivbdhXwqZ6HzQjCnN0Rg1DyLXNqe/aNNwgFglKnvpYxJYr2
         8+1RQab2Bf2yu9zBYEeDzw3UVOV2jd1asQ7hNWHeth3GvGuS2uRyRNX3cYOn641Wb3HP
         AB2fx+YxY7uLTw9BUzjyGgkE2W8Wi6v2jciYINTPBP7Oy1NxCn4CrfsJQ1mt9TIew4Uh
         zs8g==
X-Gm-Message-State: APzg51DnG/P0mu6d7LvTK46aiwSAtPqKnFD/JlZg+TpzeFZmNBlUY18/
        Jiti2bsw8Tz+RA1ZONg6RHAwViPP0/s=
X-Google-Smtp-Source: ANB0Vdazvy5+Y9S+kMz1LU3d8oz16e/Q6biPuqLWAUcCNe6fOam6pWAG82hAtTOGD1hWtCJ1VlrkgQ==
X-Received: by 2002:a50:a3cb:: with SMTP id t11-v6mr2461246edb.238.1535463539269;
        Tue, 28 Aug 2018 06:38:59 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id o22-v6sm693563edc.90.2018.08.28.06.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:38:58 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH v2 00/11] Another round of tsens cleanups
Date:   Tue, 28 Aug 2018 19:08:29 +0530
Message-Id: <cover.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another series of tsens cleanups before we add interrupt support. This applies on top of 4.19-rc1.

In this series, we have the following:
- splitup 8916 and 8974 register address spaces for SROT and TM
- cleanups: move to spdx, dead code removal, removal of id field
- Add support to map the SROT address space for DTs that list it separately
- Check if TSENS IP is enabled in firmware by querying the SROT space
- Add reg-names property to get more readable outputs in /proc/iomem
- Add myself as maintainer of tsens

Changes since v1:
- Split up changes that split the address space and added qcom,sensors
  property into two separate patches
- Remove brackets in typo correction patch

Amit Kucheria (11):
  arm/arm64: dts: msm8974/msm8916: thermal: Split address space into two
  arm/arm64: dts: msm8974/msm8916: thermal: Add "qcom,sensors" property
  dt-bindings: thermal: Fix a typo in documentation
  thermal: tsens: Add SPDX license identifiers
  thermal: tsens: Get rid of dead code
  thermal: tsens: Rename map field in order to add a second address map
  thermal: tsens: Add the SROT address map
  thermal: tsens: Check if the IP is correctly enabled by firmware
  thermal: tsens: Get rid of 'id' field
  arm64: dts: qcom: Add reg-names for all tsens nodes
  MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers

 .../devicetree/bindings/thermal/thermal.txt   |  2 +-
 MAINTAINERS                                   |  7 +++
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  7 ++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  7 ++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  2 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  2 +
 drivers/thermal/qcom/tsens-8916.c             | 11 +---
 drivers/thermal/qcom/tsens-8960.c             | 41 +++++-------
 drivers/thermal/qcom/tsens-8974.c             | 11 +---
 drivers/thermal/qcom/tsens-common.c           | 62 ++++++++++++-------
 drivers/thermal/qcom/tsens-v2.c               |  6 +-
 drivers/thermal/qcom/tsens.c                  | 21 +------
 drivers/thermal/qcom/tsens.h                  | 24 +++----
 13 files changed, 99 insertions(+), 104 deletions(-)

-- 
2.17.1

