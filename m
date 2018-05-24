Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970684AbeEXPDr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:03:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966863AbeEXPDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:03:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A0FDB60262
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ilialin@codeaurora.org
Subject: [PATCH v13 0/2] Kryo CPU scaling driver
Date: Thu, 24 May 2018 18:03:38 +0300
Message-Id: <1527174220-13244-1-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v13]
 * Addressed comment from Sudeep about DT compatible check on init

[v12]
 * Addressed comments from Sudeep and Viresh about the single init

[v11]
 * Addressed comment from Russel about device_node reference
 * Addressed comment from Sudeep about the late_initcall
 * Transformed init into probe to take care of deferals

[v10]
 * Split the series into domains
 * Addressed comments from Viresh and Sudeep about logical CPU numbering.

The qcom-cpufreq-kryo driver is aimed to support different SOC versions.
The driver reads eFuse information and chooses the required OPP subset
by passing the OPP supported-hw parameter.

The series depends on the series from Viresh:
https://patchwork.kernel.org/patch/10418139/

The previous spin was here:
https://patchwork.kernel.org/patch/10423137/

Ilia Lin (2):
  cpufreq: Add Kryo CPU scaling driver
  dt-bindings: cpufreq: Document operating-points-v2-kryo-cpu

 .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/cpufreq/qcom-cpufreq-kryo.c                | 206 +++++++
 5 files changed, 900 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c

-- 
1.9.1
