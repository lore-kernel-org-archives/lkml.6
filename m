Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425506AbeBOQCp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:02:45 -0500
Received: from mout.web.de ([212.227.17.12]:38371 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424630AbeBOPqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:46:30 -0500
To: linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ARM: cpuidle: Delete an error message for a failed memory
 allocation in arm_idle_init_cpu()
Message-ID: <7f419639-edfc-adb8-1dd2-d16b0dbfe19d@users.sourceforge.net>
Date: Thu, 15 Feb 2018 16:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:RsX/MnzodTuf2ZKSo8uFQTKlCB8Y18my0iLjJpXYfj3gtMuCVhJ
 iER/NGdmzcgB8Rj/2MEaSEOYNjmHKdxiEjIjXvBOH6E6kbYnJYZ7EqHy04k5JUnRuvjmu2I
 Y4hd5RVbjNGGFg8RD0/mAEIp1roNVL1szRFkTqerjHTrQuLjjtzfm2mIEtUQx3rwDHJ9UP7
 se8CMVxBU7GQfczi1qCNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vTJ0l4wYSTE=:r5iZSjQuYtKH5FJs6hQ+DM
 iiDS4gzU3JFBjg4yfc3qU8RCwgYGu16Tn/wPB27vsbBtAexd24vsGuZXYZz/raM9ngUJhsL9z
 NLaDHSU0J5e9hCGlY6Qh/il/YgBAx0VdWzENocFGOFe5tT0tiJ9kddMlm31MeGYfI9WuMte2/
 T5iI6e/g+wxbeFc/cVRyYwdNYoyh/yda3ekSYjCd81vvrrsG1AGrDxWBeNZu5eV1Jl4r/u3fn
 QCGzD/uXB0hYCJM3DDiGUBAYz+9IHaxNY95Sjy4pi2L7czA8AWZsx+2YlZrEznkPEyn59Pw87
 9Wl1+DdMiruoDX9cV2wpMIusJHFKP1DuVyc+Yr0V3vout2/4oN7jmOfAP5XhbDSB1JkdY1zks
 +Vl5xHTWinuWDq+vueIL/77kgRPCPy4TkJyrCA5rCY3eLaso7+tP3s/8diDsyRqbQaWD8hmhS
 krlirRat8ehi8XO+p7RJHjWmgAb6U7nugb5SemAS4A8Oe8NThK8GGNW+X1sGTX6GbSpNg/Mdn
 2Wekhygs/3uNhvykLq1v4zzKRNOVUS3ayxa0J48AyyGx9NoCcnMaVTp1WRKB888kJQReKdOnu
 7jwwWwgaa1m0pmlADdwtbOu0hhu/cWCs4IjxmgV504dBpAujyJUKlcNkHBJq9zhDFVmwwq4na
 D8vLWuZ5DdnyQiAjq7kb6t4DPEPKzsQ6mllgDW4NGqPKEMqEL+fuMOhpolgBSBS/s6/4AWDC+
 s3BV3vYFEPHZmeiaV3ym6nKY/xUYjjR6LpraPz/G53mcaZaCRNPLUX6p29HyMBqBEJN5c3oHF
 uXHITfkYsd9BLii6322dbPghoFFS+BY4R4xZvjYFrOG+WvtPis=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 16:40:38 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/cpuidle/cpuidle-arm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index ddee1b601b89..e07bc7ace774 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -129,7 +129,6 @@ static int __init arm_idle_init_cpu(int cpu)
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
-		pr_err("Failed to allocate cpuidle device\n");
 		ret = -ENOMEM;
 		goto out_unregister_drv;
 	}
-- 
2.16.1
