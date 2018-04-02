Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbeDBKqI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:46:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754257AbeDBKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:46:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E03256037B
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
Subject: [PATCH 0/3] Update reset and poll logic for GDSCs
Date: Mon,  2 Apr 2018 16:15:42 +0530
Message-Id: <1522665945-28147-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements the below logic for the GDSCs

1. logic to reset the AON logic before or assert/deassert the block
   control reset removing the clamp io for few GDSCs on SDM845 SoC.
2. It also introduces the requirement to poll for higher timeout values
   for few of the GDSCs.
3. There is a new poll register for the GDSCs on SDM845 SoCs which needs
   to be polled for the correct hardware status of the GDSCs.

Amit Nischal (3):
  clk: qcom: gdsc: Add support to reset AON and block reset logic
  clk: qcom: gdsc: Add support to poll for higher timeout value
  clk: qcom: gdsc: Add support to poll CFG register to check GDSC state

 drivers/clk/qcom/gdsc.c | 77 +++++++++++++++++++++++++++++++++++++++++++++----
 drivers/clk/qcom/gdsc.h |  6 +++-
 2 files changed, 76 insertions(+), 7 deletions(-)

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
