Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeFDKqr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:46:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeFDKqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:46:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1C4A60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        robh@kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        skannan@codeaurora.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v3 0/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver
Date: Mon,  4 Jun 2018 16:16:32 +0530
Message-Id: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v3]
  * Remove index check from 'qcom_cpufreq_fw_target_index'.
  * Update the Documentation binding to add the platform specific properties in
    the CPU nodes, node name "qcom,freq-domain".
  * Update return value to '0' from -ENODEV from 'qcom_cpufreq_fw_get'.
  * Update the logic for boost frequency to use local variables instead of
    cpufreq driver data in 'qcom_read_lut'.
  * Update the logic in 'qcom_get_related_cpus' to find the related cpus.
  * Update the reg-names to remove "_base" and also update the binding with the
    description of these registers.
  * Update the logic in 'qcom_resources_init' to address the new device tree
    notation of handling the frequency domain phandles.

 [v2]
 * Fixed the alignment issues in "qcom_cpufreq_fw_target_index" for dev_err and
   also for "qcom_cpu_resources_init".
 * Removed ret = 0 from qcom_get_related_cpus and added to check for
   cpu_mask_empty to return -ENOENT.
 * Fixes qcom_cpu_resources_init function
   * Remove initialization of 'index'
   * Check for valid 'c'
 * Removed initialization of 'prev_cc' from 'qcom_read_lut'.
 * Remove initialization of 'ret' from function qcom_resources_init and add
   return -ENODEV based on 'of_get_available_child_count'.
 * Removed initialization of 'rc' from qcom_cpufreq_fw_driver_probe
 * Removed module_exit as this driver would not be used as module, also updated
   the Kconfig to bool from tristate.
 * Updated the subsystem in device tree bindings.

 [v1]
   * Fixed compilation reported by Amit K.

Taniya Das (2):
  dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
  cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver

 .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 173 +++++++++++
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/qcom-cpufreq-fw.c                  | 318 +++++++++++++++++++++
 4 files changed, 501 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
