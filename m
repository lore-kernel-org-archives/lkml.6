Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D227DC65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834CD2147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZCRWqvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834CD2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJFUF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 16:05:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39658 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeJFUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 16:05:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id q8-v6so4233883wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 06:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulC9nAQHK+9OXPeQ1WiALV3lADIhInbAfmkVk+SxKhU=;
        b=tZCRWqvp9O8bZSBgjRr+MZ336ZVqIoBOye9f4bZiKCqcKWHaDAiYG8LxeZY1gqpbNX
         e6nieYHEJJSZQTA/zkMYGZb5nx1IYcp9iORt6Qx4GZ1jqdP8ZmBnRWC8Er2AjCJBqQ7B
         Aufntk2AydsUdVmt9mZzc4qQqUhHf5uj1e2ywtf6NdFrjFRkkgstle9lpfZjKwOoF9nA
         F3rLbHPJKNoFUe9wWknqKS6CAZR4FxKt+qBy5VTGCeU93RMYO1WBO5zucBMKvET2S298
         Rd1C/jTbXsN7PU+illxLsZtln2qXa09CTkJMO44QlEC4PO2L562lV1NxJJYXpnl1IoFd
         vV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulC9nAQHK+9OXPeQ1WiALV3lADIhInbAfmkVk+SxKhU=;
        b=qLVEwQ7JVXf1o3s2cU9I6OR2yXyKsucFVnkfGdukckTIN1q/EUz66CEwVO9/BcNl8h
         vjN7uwl0avgQ86fXkvPjdbTO7mVkfuUWOvnMsjEEHBjbras5fpnegA6X45AnLUAMlRgb
         YM7YC3ZaMbfd90YwTqKtIrYdLNb7JAGDBouXJimI+9LsszqCfT41vg+p2VDx2406wKiB
         j9wkzWKr1qwsvkGnhS2MwTvzAho5+nHecpmo0b6TwVikKCk6xo8am+KZ/g9gq+yDni8L
         V43fwG9CNArcZtnnbb8DTGndGHaHj4aZxERAeNw2UQOKVQy53qEIAODlV266IXV85ecw
         xiBQ==
X-Gm-Message-State: ABuFfogZnVcfDXRxn23T296gPTO2f4ADI0VzmG+fCorSyN5Mymv8JdYZ
        VdNivaC8/ue9JBPqx9MTL9duuxn5
X-Google-Smtp-Source: ACcGV63D74hkktONSMlXv+71S+wDD17rX0iW8Sc44ZlWAzjl2+RjRIZECrTSsiCA5ncglq4vNSz51Q==
X-Received: by 2002:a1c:a851:: with SMTP id r78-v6mr10314543wme.97.1538830963596;
        Sat, 06 Oct 2018 06:02:43 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd32.dynamic.kabel-deutschland.de. [31.18.253.50])
        by smtp.gmail.com with ESMTPSA id z89-v6sm23230445wrb.3.2018.10.06.06.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 06:02:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove dead code from dm_fast_training_init()
Date:   Sat,  6 Oct 2018 15:02:30 +0200
Message-Id: <20181006130231.1428-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable AntCombination is initialized to 2 and never changed.
So the else if path is never used. Remove the dead code and the
variable AntCombination.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c | 38 ++++----------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
index 3fb0ed604e3e..3430796d56a3 100644
--- a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
+++ b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
@@ -88,7 +88,6 @@ static void dm_fast_training_init(struct odm_dm_struct *dm_odm)
 	struct adapter *adapter = dm_odm->Adapter;
 	u32 value32, i;
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
-	u32 AntCombination = 2;
 
 	if (*dm_odm->mp_mode == 1)
 		return;
@@ -119,35 +118,12 @@ static void dm_fast_training_init(struct odm_dm_struct *dm_odm)
 	phy_set_bb_reg(adapter, 0xca4, bMaskDWord, 0x000000a0);
 
 	/* antenna mapping table */
-	if (AntCombination == 2) {
-		if (!dm_odm->bIsMPChip) { /* testchip */
-			phy_set_bb_reg(adapter, 0x858, BIT(10) | BIT(9) | BIT(8), 1);
-			phy_set_bb_reg(adapter, 0x858, BIT(13) | BIT(12) | BIT(11), 2);
-		} else { /* MPchip */
-			phy_set_bb_reg(adapter, 0x914, bMaskByte0, 1);
-			phy_set_bb_reg(adapter, 0x914, bMaskByte1, 2);
-		}
-	} else if (AntCombination == 7) {
-		if (!dm_odm->bIsMPChip) { /* testchip */
-			phy_set_bb_reg(adapter, 0x858, BIT(10) | BIT(9) | BIT(8), 0);
-			phy_set_bb_reg(adapter, 0x858, BIT(13) | BIT(12) | BIT(11), 1);
-			phy_set_bb_reg(adapter, 0x878, BIT(16), 0);
-			phy_set_bb_reg(adapter, 0x858, BIT(15) | BIT(14), 2);
-			phy_set_bb_reg(adapter, 0x878, BIT(19) | BIT(18) | BIT(17), 3);
-			phy_set_bb_reg(adapter, 0x878, BIT(22) | BIT(21) | BIT(20), 4);
-			phy_set_bb_reg(adapter, 0x878, BIT(25) | BIT(24) | BIT(23), 5);
-			phy_set_bb_reg(adapter, 0x878, BIT(28) | BIT(27) | BIT(26), 6);
-			phy_set_bb_reg(adapter, 0x878, BIT(31) | BIT(30) | BIT(29), 7);
-		} else { /* MPchip */
-			phy_set_bb_reg(adapter, 0x914, bMaskByte0, 0);
-			phy_set_bb_reg(adapter, 0x914, bMaskByte1, 1);
-			phy_set_bb_reg(adapter, 0x914, bMaskByte2, 2);
-			phy_set_bb_reg(adapter, 0x914, bMaskByte3, 3);
-			phy_set_bb_reg(adapter, 0x918, bMaskByte0, 4);
-			phy_set_bb_reg(adapter, 0x918, bMaskByte1, 5);
-			phy_set_bb_reg(adapter, 0x918, bMaskByte2, 6);
-			phy_set_bb_reg(adapter, 0x918, bMaskByte3, 7);
-		}
+	if (!dm_odm->bIsMPChip) { /* testchip */
+		phy_set_bb_reg(adapter, 0x858, BIT(10) | BIT(9) | BIT(8), 1);
+		phy_set_bb_reg(adapter, 0x858, BIT(13) | BIT(12) | BIT(11), 2);
+	} else { /* MPchip */
+		phy_set_bb_reg(adapter, 0x914, bMaskByte0, 1);
+		phy_set_bb_reg(adapter, 0x914, bMaskByte1, 2);
 	}
 
 	/* Default Ant Setting when no fast training */
@@ -156,7 +132,7 @@ static void dm_fast_training_init(struct odm_dm_struct *dm_odm)
 	phy_set_bb_reg(adapter, 0x864, BIT(8) | BIT(7) | BIT(6), 1);
 
 	/* Enter Traing state */
-	phy_set_bb_reg(adapter, 0x864, BIT(2) | BIT(1) | BIT(0), (AntCombination-1));
+	phy_set_bb_reg(adapter, 0x864, BIT(2) | BIT(1) | BIT(0), 1);
 	phy_set_bb_reg(adapter, 0xc50, BIT(7), 1);
 }
 
-- 
2.19.0

