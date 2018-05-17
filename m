Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeEQSB0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:01:26 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46830 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbeEQSBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:01:23 -0400
X-Google-Smtp-Source: AB8JxZox/efiBt3Xuj9h4my0w6je0QmhvKxrEtrhzeWt5t0V3XUoqwGtJFNhvl2ZIcgOB60AclMhRQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 09/11] cpufreq: tegra20: Allow cpufreq driver to be built as loadable module
Date: Thu, 17 May 2018 21:00:54 +0300
Message-Id: <20180517180056.13336-10-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing prevents Tegra20 CPUFreq module to be unloaded, hence allow it to
be built as a non-builtin kernel module.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 96b35b8b3606..a8a2e210c624 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -264,7 +264,7 @@ config ARM_TANGO_CPUFREQ
 	default y
 
 config ARM_TEGRA20_CPUFREQ
-	bool "Tegra20 CPUFreq support"
+	tristate "Tegra20 CPUFreq support"
 	depends on ARCH_TEGRA
 	default y
 	help
-- 
2.17.0
