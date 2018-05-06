Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeEFK1d (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:27:33 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59774 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeEFK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:26:43 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180506102642epoutp03ed3f0e3853b4e05767281c03980fa24b~sB01Eih4N1710817108epoutp03U
X-AuditID: b6c32a48-c49ff70000000fef-2e-5aeed860b599
From: Alim Akhtar <alim.akhtar@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vivek.gautam@codeaurora.org, subhashj@codeaurora.org,
        vinholikatti@gmail.com, olof@lixom.net, alim.akhtar@samsung.com
Subject: [PATCH 2/4] scsi: ufs: add quirk not to allow reset of interrupt
 aggregation
Date: Sun, 06 May 2018 15:44:16 +0530
Message-id: <1525601658-31989-3-git-send-email-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCmuW7CjXdRBku+21g8mLeNzWLVxDyL
        y7vmsFl0X9/BZrH8+D8mi1PXP7NZ3Fi8k81ix8IqixM/dzA7cHpc7utl8tg56y67x4NDm1k8
        rpxoYvX4+PQWi0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlPLh8jbFgA0/FzOmPmBoYV3N1
        MXJySAiYSHz/f4wdxBYS2MEo8fivZRcjF5D9nVHi7+z/zDBF57rvs0EkNjBKrD1wjRHC+cEo
        cWPRESaQKjYBbYm707eA2SICNhLnbz5gAiliFtjEKLFg4nI2kISwQLjEueNdYDaLgKrE9w0P
        WbsYOTh4BdwlHk3igNgmJ3HzXCfYZk4BD4kdpzvBNksIrGCTuPRqHgtEkYvEoqZ+VghbWOLV
        8S3sELa0xLNVGxkh7GyJD8dPQr1QIzHrYi8bhG0vceDKHLA5zAJ8Eh2H/7KD3CAhwCvR0SYE
        UeIhcWTvcahVjhLPH11nh3h4NqPE9itvWCYwSi1gZFjFKJZaUJybnlpsVGCiV5yYW1yal66X
        nJ+7iREcuVoeOxgPnPM5xCjAwajEwzuB412UEGtiWXFl7iFGCQ5mJRHewPVAId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rwNvmeihATSE0tSs1NTC1KLYLJMHJxSDYyKXF9t7Ko/lDr+2c1w5FHc
        xs1T4ssNnT0mTzq1q/VJRUxslxab5FfuY23Jkud2y7BwBMVHzhRQ2Xji0h/GXMlXjxUMlk3q
        X6CQ5vz5xoY+oZi2zdrvVLTP/t7CKnjmlnHV4azJXlGeF+7dbj9oqBPgyjLhAVuasZjiLBah
        6GPnTxwstMzpLFViKc5INNRiLipOBABWEC5n2AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsVy+t9jQd34G++iDA59M7V4MG8bm8WqiXkW
        l3fNYbPovr6DzWL58X9MFqeuf2azuLF4J5vFjoVVFid+7mB24PS43NfL5LFz1l12jweHNrN4
        XDnRxOrx8ektFo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DKeHD5GmPBBp6KmdMfMTUwrubq
        YuTkkBAwkTjXfZ+ti5GLQ0hgHaPEor9/2CGcH4wSD3Z8YAOpYhPQlrg7fQsTiC0iYCNx/uYD
        JpAiZoFNjBKzn55nAUkIC4RLnDveBdbAIqAq8X3DQ9YuRg4OXgF3iUeTOCC2yUncPNfJDGJz
        CnhI7DjdCVYuBFQy8fVt1gmMPAsYGVYxSqYWFOem5xYbFRjlpZbrFSfmFpfmpesl5+duYgSG
        2rbDWv07GB8viT/EKMDBqMTDO4HjXZQQa2JZcWXuIUYJDmYlEd7A9UAh3pTEyqrUovz4otKc
        1OJDjNIcLErivPz5xyKFBNITS1KzU1MLUotgskwcnFINjALx7Avmpoce+zLHfMfbLX1/TuTr
        G7rIze/4JBrAcWftx3LtqeVrClM/OL+7fnCes+oe5k/hy5JXOB99zS40Nd9C8NRFJefPJp6e
        m0+1StXrPe0/rqzTxNXw88D+rVZG06dXip0K1S+/tCxQWEH2WNkPhuVeLKVS5jZNp4W8Feof
        3jXoX81rpsRSnJFoqMVcVJwIAM2HG1YxAgAA
X-CMS-MailID: 20180506102639epcas2p13ac44966a64e539f611ccdc2479e1abb
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180506102639epcas2p13ac44966a64e539f611ccdc2479e1abb
X-RootMTR: 20180506102639epcas2p13ac44966a64e539f611ccdc2479e1abb
References: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
        <CGME20180506102639epcas2p13ac44966a64e539f611ccdc2479e1abb@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some host controller supports interrupt aggregation, but doesn't
allow to reset counter and timer by s/w.

Signed-off-by: Seungwon Jeon <essuuj@gmail.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 drivers/scsi/ufs/ufshcd.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 9898ce5..253257c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4695,7 +4695,8 @@ static void ufshcd_transfer_req_compl(struct ufs_hba *hba)
 	 * false interrupt if device completes another request after resetting
 	 * aggregation and before reading the DB.
 	 */
-	if (ufshcd_is_intr_aggr_allowed(hba))
+	if (ufshcd_is_intr_aggr_allowed(hba) &&
+	    !(hba->quirks & UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR))
 		ufshcd_reset_intr_aggr(hba);
 
 	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 43035f8..5c91ff1 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -600,6 +600,12 @@ struct ufs_hba {
 	 */
 	#define UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR		0x100
 
+	/*
+	 * This quirk needs to be enabled if host controller doesn't allow
+	 * that the interrupt aggregation timer and counter are reset by s/w.
+	 */
+	#define UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR		0x200
+
 	unsigned int quirks;	/* Deviations from standard UFSHCI spec. */
 
 	/* Device deviations from standard UFS device spec. */
-- 
2.7.4
