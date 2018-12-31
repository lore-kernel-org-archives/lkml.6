Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800F3C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0DF2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b98qWlJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeLaSzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:55:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43687 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeLaSzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:55:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so13456141pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XIzqSzvnS+vj4Sll9x6Seco6sA7Z+UbLnEB7Ylb8mHc=;
        b=b98qWlJYut0UqW3LDhal3ej051J+e5txsgs5wuNpP5qFP84EPLc44VkTayjTFlCezR
         EugbUq5bvrF1Ga+rXUESXzsWJtI3sG0+FcCHF0gCfGWwRE3SGH2OrJfBeiUO8006OoXJ
         TJYdc1ei9ec4P39pFyLvsD1pw/knGRSlGauu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XIzqSzvnS+vj4Sll9x6Seco6sA7Z+UbLnEB7Ylb8mHc=;
        b=bM6FLSNvb2bqILB+BvpG0QTlwq446MjRBuQmgLWNRMxZS8h4f+jIUPOVz/hINwec+Q
         qxfkYXBImh7nhDjTcMZlXnLjmrUQi/NeLOiUVJy93wWEAtLN2sowA4WDT2X3uliUvWK3
         8zXT03FVVQX3ND4e3s7o1EpgX250n+PjxhG+ewSu/7cK9xvutBYh8Wl/WwVbLFepkEWK
         e9wysCoeQs/068JP/uAAbFn2cSPsih04P0JsDXvr4poTPAydZB9XllLjZ6/EbNwaFu7k
         7VEdDQ8Y2T9zUaUCgTa+f/yOgO5e0QUDLYw2w3x5zPoDoPN5CqukH1F/vEK6R+JmMidx
         0IpQ==
X-Gm-Message-State: AJcUukdeDEWRo836MvvwEh/oPlhHuKLtxWaoSHhS2bsj2VqOrcHKHEKq
        ZlyLQ5H1N8jbR+MeaME31RVx
X-Google-Smtp-Source: ALg8bN5Usp8F4ykrKm2/LbYg1HM7q7JAX2yRcmpDfT6GvtdTtC/hyJXNCygE78NaIHPx4kXLEXIovA==
X-Received: by 2002:a63:9402:: with SMTP id m2mr8086322pge.93.1546282538801;
        Mon, 31 Dec 2018 10:55:38 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
        by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 10:55:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/6] Add clock support for Actions Semi S500 SoC
Date:   Tue,  1 Jan 2019 00:25:11 +0530
Message-Id: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds common clock support for Actions Semi S500 SoC of
the Owl family SoCs. This series is based on the initial work done
by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/

Since there isn't any update from him for long time, I took the liberty
to modify his patches, address review comments and send to list for review.

This series has been tested on Allo Sparky SBC.

Thanks,
Mani

Edgar Bernardi Righi (1):
  dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU

Manivannan Sadhasivam (5):
  clk: actions: Add configurable PLL delay
  ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
  ARM: dts: Remove fake UART clock for S500 based SBCs
  clk: actions: Add clock driver for S500 SoC
  MAINTAINERS: Add linux-actions mailing list for Actions Semi

 .../bindings/clock/actions,owl-cmu.txt        |   7 +-
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/owl-s500-cubieboard6.dts    |   7 -
 .../arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |   7 -
 arch/arm/boot/dts/owl-s500-sparky.dts         |   7 -
 arch/arm/boot/dts/owl-s500.dtsi               |  22 +
 drivers/clk/actions/Kconfig                   |   5 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-pll.c                 |   2 +-
 drivers/clk/actions/owl-pll.h                 |  30 +-
 drivers/clk/actions/owl-s500.c                | 524 ++++++++++++++++++
 include/dt-bindings/clock/actions,s500-cmu.h  |  78 +++
 12 files changed, 660 insertions(+), 31 deletions(-)
 create mode 100644 drivers/clk/actions/owl-s500.c
 create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h

-- 
2.17.1

