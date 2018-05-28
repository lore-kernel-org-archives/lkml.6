Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163383AbeE1NeD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:34:03 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:50932 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162641AbeE1NeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:34:00 -0400
To: "Vinayak Holikatti <vinholikatti@gmail.com>; \"James E.J. Bottomley\"
        <jejb@linux.vnet.ibm.com>; \"Martin K. Petersen\""
        <martin.petersen@oracle.com>
Subject: [PATCH 4/5] scsi: ufs: Add crypto masks for UFS HC driver
CC: <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org;Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
Message-ID: <ff79e81f-2250-35e8-9c10-ae4e0b2e08ba@synopsys.com>
Date: Mon, 28 May 2018 14:32:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.144.133.104]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch add necessary crypto mask and command for
inline encryption support in the UFS Host Controller driver.

Signed-off-by: Ladvine D Almeida <ladvine@synopsys.com>
---
 drivers/scsi/ufs/ufshci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index bb5d9c7..c003924 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -90,6 +90,7 @@ enum {
 	MASK_64_ADDRESSING_SUPPORT		= 0x01000000,
 	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
 	MASK_UIC_DME_TEST_MODE_SUPPORT		= 0x04000000,
+	MASK_CRYPTO_SUPPORT                     = 0x10000000,
 };
 
 #define UFS_MASK(mask, offset)		((mask) << (offset))
@@ -337,6 +338,7 @@ enum {
 	UTP_NATIVE_UFS_COMMAND		= 0x10000000,
 	UTP_DEVICE_MANAGEMENT_FUNCTION	= 0x20000000,
 	UTP_REQ_DESC_INT_CMD		= 0x01000000,
+	UTP_REQ_CRYPT_EN_CMD            = 0x00800000, /* Inline Encryption */
 };
 
 /* UTP Transfer Request Data Direction (DD) */
-- 
2.7.4
