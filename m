Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeETCgl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 22:36:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:62677 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeETCgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 22:36:37 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180520023635epoutp02934349be072a52f8d7fe0d4239a989b0~wOcXdARlU2853828538epoutp02S
X-AuditID: b6c32a47-bdfff70000001011-29-5b00df32bf83
From: Alim Akhtar <alim.akhtar@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        subhashj@codeaurora.org, vinholikatti@gmail.com,
        shaik.ameer@samsung.com, alim.akhtar@samsung.com
Subject: [PATCH V3] scsi: ufs: Add specific callback for setting DMA mask
Date: Sun, 20 May 2018 07:54:17 +0530
Message-id: <1526783057-16620-1-git-send-email-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCmha7RfYZog8/d0hYP5m1js1g1Mc/i
        8q45bBbd13ewWSw//o/J4sjD3ewWNxbvZLPYsbDKgcPjcl8vk8fOWXfZPR4c2szi8fHpLRaP
        vi2rGD0+b5ILYIvisklJzcksSy3St0vgyvh2R6Hgg1DF0fsLmBsYd/F3MXJySAiYSBy9PYmt
        i5GLQ0hgB6NEx/WjzCAJIYHvjBLT5/N1MXKAFW27xgVRs5tR4uCJ2ewQzg9Gic93zjKCNLAJ
        aEvcnb6FCcQWEbCROH/zARNIEbPAPEaJpXOmsIIkhAU8JY5d3AK2gUVAVWL+rydMIBt4Bdwl
        fq/ihbhITuLmuU5mkF4JgUY2idtzPjJCJFwkll+7wwRhC0u8Or6FHcKWlni2aiNUTbbEh+Mn
        mSHsGolZF3vZIGx7iQNX5rCA2MwCfBIdh/+yQ3zGK9HRJgRR4iHx+EAL1BhHiZNnH7NCAiJW
        4sLzj4wTGCUXMDKsYhRLLSjOTU8tNiow1itOzC0uzUvXS87P3cQIjkMt9x2M2875HGIU4GBU
        4uG9UcgQLcSaWFZcmXuIUYKDWUmEd10qUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjvTbN/UUIC
        6YklqdmpqQWpRTBZJg5OqQbG5MzDq7e5KFU/3btkisEnxyP73bMCbha+rFOuz6t7HLFs/X3b
        XR17/2+zbG869VNafeW5aWk380K2X19jbnp/ia2Rtjbf4bPv+DnXv1o4676VyKMKicI31xoU
        +i21bkduC0v/mCcZN+WYFbfJi2UJ7+odC5c4TtaUZ3YL2GaQ7SK0+l2d58azSizFGYmGWsxF
        xYkAYMWFqL8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFJMWRmVeSWpSXmKPExsVy+t9jAV3D+wzRBpe3iFg8mLeNzWLVxDyL
        y7vmsFl0X9/BZrH8+D8miyMPd7Nb3Fi8k81ix8IqBw6Py329TB47Z91l93hwaDOLx8ent1g8
        +rasYvT4vEkugC2KyyYlNSezLLVI3y6BK+PbHYWCD0IVR+8vYG5g3MXfxcjBISFgIrHtGlcX
        IxeHkMBORonGc5MYIZwfjBKL9h1n6mLk5GAT0Ja4O30LmC0iYCNx/uYDJpAiZoF5jBJHTy5j
        BEkIC3hKHLu4hRnEZhFQlZj/6wkTyAZeAXeJ36t4QcISAnISN891Mk9g5FrAyLCKUTK1oDg3
        PbfYqMAoL7Vcrzgxt7g0L10vOT93EyMwRLYd1urfwfh4SfwhRgEORiUe3huFDNFCrIllxZW5
        hxglOJiVRHjXpQKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJx
        cEo1MC4uMt+q+8/ZoX5pyKO2W0/4utOefly5rm4Vy5u6mmNbNzeElC7jmZ/1sDB2gvzVRUWH
        +2aW5jPfUeQPkD4gd1H14byaM28NX+28Nsl36oZdgUsWnRb56PtEiltxi9Kzo/xSFTPjboS9
        vHHM/yE/S8dDRallByy43nmVrH011zlkeV9P4kSemEwlluKMREMt5qLiRAD0Y4d/DQIAAA==
X-CMS-MailID: 20180520023633epcas2p333689dfc3c9f94c15018e33f69c751cb
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180520023633epcas2p333689dfc3c9f94c15018e33f69c751cb
X-RootMTR: 20180520023633epcas2p333689dfc3c9f94c15018e33f69c751cb
References: <CGME20180520023633epcas2p333689dfc3c9f94c15018e33f69c751cb@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently DMA mask for UFS HCI is set by reading CAP register's
[64AS] bit. Some HCI controller like Exynos support 36-bit bus address.
This works perfectly fine with DMA mask set as 64 in case there is no
IOMMU attached to HCI.
In case if HCI is behind an IOMMU, setting DMA mask as 64 bit won't
work as HCI has only 36bit addressing and SMMU has created mapping of
64 bit and as the device truncates the address, its mapping will not
be found by iommu.
To resolve such issues, let the variant driver sets its own DMA mask.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 drivers/scsi/ufs/ufshcd.h | 2 ++
 2 files changed, 5 insertions(+)

I am not sure if there are other ways available to handle such cases.
The IOMMU I am talking about is arm-smmu and it DT binding does not
give much idea about handling such cases.
Have tested this patch with HCI controller with IOMMU attached.

Changes Since V1: 
	- Fixed build issue as reported by Kbuild test robot.

Changes Since V2: 
	- Remove RFC tag as suggested by Subhash.

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a355d98..9a1374e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7781,6 +7781,9 @@ EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
  */
 static int ufshcd_set_dma_mask(struct ufs_hba *hba)
 {
+	if (hba->vops && hba->vops->set_dma_mask)
+		return hba->vops->set_dma_mask(hba);
+
 	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
 		if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
 			return 0;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 1332e54..89c6dae 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
  * @resume: called during host controller PM callback
  * @dbg_register_dump: used to dump controller debug information
  * @phy_initialization: used to initialize phys
+ * @set_dma_mask: used to set variant specific DMA mask
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -325,6 +326,7 @@ struct ufs_hba_variant_ops {
 	int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
 	void	(*dbg_register_dump)(struct ufs_hba *hba);
 	int	(*phy_initialization)(struct ufs_hba *);
+	int	(*set_dma_mask)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
-- 
2.7.4
