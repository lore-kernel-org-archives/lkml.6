Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2A720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc4hKmEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2A720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLJJw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:52:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34940 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJJw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:52:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so10460840wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 01:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXDoZ8jE9MyBS+p0JjDhP1XU6R4Op0vx+0PGWWELvaM=;
        b=Gc4hKmEUs0CRnzr5VWMRLHMMEmddCO5oXV/HdOujbr+ukX4ZAq1RxujrLYdq2WuUVp
         dcJsp0J1IIOnUbqam2rJJLe8s0KmHcrFKAGvYqTbRSNSOSt7UgaiWMx0x2YiNnAbBHzS
         qdxG8WP73rRPVRGNp2uPxc2bE8XBVFN9WWYyN168kSO/tpL1K1LoMZNMUqrekzjxwH33
         3RQEqc7cvfKkbbnoKeJi/j2xh+NJdBe7pRQ+tI7SigP2v9g1MIzy5WFgapa/S7ysKKQ5
         2aXtWpo8wZu+qznvejncl6bVTRIvhtbXu4yW6ZxCUnSOJIMh7YCaP5vOobY4uRWtuG4F
         cvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXDoZ8jE9MyBS+p0JjDhP1XU6R4Op0vx+0PGWWELvaM=;
        b=qUMawZDAsq0cNcXLZyt3Hg4RbE6KDV9DroBqbrFnkKgCrxxLWE841KQBj9CPtNwzmx
         5GAzr5/Cx9PXMTnuZU/qPF8RC48IL3DukPP3nzxyG6ySV1n8QX2xswnvQtVoh0/sHFJA
         ylEGo+dw/oJhZuiXp69Ig/UUDM+I2tlfUkWCPtZbR7aNSVE19Y8jSg/W0UOGrvPWCy3n
         tbkkiq5mkj8S7qx6EW71oyJHm47WIneuJR0ShyNqm8ErBZb2MQXY+8DkVQXU0pxf3jn3
         lU8hM7WcBQRgFl6ABYKXP1nnP+kA7VNjFSlBraNh8QFv+fPiyf250NfGys8QwdS5ncet
         9/lg==
X-Gm-Message-State: AA+aEWYx3qiQ2qt00A3Xx/a2jPHT7NYknHc0Oh73hmdb22Ur8xVUOU4t
        v1yXrYIU9Vn/aiPAFEpmfbM=
X-Google-Smtp-Source: AFSGD/X3AefCLOoH++WVeM+qA2VCbw6r9mZ1XQp3EHBp42s707bNwxPr0GxTdvIUgxO4PntFtOAWWg==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr10346711wmc.116.1544435545425;
        Mon, 10 Dec 2018 01:52:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id q12sm10346003wrx.31.2018.12.10.01.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 01:52:24 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: remove dead code, rtw_port_switch_chk()
Date:   Mon, 10 Dec 2018 10:52:01 +0100
Message-Id: <20181210095202.17599-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_port_switch_chk() returns always false.
Remove the function and related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 34 -------------------
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  1 -
 2 files changed, 35 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 8445d516c93d..35003d8d9ba4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5334,13 +5334,6 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	return;
 }
 
-
-bool rtw_port_switch_chk(struct adapter *adapter)
-{
-	bool switch_needed = false;
-	return switch_needed;
-}
-
 /****************************************************************************
 
 Following are the event callback functions
@@ -5414,7 +5407,6 @@ static void rtw_mlmeext_disconnect(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
-	u8 state_backup = (pmlmeinfo->state&0x03);
 
 	/* set_opmode_cmd(padapter, infra_client_with_mlme); */
 
@@ -5440,17 +5432,6 @@ static void rtw_mlmeext_disconnect(struct adapter *padapter)
 
 	pmlmeinfo->state = WIFI_FW_NULL_STATE;
 
-	if (state_backup == WIFI_FW_STATION_STATE) {
-		if (rtw_port_switch_chk(padapter)) {
-			rtw_hal_set_hwreg(padapter, HW_VAR_PORT_SWITCH, NULL);
-			{
-				struct adapter *port0_iface = dvobj_get_port0_adapter(adapter_to_dvobj(padapter));
-				if (port0_iface)
-					rtw_lps_ctrl_wk_cmd(port0_iface, LPS_CTRL_CONNECT, 0);
-			}
-		}
-	}
-
 	/* switch to the 20M Hz mode after disconnect */
 	pmlmeext->cur_bwmode = CHANNEL_WIDTH_20;
 	pmlmeext->cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
@@ -5530,9 +5511,6 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 		rtw_hal_macid_wakeup(padapter, psta->mac_id);
 	}
 
-	if (rtw_port_switch_chk(padapter))
-		rtw_hal_set_hwreg(padapter, HW_VAR_PORT_SWITCH, NULL);
-
 	join_type = 2;
 	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
@@ -6087,18 +6065,6 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
 		rtw_auto_ap_start_beacon(padapter);
 #endif
 
-	if (rtw_port_switch_chk(padapter)) {
-		rtw_hal_set_hwreg(padapter, HW_VAR_PORT_SWITCH, NULL);
-
-		if (psetop->mode == Ndis802_11APMode)
-			adapter_to_pwrctl(padapter)->fw_psmode_iface_id = 0xff; /* ap mode won't dowload rsvd pages */
-		else if (psetop->mode == Ndis802_11Infrastructure) {
-			struct adapter *port0_iface = dvobj_get_port0_adapter(adapter_to_dvobj(padapter));
-			if (port0_iface)
-				rtw_lps_ctrl_wk_cmd(port0_iface, LPS_CTRL_CONNECT, 0);
-		}
-	}
-
 	if (psetop->mode == Ndis802_11APMode) {
 		/*  Do this after port switch to */
 		/*  prevent from downloading rsvd page to wrong port */
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 4c3141882143..f6eabad4bbe0 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -648,7 +648,6 @@ void report_survey_event(struct adapter *padapter, union recv_frame *precv_frame
 void report_surveydone_event(struct adapter *padapter);
 void report_del_sta_event(struct adapter *padapter, unsigned char* MacAddr, unsigned short reason);
 void report_add_sta_event(struct adapter *padapter, unsigned char* MacAddr, int cam_idx);
-bool rtw_port_switch_chk(struct adapter *adapter);
 void report_wmm_edca_update(struct adapter *padapter);
 
 void beacon_timing_control(struct adapter *padapter);
-- 
2.19.2

