Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbeCPEIq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:08:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48866 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeCPEIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:08:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BECE4603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 0/7] Add powerdomain driver for corners on msm8996
Date: Fri, 16 Mar 2018 09:38:17 +0530
Message-Id: <20180316040824.21472-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With performance state support for genpd merged, and with some more
patches to add support for them in the OPP layer [1] under discussion,
this is an effort to model a powerdomain driver to communicate corner/level
values for qualcomm platforms to RPM (Remote Power Manager)

This series adds data specific to msm8996 and is tested on the
db820c. We also modify mmc as one of the first devices to move to
using an OPP table and vote on corners using the performance state
infrastructure.

[1] https://lwn.net/Articles/742136/

Rajendra Nayak (6):
  soc: qcom: rpmpd: Add a powerdomain driver to model corners
  dt-bindings: opp: Introduce qcom-opp bindings
  soc: qcom: rpmpd: Add support for get/set performance state
  arm64: dts: msm8996: Add rpmpd device node
  mmc: sdhci-msm: Adapt the driver to use OPPs to set clocks/performance
    state
  soc: qcom: rpmpd: Add a max vote on all corners at init

Viresh Kumar (1):
  PM / OPP: Add dev_pm_opp_get_of_node()

 Documentation/devicetree/bindings/opp/qcom-opp.txt |  25 ++
 .../devicetree/bindings/power/qcom,rpmpd.txt       |  14 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  87 +++++
 drivers/clk/qcom/gcc-msm8996.c                     |   8 +-
 drivers/mmc/host/sdhci-msm.c                       |  57 +++-
 drivers/opp/of.c                                   |  19 ++
 drivers/soc/qcom/Kconfig                           |   9 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rpmpd.c                           | 350 +++++++++++++++++++++
 include/linux/pm_opp.h                             |   5 +
 10 files changed, 561 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 drivers/soc/qcom/rpmpd.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
