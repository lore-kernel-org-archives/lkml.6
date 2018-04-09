Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeDIIhb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:37:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDIIh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:37:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 564AC60540
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
Subject: [PATCH v2 0/3] Update reset and poll logic for GDSCs
Date: Mon,  9 Apr 2018 14:07:07 +0530
Message-Id: <1523263030-26884-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v2]
  * Addressed review comments given in v1 series

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

 drivers/clk/qcom/gdsc.c | 63 +++++++++++++++++++++++++++++++++++++++++++------
 drivers/clk/qcom/gdsc.h |  5 +++-
 2 files changed, 60 insertions(+), 8 deletions(-)

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
