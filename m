Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D85AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF59F215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ0bX+Jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF59F215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeI0Sew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:34:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51498 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeI0Sew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:34:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id y25-v6so5667160wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7alBIzHR4wHS1wGxHG9SAa0enh5zZp0UrDSbML+ciE4=;
        b=LZ0bX+JwaC46M7lowrQadJp0g0eYVOVDPhUIHtDPymbBJBKmEjSCXPsgz4byi+IgXW
         sMxg/QCy+Zv+rxZc9NVvs3LmQtSXwwK0tDdVEpJ0eYu3nmdKwYWfPGwn70+0rPPyTg9P
         wvpKv3mqbIcI00zDpaBZd6AeQuQaZZKf/1mLi6kpOhYGzd3X8TWLcxRoa2lbu73aLAkY
         p4h7Hf44aryRU9elVsI7s4i3PepiM9rfez26WoEsz+INAwB3j3I6IYVzrVNSFSBv9ouD
         Q8MRxk7ytnQOllLdb/HszkyJH5D1IBMaQ7FEXrMOUHaxA6fLiRlo1K2yIwradN5qR8v/
         vo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7alBIzHR4wHS1wGxHG9SAa0enh5zZp0UrDSbML+ciE4=;
        b=hX7HZ74Q///G0TjlJj+n1Y7TSYxlICf4Kt0cGMGMFVnBTp/FNKwnmQpCeVxxWu+YoJ
         9xKXjlDMAYnRE6dfpJzzhgpk1GpM9bWjnKBdD1615UWr1xfFYrpDYMCYzunoZfclTanp
         G+Z6WY1NlAl/doVcUlfgnKIM4+uAoTcxnvNDFVp0ucIqG+vWOB9Y2rLoI1tu/y594MMp
         ba5nDSNKjbzZQtd/snqB0lCQC/kQIPhiDqfhIN5wfoc7hNkHeX3h2yMIjdgGnVrM5KnU
         Ug5oyBznhtYItqAS3+bdbx3i1Jw2RBtx1CT40KWKVttjAO2W2TkPDqKNY4AjBDzkiojW
         wPAw==
X-Gm-Message-State: ABuFfojy48B8N0nVqI1I339zRyVm0Zt2RYCvPiN9ozMDE4CSxpIx30tp
        gNeiBIW7ypLDJwq2NobIVeDePR2G
X-Google-Smtp-Source: ACcGV63UYJQhKtc3hr8IiqtRqkXueoBuD+rRtBqxvvGskmvAfzJB661IXbr2UG2rqT3mNuxMFelVQg==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr7651586wmx.38.1538050609900;
        Thu, 27 Sep 2018 05:16:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id h18-v6sm1580803wrb.82.2018.09.27.05.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 05:16:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove get_right_chnl_for_iqk()
Date:   Thu, 27 Sep 2018 14:16:40 +0200
Message-Id: <20180927121640.1580-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function get_right_chnl_for_iqk() only returns non zero values for
channels > 14. According to the TODO, code valid only for 5 GHz should
be removed.

- find and remove remaining code valid only for 5 GHz. Most of the obvious
  ones have been removed, but things like channel > 14 still exist.

Remove get_right_chnl_for_iqk() and the variable chn_index that is
used to save the return value. Replace the uses of chn_index with zero.

Remove the now unused define ODM_TARGET_CHNL_NUM_2G_5G.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/phy.c     | 27 +++----------------------
 drivers/staging/rtl8188eu/include/phy.h |  1 -
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 3c7cf8720df8..482d48e003b7 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -298,25 +298,6 @@ void rtw_hal_set_chan(struct adapter *adapt, u8 channel)
 
 #define ODM_TXPWRTRACK_MAX_IDX_88E  6
 
-static u8 get_right_chnl_for_iqk(u8 chnl)
-{
-	u8 place;
-	u8 channel_all[ODM_TARGET_CHNL_NUM_2G_5G] = {
-		36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64,
-		100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122,
-		124, 126, 128, 130, 132, 134, 136, 138, 140, 149, 151, 153,
-		155, 157, 159, 161, 163, 165
-	};
-
-	if (chnl > 14) {
-		for (place = 0; place < sizeof(channel_all); place++) {
-			if (channel_all[place] == chnl)
-				return ++place;
-		}
-	}
-	return 0;
-}
-
 void rtl88eu_dm_txpower_track_adjust(struct odm_dm_struct *dm_odm, u8 type,
 				     u8 *direction, u32 *out_write_val)
 {
@@ -1215,7 +1196,7 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 {
 	struct odm_dm_struct *dm_odm = &adapt->HalData->odmpriv;
 	s32 result[4][8];
-	u8 i, final, chn_index;
+	u8 i, final;
 	bool pathaok, pathbok;
 	s32 reg_e94, reg_e9c, reg_ea4, reg_eb4, reg_ebc, reg_ec4;
 	bool is12simular, is13simular, is23simular;
@@ -1324,12 +1305,10 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 				       (reg_ec4 == 0));
 	}
 
-	chn_index = get_right_chnl_for_iqk(adapt->HalData->CurrentChannel);
-
 	if (final < 4) {
 		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
-			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[chn_index].Value[0][i] = result[final][i];
-		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[chn_index].bIQKDone = true;
+			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][i] = result[final][i];
+		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].bIQKDone = true;
 	}
 
 	save_adda_registers(adapt, iqk_bb_reg_92c,
diff --git a/drivers/staging/rtl8188eu/include/phy.h b/drivers/staging/rtl8188eu/include/phy.h
index e99ac3910787..40901d6dcaf5 100644
--- a/drivers/staging/rtl8188eu/include/phy.h
+++ b/drivers/staging/rtl8188eu/include/phy.h
@@ -4,7 +4,6 @@
 #define IQK_DELAY_TIME_88E	    10
 #define index_mapping_NUM_88E	    15
 #define AVG_THERMAL_NUM_88E	    4
-#define ODM_TARGET_CHNL_NUM_2G_5G   59
 
 bool rtl88eu_phy_mac_config(struct adapter *adapt);
 bool rtl88eu_phy_rf_config(struct adapter *adapt);
-- 
2.19.0

