Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934154AbeEILcy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:32:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54440 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756252AbeEILcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:32:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5C8860F8F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v2 0/2] Add QCOM video clock controller driver
Date: Wed,  9 May 2018 17:02:29 +0530
Message-Id: <1525865551-20489-1-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
https://lkml.org/lkml/2018/5/8/918
- Added #defines for resets in the header file.

Changes in v1:
   https://lkml.org/lkml/2018/4/24/545
Addressed below review comments given by Rob
- Change the compatible property as per '<vendor>,<soc>-<block>' format.
- Add header definitions for resets and power-domain cells.

This patch series adds a driver and device tree documentation binding
for the video clock controller on some Qualcomm Technologies, Inc, SoCs
such as SDM845. This would allow video drivers to probe and control their
clocks.

The video clock driver depends upon the RPMh driver[1], command DB driver[2],
RPMh clock driver[3], rcg2 shared ops[4] and GCC clock driver[5] changes
which are undergoing review.

[1]: https://lkml.org/lkml/2018/4/19/914
[2]: https://lkml.org/lkml/2018/4/5/451
[3]: https://lkml.org/lkml/2018/4/24/390
[4]: https://lkml.org/lkml/2018/4/18/367
[5]: https://lkml.org/lkml/2018/4/30/533

[v1]: https://lkml.org/lkml/2018/5/3/386

Amit Nischal (2):
  dt-bindings: clock: Introduce QCOM Video clock bindings
  clk: qcom: Add video clock controller driver for SDM845

 .../devicetree/bindings/clock/qcom,videocc.txt     |  19 ++
 drivers/clk/qcom/Kconfig                           |  11 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/videocc-sdm845.c                  | 358 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,videocc-sdm845.h    |  35 ++
 5 files changed, 424 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,videocc.txt
 create mode 100644 drivers/clk/qcom/videocc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sdm845.h

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
