Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932285AbeDCNCT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:02:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51904 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932225AbeDCNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:01:51 -0400
X-Google-Smtp-Source: AIpwx483hNiKl8+NhIMYu2G24pVHWp4922zb6J4IzrwfiVkpDro+hm+D69FKSN/bEFr6scvVroeptg==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 4/6] clocksource/drivers/imx-tpm: Fix typo of clock name
Date: Tue,  3 Apr 2018 15:00:28 +0200
Message-Id: <1522760432-32048-4-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522760432-32048-1-git-send-email-daniel.lezcano@linaro.org>
References: <b2886156-4d6e-4c0c-1047-a54da8049ef6@linaro.org>
 <1522760432-32048-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

The clock name should be ipg instead of igp.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 21bffdc..3f97d49 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -179,7 +179,7 @@ static int __init tpm_timer_init(struct device_node *np)
 	ipg = of_clk_get_by_name(np, "ipg");
 	per = of_clk_get_by_name(np, "per");
 	if (IS_ERR(ipg) || IS_ERR(per)) {
-		pr_err("tpm: failed to get igp or per clk\n");
+		pr_err("tpm: failed to get ipg or per clk\n");
 		ret = -ENODEV;
 		goto err_clk_get;
 	}
-- 
2.7.4
