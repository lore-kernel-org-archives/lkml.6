Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967330AbeBPMks (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:40:48 -0500
Received: from mout.web.de ([212.227.17.12]:51653 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967151AbeBPMkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:40:45 -0500
Subject: [PATCH 3/3] pata_macio: Adjust 11 checks for null pointers
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
Message-ID: <046bc8ef-c7b3-91ed-8fbc-1609a80c4c7b@users.sourceforge.net>
Date: Fri, 16 Feb 2018 13:40:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:PBq58ZovjaUdlJaJxZLF3vzDs7fpWoH6H7suPSLzzVUml23obee
 fkp0gMS7UC/P8phYq0YiKzqPZ3Or4H2HvMVFp6SHwcJGTYVu/hO91YKMFyekMXs4PZjx7Jw
 t0BKFaWsmStYdGJwcyFyN4F2fyUscFCCbFegnQF9+40Kt4p8LUMbIKsgB7t0sg+HJjHiGF9
 wHNFacaZH28Fcq4Ak50xQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uz68HJyo5CU=:Rqhdlut1uhSDy9Hapr2wXX
 AxjW+5okxtDDV04QG99g60mPxDseVqpgh3QqlVc28BUYqtTW3yGkQeT6VSsmmkOGmvoegOhIF
 8CdVJpYqpor5OlvhBeQTzWkY1z+WUhr+O6jIQKr/5U5/JKFNHMNmb2KtqhGjMRWyf95Ys3XRj
 Q86t7Tn03KEpizr/X2e0Klw8535KzFQumeryzVTDFREz/6/m0G514oG2dW6gvd7OJ8nKHUtNF
 f1fYaSsiXsQVSr2eDdO9PREC2chdZG2Tu7MhNZ9OMKEEhuMp6VWDLqIIDZMCwzKWXQn2pcl5I
 nLR0zBmDYmINzsOK7IE1lN7boDJfL7b9eWLZXUVB9trbq9tge3JrGprHa47s7+jgCKsk40JYy
 MF0m43+DoqNnOG6YNzoJ+FbrvFn+CsSIR2MrEg0RzpUJQUOKMv64+CKHCxYEzfFV15ZZJuPA0
 /nhSUsySFDxmXLKnXsVb2wObCUkgxS0JErTS1H5fq6X8hdh2f7D9gU4U3zBZ7/i7U1rUlTDWa
 5EjczUbPC3qhGyCmQ7U7hAOy0xj7EnRzAEtbaCUk2pWc/NDgNro99xh0NSwFzoKQOP0mgpmLw
 +pUv0t58Xtr3TOJnbHu1MGqw/x4QKPm+cs/kKldD0Pbb/OUEFylNvPxAITi/pF0DS4DBdvciL
 jAgA6gyR8GMOnfN9d4RTbSV24FxkeFkLQHLFTK+zEQ9piYPjgAUVFZ5WKt+mxFwAfJ8rAZGyf
 eJ24JBo2qGDKcpS5DvDxwQ7Mc5ud19k1DJFhKm/efMZCUWCyQ1crb07HJZ42Oh3PQFZBP8DIv
 dFWeoAchdFQ37/n2LMc8A3M6wsXucBYLhkfzxXiF4DOVRwwd/o=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 13:20:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_macio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index dc40af4c615c..04d546d672c0 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -405,23 +405,23 @@ static void pata_macio_set_timings(struct ata_port *ap,
 
 	/* Now get the PIO timings */
 	t = pata_macio_find_timing(priv, adev->pio_mode);
-	if (t == NULL) {
+	if (!t) {
 		dev_warn(priv->dev, "Invalid PIO timing requested: 0x%x\n",
 			 adev->pio_mode);
 		t = pata_macio_find_timing(priv, XFER_PIO_0);
 	}
-	BUG_ON(t == NULL);
+	BUG_ON(!t);
 
 	/* PIO timings only ever use the first treg */
 	priv->treg[adev->devno][0] |= t->reg1;
 
 	/* Now get DMA timings */
 	t = pata_macio_find_timing(priv, adev->dma_mode);
-	if (t == NULL || (t->reg1 == 0 && t->reg2 == 0)) {
+	if (!t || (t->reg1 == 0 && t->reg2 == 0)) {
 		dev_dbg(priv->dev, "DMA timing not set yet, using MW_DMA_0\n");
 		t = pata_macio_find_timing(priv, XFER_MW_DMA_0);
 	}
-	BUG_ON(t == NULL);
+	BUG_ON(!t);
 
 	/* DMA timings can use both tregs */
 	priv->treg[adev->devno][0] |= t->reg1;
@@ -705,7 +705,7 @@ static int pata_macio_port_start(struct ata_port *ap)
 {
 	struct pata_macio_priv *priv = ap->private_data;
 
-	if (ap->ioaddr.bmdma_addr == NULL)
+	if (!ap->ioaddr.bmdma_addr)
 		return 0;
 
 	/* Allocate space for the DBDMA commands.
@@ -717,7 +717,7 @@ static int pata_macio_port_start(struct ata_port *ap)
 		dmam_alloc_coherent(priv->dev,
 				    (MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
 				    &priv->dma_table_dma, GFP_KERNEL);
-	if (priv->dma_table_cpu == NULL) {
+	if (!priv->dma_table_cpu) {
 		dev_err(priv->dev, "Unable to allocate DMA command list\n");
 		ap->ioaddr.bmdma_addr = NULL;
 		ap->mwdma_mask = 0;
@@ -1055,7 +1055,7 @@ static int pata_macio_common_init(struct pata_macio_priv *priv,
 	pinfo.private_data	= priv;
 
 	priv->host = ata_host_alloc_pinfo(priv->dev, ppi, 1);
-	if (priv->host == NULL) {
+	if (!priv->host) {
 		dev_err(priv->dev, "Failed to allocate ATA port structure\n");
 		return -ENOMEM;
 	}
@@ -1065,7 +1065,7 @@ static int pata_macio_common_init(struct pata_macio_priv *priv,
 
 	/* Map base registers */
 	priv->tfregs = devm_ioremap(priv->dev, tfregs, 0x100);
-	if (priv->tfregs == NULL) {
+	if (!priv->tfregs) {
 		dev_err(priv->dev, "Failed to map ATA ports\n");
 		return -ENOMEM;
 	}
@@ -1075,14 +1075,14 @@ static int pata_macio_common_init(struct pata_macio_priv *priv,
 	if (dmaregs != 0) {
 		dma_regs = devm_ioremap(priv->dev, dmaregs,
 					sizeof(struct dbdma_regs));
-		if (dma_regs == NULL)
+		if (!dma_regs)
 			dev_warn(priv->dev, "Failed to map ATA DMA registers\n");
 	}
 
 	/* If chip has local feature control, map those regs too */
 	if (fcregs != 0) {
 		priv->kauai_fcr = devm_ioremap(priv->dev, fcregs, 4);
-		if (priv->kauai_fcr == NULL) {
+		if (!priv->kauai_fcr) {
 			dev_err(priv->dev, "Failed to map ATA FCR register\n");
 			return -ENOMEM;
 		}
@@ -1258,7 +1258,7 @@ static int pata_macio_pci_attach(struct pci_dev *pdev,
 
 	/* We cannot use a MacIO controller without its OF device node */
 	np = pci_device_to_OF_node(pdev);
-	if (np == NULL) {
+	if (!np) {
 		dev_err(&pdev->dev,
 			"Cannot find OF device node for controller\n");
 		return -ENODEV;
-- 
2.16.1
