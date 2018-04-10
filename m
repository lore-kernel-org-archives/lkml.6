Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeDJR5d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:57:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33496 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDJR5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:57:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA8F06079B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v8 0/2]  drivers/qcom: add Command DB support
Date: Tue, 10 Apr 2018 11:57:22 -0600
Message-Id: <20180410175724.7165-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v7:
	- Add reviewed-by tags
	- Fix example

Changes since v6:
        - Fix 'reg' property
        - Add reviewed-by tags

Changes since v5:
        - Remove indirection of command db start address
        - Rebase on top of 4.16

Changes since v4:
        - Address comments from Stephen and Bjorn

These patches add support for reading a shared memory database in the newer
QCOM SoCs called Command DB. With the new architecture on SDM845, shared
resources like clocks, regulators etc., have dynamic properties. These
properties may change based on external components, board configurations or
available feature set. A remote processor detects these parameters and fills up
the database with the resource and available state information. Platform
drivers that need these shared resources will need to query this database to
get the address and properties and vote for the state.

The information in the database is static. The database is read-only memory
location that is available for Linux. A pre-defined string is used as a key into
an entry in the database. Generally, platform drivers query the database only
at init to get the information they need.

[v1]: https://www.spinics.net/lists/linux-arm-msm/msg32462.html
[v2]: https://lkml.org/lkml/2018/2/8/588
[v3]: https://lkml.org/lkml/2018/2/16/842
[v4]: https://patchwork.kernel.org/patch/10242935/
[v5]: https://lkml.org/lkml/2018/3/14/787
[v6]: https://lkml.org/lkml/2018/4/5/451
[v7]: https://lkml.org/lkml/2018/4/6/756

Lina Iyer (2):
  drivers: qcom: add command DB driver
  dt-bindings: introduce Command DB for QCOM SoCs

 .../bindings/reserved-memory/qcom,cmd-db.txt       |  37 +++
 drivers/of/platform.c                              |   1 +
 drivers/soc/qcom/Kconfig                           |   9 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/cmd-db.c                          | 310 +++++++++++++++++++++
 include/soc/qcom/cmd-db.h                          |  45 +++
 6 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
 create mode 100644 drivers/soc/qcom/cmd-db.c
 create mode 100644 include/soc/qcom/cmd-db.h

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
