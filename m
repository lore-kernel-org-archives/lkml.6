Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97414C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E8321736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzk2CgmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfA1JwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:52:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52381 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfA1JwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:52:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so13231291wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 01:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jN4kC6D66STCGrqwm0FrKe6NuL8FmG5CO4NjzuSPwQ=;
        b=Bzk2CgmQnx7Mslz23B9BkJ8EizKlsVtq9WrW8HD0PDE+MEcPRX8nAw45YxOsPl7NaP
         B8c21Axc5/wVd1w8w9Ma4j6G+9hgYA2Bb6EMB5y5DQK5GEnxQZzcw8ck2dYEmouJvL5c
         IDtI12vfReciKZDqFrltdKd+eyu1U8ELiabjD1I6GIzi2gYDcEnD08vDWZKIdvkZwi4H
         vfju8CfPMN/YdN15CJ7p2mRW/gANXuYV1mpJpEljZAMYRb2pQSd45czVS8LCEJy13adJ
         BqA6i46GhRVfnLNNZ6e5P3qY6gyoOcOIGYiuWpMeVFR39rpmEY3h54nqe1zuikgDy/b9
         N3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jN4kC6D66STCGrqwm0FrKe6NuL8FmG5CO4NjzuSPwQ=;
        b=FOtbOQ4Gk9FvVnat4dGMhuIn8L/anjiaOlWmzMdwm1lw7hs9UQ2+v4ptgbyoWFVEKq
         G3NKqKlW6NLYCvlatbrp8b3rLCXNWdqzj0bN1HlRVBkFvIsI2YfM2pycIh0/LFWpgAH6
         M+V3s23gAF1gGb0huhUHkLTBFJm+5q/8vPVzPc2h/Fw4G2EM8pG4WzPbbzmahYYEYM/n
         5Cto4i2OdighOztxEWs2RU2jEADftVAkGp3QWmpg6MebS+a0xkAdn8yRBQfTwfAo33Be
         5Ii9BlthjIG/RG1zooEugzOkClpIvSoT1icv/Rq7yhdPPPl9sMnA3hx1/vMED+8imutI
         77tw==
X-Gm-Message-State: AJcUukcpheEufg9POwbr3eXBoI03dNU4dP2QpkbXATiOY4m51iTHKPC5
        iHubgKAbgND/NJ4OaJQyEcs=
X-Google-Smtp-Source: AHgI3IYWTCLHFBsSmzpufzs/1LNzS8fyDI/lDK97u69HjNcy/EitaDTHYvc/i2bZrd2NleDHCE7EIQ==
X-Received: by 2002:a1c:488b:: with SMTP id v133mr6832877wma.31.1548669119036;
        Mon, 28 Jan 2019 01:51:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id a18sm139023711wrp.13.2019.01.28.01.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 01:51:58 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: rtl8188eu: cleanup comments in mlme_linux.c
Date:   Mon, 28 Jan 2019 10:51:32 +0100
Message-Id: <20190128095137.26815-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup comments to avoid lines over 80 characters
and follow kernel style for block comments.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index 2bc49d074ce4..0321f1d45809 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -41,17 +41,21 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 	u32	backup_time = 0;
 
 	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
-		/* 802.1x */
-		/*  We have to backup the PMK information for WiFi PMK Caching test item. */
-		/*  Backup the btkip_countermeasure information. */
-		/*  When the countermeasure is trigger, the driver have to disconnect with AP for 60 seconds. */
+		/* 802.1x
+		 * We have to backup the PMK information for WiFi PMK Caching
+		 * test item. Backup the btkip_countermeasure information. When
+		 * the countermeasure is trigger, the driver have to disconnect
+		 * with AP for 60 seconds.
+		 */
 		memcpy(&backup_pmkid[0], &adapter->securitypriv.PMKIDList[0], sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
 		backup_index = adapter->securitypriv.PMKIDIndex;
 		backup_counter = adapter->securitypriv.btkip_countermeasure;
 		backup_time = adapter->securitypriv.btkip_countermeasure_time;
 		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
 
-		/*  Restore the PMK information to securitypriv structure for the following connection. */
+		/* Restore the PMK information to securitypriv structure
+		 * for the following connection.
+		 */
 		memcpy(&adapter->securitypriv.PMKIDList[0], &backup_pmkid[0],
 		       sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
 		adapter->securitypriv.PMKIDIndex = backup_index;
@@ -75,7 +79,8 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 
 void rtw_os_indicate_disconnect(struct adapter *adapter)
 {
-	netif_carrier_off(adapter->pnetdev); /*  Do it first for tx broadcast pkt after disconnection issue! */
+	/* Do it first for tx broadcast pkt after disconnection issue! */
+	netif_carrier_off(adapter->pnetdev);
 	rtw_indicate_wx_disassoc_event(adapter);
 	rtw_reset_securitypriv(adapter);
 }
-- 
2.20.1

