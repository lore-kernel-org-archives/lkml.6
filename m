Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0AEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1653218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFlLaJQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbeLRSf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43756 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbeLRSf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so16940489wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sUGsNgd4dozXoP8kuT8p5veRRZUA6RCm5Lvxkb5vuEo=;
        b=tFlLaJQDTj4lOTTrGyZ2jofx4vm3if4kory0IVst+qcdiVcjH/4VqJSFXv3XMxzUgI
         2Z4kYZO3Wpt64RrAJJJmZGO0fRKAI7ztBjSWIQ/HUk47ZuMWsHbzxSfscMy9R8ahOuVK
         1iWBE7lWnzPhRoxI7J/lnmMWviK/m6dqEQqhfOkgw15IqVataiUY27Y34l9F0JvEyQqP
         dAYSZlaIG+1ZWARjMLElX06MN+qVnH1gHr39FKkCiaVS9W8ykKNM9Cn+n2fB36C0dFlg
         c7U1LAzfz/+/2phZWo4kpYoJys8gaemT94SzgzgWo1OuMeZfgOTiN4WECUCsuECPY1yy
         DWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sUGsNgd4dozXoP8kuT8p5veRRZUA6RCm5Lvxkb5vuEo=;
        b=NhQ9mU6UJrQW9/FM0QLcBu64AlXkUWjPo05FaFHqeXZKT8g+posyi6jziiHk7BEBb8
         qYKpg1HIzkL1fstjqE897X48yd0x8cxpKnBV3HJVLDsKc1NS/WZO5DQiW+gPQnuqZ1sK
         KpQ8spCZYjJpszJEluQLLNnAUBK4Uf/qiIRthrem7mvMeb/dyQbAqPvUYc4t5ixThX0F
         oCbT/0owKWy79ZYPTUVGRUVh/j2MtsxEDMZXRHKrVu8D5Ywy3v+FZNORtI1dp4eJ4/wr
         XcrUZVyo042IkU/gVoMVVQekWTALOInwQCKH1PERyPpPE9fMWubyc5UGA5Yu7zTuWv3B
         7lvA==
X-Gm-Message-State: AA+aEWZmXK4SXVeFQeM6XRp3OFJ8my8cqCGy1WzHpuvgV2g21fTSUKfH
        H7mxBOD2z5NXC3jVIak1M0Q=
X-Google-Smtp-Source: AFSGD/UoLYDrurt+qFVK9xw7vMVJ659IUSBzy26NhMRph6A8EaylAboLaIpYzLjuoNHvaDgfWCewTw==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr15261018wrx.79.1545158124603;
        Tue, 18 Dec 2018 10:35:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:23 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 17/17] staging: rtl8188eu: cleanup brace coding style issues
Date:   Tue, 18 Dec 2018 19:34:51 +0100
Message-Id: <20181218183451.18692-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup brace coding style issues reported by checkpatch.

ERROR: space required before the open brace '{'
WARNING: braces {} are not necessary for single statement blocks
CHECK: Unbalanced braces around else statement

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c          | 3 +--
 drivers/staging/rtl8188eu/core/rtw_security.c     | 4 ++--
 drivers/staging/rtl8188eu/hal/phy.c               | 4 ++--
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c      | 7 +++----
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 3 +--
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index f9cdd1da8add..407f65cf7150 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -214,9 +214,8 @@ int rtw_cmd_thread(void *context)
 	pcmdpriv->cmdthd_running = false;
 
 	/*  free all cmd_obj resources */
-	while ((pcmd = rtw_dequeue_cmd(&pcmdpriv->cmd_queue))) {
+	while ((pcmd = rtw_dequeue_cmd(&pcmdpriv->cmd_queue)))
 		rtw_free_cmd_obj(pcmd);
-	}
 
 	complete(&pcmdpriv->terminate_cmdthread_comp);
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index f7407632e80b..364d6ea14bf8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -1259,7 +1259,7 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 
 					aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
-				} else{
+				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 
 					aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
@@ -1267,7 +1267,7 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 					pframe = (u8 *)round_up((size_t)(pframe), 8);
 				}
 			}
-		} else{
+		} else {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n", __func__));
 			res = _FAIL;
 		}
diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 051cfbab78b1..51c40abfafaa 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -437,9 +437,9 @@ void rtl88eu_dm_txpower_tracking_callback_thermalmeter(struct adapter *adapt)
 			thermal_val = (u8)(thermal_avg / thermal_avg_count);
 
 		if (dm_odm->RFCalibrateInfo.bDoneTxpower &&
-			!dm_odm->RFCalibrateInfo.bReloadtxpowerindex)
+			!dm_odm->RFCalibrateInfo.bReloadtxpowerindex) {
 			delta = abs(thermal_val - dm_odm->RFCalibrateInfo.ThermalValue);
-		else {
+		} else {
 			delta = abs(thermal_val - hal_data->EEPROMThermalMeter);
 			if (dm_odm->RFCalibrateInfo.bReloadtxpowerindex) {
 				dm_odm->RFCalibrateInfo.bReloadtxpowerindex = false;
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index b832bbf202a5..7022221136f6 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -90,15 +90,14 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 
 			/* Write Ext command */
 			msgbox_ex_addr = REG_HMEBOX_EXT_0 + (h2c_box_num * RTL88E_EX_MESSAGE_BOX_SIZE);
-			for (cmd_idx = 0; cmd_idx < ext_cmd_len; cmd_idx++) {
+			for (cmd_idx = 0; cmd_idx < ext_cmd_len; cmd_idx++)
 				usb_write8(adapt, msgbox_ex_addr+cmd_idx, *((u8 *)(&h2c_cmd_ex)+cmd_idx));
-			}
 		}
 		/*  Write command */
 		msgbox_addr = REG_HMEBOX_0 + (h2c_box_num * RTL88E_MESSAGE_BOX_SIZE);
-		for (cmd_idx = 0; cmd_idx < RTL88E_MESSAGE_BOX_SIZE; cmd_idx++) {
+		for (cmd_idx = 0; cmd_idx < RTL88E_MESSAGE_BOX_SIZE; cmd_idx++)
 			usb_write8(adapt, msgbox_addr+cmd_idx, *((u8 *)(&h2c_cmd)+cmd_idx));
-		}
+
 		bcmd_down = true;
 
 		adapt->HalData->LastHMEBoxNum =
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index d5a1cf92ca6f..086f98d38cba 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -232,9 +232,8 @@ s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 
 		/*  Let last entry point to the start entry of ring buffer */
 		status = _LLTWrite(padapter, Last_Entry_Of_TxPktBuf, txpktbuf_bndy);
-		if (status != _SUCCESS) {
+		if (status != _SUCCESS)
 			return status;
-		}
 	}
 
 	return status;
-- 
2.20.1

