Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754183AbeEAIlv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:41:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbeEAIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:41:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E995F60C67
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
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [v5 0/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Tue,  1 May 2018 14:11:31 +0530
Message-Id: <1525164093-16645-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v5]
   * Addressed comments from Stephen
   * Introduced a new DT property to take clock divs

 [v4]
  * Addressed comments from Stephen

 [v3]
  * Addressed documentation & code review comments from Bjorn
  * Addressed bindings comments from Rob
  * Updated the patch series order for bindings

 [v2]
  * Addressed comments from Stephen
  * Addressed comments from Evan

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

Taniya Das (2):
  dt-bindings: clock: Introduce QCOM RPMh clock bindings
  clk: qcom: clk-rpmh: Add QCOM RPMh clock driver

 .../devicetree/bindings/clock/qcom,rpmh-clk.txt    |  32 ++
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-rpmh.c                        | 387 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,rpmh.h              |  22 ++
 5 files changed, 451 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
 create mode 100644 drivers/clk/qcom/clk-rpmh.c
 create mode 100644 include/dt-bindings/clock/qcom,rpmh.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
