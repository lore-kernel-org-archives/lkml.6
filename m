Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967971AbeBOMZI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:25:08 -0500
Received: from mout.web.de ([212.227.17.11]:56069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967914AbeBOMZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:25:04 -0500
To: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] crypto: atmel: Delete error messages for a failed memory
 allocation in six functions
Message-ID: <77cf1006-966d-78a9-0fdc-b53ccdd80df2@users.sourceforge.net>
Date: Thu, 15 Feb 2018 13:24:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:pr1cFF/DukdwA6ruD+NFGugMdVTLEACITUN7Mz+QN6Tww5bXZU0
 ZALyhN+bpG4iXt+LgzjEwrkrbBIfeR1SuO4H5CxY6KrELEcziH+UZ1kHMHNrlMDOKjcqs3v
 ULq7BSIlBBQDaSgU/kmrVB/JvDN/cjhqvTxV1k5cHTVq+DSzZGP/UG3VWAZ052P9yRt6MpT
 fGvSBCZOFzSa9PIEm6qow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KqmHVG5P1q4=:Pb85MRIexMt1jNo01tzOh4
 XIcFea6tBrLfczyJKSDnICTCNs0dT3mPqi7iaPJp58odTg3V2a7R22Qb2g56nDLgeova3MJcH
 hijQzFbDJAnkDYnMFgSTDQEndWxR+M9bmX6dXM5Yd/bfmYMT4jxF4eiYYuh0c3pjjYGU05ckS
 5gO2KayizKm0Qw++5HV/0NWReXuZ/L1Hh5tXsrjSnhN63HoO8tKQmuioryCM8Ad+0lFqrC8t1
 q9PhhiPFClqaMN+A8db+mho20gCJApJcWjjVbyzBiAMIXF54j/KK9aeoZEC8+mqg/nwTdbRyx
 HYnpOQ/PAK0RYziJbpdrHQe7rJDyoP9qbNKlQfX9ItMiguMk8lh+uspvshmx5WkLnC8rQ7syc
 7fDCtvyQH3t5AqIiGseISTZmH474OOS2OjmQ66VJPRP4zJIHnGjbeU3c+hHMb9qSC0ouhuVvO
 4dZ935Ln7wtcyhhvI70UlAJrbptiFFmD9osI/aqqkP0P34I5MEF9Y1yjYLIcnLP9JikGChHVL
 Nc4neQrmtz6iZZf9az+t/7P/OujaHe5J9kUnimyiIOFFjKzpfkVYKMt5jB7yYB3GqlGLP1S2H
 Zgoh1v//LFqDcY3KD6oHBTGzgEi/fcN4InbTCVDX0UqO7AyL3JmXY5YDqm+YRDXvwS1KvGNpL
 85iPKpbQEZjpNlZ63sb7a2KV2MS7sk3G6jF17ScfzCOUwPOTSgb1pPXibqQ4T0rxUYeBJrHfb
 UlnAvTV1IeEHQSrRHcKDRL09XdGKLse/78+Tj3/dqEcNd4GSyIUK9G/PsQDOLvJ9j43yRaFn/
 +mM+2uF3dss9J8kGG6EdzTOG7WD84fWYFjV0V2fTOx9o+aEXOI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 11:38:30 +0100

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/atmel-aes.c  | 6 +-----
 drivers/crypto/atmel-sha.c  | 9 ++-------
 drivers/crypto/atmel-tdes.c | 9 ++-------
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 691c6465b71e..6fb24fc94b1f 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2602,16 +2602,13 @@ static struct crypto_platform_data *atmel_aes_of_init(struct platform_device *pd
 	}
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(&pdev->dev, "could not allocate memory for pdata\n");
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	pdata->dma_slave = devm_kzalloc(&pdev->dev,
 					sizeof(*(pdata->dma_slave)),
 					GFP_KERNEL);
 	if (!pdata->dma_slave) {
-		dev_err(&pdev->dev, "could not allocate memory for dma_slave\n");
 		devm_kfree(&pdev->dev, pdata);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -2649,7 +2646,6 @@ static int atmel_aes_probe(struct platform_device *pdev)
 
 	aes_dd = devm_kzalloc(&pdev->dev, sizeof(*aes_dd), GFP_KERNEL);
 	if (aes_dd == NULL) {
-		dev_err(dev, "unable to alloc data struct.\n");
 		err = -ENOMEM;
 		goto aes_dd_err;
 	}
diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 8874aa5ca0f7..4d43081120db 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -2726,18 +2726,14 @@ static struct crypto_platform_data *atmel_sha_of_init(struct platform_device *pd
 	}
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(&pdev->dev, "could not allocate memory for pdata\n");
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	pdata->dma_slave = devm_kzalloc(&pdev->dev,
 					sizeof(*(pdata->dma_slave)),
 					GFP_KERNEL);
-	if (!pdata->dma_slave) {
-		dev_err(&pdev->dev, "could not allocate memory for dma_slave\n");
+	if (!pdata->dma_slave)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	return pdata;
 }
@@ -2758,7 +2754,6 @@ static int atmel_sha_probe(struct platform_device *pdev)
 
 	sha_dd = devm_kzalloc(&pdev->dev, sizeof(*sha_dd), GFP_KERNEL);
 	if (sha_dd == NULL) {
-		dev_err(dev, "unable to alloc data struct.\n");
 		err = -ENOMEM;
 		goto sha_dd_err;
 	}
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 592124f8382b..97b0423efa7f 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -1312,18 +1312,14 @@ static struct crypto_platform_data *atmel_tdes_of_init(struct platform_device *p
 	}
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(&pdev->dev, "could not allocate memory for pdata\n");
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	pdata->dma_slave = devm_kzalloc(&pdev->dev,
 					sizeof(*(pdata->dma_slave)),
 					GFP_KERNEL);
-	if (!pdata->dma_slave) {
-		dev_err(&pdev->dev, "could not allocate memory for dma_slave\n");
+	if (!pdata->dma_slave)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	return pdata;
 }
@@ -1344,7 +1340,6 @@ static int atmel_tdes_probe(struct platform_device *pdev)
 
 	tdes_dd = devm_kmalloc(&pdev->dev, sizeof(*tdes_dd), GFP_KERNEL);
 	if (tdes_dd == NULL) {
-		dev_err(dev, "unable to alloc data struct.\n");
 		err = -ENOMEM;
 		goto tdes_dd_err;
 	}
-- 
2.16.1
