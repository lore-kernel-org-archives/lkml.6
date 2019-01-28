Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEBCC282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE27B21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLjiPCpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfA1JwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:52:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41999 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfA1JwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:52:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so17239979wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 01:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7afVye0rr0CiH0qOIcmll7EhY3vJvfxLzf4WhxQijcA=;
        b=kLjiPCpX2GqnUMKiFG842FaOBY2FEWXIY6UKriDJUivRHAdiTSvf77UDX9j47ERNL6
         R+jnMRk8vqwvLgPb0PySigQ4qLV+lxaHEUkucQ+nx0ZBMy0eekdeyCXxkE3YMTVsOLhd
         6jKo6z6lVwBEDdNdfXg9viLwUX6REI1fzD4ukuiGqVuwHEq++diXy2zNsd+fOXSRHwl+
         hHWIPvUFJCFoTN9uSR7aZm5iHCdnk+SBMP0oVa8HBp+MAhbGcxAYgYjRG8dmDWgH/wEC
         seU6E81RuR+i3pMOCPBTSiVJOCVwcEtwygvEW3NhiXc04Tk4WUZPlfMBWX5pGyw0G5iX
         Ik8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7afVye0rr0CiH0qOIcmll7EhY3vJvfxLzf4WhxQijcA=;
        b=eJUYmwu62I8N4muMl5mQbEZzrPdGqSSJ1m3r3/5yjgNtK4BstjfZINYOxML40ZEhj/
         6CxtRnZZaJGfz7y86hZXJ3owRNB0TwMPczYVx+Lv8chOFx2ZGxjX69tNzB2xiRrb+knP
         kVfzDJeTJZM7RSiHOx38/ho81enutZRaLqTaiQXJvNQtI4radx3KQ34RarxB9Zq6TD6E
         woGu96J5JPOnDvSsWJfYtddY5cl67yvSA0xo4lsmwHrZd7rtWBeNwlughSYQOTfJjlLL
         TVOogZIhYI/QIT6tV43oRpF8xmK/0Hk4sH26QxEEyyiyDpkl4UVJbWUCcG8I2KTeIlOb
         ayvQ==
X-Gm-Message-State: AJcUukcL4x4GyyXA83zTUWSkvCSAtv00xo/BsIpvexL//NsKU4VF7bFg
        LIlN+RN4Z3QQg70WSD/SPn52E+8G
X-Google-Smtp-Source: ALg8bN6fA4709lic841hy74K5tckhTJWImaglV+81RuG2md/C28GAel3Hn6WsgwR+MrqrW6iaXmg5Q==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr21497070wro.261.1548669125186;
        Mon, 28 Jan 2019 01:52:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id a18sm139023711wrp.13.2019.01.28.01.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 01:52:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 6/6] staging: rtl8188eu: refactor rtw_reset_securitypriv()
Date:   Mon, 28 Jan 2019 10:51:37 +0100
Message-Id: <20190128095137.26815-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128095137.26815-1-straube.linux@gmail.com>
References: <20190128095137.26815-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the declaration of 'psec_priv' out of the else path and use it
in the if path as well to improve readability. Also clears line over
80 characters checkpatch warnings.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index caba3fe0250c..9db11b16cb93 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -39,34 +39,35 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 	u8 backup_index;
 	u8 backup_counter;
 	u32 backup_time;
+	struct security_priv *psec_priv = &adapter->securitypriv;
 
-	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
+	if (psec_priv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 		/* 802.1x
 		 * We have to backup the PMK information for WiFi PMK Caching
 		 * test item. Backup the btkip_countermeasure information. When
 		 * the countermeasure is trigger, the driver have to disconnect
 		 * with AP for 60 seconds.
 		 */
-		memcpy(backup_pmkid, adapter->securitypriv.PMKIDList, sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
-		backup_index = adapter->securitypriv.PMKIDIndex;
-		backup_counter = adapter->securitypriv.btkip_countermeasure;
-		backup_time = adapter->securitypriv.btkip_countermeasure_time;
-		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
+		memcpy(backup_pmkid, psec_priv->PMKIDList,
+		       sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
+		backup_index = psec_priv->PMKIDIndex;
+		backup_counter = psec_priv->btkip_countermeasure;
+		backup_time = psec_priv->btkip_countermeasure_time;
+
+		memset(psec_priv, 0, sizeof(*psec_priv));
 
 		/* Restore the PMK information to securitypriv structure
 		 * for the following connection.
 		 */
-		memcpy(adapter->securitypriv.PMKIDList, backup_pmkid,
+		memcpy(psec_priv->PMKIDList, backup_pmkid,
 		       sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
-		adapter->securitypriv.PMKIDIndex = backup_index;
-		adapter->securitypriv.btkip_countermeasure = backup_counter;
-		adapter->securitypriv.btkip_countermeasure_time = backup_time;
-		adapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
-		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
+		psec_priv->PMKIDIndex = backup_index;
+		psec_priv->btkip_countermeasure = backup_counter;
+		psec_priv->btkip_countermeasure_time = backup_time;
+		psec_priv->ndisauthtype = Ndis802_11AuthModeOpen;
+		psec_priv->ndisencryptstatus = Ndis802_11WEPDisabled;
 	} else {
 		/* reset values in securitypriv */
-		struct security_priv *psec_priv = &adapter->securitypriv;
-
 		psec_priv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		psec_priv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
 		psec_priv->dot11PrivacyKeyIndex = 0;
-- 
2.20.1

