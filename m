Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032568AbeBPR0k (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:26:40 -0500
Received: from mout.web.de ([217.72.192.78]:34363 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032507AbeBPR0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:26:35 -0500
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] libata-scsi: Delete an unnecessary variable in
 ata_scsi_slave_config()
Message-ID: <52d9a12e-e420-b880-ac02-c8156d977264@users.sourceforge.net>
Date: Fri, 16 Feb 2018 18:26:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:dWZNq49V3DXIe68zImkfSFEHEtTjrIngkczksYz6PddJZNg18D2
 /zQ/9BaIAPnUyfIGaTpOzgOPsrmwvbU5wKg4MPppOKI84+V7qWvuS/VBnzVrwz5QxesqXlc
 V3nRyciT+nT2KkMlmQoarsMe3xWlAmB1gi89ZZJG0NYDcAT2bdemi5m1L5J85reYheIzJHg
 09bnT9ifhCxCx20bcenUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:scsnH1RoDdw=:XOGeTSdoL68VmIhMCzmskJ
 pb/jStScaPxw30nDO4QH7me5e5z7M5nz4FY9ZReOlPPNXubk0oDWZQa5s8XQ5INZntP6pWmvN
 11NJbiCnyVf9wg39Rqz/y72Kf8Vppbsq+eU2K8oGdTlvNOPgU5KkPOCF9zAMFn6eWoJLj2S6x
 zZsBtCowuZ3VNdkOO1KIU1x9rBwcl2Sg3qKuBT8HKzZXgm8LY+7UGLYF1soDSeDavBA4nihuI
 /ZQ2ZswmHUoicV9LEDa1VvN7wPDi87/4ANaoIuxQRvk1YHeUnhZBZS80UnDs4ZINZV+pSCljK
 x1VsxnyuZjkeUuio0CJcc1SBHPurOd1eR2jl6ic1R7k8fNWiZ01l3mkxhtxCfjUzBoVu5cjAG
 UOeNr1OuFrmBdIvEm+drWsh9q/bELOCKt+nTjubbomRiXz5PyEQaPOH/EvNDhfz9aT8mo4PG0
 fEU5f3KmgJN/oZ7HTBfA5qZqLvDEVFko1b2cyzuGQQx8MC56GqtGSPTEzaZ2K50CbqYxZRcZp
 mYkmkaw4j1fQZxmT72SRU4I+NjRaERrKfS927dLs8u15GmJgCOp+bpgmDeIPSxMYM5ckrL281
 yUao1yXlBBVFQY9fVKUMdP1IGSLlI6+QbZq9y/IG2VQUr+/SaE7v/ZfATSzYYyoDITr7VThyp
 ADYY95eWE3I2EGutWthQTXEViH2QNWZ18VbBazeFYvamKHJJmXWxQ8oVnxLcJ+t7vvfq50yAN
 Avvw4/gIO5D4aI3iVwjRt+KahFyrq2gEeVLm2FUMveOCf3o02AfBLfNb/Dy99u0uE+89VRn4I
 8UZmlLuMlQydEuDbkMxmj/lYtKJsBKufCNhc9RgxhTh6uDeuh0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 18:19:13 +0100

* Return a result code without storing it in an intermediate variable.

* Reduce the needed source code.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/libata-scsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 66be961c93a4..93456cff051b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1345,14 +1345,9 @@ int ata_scsi_slave_config(struct scsi_device *sdev)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
-	int rc = 0;
 
 	ata_scsi_sdev_config(sdev);
-
-	if (dev)
-		rc = ata_scsi_dev_config(sdev, dev);
-
-	return rc;
+	return dev ? ata_scsi_dev_config(sdev, dev) : 0;
 }
 
 /**
-- 
2.16.1
