Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61161C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CFD20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CFD20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbeKLFsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49272 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729548AbeKLFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0000l9-NG; Sun, 11 Nov 2018 19:58:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001MP-Hx; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.928075477@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 005/366] staging: rtl8192ee: Fix misleading indentation
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

Fix the compiler warnings:

drivers/staging/rtl8192ee/rtl8192ee/hw.c:524:4: warning: this 'if' clause does not guard...
drivers/staging/rtl8192ee/rtl8192ee/hw.c:529:5: warning: this 'if' clause does not guard...
drivers/staging/rtl8192ee/btcoexist/halbtc8821a2ant.c:2338:2: warning: this 'else' clause does not guard...

by changing the indentation of these statements to match the upstream
code in drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c and
drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c.

These were fixed upstream when the driver was removed from staging and
re-added with some clean-ups.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/staging/rtl8192ee/rtl8192ee/hw.c
+++ b/drivers/staging/rtl8192ee/rtl8192ee/hw.c
@@ -523,17 +523,17 @@ void rtl92ee_set_hw_reg(struct ieee80211
 			fac = (1 << (fac + 2));
 			if (fac > 0xf)
 				fac = 0xf;
-				for (i = 0; i < 4; i++) {
+			for (i = 0; i < 4; i++) {
 				if ((reg[i] & 0xf0) > (fac << 4))
 					reg[i] = (reg[i] & 0x0f) | (fac << 4);
 				if ((reg[i] & 0x0f) > fac)
 					reg[i] = (reg[i] & 0xf0) | fac;
-					rtl_write_byte(rtlpriv,
-						       (REG_AGGLEN_LMT + i),
-						       reg[i]);
-				}
-				RT_TRACE(COMP_MLME, DBG_LOUD,
-					("Set HW_VAR_AMPDU_FACTOR:%#x\n", fac));
+				rtl_write_byte(rtlpriv,
+					       (REG_AGGLEN_LMT + i),
+					       reg[i]);
+			}
+			RT_TRACE(COMP_MLME, DBG_LOUD,
+				 ("Set HW_VAR_AMPDU_FACTOR:%#x\n", fac));
 		}
 		break; }
 	case HW_VAR_AC_PARAM:{
--- a/drivers/staging/rtl8192ee/btcoexist/halbtc8821a2ant.c
+++ b/drivers/staging/rtl8192ee/btcoexist/halbtc8821a2ant.c
@@ -2339,8 +2339,8 @@ static void halbtc8821a2ant_action_pan_e
 		halbtc8821a2ant_coex_table(btcoexist, NORMAL_EXEC, 0x55ff55ff,
 					   0x5aff5aff, 0xffff, 0x3);
 
-		if (BTC_WIFI_BW_HT40 == wifi_bw) {
-			/*  fw mechanism */
+	if (BTC_WIFI_BW_HT40 == wifi_bw) {
+		/*  fw mechanism */
 		if ((bt_rssi_state == BTC_RSSI_STATE_HIGH) ||
 		    (bt_rssi_state == BTC_RSSI_STATE_STAY_HIGH))
 			ps21a_tdma(btcoexist, NORMAL_EXEC, true, 1);

