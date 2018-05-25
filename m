Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965629AbeEYKBh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:01:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45184 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965259AbeEYKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:01:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D4F960618
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, collinsd@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 0/6] Add powerdomain driver for corners on msm8996/sdm845
Date: Fri, 25 May 2018 15:31:15 +0530
Message-Id: <20180525100121.28214-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
* added a powerdomain driver for sdm845 which supports communicating to RPMh
* dropped the changes to sdhc driver to move over to using OPP
as there is active discussion on using OPP as the interface vs
handling all of it in clock drivers
* Other minor binding updates based on review of v1

With performance state support for genpd merged, and with some more
patches to add support for them in the OPP layer [1] in linux-next,
this is an effort to model a powerdomain driver to communicate corner/level
values for qualcomm platforms to RPM (Remote Power Manager) and RPMh.

The series is based on linux-next as it depends on OPP updates and SMD845
specific patches which are all in linux-next. It also depends on the RPMH
communication patches [2] for the sdm845 rpmhpd driver.

[1] https://lwn.net/Articles/742136/
[2] https://lkml.org/lkml/2018/5/9/729

Rajendra Nayak (6):
  soc: qcom: rpmpd: Add a powerdomain driver to model corners
  dt-bindings: opp: Introduce qcom-opp bindings
  soc: qcom: rpmpd: Add support for get/set performance state
  arm64: dts: msm8996: Add rpmpd device node
  soc: qcom: rpmh powerdomain driver
  soc: qcom: rpmpd/rpmhpd: Add a max vote on all corners at init

 .../devicetree/bindings/opp/qcom-opp.txt      |  25 ++
 .../devicetree/bindings/power/qcom,rpmhpd.txt |  65 +++
 .../devicetree/bindings/power/qcom,rpmpd.txt  |  55 +++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  40 ++
 drivers/soc/qcom/Kconfig                      |  18 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/rpmhpd.c                     | 369 ++++++++++++++++++
 drivers/soc/qcom/rpmpd.c                      | 354 +++++++++++++++++
 8 files changed, 928 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 drivers/soc/qcom/rpmhpd.c
 create mode 100644 drivers/soc/qcom/rpmpd.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
