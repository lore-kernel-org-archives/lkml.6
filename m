Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeBVF4m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:56:42 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37900 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeBVF4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:56:41 -0500
X-Google-Smtp-Source: AH8x227CdLRfoD3SrfF+pO4OcO8bmVpz+lV9clTqIAMXJhtlUZ1kRnfpEkuqCpvU3fzwDPQdfTxnPQ==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] cpufreq: mediatek: Convert pr_warn() to pr_debug()
Date: Thu, 22 Feb 2018 11:26:31 +0530
Message-Id: <5bc4db542fa521c32d295f490a1ad1dadf715098.1519278976.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With multi-platform build images, this shows a message on non mediatek
platforms, which is unnecessary. Convert pr_warn() to pr_debug() here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 8c04dddd3c28..84d658d57029 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -578,7 +578,7 @@ static int __init mtk_cpufreq_driver_init(void)
 	match = of_match_node(mtk_cpufreq_machines, np);
 	of_node_put(np);
 	if (!match) {
-		pr_warn("Machine is not compatible with mtk-cpufreq\n");
+		pr_debug("Machine is not compatible with mtk-cpufreq\n");
 		return -ENODEV;
 	}
 
-- 
2.15.0.194.g9af6a3dea062
