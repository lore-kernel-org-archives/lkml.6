Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBZR6X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:58:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbeBZR6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:58:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 962FD6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v4 0/2] drivers/qcom: add Command DB support
Date: Mon, 26 Feb 2018 10:58:00 -0700
Message-Id: <20180226175802.20052-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
	- DT binding documentation fixes as suggested by Rob.

These patches add support for reading a shared memory database in the newer
QCOM SoCs called Command DB. With the new architecture on SDM845, shared
resources like clocks, regulators etc., have dynamic properties. These
properties may change based on external components, board configurations or
available feature set. A remote processor detects these parameters and fills up
the database with the resource and available state information. Platform
drivers that need these shared resources will need to query this database to
get the address and properties and vote for the state.

The information in the database is static.  The database is read-only memory
location that is available for Linux. A pre-defined string is used as a key into
an entry in the database. Generally, platform drivers query the database only
at init to get the information they need.

[v1]: https://www.spinics.net/lists/linux-arm-msm/msg32462.html
[v2]: https://lkml.org/lkml/2018/2/8/588
[v3]: https://lkml.org/lkml/2018/2/16/842

Lina Iyer (2):
  drivers: qcom: add command DB driver
  dt-bindings: introduce Command DB for QCOM SoCs

 .../devicetree/bindings/arm/msm/cmd-db.txt         |  38 +++
 drivers/of/platform.c                              |   1 +
 drivers/soc/qcom/Kconfig                           |   9 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/cmd-db.c                          | 319 +++++++++++++++++++++
 include/soc/qcom/cmd-db.h                          |  50 ++++
 6 files changed, 418 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/cmd-db.txt
 create mode 100644 drivers/soc/qcom/cmd-db.c
 create mode 100644 include/soc/qcom/cmd-db.h

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
