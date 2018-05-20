Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeETCXa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 22:23:30 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:16833 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeETCX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 22:23:26 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180520022323epoutp044085f58cadc58fd75448d5778b449b82~wOQ2E1b_X0915609156epoutp04B
X-AuditID: b6c32a36-b6dff70000001027-50-5b00dc1b4c99
From: Bharat Uppal <bharat.uppal@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        subhashj@codeaurora.org, vinholikatti@gmail.com,
        shaik.ameer@samsung.com, alim.akhtar@samsung.com
Subject: [PATCH V3] scsi: ufs: Add specific callback for setting DMA mask
Date: Sun, 20 May 2018 07:41:02 +0530
Message-id: <1526782262-9808-1-git-send-email-bharat.uppal@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCmga70HYZog5vLWCwezNvGZrFqYp7F
        5V1z2Cy6r+9gs1h+/B+TxZGHu9ktbizeyWaxY2GVA4fH5b5eJo+ds+6yezw4tJnF4+PTWywe
        fVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlXH24SW2gvnCFRPP9TM1MD7i72Lk5JAQMJHoXveD
        tYuRi0NIYAejxPyTzxkhnO+MEl1HJ7LAVH1494EdxBYS2M0osfelH0TRD0aJ1rnTwYrYBHQl
        XiydxAxiiwjYSJy/+YAJpIhZYB6jxNI5U1hBEsICnhLHLm4BK2IRUJWY9Xw5I4jNK+Aucebc
        VahtchI3z3UygzRLCPxllZh75yQrRMJFYtHEfVC2sMSr41uATuIAsqUlLh21hQiXS+xY1gLV
        28AocfZFNztEwl7iwJU5YAuYBfgk3n3tYYXo5ZXoaBOCKPGQOLDvLBtE2FHi0EtPiIdjJTou
        zWWbwCi5gJFhFaNYakFxbnpqsWGBkV5xYm5xaV66XnJ+7iZGcCxqme1gXHTO5xCjAAejEg/v
        jUKGaCHWxLLiytxDjBIczEoivOtSgUK8KYmVValF+fFFpTmpxYcYpTlYlMR528z/RQkJpCeW
        pGanphakFsFkmTg4pRoYDVaZqE+4cDe8rjH8UHDB9ivcXpNsV4THnn8XIaTmeftAQu7fHNPn
        XuH8uastgoTrN+nEKSdn/p23N9B016HPwUtOvtX0vpHFt/Gtmu//icl3Jl+94vHHo/mnpe3E
        RxLN/7XCPrDafLCXX6IWkjOJV9LPJSRQrKnBm+laN9NMIZfsCduSPuYpsRRnJBpqMRcVJwIA
        PpHK3sECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsVy+t9jAV3JOwzRBs/b9CwezNvGZrFqYp7F
        5V1z2Cy6r+9gs1h+/B+TxZGHu9ktbizeyWaxY2GVA4fH5b5eJo+ds+6yezw4tJnF4+PTWywe
        fVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlXH24SW2gvnCFRPP9TM1MD7i72Lk5JAQMJH48O4D
        excjF4eQwE5GiVNz5jFDOD8YJX7sf8IIUsUmoCvxYukkZhBbRMBG4vzNB0wgRcwC8xgljp5c
        BlYkLOApceziFrAiFgFViVnPl4PFeQXcJc6cu8oCsU5O4ua5TuYJjFwLGBlWMUqmFhTnpucW
        GxUY5qWW6xUn5haX5qXrJefnbmIEBsq2w1p9OxjvL4k/xCjAwajEw3ujkCFaiDWxrLgy9xCj
        BAezkgjvulSgEG9KYmVValF+fFFpTmrxIUZpDhYlcd7beccihQTSE0tSs1NTC1KLYLJMHJxS
        DYxVRY8O79Z1XXqPOaf/2fHeMOezTRu/eqRyXuF4N7ungGfpopUfL2slLj1nyu+h9/eofr2p
        xbrS87tF3dXtdD/Wx56xiAkV1eLynJD7WP0Hz4sDy/fUMp6YuNm9RMhVmcm0IjT+/M74Y90O
        C7vX+RzbOcPcVCmdU+bKhsbLEekez4u7mFZHNCuxFGckGmoxFxUnAgBwqu5eEAIAAA==
X-CMS-MailID: 20180520022321epcas1p4b0084a15aca3e5aea02700e272149ef3
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180520022321epcas1p4b0084a15aca3e5aea02700e272149ef3
X-RootMTR: 20180520022321epcas1p4b0084a15aca3e5aea02700e272149ef3
References: <CGME20180520022321epcas1p4b0084a15aca3e5aea02700e272149ef3@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alim Akhtar <alim.akhtar@samsung.com>

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
