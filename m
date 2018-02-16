Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933871AbeBPKod (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:44:33 -0500
Received: from mout.web.de ([212.227.17.11]:46911 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933759AbeBPKoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:44:30 -0500
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] pata_mpc52xx: Delete an error message for a failed memory
 allocation in mpc52xx_ata_probe()
Message-ID: <b9749bf6-0bbb-2b2d-b946-aae893f3e305@users.sourceforge.net>
Date: Fri, 16 Feb 2018 11:44:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zH+pwWaMrgrUj2UfgDwrv5qKJzPQauh8pRi9RTLKbHBwoXgrsiN
 0VvDOIPrO+WpotywZLZMH4V4n9ShwfLdTiTwZ5S3DBg3fnZlSrUtCa5objm9/CEw6w57t88
 eLXChid40Ke26VPnZy6ba1ScfvHHG9pMD1y6hpoRJ9XFsSv7ywsOUDnDOhV749yyQ3zwYeb
 HeB+Z5zcK0pzTjRwpxawQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m7rXVQ3nRF0=:kZM9WXrS62/EUXZ8pzsog8
 aHkAvL0OG4y898a8AnElcm6COk8uIRaIaTBm18k1LJLLpffXCIQgaSEtxDeVM7AHKpDcb4OS/
 vNPaWaECDAQTi3t4e1Ei2jxrFFK4cQKqypIuRIj1Q9I+tznRS0gCjN+S4WEPBAs3nrvn4ZD7v
 KlwddYDFk9yH754E0yKCcOsI7bzhN099YBytEPyy2H975Ye8C+thz5CCmaTlPci3HxllC0J6/
 AMp1wM6361IEILQ2xcPIifFxq+kRJQzYKgLA7emIceVl2GWw51xsmOkgw1yIY64DuWaAun0dD
 nhE6rZ2dFQlVfWbwHvpr22hH01FqMuJFcJZPe+SWJidcS1f7IXirtyFG7SYL8sardv0KDXiIJ
 F6aJrO6EGyHWEI8rxbCC1Yi6igzdOucj3QMHaKpeCv1BaSd6abB6842utZ8A42eJznicza8PD
 lruQ9l7A+SHZjr6znxNzI8X+BqtA3SY9izvteIDCrpAQyk8qz4coDgiJUMe30n2n1MfASPc6A
 d0ELcKK4NsZJp3+NKs23DmG32usD13GmY2tdaEiWsa8zPhnheK9/r4uSR/ttKVtndp9l7tL11
 CYWozXsYHP8FsGti5wrpPpog50gyS5cnQxFJGDstMVBsrH1/6VxUCR6eLXSeHLsGA5M2IL+EI
 K4ARWh3zmECspOwjXI4gUqF0Yuz+V5hGV2P7EWYyWlSN4Jiw7tsNU2p863lhE5RDZTZRso0Xb
 u5EvW9b6XGJDb6OkMHQC2fnsByjmAWKylMLAsR3uKxQio7T4cbbL8tC4guT3Am3KQa57nSJXH
 lLMIySGh06Onq+KTdZtWro9S8tFk4/oQIoWkSxHkdX1CTuLj3Y=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 11:34:53 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_mpc52xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 9730125530f6..f1d352d5f128 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -738,7 +738,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	/* Prepare our private structure */
 	priv = devm_kzalloc(&op->dev, sizeof(*priv), GFP_ATOMIC);
 	if (!priv) {
-		dev_err(&op->dev, "error allocating private structure\n");
 		rv = -ENOMEM;
 		goto err1;
 	}
-- 
2.16.1
