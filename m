Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935801AbeCHLOW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:14:22 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:31198 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934456AbeCHLOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:14:19 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180308111417epoutp047003777572260d73cf460aae67631834~Z7ah57KEM1374613746epoutp04c
X-AuditID: b6c32a35-891ff70000001031-df-5aa11b08f9e0
From: Alim Akhtar <alim.akhtar@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vinholikatti@gmail.com, subhashj@codeaurora.org,
        devicetree@vger.kernel.org, shaik.ameer@samsung.com
Subject: [RFC PATCH V2] scsi: ufs: Add specific callback for setting DMA
 mask
Date: Thu, 08 Mar 2018 16:33:33 +0530
Message-id: <1520507013-2410-1-git-send-email-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCmri6H9MIog78PtS3mHznHarFqYp7F
        5V1z2Cy6r+9gs1h+/B+TxZGHu9ktbizeyWaxY2GVA4fH5b5eJo+ds+6yezw4tJnF4+PTWywe
        fVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlXH34VHWgnVCFQvOzWZtYOzk72Lk5JAQMJGY+GYz
        UxcjF4eQwA5Gifd7frFCON8ZJbafaGeHqZo+oZUNIrGBUeLxy8nsEM4PRolZJ/tYQKrYBLQl
        7k7fwgRiiwjYSJy/+QBsLrPAQkaJPbdOAHVwcAgL+Esc7kgHqWERUJXYsGALM4jNK+AmsX7W
        FVaIbXISN891MoP0Sgj8ZZV4dWUzI0TCRWLS3J9sELawxKvjW8BmSghIS1w6agsRzpb4cPwk
        M4RdIzHrYi9Uub3EgStzwO5kFuCTePe1hxWilVeio00IosRD4tzbL0wQtqPE82//wM4REoiV
        WHvpBesERskFjAyrGMVSC4pz01OLDQsM9YoTc4tL89L1kvNzNzGCY1HLdAfjlHM+hxgFOBiV
        eHgl/syPEmJNLCuuzD3EKMHBrCTCy7VsQZQQb0piZVVqUX58UWlOavEhRmkOFiVx3oAAlygh
        gfTEktTs1NSC1CKYLBMHp1QD4/GyRzFnZ3QLmqctatVbcInF+9rD2xsf8GiET793ij1rwr5H
        LUybX7rP/PPkgKroliSemLMOlq2OOavt5a/L9sxRybnyvdL9x5vFDzdw2ghmf3AsK0hekndn
        p8XqfQoh9SECgbMcud2m+Jd3SXT82iR/q/mApkP7beZd83WzVsX3XMpazf5jhRJLcUaioRZz
        UXEiABewK0LBAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsVy+t9jQV0O6YVRBqt/C1nMP3KO1WLVxDyL
        y7vmsFl0X9/BZrH8+D8miyMPd7Nb3Fi8k81ix8IqBw6Py329TB47Z91l93hwaDOLx8ent1g8
        +rasYvT4vEkugC2KyyYlNSezLLVI3y6BK+Puw6OsBeuEKhacm83awNjJ38XIySEhYCIxfUIr
        WxcjF4eQwDpGiVd/+5kgnB+MEqt23WMBqWIT0Ja4O30LE4gtImAjcf7mA7AiZoGFjBInu7Yy
        giSEBXwl1h1qB7NZBFQlNizYwgxi8wq4SayfdYUVYp2cxM1zncwTGLkWMDKsYpRMLSjOTc8t
        NiowzEst1ytOzC0uzUvXS87P3cQIDJRth7X6djDeXxJ/iFGAg1GJh1fiz/woIdbEsuLK3EOM
        EhzMSiK8XMsWRAnxpiRWVqUW5ccXleakFh9ilOZgURLnvZ13LFJIID2xJDU7NbUgtQgmy8TB
        KdXAuO5i7hq5TQlzt5h0na4zvPEjLZHjqNOpSf7mPMw3DVz0jnWVygvxLvg39Y+gUzdzzR6O
        z+G1a/R3f85nCD1fdrXk+AxDpcg5m74c31LBlGAsuFPfUGeiidkkH1a/J9ITPjlkpOf+NKte
        Ux758+XN2KLMGcosaczzr7Tqd9s1pa2o+bvxaMl0JZbijERDLeai4kQAOxFd2BACAAA=
X-CMS-MailID: 20180308111416epcas1p4f9f1dbb36e8567121c6236ac0e9b4e03
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180308111416epcas1p4f9f1dbb36e8567121c6236ac0e9b4e03
X-RootMTR: 20180308111416epcas1p4f9f1dbb36e8567121c6236ac0e9b4e03
References: <CGME20180308111416epcas1p4f9f1dbb36e8567121c6236ac0e9b4e03@epcas1p4.samsung.com>
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
