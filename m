Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427007AbeBORIl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:08:41 -0500
Received: from mout.web.de ([212.227.17.11]:51537 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422885AbeBORIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:08:37 -0500
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] cpufreq: qoriq: Delete two error messages for a failed memory
 allocation in qoriq_cpufreq_cpu_init()
Message-ID: <650e783f-7b4c-17b5-3bc7-56e3058a95d1@users.sourceforge.net>
Date: Thu, 15 Feb 2018 18:08:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:nSmbYIxsy93Reb8GBjMMeZR2rn0uLVdwHouI6Wr6Jh+siJooXGT
 OV4xHYQ1r1xzeQXYr3LgJF9+b0Hx+Pqbjf2+wstGCUyv2pJM6dLCy5vX4lVlLArwKaUNZHq
 vEbz/ryea4P8nQGSu6cDanmQdl8JJdTYdvoK7E8bww5v0YnSQtbQBC5Qt+4P5aobfX9K+Xq
 P3not3vJBDQuGllY8NdRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GnJNVko7290=:IizO5hP8ASz8N31FSKjJmp
 KWXBTOaUoNE6WuMRIZKKF4kwAE1KqJhHh4VG3w3Z8kVC4qOurFSb7+tpLoiS7VEYsk/+tAzxg
 L59Y4pyXbm44+OaPxSTe8dbaWcy92MVth58tFaSnz3N41hnWP1fPJAuKdpCymQvP2uGOUN5GI
 y3KtI74+yBSj+4sqGJ9nKyVnfC7ru1CNeOo3zGdtoWChongBDh2OdrIUW/0x5HCKgQ/7mReUP
 5eZD6sTXVXptcl4/2YnKsXFpZutFT91P1g/7SWY+h3UsSCg3gE9042OdH52jKGzVjmzQXcIZb
 CnoE5+okh7TBWBOMgb/xTcBATQ+kZCDcHWrS5v5tYwC0p1UWCOSJysmq6EKeo8PHUw7w5Oj8w
 0+0yxl2PTjNKM8IzZKyPyekiKHpwxXRdFHRMk0a2GDW9C+4Gymd3A0kcdhyb9vR3ZwLFSleJ2
 y2OG+iLNyh406Jmp+ZnV1To9GmVtSOcr6Cf1pJBkjCCuCrMb612aM+G2A/AyUrkr1pOr6uUwe
 4XgFIG1SFgf0Rq5MHaUpIRQux9BI+0+31m/iZd5YqqZe70El1bWUsXEbfI9HjwlEUF4MhTcET
 hb3HJhaixnM+hUq3W29qcmivmw1o438vzNWg/wnB8qHLQBEuQHe3O+tAA6m2b8nJPSFbqrjqM
 IGAeUVSCzQhgCe8keVPsXtsQVMQIlvJuxaTGopzXVtfbzGPXtjYBy//3a1pMux0Y0tNoCV98V
 2lX1J+r1Z80u4urWfUbipiV7KM6WUzhAiW2cSyJkRcksvrS+hrNTQ7oPeMFMZM3X6AiwZHrT7
 whltTx8i1PpqsQbkOFWnZbtdXjx9B6qL2obOn6Z46yLNEMDBFE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 18:00:37 +0100

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/cpufreq/qoriq-cpufreq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 0562761a3dec..ee3e3656485b 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -192,16 +192,12 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	count = clk_hw_get_num_parents(hwclk);
 
 	data->pclk = kcalloc(count, sizeof(struct clk *), GFP_KERNEL);
-	if (!data->pclk) {
-		pr_err("%s: no memory\n", __func__);
+	if (!data->pclk)
 		goto err_nomem2;
-	}
 
 	table = kcalloc(count + 1, sizeof(*table), GFP_KERNEL);
-	if (!table) {
-		pr_err("%s: no memory\n", __func__);
+	if (!table)
 		goto err_pclk;
-	}
 
 	for (i = 0; i < count; i++) {
 		clk = clk_hw_get_parent_by_index(hwclk, i)->clk;
-- 
2.16.1
