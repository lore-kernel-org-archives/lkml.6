Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeEFK04 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:26:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:27032 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeEFK0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:26:44 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180506102642epoutp01f8bf9215ab0d9ef1c0e9980841ad38ab~sB01kvyxR0368103681epoutp01O
X-AuditID: b6c32a36-b55ff70000001027-16-5aeed8611cb8
From: Alim Akhtar <alim.akhtar@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vivek.gautam@codeaurora.org, subhashj@codeaurora.org,
        vinholikatti@gmail.com, olof@lixom.net, alim.akhtar@samsung.com
Subject: [PATCH 3/4] scsi: ufs: add quirk to enable host controller without
 hce
Date: Sun, 06 May 2018 15:44:17 +0530
Message-id: <1525601658-31989-4-git-send-email-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCmvm7ijXdRBgv7jCwezNvGZrFqYp7F
        5V1z2Cy6r+9gs1h+/B+Txanrn9ksbizeyWaxY2GVxYmfO5gdOD0u9/UyeeycdZfd48GhzSwe
        V040sXp8fHqLxaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgyZvx9w17wXrZi8akNzA2MfRJd
        jJwcEgImElt2NjN3MXJxCAnsYJT4vekqC4TznVGic+kfNpiqKb1fGCESGxglFs/dAlX1g1Hi
        2cL17CBVbALaEnenb2ECsUUEbCTO33zABFLELLCJUWLBxOVgo4QFAiV63/8BK2IRUJVYd+4e
        K4jNK+AusXlVDxPEOjmJm+c6mUFsTgEPiR2nO9lABkkIrGCT6DkxjRmiyEVi/95T7BC2sMSr
        41uAbA4gW1ri0lFbiHC2xIfjJ6HKayRmXeyFesde4sCVOSwgNrMAn8S7rz2sEK28Eh1tQhAl
        HhJbF91ghbAdJY617GOHeHg2o8Tfp7fYJjBKLWBkWMUollpQnJueWmxYYKRXnJhbXJqXrpec
        n7uJERy7WmY7GBed8znEKMDBqMTDO4HjXZQQa2JZcWXuIUYJDmYlEd7A9UAh3pTEyqrUovz4
        otKc1OJDjNIcLErivE99zkQJCaQnlqRmp6YWpBbBZJk4OKUaGG12rEzYG/S1Nqr1xaesGLvN
        UQH9Wx3YUg9FKhSaquSdXLpqboEW5+cvYS6VbueqWg9EnfnlobdZyks2dceiK2c7ewwU9jac
        9uRs+xDC0/3gRFF34gQWxzUvbq7j7L/08vsKE3U5nr/HTUoUvKer3/Xb6sn8p+Hrsuo8jpa+
        uUmHq9c/mv3eSomlOCPRUIu5qDgRANK1FVjZAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsVy+t9jQd3EG++iDL4clLV4MG8bm8WqiXkW
        l3fNYbPovr6DzWL58X9MFqeuf2azuLF4J5vFjoVVFid+7mB24PS43NfL5LFz1l12jweHNrN4
        XDnRxOrx8ektFo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DKmPH3DXvBe9mKxac2MDcw9kl0
        MXJySAiYSEzp/cLYxcjFISSwjlHi0rNOdgjnB6PEm65+ZpAqNgFtibvTtzCB2CICNhLnbz5g
        AiliFtjEKDH76XkWkISwgL/Enr9fwBpYBFQl1p27xwpi8wq4S2xe1cMEsU5O4ua5TrAaTgEP
        iR2nO9lAbCGgmomvb7NOYORZwMiwilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMjMNi2
        Hdbq28F4f0n8IUYBDkYlHt4JHO+ihFgTy4orcw8xSnAwK4nwBq4HCvGmJFZWpRblxxeV5qQW
        H2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbLxMEp1cDYKGzelXc1xH/Hzaf679jrbRL+W1k7
        zPPQ+JRqdynnb2fCbL4ov/+da+//2PM4/n/GB5Z/vX1pbmWxHZWmnzaUGeZdOFT34PIrXX1p
        8W0/ZL6Ktt/JTQ2pyLx9vGbhI6s3whWnLyZOXbuotqHnyclYrbv7dv/fW1KkccJqUt7ckw+e
        P6nc5bZSiaU4I9FQi7moOBEABLimyzICAAA=
