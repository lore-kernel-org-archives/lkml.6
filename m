Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47305C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC27205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgmcQxOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC27205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbeGYUva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:51:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53206 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbeGYUv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:51:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so7140426wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jrERPRFOhzRqnfg7ytTZ640w5+sEOrDFWYpGOjEtTDU=;
        b=TgmcQxOOreQrQxemxbDPCdxfIgd2unjeECGCciwAVan4nKMQx1DXjOwZsgexAA6g84
         FpL6RqFQ0JS0NYGftqcAp4dUMECW+13w6uRcPXs6ayeuHwq9jJ9zzTWOJstkcq2LTpDM
         baSu+HtpxGDYPt91xFm33gr8TGsflwFSsxx4U7Fqa+EF1la50yssxOrf0OoCYvFmiXws
         PsR86q2NNsnGOx63AGNSwI2DS8IB0NSni5bOndjIy5mGjVLaz1/Y95Z9rVggkdyFFrDU
         S+LY/wx0cSIj02WcpcjxmX5HBACghM2bcrtJec1aEzx0kqV98SpKDcBpj3pLh3ldCmdY
         vpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jrERPRFOhzRqnfg7ytTZ640w5+sEOrDFWYpGOjEtTDU=;
        b=uB/eZ2uFBnlcuxDRZZCoJV49U8KbXAEU6irHUUZp+plmI8uhYuGRsaSgO9XTE7ly4N
         DwwQ6oZucJYrDmRDMzejdmDWwIg80pGEVrExKw+2z+ELFYprFEENCCNAn+2iccdE5DcI
         cchdB2O7CoGt8msGcFYqIqZujzxYXgRaTTWXXzh3JIYct7gvnI8naZFV37fSrz+BSbZh
         oLTrrlDQ3to7NtRsW9ebr67rT4KqW3bRvsptQKhczvv3gzT8Obb6vQdeTywrPHXrZK5r
         S4KS0NmhhHewJ1k9f8FRWi03JlPWzuefw1E3mq5gw8y5GIxbPyYXw2acmE1K52aa/KEr
         0Ulw==
X-Gm-Message-State: AOUpUlEGTu6Dmxfjzzsw+zTzCqp6H9k/CNx0W/65sTx+cjQM3DzWKR6o
        63azXXexRQ3IDV5WRS9T3wk=
X-Google-Smtp-Source: AAOMgpdUd79mB6OlTZyMMcBEzST5aRzKBwD16SIQMxFHudG4mGNT/pp//tT7jR0qHVRAwf4hV4pRQg==
X-Received: by 2002:a1c:228b:: with SMTP id i133-v6mr5724873wmi.69.1532547501696;
        Wed, 25 Jul 2018 12:38:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t186-v6sm3752729wmf.14.2018.07.25.12.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 12:38:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: remove unused CAM_empty_entry()
Date:   Wed, 25 Jul 2018 21:37:56 +0200
Message-Id: <20180725193758.1219-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725193758.1219-1-straube.linux@gmail.com>
References: <20180725193758.1219-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function CAM_empty_entry() is never used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c   | 5 -----
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 5c4f3f8d013f..474aa9dcf39d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -434,11 +434,6 @@ unsigned int decide_wait_for_beacon_timeout(unsigned int bcn_interval)
 		return bcn_interval << 2;
 }
 
-void CAM_empty_entry(struct adapter *Adapter, u8 ucIndex)
-{
-	rtw_hal_set_hwreg(Adapter, HW_VAR_CAM_EMPTY_ENTRY, (u8 *)(&ucIndex));
-}
-
 void invalidate_cam_all(struct adapter *padapter)
 {
 	rtw_hal_set_hwreg(padapter, HW_VAR_CAM_INVALID_ALL, NULL);
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 8ecf43d03278..43a3c5009ad0 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -487,7 +487,6 @@ void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key);
 void clear_cam_entry(struct adapter *padapter, u8 entry);
 
 void invalidate_cam_all(struct adapter *padapter);
-void CAM_empty_entry(struct adapter *Adapter, u8 ucIndex);
 
 int allocate_fw_sta_entry(struct adapter *padapter);
 void flush_all_cam_entry(struct adapter *padapter);
-- 
2.18.0

