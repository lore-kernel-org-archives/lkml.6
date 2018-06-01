Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeFANHL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:07:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48840 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbeFANFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:05:14 -0400
From: Colin King <colin.king@canonical.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: ACPI: make function acpi_cpufreq_fast_switch static
Date: Fri,  1 Jun 2018 14:05:12 +0100
Message-Id: <20180601130512.30857-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function acpi_cpufreq_fast_switch is local to the source and does
not need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/cpufreq/acpi-cpufreq.c:468:14: warning: symbol
'acpi_cpufreq_fast_switch' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 9449657d72f0..32ba4bc972e7 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -465,8 +465,8 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	return result;
 }
 
-unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
-				      unsigned int target_freq)
+static unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 	struct acpi_processor_performance *perf;
-- 
2.17.0
