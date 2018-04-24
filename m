Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758351AbeDXOAw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:00:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38990 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757888AbeDXNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:14:17 -0400
X-Google-Smtp-Source: AIpwx4/KHfnrDF4k+muhTuYUXwJrX36jsQAYZBkmRsj5/ygKEydhvnPsywrdmHx9FxcCQvhoKJDJiA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: fix speedstep_detect_processor()'s return type
Date: Tue, 24 Apr 2018 15:14:13 +0200
Message-Id: <20180424131414.1653-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

speedstep_detect_processor() is declared as returing an
'enum speedstep_processor' but use an 'int' in its definition.

Fix this by using 'enum speedstep_processor' in its definition too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/cpufreq/speedstep-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index e3a9962ee..cabb6f48e 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -252,7 +252,7 @@ EXPORT_SYMBOL_GPL(speedstep_get_frequency);
  *********************************************************************/
 
 /* Keep in sync with the x86_cpu_id tables in the different modules */
-unsigned int speedstep_detect_processor(void)
+enum speedstep_processor speedstep_detect_processor(void)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
 	u32 ebx, msr_lo, msr_hi;
-- 
2.17.0
