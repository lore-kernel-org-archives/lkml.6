Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE4BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8D920849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8D920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeLKOfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:35:43 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:45019 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeLKOfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:35:42 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MD9Kp-1gfHhj1Z6f-009As2; Tue, 11 Dec 2018 15:35:30 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Aapo Vienamo <avienamo@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: tegra: fix SMP build
Date:   Tue, 11 Dec 2018 15:35:07 +0100
Message-Id: <20181211143528.2024488-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Yr3PefCHlIiPhTL2RRzUnnSvWzKtAq7GB9ZHq121Zj2swOZ/i7Q
 Vl0WGVI0DbkaB9jq6r13YWDMxu0CMgNUIqHe2QS8CEmITnyrrzc6tbzoIFZR2yHUYji/hZ8
 StAtGjdFXpMiH/PO+l19Wuu6XA1e1JBiXYnrNMGMmky3oDd7+zidzlyY9Ce8W4WoUhQomMY
 HJ/nwwHZUX77NphkjGvuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PrHJ2V1FYIA=:+dIncFvgge7dlAORd3u9bI
 eArkfmGK4PCk4pFtgJofpH9QNtdEUyJ8ZZxK3fMfyTukNeBh08s19ZK7P4WJk5Eh+iB3RDyPX
 eXVUmz4k9L3T/cZe+yyeuAiVO6O5QFCrQdmdZO+jSzIKWvAkB7R6dVCbHUaqhzonnC64w6cU1
 fM4hxWY1kUBOVYP2ZmbYwhb3B6E4gMAEljvX8aBv3CKD9WZ5uPoJNiWGUOoYmerPjBK5aOKLk
 W53/QqOwBEJxAOz3B6rXJYtiCET0RppSgwo5ADzXkMCxj5MLv9Zp/O2p3enP7AVqhwoit98nj
 NqvyNNs5hlWctupAgUdMriWUfu+KQUxaPfkFOA2NwEkj5LHXST0Nizi+iLWUNeeC4XNFa/xhP
 3cwAiJvVLpCcpSlx09LlHiT1DY7h1NoXZGbiPnLL1OgnLIHY3AGxgxD/4Qz9XR0twU5o3HMOQ
 iOtZQ+/+s45e/1FDZsgt6Fo40LkFch9jxbABTkWJx2zT7FLORYeh1gJtHQCMc6anlMirFi16L
 STYpWESpc1766UEp6AM0UXJKiV1GtiWQr+GTAWRxQiuxp2FFOLLw5EmOPkaWy4xYtM3yF/Ej/
 Lb+Ayld0eQH8zJKA0p/UaeI0xgJD6HU7mca2a/tNm4S2eq2zZQu81LiBhyxzAZ05Ns83gEaoK
 WnZM78wknjdmcAwyZD7enX7RiK0QN72zHqUwuNo/xTAVg8OueD+RQ3XfcMpsx1GlPkJC3SXK9
 fNZ9LqDAVVe7edE1rpBKKvRerw72dlrX973SXw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SMP is disabled, the tegra clk driver now fails to build:

drivers/clk/tegra/clk-tegra30.c: In function 'tegra30_cpu_rail_off_ready':
drivers/clk/tegra/clk-tegra30.c:1151:19: error: implicit declaration of function 'tegra_pmc_cpu_is_powered'; did you mean 'tegra_powergate_is_powered'? [-Werror=implicit-function-declaration]
  cpu_pwr_status = tegra_pmc_cpu_is_powered(1) ||

I don't know if tegra works without CONFIG_SMP, but we can get it to
build by making the calls conditional, and removing the pointless
ifdef around the declaration. The assumption now is that in a
non-SMP system, the secondary CPUs are always disabled.

Fixes: 61866523ed6e ("clk: tegra30: Use Tegra CPU powergate helper function")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure if this is the best solution. If you think it's not, please
submit a different fix.
---
 drivers/clk/tegra/clk-tegra30.c | 10 +++++++---
 include/soc/tegra/pmc.h         |  2 --
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index fa8d573ac626..1505185936f4 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1148,9 +1148,13 @@ static bool tegra30_cpu_rail_off_ready(void)
 
 	cpu_rst_status = readl(clk_base +
 				TEGRA30_CLK_RST_CONTROLLER_CPU_CMPLX_STATUS);
-	cpu_pwr_status = tegra_pmc_cpu_is_powered(1) ||
-			 tegra_pmc_cpu_is_powered(2) ||
-			 tegra_pmc_cpu_is_powered(3);
+
+	if (IS_ENABLED(CONFIG_SMP))
+		cpu_pwr_status = tegra_pmc_cpu_is_powered(1) ||
+				 tegra_pmc_cpu_is_powered(2) ||
+				 tegra_pmc_cpu_is_powered(3);
+	else
+		cpu_pwr_status = 0;
 
 	if (((cpu_rst_status & 0xE) != 0xE) || cpu_pwr_status)
 		return false;
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index fd816f6aa9cc..a9db1b501de1 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -26,11 +26,9 @@
 struct clk;
 struct reset_control;
 
-#ifdef CONFIG_SMP
 bool tegra_pmc_cpu_is_powered(unsigned int cpuid);
 int tegra_pmc_cpu_power_on(unsigned int cpuid);
 int tegra_pmc_cpu_remove_clamping(unsigned int cpuid);
-#endif /* CONFIG_SMP */
 
 /*
  * powergate and I/O rail APIs
-- 
2.20.0

