Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeBPKIl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:08:41 -0500
Received: from mout.web.de ([212.227.17.12]:56831 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933129AbeBPKIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:08:37 -0500
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] pata_samsung_cf: Delete an error message for a failed memory
 allocation in pata_s3c_probe()
Message-ID: <b757fb06-dde6-b1f6-77fa-f5301fb6fec1@users.sourceforge.net>
Date: Fri, 16 Feb 2018 11:08:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:+Z4jMm81e+j42T8U+BHczGAqXMwmB+4lyu/Vxiel1O1wyD5GH1q
 yjixXdQR/96HQDxo/ITyGw2IuOC4rXumY040BeTFkpQQZwB56YsEjItzvBNJo20PkAWbG3C
 I7tKFJl2/oJz7RwrExqwoZs2aVepZyGF87sXyoL8hRPqcbLpv4Oj401/bpP3RIkYWDBg6qa
 7kSjY9x9ejrOx6pNeCHrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9/XEzPljOqw=:8c2EtUrYOECkL41R42W6XE
 0F3qELBMnVgoXezxQsRz92c86DK1r1cUU6A5FF6cEXvEqFm3kEthLgft/5Kl8KsjK2SuFjqOA
 eacO3nm6wBHAce/vujVMWZSCcW87luGf+skN9Qzv0GcaORvaA6J/y05/2b6zCYIDTc+Wq4nrf
 apE1qyI6UDF+JyQy/OsrNYZjEYhpIWcG30Rc/4acRGsL8bbWoIXfWajl7gCKqgdUaxJGKhHHH
 P5ZAFworMLke3e39Vog6cnSHaLY2zUx67V/A7J0DRcny9u+JAu4N0ZnpKocP1X62QuKQAdEoc
 Iav8G6LODLw6veuPjl+5gG2MOYgEIaS9JIt0y2bbW7VSbs6QCYfpK82hYphVppVL1zaxcasnN
 QkeK84oAoqxqCWOCuMkzug2IFJfJU/2j0I1itCXMxF2Sz3VQA7xYg/lmKaL2j6SbUYpOSROpF
 dYNnrGzi4amgzjwxGlVeMlR/ksIZFLPGgKpWbgC/uYweKSjJHwx+ewUh1ySXLm/J0J25PAeIC
 IRlKPXNYvf4mibOskNC9m9YnK3tIMUEUgYLHcUgHzBVm/4IzsQBzvc5AnHBWSJkX9jjVpghb/
 QxIMWYw7zL9sXt/q0X3fyfmPXWaawTlpMjU9RpSxZqE14CMabjsOaUHxN54PChXupSuvevE1g
 qDR7WC66r9rxxLZ+A+JqiiJLx3TrD8GNXhmEsaslWrjqwhgbYTMwO35DjyhxW2CEsV7RSKt+t
 tB9zOF78YvkM2QdQy2JNqpXCA2hRq7U5TGzGiAnw6K/LTtFjes5BmuCWb2pPGoyZn5B3wKT1S
 a6iyKZpcV1EeQTsx6KDC+xhevOXF033CceKjD0op3S/ibw48Hg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 10:55:51 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_samsung_cf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 50801c40b029..bb96dc35950d 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -505,10 +505,8 @@ static int __init pata_s3c_probe(struct platform_device *pdev)
 	cpu_type = platform_get_device_id(pdev)->driver_data;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		dev_err(dev, "failed to allocate memory for device data\n");
+	if (!info)
 		return -ENOMEM;
-	}
 
 	info->irq = platform_get_irq(pdev, 0);
 
-- 
2.16.1
