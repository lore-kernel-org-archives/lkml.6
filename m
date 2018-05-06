Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEFK1s (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:27:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59765 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeEFK0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:26:41 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180506102639epoutp038cefa84df74b53d548672a06a8544e10~sB0y2h0Is1711217112epoutp03U
X-AuditID: b6c32a38-6f7ff7000000105c-e7-5aeed85e6af1
From: Alim Akhtar <alim.akhtar@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vivek.gautam@codeaurora.org, subhashj@codeaurora.org,
        vinholikatti@gmail.com, olof@lixom.net, alim.akhtar@samsung.com
Subject: [PATCH 1/4] scsi: ufs: add quirk to fix mishandling
 utrlclr/utmrlclr
Date: Sun, 06 May 2018 15:44:15 +0530
Message-id: <1525601658-31989-2-git-send-email-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCmnm7cjXdRBi+Oalk8mLeNzWLVxDyL
        y7vmsFl0X9/BZrH8+D8mi1PXP7NZ3Fi8k81ix8IqixM/dzA7cHpc7utl8tg56y67x4NDm1k8
        rpxoYvX4+PQWi0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlvN+xm73guVDFzX/tzA2MN/m7
        GDk5JARMJDp2XGbtYuTiEBLYwSjROvswC4TznVFiQu9zNpiqNZ9Ps0EkNjBKfFq8lh3C+cEo
        sfD5U0aQKjYBbYm707cwgdgiAjYS528+YAIpYhbYxCixYOJysFHCAv4SPXdOsoLYLAKqEosa
        7oDZvALuEuenHWeGWCcncfNcJ5jNKeAhseN0J9hqCYEVbBITDn5ggShykdh35BEThC0s8er4
        FqCTOIBsaYlLR20hwtkSH46fhJpZIzHrYi/UO/YSB67MARvDLMAn8e5rDytEK69ER5sQRImH
        xK5tf6HKHSWund/CBPHwbEaJF+vnM05glFrAyLCKUSy1oDg3PbXYsMBErzgxt7g0L10vOT93
        EyM4drUsdjDuOedziFGAg1GJh3cCx7soIdbEsuLK3EOMEhzMSiK8geuBQrwpiZVVqUX58UWl
        OanFhxilOViUxHmf+pyJEhJITyxJzU5NLUgtgskycXBKNTBW75pz3Kh28rmXnx71pad/vBH6
        0DDOell+wqy6Nj6TG/k5TjtfKCXZaf+rYrqjXX1+yftpuy/ELdCytHnH8TNVRL7I6VEt34SK
        X7b6aTsU/1r6zi/d/tdktrrkn7Y48QMqTtKfVTptr7+bcHly4ea3h8KSWtlWiVx+vXhxR8Z/
        /t58C7llqV+VWIozEg21mIuKEwGe/R4L2QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsVy+t9jQd24G++iDHo2CVo8mLeNzWLVxDyL
        y7vmsFl0X9/BZrH8+D8mi1PXP7NZ3Fi8k81ix8IqixM/dzA7cHpc7utl8tg56y67x4NDm1k8
        rpxoYvX4+PQWi0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlvN+xm73guVDFzX/tzA2MN/m7
        GDk5JARMJNZ8Ps3WxcjFISSwjlHi5aSVjCAJIYEfjBI3zzqC2GwC2hJ3p29hArFFBGwkzt98
        wATSwCywiVFi9tPzLCAJYQFfiW2HJrGC2CwCqhKLGu6A2bwC7hLnpx1nhtgmJ3HzXCeYzSng
        IbHjdCcbxDJ3iYmvb7NOYORZwMiwilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMjMNS2
        Hdbq28F4f0n8IUYBDkYlHt4JHO+ihFgTy4orcw8xSnAwK4nwBq4HCvGmJFZWpRblxxeV5qQW
        H2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbLxMEp1cAoUNPKFHyVd+nBxZPyHJc+NzntwXOC
        9+PGmWkm7C9vlxzhkVlwsrNBRGXr5LKeAo0S58q1r/SEP7k831pW0PP37RT1bbeSOr/8ndzf
        yOioHjWVnVPFYeq7Y19MLq46/W5zxvZZbB+S5zRXyjs1zIqxY6t+01fc9OgPyzXZSea/5og2
        HS7YdDdKiaU4I9FQi7moOBEAtH3wFDECAAA=
X-CMS-MailID: 20180506102638epcas1p17bea76e1a5dbac535d5d6a10181f7e29
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180506102638epcas1p17bea76e1a5dbac535d5d6a10181f7e29
X-RootMTR: 20180506102638epcas1p17bea76e1a5dbac535d5d6a10181f7e29
References: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
        <CGME20180506102638epcas1p17bea76e1a5dbac535d5d6a10181f7e29@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the right behavior, setting the bit to '0' indicates clear and
'1' indicates no change. If host controller handles this the other way,
UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR can be used.

Signed-off-by: Seungwon Jeon <essuuj@gmail.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 21 +++++++++++++++++++--
 drivers/scsi/ufs/ufshcd.h |  5 +++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 00e7905..9898ce5 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -675,7 +675,24 @@ static inline void ufshcd_put_tm_slot(struct ufs_hba *hba, int slot)
  */
 static inline void ufshcd_utrl_clear(struct ufs_hba *hba, u32 pos)
 {
-	ufshcd_writel(hba, ~(1 << pos), REG_UTP_TRANSFER_REQ_LIST_CLEAR);
+	if (hba->quirks & UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR)
+		ufshcd_writel(hba, (1 << pos), REG_UTP_TRANSFER_REQ_LIST_CLEAR);
+	else
+		ufshcd_writel(hba, ~(1 << pos),
+				REG_UTP_TRANSFER_REQ_LIST_CLEAR);
+}
+
+/**
+ * ufshcd_utmrl_clear - Clear a bit in UTRMLCLR register
+ * @hba: per adapter instance
+ * @pos: position of the bit to be cleared
+ */
+static inline void ufshcd_utmrl_clear(struct ufs_hba *hba, u32 pos)
+{
+	if (hba->quirks & UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR)
+		ufshcd_writel(hba, (1 << pos), REG_UTP_TASK_REQ_LIST_CLEAR);
+	else
+		ufshcd_writel(hba, ~(1 << pos), REG_UTP_TASK_REQ_LIST_CLEAR);
 }
 
 /**
@@ -5398,7 +5415,7 @@ static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag)
 		goto out;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
-	ufshcd_writel(hba, ~(1 << tag), REG_UTP_TASK_REQ_LIST_CLEAR);
+	ufshcd_utmrl_clear(hba, tag);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	/* poll for max. 1 sec to clear door bell register by h/w */
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 8110dcd..43035f8 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -595,6 +595,11 @@ struct ufs_hba {
 	 */
 	#define UFSHCD_QUIRK_PRDT_BYTE_GRAN			0x80
 
+	/*
+	 * Cleaer handling for transfer/task request list is just opposite.
+	 */
+	#define UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR		0x100
+
 	unsigned int quirks;	/* Deviations from standard UFSHCI spec. */
 
 	/* Device deviations from standard UFS device spec. */
-- 
2.7.4
