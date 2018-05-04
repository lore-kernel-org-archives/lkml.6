Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEDKC4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:02:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEDKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:02:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05DBF6055D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [v8] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Fri,  4 May 2018 15:32:37 +0530
Message-Id: <1525428158-29147-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v8]
   * cleanup code to remove of rpmh_client handle.
   * pass the hw_clks array to the devm_of_clk_add_hw_provider getter function.

 [v7]
   * Addressed comments from Stephen
	- Keep only xo_board as clock parent.
	- Associate divs from SoC specific clock listing to calculate
	   the clock rate.
	- Add back the recalc_rate clock ops to return the clock rate
	   based on the parent rate and div associated with clock.
	- void cast kept to avoid compiler warnings.

 [v6]
   * Addressed comments from Rob
   * Addressed comments from Stephen

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

Taniya Das (1):
  clk: qcom: clk-rpmh: Add QCOM RPMh clock driver

 drivers/clk/qcom/Kconfig    |   9 ++
 drivers/clk/qcom/Makefile   |   1 +
 drivers/clk/qcom/clk-rpmh.c | 334 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+)
 create mode 100644 drivers/clk/qcom/clk-rpmh.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
