Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C910BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934042145D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934042145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbeLJUqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:46:03 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:60849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeLJUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:46:03 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N4yqC-1hUmoZ2uKy-010uIx; Mon, 10 Dec 2018 21:45:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-msm: avoid unused function warning
Date:   Mon, 10 Dec 2018 21:45:36 +0100
Message-Id: <20181210204546.2384299-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zEJx0bDd6tl+VoEOfulBPFWryW46KUhq3qSGXgTOahAORc4HTlf
 YLDsReyLbx+mR/9gIMY9qjVGc00Sr+sNWGVjNfBuSDmafvfJ1YFTjtvlBNlIOh/ulCTKwA3
 ow+7Mj8ufRLG/BjY6UnUwgzKVUADgI3OiGZWWGFoAYIUb0qT3PHpxXGELN8CliDHSPghEGF
 OwsBMw2mk1ADQWr9ZTaJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NqfvuMT9nos=:0j0QZvm8nWNgw80sNJn5Jc
 vvGI7FcycBG+pH1P+Z9N/ij4PVAWFUirvy/bRPGhBstQBRbf2iGCRJ0SUxlpkFXjQZeg0q00n
 ndPA8lK3UmHFDj0eBTOBUTAwYPCDR7ELwOJisKm2zt12T1e61OLPs3Qz6AgA5cBGh5gEkPwdP
 Dolf/zkRChAqEAZYmw+3T8tMIFPhUfqJrCcCdjnTK9K32EgjwdItUaGDu9dUTBxFJtcVFVXA2
 fVuMSADh5YCKYjvanibpCLCdPB9xGy32/TvprhdyChF3u7XVzQ+dBgGvMx8vNHMDs9icYWDU/
 nKRZ9igYLHMqwzdkGMAd9iFHymEg31sq9xeH3HkTQuEeOZKqh+QAi4oU8z4qJz9rDjejL7wiO
 1OEgxqV3Qvwos9egtWeZTiOXbLRGwYlK+hvmF9EuMqt9cWPeq+g52NPe40y7N216M6JAvSv2+
 7iNNmYds88SvS/4Mxxe57q3BIev8oGKIkoiuu/ePyMq7dO7wNY12k2DWs3mVybQe+fpbHUD86
 DmH3RiVwmXRsoMPFz/LzUqyZd/vdgnGdzL6AhbT+UjAzHXIf5ds4Ev+TGRs6RhJsc8H/zX+Da
 5PXwL7JGu/z5uLJlyPh7pa2vlqnWHosrlxyn+akT3vxI413BSUjkgOLWsv89PWb9D1oJOHLYS
 3Qn03gfMWKof4npNZI58yUGxAdlm+uwuKGOjQLfVfTI0hBVieyr1But4okThF7BaI9eTYIVoC
 TLeDE4REQBFw6AeYBKSy+5P0eK4lgWLLfRYiZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added sdhci_msm_restore_sdr_dll_config() function is only
called if CONFIG_PM is enabled:

drivers/mmc/host/sdhci-msm.c:1050:12: error: 'sdhci_msm_restore_sdr_dll_config' defined but not used [-Werror=unused-function]

Better remove the incorrect #ifdef altogether and just use __maybe_unused,
which is harder to get wrong.

Fixes: ec3349733550 ("mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-msm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5497a71abe07..d6c9ebd8d263 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1997,8 +1997,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int sdhci_msm_runtime_suspend(struct device *dev)
+static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2010,7 +2009,7 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int sdhci_msm_runtime_resume(struct device *dev)
+static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2030,7 +2029,6 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sdhci_msm_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-- 
2.20.0

