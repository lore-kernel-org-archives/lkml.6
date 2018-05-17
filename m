Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeEQSBP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:01:15 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45024 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQSBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:01:13 -0400
X-Google-Smtp-Source: AB8JxZrtvzJrA0+v8stTulKhcMjWnyWVyAzm7JftiDWny0CYh/IE0b6Ha2JUwLrI7dvUFP/1eXgVyQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 00/11] Clean up Tegra20 cpufreq driver
Date: Thu, 17 May 2018 21:00:45 +0300
Message-Id: <20180517180056.13336-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Recently Peter Geis (who is working on Tegra30 cpufreq driver) asked me how
tegra20-cpufreq driver is getting loaded. After taking a look at the code
it became apparent that the drivers code has been rusted a tad and so this
series is intended to refresh the drivers code by disallowing module to be
loaded on non-Tegra20 machines, by cleaning whitespaces in the code, removing
dead EMC code and in the end by allowing tegra20-cpufreq to be built as a
loadable module.

Please review, thanks.

Dmitry Osipenko (11):
  cpufreq: tegra20: Change module description
  cpufreq: tegra20: Clean up whitespaces in the code
  cpufreq: tegra20: Remove EMC clock usage
  cpufreq: tegra20: Release clocks properly
  cpufreq: tegra20: Clean up included headers
  cpufreq: tegra20: Remove unneeded check in tegra_cpu_init
  cpufreq: tegra20: Check if this is Tegra20 machine
  cpufreq: tegra20: Remove unneeded variable initialization
  cpufreq: tegra20: Allow cpufreq driver to be built as loadable module
  cpufreq: tegra20: Wrap cpufreq into platform driver
  ARM: tegra: Create platform device for tegra20-cpufreq driver

 arch/arm/mach-tegra/tegra.c       |   4 +
 drivers/cpufreq/Kconfig.arm       |   2 +-
 drivers/cpufreq/tegra20-cpufreq.c | 172 +++++++++++++++++-------------
 3 files changed, 101 insertions(+), 77 deletions(-)

-- 
2.17.0
