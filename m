Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758441AbeBPQAZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:00:25 -0500
Received: from mout.web.de ([217.72.192.78]:42411 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752879AbeBPQAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:00:22 -0500
Subject: [PATCH 3/3] pata_arasan_cf: Move two variable assignments in
 arasan_cf_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Message-ID: <0f5492bc-d239-401e-6f77-a27897e4ede5@users.sourceforge.net>
Date: Fri, 16 Feb 2018 17:00:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BHLlB4bIUYmRu/zKg2N6s5sY51ZIUM7e6NiSt3kApcA71SOmbmw
 BEnbhdBwgz5oJGqJowdCKqKxIJS66eR2Oo+3T8o/y9g0pW5JkwNvM2zhSf+QJSbiL8JRovH
 5zdPOpYr3FQom3H/sfegUK3bknKR2qwtd01JtyKerLlSarkt9B1FJh1NyCl90VlFKddMJj2
 NLHCTWkO81FLG9TsOramQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y8oBRcDLZq4=:farF5icsI/lqAbpg9THsnW
 3DiRci1+7OllGsZSdOnIempZdftAnA+gVhIHU+TARQNjYQFLr9kRPOzU+zUXMyhfCwzGu49RY
 5dL8o8dv4dPwBS7A1/H4H4yFQrsCH1aB1FqAGh1kWzcoeJ41o33tYBhkReiR6bhaWzl1ZvrSA
 JvokgNg19JMqIruRaZmMmbAJlh347foSFK8LgpFGTEZe+9DbG7O90JdD13u4yaGpVDdeW8IxL
 ORCFAUAxOG07pRQNm7fLakqpbRUq/s5t7+hVKz2CD0PVuoHvkwm1P+2QNhQM8K5194K96CmdG
 E8IxmtKvq7KlCejByWK4wLUP/Z3Jy1lSYwLz2ZSzeUSaH2N7P4magrM9vdli354HmOYgwQecy
 VFmZR4qlPN0o37A0lB5al8d/MOZDdJ8PnuzgmldI8s3NneQ6k82uClkWrBodBp+eRYOnwWKFQ
 GLV+1eRRM6xbXkxBq8dq9I59bMpGOOl04fC3UmSTpaeSWdW2WlnyLJsYQE8a0as+ngvbZaZ1r
 pjQoBDltJAdEHSdhpQpIYwgU+O/XCkl8YezWVuVtxFT+56YiDzykG1hDqJK/CilMxHJGpAL9S
 1spYuxA4yy0FVdGD6H9iLf5v9EZ7TH4CdcN0oEYj5cN7TEqYWKsZFZG9aa2UC35ZstqDej4hI
 d4PX16Hp7LCnyQQUNSYgwVVtmhy7hPDbo1iXl5nTaUYX5/kukophcsDmjhLmjuJdfd3iTz9ec
 HfT2ZAK3SzIZka3dR3M+GTEZpV+REk8n/SjeDX77/4jMPZv5NFPfQrv/Yk0EOW+2wA37sktt5
 4DFFfOO3BbRyxbpEvmr7XqHMQ8qPgmyGm8udWAGjsoeVkTut4Q=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 16:42:26 +0100

Move assignments for the local variables "irq_handler" and "pdata"
so that their setting will only be performed after a call
of the function "devm_kzalloc" succeeded by this function.
Thus adjust a corresponding if statement.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_arasan_cf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index ebecab8c3f36..27f241b1b1b1 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -790,12 +790,12 @@ static struct ata_port_operations arasan_cf_ops = {
 static int arasan_cf_probe(struct platform_device *pdev)
 {
 	struct arasan_cf_dev *acdev;
-	struct arasan_cf_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct arasan_cf_pdata *pdata;
 	struct ata_host *host;
 	struct ata_port *ap;
 	struct resource *res;
 	u32 quirk;
-	irq_handler_t irq_handler = NULL;
+	irq_handler_t irq_handler;
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -812,6 +812,7 @@ static int arasan_cf_probe(struct platform_device *pdev)
 	if (!acdev)
 		return -ENOMEM;
 
+	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata)
 		quirk = pdata->quirk;
 	else
@@ -819,10 +820,12 @@ static int arasan_cf_probe(struct platform_device *pdev)
 
 	/* if irq is 0, support only PIO */
 	acdev->irq = platform_get_irq(pdev, 0);
-	if (acdev->irq)
+	if (acdev->irq) {
 		irq_handler = arasan_cf_interrupt;
-	else
+	} else {
 		quirk |= CF_BROKEN_MWDMA | CF_BROKEN_UDMA;
+		irq_handler = NULL;
+	}
 
 	acdev->pbase = res->start;
 	acdev->vbase = devm_ioremap_nocache(&pdev->dev, res->start,
-- 
2.16.1
