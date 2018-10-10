Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5478DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152C52150C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwb7f9Hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152C52150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJJWOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeJJWOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:14:53 -0400
Received: from localhost.localdomain (unknown [171.76.86.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC5A2087A;
        Wed, 10 Oct 2018 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539183141;
        bh=hdVUSfkIIpCQk91Rpj6W5n+wZqwd/sDigokYzCyAzj4=;
        h=From:To:Cc:Subject:Date:From;
        b=nwb7f9Hq6Y6twtO1G5dus8GRiU6x3FzYcZc+0jBhJecaKuui+jwu5zxhgeZ+x2iRn
         S1ANPoFmgiR6sxp4hujMYptWdr5TZTDjHWTFXxVL00EACJos2dk7U0j0dL0n8Bsk88
         9Y2WIP3V3k2pdx5bVgz1D02y1tTrjb5ayUzNSlr0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Shefali Jain <shefjain@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Subject: [PATCH v2 0/2] clk: qcom: Add support for QCS404
Date:   Wed, 10 Oct 2018 20:21:36 +0530
Message-Id: <20181010145138.17185-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock driver for QCS404 SoC. This needs to export
clk_alpha_pll_configure() so first patch does that

Changes in v2:
 - Fix comments provided by Stephen & Taniya

Bjorn Andersson (1):
  clk: qcom: Export clk_alpha_pll_configure()

Shefali Jain (1):
  clk: qcom: gcc: Add global clock controller driver for QCS404

 .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
 drivers/clk/qcom/Kconfig                           |    8 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |    1 +
 drivers/clk/qcom/gcc-qcs404.c                      | 2744 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-qcs404.h        |  165 ++
 6 files changed, 2920 insertions(+)
 create mode 100644 drivers/clk/qcom/gcc-qcs404.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-qcs404.h

-- 
2.14.4

