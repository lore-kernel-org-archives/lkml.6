Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeC2GSt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 02:18:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeC2GSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 02:18:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EBDD602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 0/2] Add QCOM RPMh Clock driver
Date: Thu, 29 Mar 2018 11:47:51 +0530
Message-Id: <1522304274-18989-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds a driver and device tree documentation binding
for the clock control via Resource Power Manager-hardened (RPMh) on some
Qualcomm Technologies, Inc, SoCs such as SDM845. The clock RPMh driver
would send requests for the RPMh managed clock resources.

The RPMh clock driver depends upon the RPMh driver [1] and command DB
driver [2] which are both still undergoing review.

Thanks,
Taniya

[1]: https://lkml.org/lkml/2018/3/9/979
[2]: https://lkml.org/lkml/2018/3/14/787

Amit Nischal (2):
  clk: qcom: clk-rpmh: Add QCOM clock RPMh driver
  dt-bindings: clock: Introduce QCOM RPMh clock bindings

 .../devicetree/bindings/clock/qcom,rpmh.txt    |  22 ++
 drivers/clk/qcom/Kconfig                       |   9 +
 drivers/clk/qcom/Makefile                      |   1 +
 drivers/clk/qcom/clk-rpmh.c                    | 397 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,rpmh.h          |  25 ++
 5 files changed, 454 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmh.txt
 create mode 100644 drivers/clk/qcom/clk-rpmh.c
 create mode 100644 include/dt-bindings/clock/qcom,rpmh.h

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
