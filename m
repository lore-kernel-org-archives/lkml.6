Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbeEQSBm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:01:42 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46836 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeEQSBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:01:24 -0400
X-Google-Smtp-Source: AB8JxZpyNS2sSlGOnZBHoD0eR5q/l2i8R8GI1hfSdxnwgXn6j+ziUvS0lHyTpi+lVaTbl5splhRjPA==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 11/11] ARM: tegra: Create platform device for tegra20-cpufreq driver
Date: Thu, 17 May 2018 21:00:56 +0300
Message-Id: <20180517180056.13336-12-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20-cpufreq driver require a platform device in order to be loaded,
instantiate a simple platform device for the driver during of the machines
late initialization.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 02e712d2ea30..f9587be48235 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -97,6 +97,10 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("compal,paz00"))
 		tegra_paz00_wifikill_init();
+
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra20"))
+		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.17.0