X-CMS-MailID: 20180506102641epcas1p40fb2055e82d32d7cfa594af132273d31
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180506102641epcas1p40fb2055e82d32d7cfa594af132273d31
X-RootMTR: 20180506102641epcas1p40fb2055e82d32d7cfa594af132273d31
References: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
        <CGME20180506102641epcas1p40fb2055e82d32d7cfa594af132273d31@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some host controller doesn't support host controller enable via HCE.

Signed-off-by: Seungwon Jeon <essuuj@gmail.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 75 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/ufs/ufshcd.h |  5 ++++
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 253257c..5bfd385 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3400,6 +3400,52 @@ static int ufshcd_dme_link_startup(struct ufs_hba *hba)
 			"dme-link-startup: error code %d\n", ret);
 	return ret;
 }
+/**
+ * ufshcd_dme_reset - UIC command for DME_RESET
+ * @hba: per adapter instance
+ *
+ * DME_RESET command is issued in order to reset UniPro stack.
+ * This function now deal with cold reset.
+ *
+ * Returns 0 on success, non-zero value on failure
+ */
+static int ufshcd_dme_reset(struct ufs_hba *hba)
+{
+	struct uic_command uic_cmd = {0};
+	int ret;
+
+	uic_cmd.command = UIC_CMD_DME_RESET;
+
+	ret = ufshcd_send_uic_cmd(hba, &uic_cmd);
+	if (ret)
+		dev_err(hba->dev,
+			"dme-reset: error code %d\n", ret);
+
+	return ret;
+}
+
+/**
+ * ufshcd_dme_enable - UIC command for DME_ENABLE
+ * @hba: per adapter instance
+ *
+ * DME_ENABLE command is issued in order to enable UniPro stack.
+ *
+ * Returns 0 on success, non-zero value on failure
+ */
+static int ufshcd_dme_enable(struct ufs_hba *hba)
+{
+	struct uic_command uic_cmd = {0};
+	int ret;
+
+	uic_cmd.command = UIC_CMD_DME_ENABLE;
+
+	ret = ufshcd_send_uic_cmd(hba, &uic_cmd);
+	if (ret)
+		dev_err(hba->dev,
+			"dme-reset: error code %d\n", ret);
+
+	return ret;
+}
 
 static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
 {
@@ -4058,7 +4104,7 @@ static inline void ufshcd_hba_stop(struct ufs_hba *hba, bool can_sleep)
 }
 
 /**
- * ufshcd_hba_enable - initialize the controller
+ * ufshcd_hba_execute_hce - initialize the controller
  * @hba: per adapter instance
  *
  * The controller resets itself and controller firmware initialization
@@ -4067,7 +4113,7 @@ static inline void ufshcd_hba_stop(struct ufs_hba *hba, bool can_sleep)
  *
  * Returns 0 on success, non-zero value on failure
  */
-static int ufshcd_hba_enable(struct ufs_hba *hba)
+static int ufshcd_hba_execute_hce(struct ufs_hba *hba)
 {
 	int retry;
 
@@ -4122,6 +4168,31 @@ static int ufshcd_hba_enable(struct ufs_hba *hba)
 	return 0;
 }
 
+static int ufshcd_hba_enable(struct ufs_hba *hba)
+{
+	int ret;
+
+	if (hba->quirks & UFSHCI_QUIRK_BROKEN_HCE) {
+		ufshcd_set_link_off(hba);
+		ufshcd_vops_hce_enable_notify(hba, PRE_CHANGE);
+
+		/* enable UIC related interrupts */
+		ufshcd_enable_intr(hba, UFSHCD_UIC_MASK);
+		ret = ufshcd_dme_reset(hba);
+		if (!ret) {
+			ret = ufshcd_dme_enable(hba);
+			if (!ret)
+				ufshcd_vops_hce_enable_notify(hba, POST_CHANGE);
+			if (ret)
+				dev_err(hba->dev,
+					"Host controller enable failed with non-hce\n");
+		}
+	} else {
+		ret = ufshcd_hba_execute_hce(hba);
+	}
+
+	return ret;
+}
 static int ufshcd_disable_tx_lcc(struct ufs_hba *hba, bool peer)
 {
 	int tx_lanes, i, err = 0;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 5c91ff1..013a07e 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -606,6 +606,11 @@ struct ufs_hba {
 	 */
 	#define UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR		0x200
 
+	/*
+	 * This quirks needs to be enabled if host controller cannot be
+	 * enabled via HCE register.
+	 */
+	#define UFSHCI_QUIRK_BROKEN_HCE				0x400
 	unsigned int quirks;	/* Deviations from standard UFSHCI spec. */
 
 	/* Device deviations from standard UFS device spec. */
-- 
2.7.4
