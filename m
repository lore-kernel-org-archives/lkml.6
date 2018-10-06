Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC796C677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97C72148D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI2lgzAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97C72148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJFUGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 16:06:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38856 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbeJFUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 16:05:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id a13-v6so16136097wrt.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+KVaGT26r59EyZOx40AE+8cAXVLjkTu67ycCRZjZWc=;
        b=eI2lgzAd8TY+6pST2jQXYfKX6DMk5HvYGIBwHM1lr7C8v80M4/d7IHCtP06ABudrHn
         1Evdwxw01gal+/hZfBAhdBbUz9R0cvtatFwI90+NtMRDrmOQDWJDWHNG4e4Pq3YN7lA3
         0sccwhdSPjemzgpiZnU3O7cPnVCyvxQNcKK6GRshq4sPE2kgwdrg+MZ+Q/EzupiMBv2M
         yqnWHWolweOU6CzCyGXeTGnR86oGPxPkBt0Z25ZR9xVoi9WOfqt7WImzrEog6MtbRX0o
         C75UR1jqFr/U6BzwjJsIwWNKMFzryzIssa1MioD5/GYKKfiizcWf+EMr9pKmofn3A9zm
         kXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+KVaGT26r59EyZOx40AE+8cAXVLjkTu67ycCRZjZWc=;
        b=qPLGtqw94XdchiFonXUOOInt/bFc+dgTdVw14aUHPQRrq5KR3ROapmxkc5ai3eteWc
         /iclI6NA9ptsqClehuFEBwBLS9/CaDZcIOrTksXozjRMEatGpeZKaLySBMjF91tR/A/5
         fp/xLbv9bxm47NtNeIbuYMX26BA/E9Bf4clwCTuFkJQwiBrz0S/vrY8Jlguev9ubZ1iH
         JJFGJt5GvuBxT+cOy/DvJ3yZHOy/GF5czbZB1fub+7O6A1OWnA+qbHTfwHSyPFvzkQpc
         aP2ldX23ECqTf7jdHJABtTIm/AjkWdAeIFDrWL5xnWrRHFSViTFrlqPmeFZX7xHvtkOu
         KXBw==
X-Gm-Message-State: ABuFfohPqU5pEd9g0763uifba1CfAg4WCHFAEKMrIW89uwwygAgdu8Lk
        dvH1Ic1AzbdXQPX6TBozGkHgnIDn
X-Google-Smtp-Source: ACcGV61PxCHNL8Z0Ffc5rYNc35pT3OBgNLVM4ZuE4ctjarxi4gz7mUJB0wbuL5wSaxodPk/oQ7jj/Q==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr2378382wrx.271.1538830964619;
        Sat, 06 Oct 2018 06:02:44 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd32.dynamic.kabel-deutschland.de. [31.18.253.50])
        by smtp.gmail.com with ESMTPSA id z89-v6sm23230445wrb.3.2018.10.06.06.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 06:02:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: add spaces around operators in odm_rtl8188e.c
Date:   Sat,  6 Oct 2018 15:02:31 +0200
Message-Id: <20181006130231.1428-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181006130231.1428-1-straube.linux@gmail.com>
References: <20181006130231.1428-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '|', '>>' and '/' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
index 3430796d56a3..251bd8aba3b1 100644
--- a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
+++ b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
@@ -23,7 +23,7 @@ static void dm_rx_hw_antena_div_init(struct odm_dm_struct *dm_odm)
 	/* MAC Setting */
 	value32 = phy_query_bb_reg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
 	phy_set_bb_reg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord,
-		       value32|(BIT(23) | BIT(25)));
+		       value32 | (BIT(23) | BIT(25)));
 	/* Pin Settings */
 	phy_set_bb_reg(adapter, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);
 	phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);
@@ -55,7 +55,7 @@ static void dm_trx_hw_antenna_div_init(struct odm_dm_struct *dm_odm)
 	/* MAC Setting */
 	value32 = phy_query_bb_reg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
 	phy_set_bb_reg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord,
-		       value32|(BIT(23) | BIT(25)));
+		       value32 | (BIT(23) | BIT(25)));
 	/* Pin Settings */
 	phy_set_bb_reg(adapter, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);
 	phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);
@@ -103,9 +103,11 @@ static void dm_fast_training_init(struct odm_dm_struct *dm_odm)
 
 	/* MAC Setting */
 	value32 = phy_query_bb_reg(adapter, 0x4c, bMaskDWord);
-	phy_set_bb_reg(adapter, 0x4c, bMaskDWord, value32|(BIT(23) | BIT(25)));
+	phy_set_bb_reg(adapter, 0x4c, bMaskDWord,
+		       value32 | (BIT(23) | BIT(25)));
 	value32 = phy_query_bb_reg(adapter,  0x7B4, bMaskDWord);
-	phy_set_bb_reg(adapter, 0x7b4, bMaskDWord, value32|(BIT(16) | BIT(17)));
+	phy_set_bb_reg(adapter, 0x7b4, bMaskDWord,
+		       value32 | (BIT(16) | BIT(17)));
 
 	/* Match MAC ADDR */
 	phy_set_bb_reg(adapter, 0x7b4, 0xFFFF, 0);
@@ -194,8 +196,8 @@ static void update_tx_ant_88eu(struct odm_dm_struct *dm_odm, u8 ant, u32 mac_id)
 	else
 		target_ant = AUX_ANT_CG_TRX;
 	dm_fat_tbl->antsel_a[mac_id] = target_ant & BIT(0);
-	dm_fat_tbl->antsel_b[mac_id] = (target_ant & BIT(1))>>1;
-	dm_fat_tbl->antsel_c[mac_id] = (target_ant & BIT(2))>>2;
+	dm_fat_tbl->antsel_b[mac_id] = (target_ant & BIT(1)) >> 1;
+	dm_fat_tbl->antsel_c[mac_id] = (target_ant & BIT(2)) >> 2;
 }
 
 void rtl88eu_dm_set_tx_ant_by_tx_info(struct odm_dm_struct *dm_odm,
@@ -250,9 +252,11 @@ static void rtl88eu_dm_hw_ant_div(struct odm_dm_struct *dm_odm)
 		if (IS_STA_VALID(entry)) {
 			/* 2 Calculate RSSI per Antenna */
 			main_rssi = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ?
-				     (dm_fat_tbl->MainAnt_Sum[i]/dm_fat_tbl->MainAnt_Cnt[i]) : 0;
+				     (dm_fat_tbl->MainAnt_Sum[i] /
+				      dm_fat_tbl->MainAnt_Cnt[i]) : 0;
 			aux_rssi = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ?
-				    (dm_fat_tbl->AuxAnt_Sum[i]/dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
+				    (dm_fat_tbl->AuxAnt_Sum[i] /
+				     dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
 			target_ant = (main_rssi >= aux_rssi) ? MAIN_ANT : AUX_ANT;
 			/* 2 Select max_rssi for DIG */
 			local_max_rssi = max(main_rssi, aux_rssi);
-- 
2.19.0

