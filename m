Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030296AbeEYVIX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:08:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968376AbeEYVIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:08:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sunxi: mark PM functions as __maybe_unused
Date: Fri, 25 May 2018 23:07:42 +0200
Message-Id: <20180525210752.1794502-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:1tau9DkHdvzXdx1rmlnNedUZAtEcCsULpVUWZY9PJKqYXvuKts8
 8cud7qqENKSP3Cr6rMwZrcGels0in+cT9klDT0nPI5xyyp1ZVs6XfIwGjDIwJlaTOcdBMRL
 WzIY72fjk1P3ZzAalEXIHFu4NOX2kZN1McqQGU3YFR5aGn/TRioCMH1YjJPFjW9tTFojScg
 RjmZmQJdorjWMvZFfIUkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nBzFG2o06pc=:XFFPVm55PpQERwF0ile6rz
 YaJfws7imjQRcYBMsOtf5rGPWe/EnbRnBlyQLRO0YDhEt01gzLpbaWUKJGs9jGhdbE0moKjJQ
 C6DvRUeyR2sxoVd4AVpJX5deztSfYbKvvZXzTp3M4m/BbgLuaYdTNImgyFITPUf2Z+tIMfrpt
 WSDOqWfBLMzKa+Cc871N/CWZ/Dpmx/vhjTlkc4h4rPtgsDiibjRWVH4fKsDK2H/fs3fnvjrLg
 qQOEsANmu+IkWP2BQXoW2v69/VGhqiLb1iBdyeCbV6DZA7Gl+hX8x0n70lPicNUi/RMcaFVkU
 Rty1GW4uF1mCQws2UyV/ODnGW6NN+Br8TBUTbI8wjBxT9yHlpf5Fvu1MtTvrM+95Jho0w2UnX
 xofHrhpW49pLW7sXpVzwLGnhlh38JnIExBcJ/v18t8zhR1Kc2T3vSUDl7RplFGVj+BLV95ZN5
 iEEOXf7I8xP7g4jfIZoMfnHGkJWML5Yp1bZ7WssQccztIe+jnaohc1r7uQAGBu5W9EXJe/fPT
 mlhyW9Rt2ZbS07h923Cji9UI+Sa0gtNCi9kGcHJb5CGrTPU+xPkGiZrSwN+XTIRqRmyNc15K/
 Nb5hqkamcWBTxAlqGgY10C/bin9wHuSNchD8VcUmm/ePdGQjS8yzUtBLcFCoSCwtT1x5IIouf
 v0YHGtdxfAsA5mvQqfqlZjQKIbeWZ5Gv965OomUDlJmAjMaRVTHIpuP0I9k+tSfjksaU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added runtime-pm functions cause a harmless warning
when CONFIG_PM is disabled:

drivers/mmc/host/sunxi-mmc.c:1452:12: error: 'sunxi_mmc_runtime_suspend' defined but not used [-Werror=unused-function]
 static int sunxi_mmc_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sunxi-mmc.c:1435:12: error: 'sunxi_mmc_runtime_resume' defined but not used [-Werror=unused-function]
 static int sunxi_mmc_runtime_resume(struct device *dev)

This marks them as __maybe_unused to shut up the warning.

Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sunxi-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 97c6b79b7d6f..837888b96bd3 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1432,7 +1432,7 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int sunxi_mmc_runtime_resume(struct device *dev)
+static int __maybe_unused sunxi_mmc_runtime_resume(struct device *dev)
 {
 	struct mmc_host	*mmc = dev_get_drvdata(dev);
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -1449,7 +1449,7 @@ static int sunxi_mmc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int sunxi_mmc_runtime_suspend(struct device *dev)
+static int __maybe_unused sunxi_mmc_runtime_suspend(struct device *dev)
 {
 	struct mmc_host	*mmc = dev_get_drvdata(dev);
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
-- 
2.9.0
