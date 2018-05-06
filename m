Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeEFK0w (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:26:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:35470 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeEFK0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:26:47 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180506102645epoutp022195aee57777b7a4b5283a1a102c2022~sB04JyKxY0201502015epoutp02U
X-AuditID: b6c32a48-c31ff70000000fef-33-5aeed864c00e
From: Alim Akhtar <alim.akhtar@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vivek.gautam@codeaurora.org, subhashj@codeaurora.org,
        vinholikatti@gmail.com, olof@lixom.net, alim.akhtar@samsung.com
Subject: [PATCH 4/4] scsi: ufs: make ufshcd_config_pwr_mode of non-static
 func
Date: Sun, 06 May 2018 15:44:18 +0530
Message-id: <1525601658-31989-5-git-send-email-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCmmW7KjXdRBjNnilg8mLeNzWLVxDyL
        y7vmsFl0X9/BZrH8+D8mi1PXP7NZ3Fi8k81ix8IqixM/dzA7cHpc7utl8tg56y67x4NDm1k8
        rpxoYvX4+PQWi0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBl7Gq/yFZwQLBi57OUBsZHfF2M
        nBwSAiYSTWcOM3YxcnEICexglPi+aCUzhPOdUeL10e8sMFXvfr9jh0hsYJRYeXIdK4Tzg1Fi
        /fO57CBVbALaEnenb2ECsUUEbCTO33zABFLELLCJUWLBxOVsIAlhgQCJ1msTwcayCKhKrHrz
        gBnE5hVwl7ix8xgjxDo5iZvnOsHinAIeEjtOd7KBDJIQWMImMe/hblaIIheJ2QvfskPYwhKv
        jm+BsqUlnq3aCDUoW+LD8ZPMEHaNxKyLvWwQtr3EgStzwI5gFuCT6Dj8F6iXAyjOK9HRJgRR
        4iEx/w/MeEeJg4v3sEB8PJtR4tzXhywTGKUWMDKsYhRLLSjOTU8tNiow0StOzC0uzUvXS87P
        3cQIjl0tjx2MB875HGIU4GBU4uGdwPEuSog1say4MvcQowQHs5IIb+B6oBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHeBt8zUUIC6YklqdmpqQWpRTBZJg5OqQbGPUVds65Ind0eUDDx9J5nPTqf
        ooxKJyR7rwp91PTpvlqWeoLuJ53XCXX6x3XDJrL6VLrMNL7n4uMyV9r9Zo20oQzj1MjZDBJs
        H5zO/mdsMLoWd16ojWcr19pChbUbgvUCM/34M7T+aX29t++U0+TjHpUnWKbc5/A65RpZs6NX
        5eKH+XIRz28qsRRnJBpqMRcVJwIA9Pqd59kCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsVy+t9jQd3kG++iDLp6WS0ezNvGZrFqYp7F
        5V1z2Cy6r+9gs1h+/B+Txanrn9ksbizeyWaxY2GVxYmfO5gdOD0u9/UyeeycdZfd48GhzSwe
        V040sXp8fHqLxaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgydrVfZCs4IFix81lKA+Mjvi5G
        Tg4JAROJd7/fsXcxcnEICaxjlPj38ASU84NR4kDnHGaQKjYBbYm707cwgdgiAjYS528+YAIp
        YhbYxCgx++l5FpCEsICfxKYl09hBbBYBVYlVbx6ANfMKuEvc2HmMEWKdnMTNc51gcU4BD4kd
        pzvZQGwhoJqJr2+zTmDkWcDIsIpRMrWgODc9t9iowCgvtVyvODG3uDQvXS85P3cTIzDUth3W
        6t/B+HhJ/CFGAQ5GJR7eCRzvooRYE8uKK3MPMUpwMCuJ8AauBwrxpiRWVqUW5ccXleakFh9i
        lOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpgjG3X7J65R/w58+abP+yL7rSHS92oEJ48
        9UCIquGjSYlz4/fHBOd9/cShd2HXw2/LmvY4GW6ZeYPjbs57rqMsYXvYLabely57faw3yMKv
        nmkt68uyEim/jvNmjOEsxY1sShM86ixcvNKLfxh8N96yjW/qh//lRq98GljmJ/Pu7Jp3LcG2
        aPUuJZbijERDLeai4kQAvGWYbjECAAA=
X-CMS-MailID: 20180506102643epcas2p24ed80d7ede859db73c2595724d9c2414
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180506102643epcas2p24ed80d7ede859db73c2595724d9c2414
X-RootMTR: 20180506102643epcas2p24ed80d7ede859db73c2595724d9c2414
References: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
        <CGME20180506102643epcas2p24ed80d7ede859db73c2595724d9c2414@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes ufshcd_config_pwr_mode non-static so that other vendors
like exynos can use the same.

Signed-off-by: Seungwon Jeon <essuuj@gmail.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 5 ++---
 drivers/scsi/ufs/ufshcd.h | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 5bfd385..68aefcd 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -233,8 +233,6 @@ static void ufshcd_suspend_clkscaling(struct ufs_hba *hba);
 static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba);
 static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up);
 static irqreturn_t ufshcd_intr(int irq, void *__hba);
-static int ufshcd_config_pwr_mode(struct ufs_hba *hba,
-		struct ufs_pa_layer_attr *desired_pwr_mode);
 static int ufshcd_change_power_mode(struct ufs_hba *hba,
 			     struct ufs_pa_layer_attr *pwr_mode);
 static inline bool ufshcd_valid_tag(struct ufs_hba *hba, int tag)
@@ -3969,7 +3967,7 @@ static int ufshcd_change_power_mode(struct ufs_hba *hba,
  * @hba: per-adapter instance
  * @desired_pwr_mode: desired power configuration
  */
-static int ufshcd_config_pwr_mode(struct ufs_hba *hba,
+int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 		struct ufs_pa_layer_attr *desired_pwr_mode)
 {
 	struct ufs_pa_layer_attr final_params = { 0 };
@@ -3987,6 +3985,7 @@ static int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ufshcd_config_pwr_mode);
 
 /**
  * ufshcd_complete_dev_init() - checks device readiness
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 013a07e..b42a5a3 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -805,6 +805,8 @@ extern int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 attr_sel,
 			       u8 attr_set, u32 mib_val, u8 peer);
 extern int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 			       u32 *mib_val, u8 peer);
+extern int ufshcd_config_pwr_mode(struct ufs_hba *hba,
+			struct ufs_pa_layer_attr *desired_pwr_mode);
 
 /* UIC command interfaces for DME primitives */
 #define DME_LOCAL	0
-- 
2.7.4
