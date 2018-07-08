Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5F3C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0674D208A2
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzkKRtIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0674D208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933075AbeGHL60 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:58:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43430 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932892AbeGHL6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:58:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id u11-v6so11711401eds.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 04:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j5yAJhHA+/BeBga6do7mOnf+LBCETVO3sFZQRFsMLaM=;
        b=TzkKRtIxgD6ud6yma22GXWCK93r1+ixcwPN0tNc+behU5hv5bbMB3eOIFFzX/brKtO
         x78Xgpxvjz50Bgw9nZMp2COv9eo9bNmJXLYD2zYHhyNJEGViCrqGOVDufRnGLfpbYHvX
         msgCIMjWYaMENCAlagKRJWWAzc+QNbMEufu3mAPJ6IayA7PKdSF7jBxifPjCTjWyzzA5
         sbDnWNpaT3a2l+AdtjxvYgAGcckUHmQ2xNnAmI+NEpaVZidRgDQpf/j56JubDR/EOwxW
         Gz+s6LK1n22cxqMe6ScQYPIcmvW7f2W9K93FugS+Ok786EhmF3GPF5SVmiO8nbXhZWe3
         gY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j5yAJhHA+/BeBga6do7mOnf+LBCETVO3sFZQRFsMLaM=;
        b=KhQYkj9GWVny4JRFcVgQ0Y0pO5L1huCJP2oo+6iSrGQ8s40yGKGYDXui9b2NUHqkPa
         9IZ1Xeb6nYCWxExeK8mIxL6l7EvsrvGqx7Wt6m1JDw6oKBM2sLJKDzWWAAM2O+UF8ZlE
         KYSGVPQnPtCRq3QfHz+I6Eo+EKxJ3LIwH9+h4yScxiZgTKlj0pdshsw7cdany/VzgEJX
         nO4pPhIh+ddDSeVBf3ovyprKxSTsEtkqykTmwgfHcfvECuPfiMa2n5QD7LFrKePk8mdc
         UUPaiPP2qWbQxa6r2l/QvwLQCbXHiLzU7O0XCWabFMjeiH6WeMmmR75tGKD7CNRtWroa
         q3IA==
X-Gm-Message-State: APt69E38RsdJOGr5avUsz5KzS9ebDfMAdpBuYiAmxAz6evIFXdRlq0vn
        HzDnKYy7Cy7iXfbfE4tuHYY=
X-Google-Smtp-Source: AAOMgpfLjfVo/06BfqKCDh99SLxOymEli6V5djuPdJJz0ke3PQIzK6rvBgj5qJJSK7n7vHfMt6HyxQ==
X-Received: by 2002:aa7:d786:: with SMTP id s6-v6mr15037694edq.228.1531051103756;
        Sun, 08 Jul 2018 04:58:23 -0700 (PDT)
Received: from arch.localdomain (x4db1e3f8.dyn.telefonica.de. [77.177.227.248])
        by smtp.gmail.com with ESMTPSA id k15-v6sm5355134edr.3.2018.07.08.04.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 04:58:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: refactor rtw_macaddr_cfg()
Date:   Sun,  8 Jul 2018 13:58:11 +0200
Message-Id: <20180708115812.22769-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ether_addr_copy() instead of memcpy() to copy the mac address.

Using is_broadcast_ether_addr() and is_zero_ether_addr() instead of
testing each byte of the mac[] array for 0xff and 0x00 shortens the
code and improves readability.

Instead of a fixed default mac address use a random one to reduce the
likelihood of mac address collision.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_ieee80211.c    | 20 +++++--------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 711ebb0ad640..e6dff44e00fd 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -917,25 +917,15 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 
 	if (rtw_initmac && mac_pton(rtw_initmac, mac)) {
 		/* Users specify the mac address */
-		memcpy(mac_addr, mac, ETH_ALEN);
+		ether_addr_copy(mac_addr, mac);
 	} else {
 		/* Use the mac address stored in the Efuse */
-		memcpy(mac, mac_addr, ETH_ALEN);
+		ether_addr_copy(mac, mac_addr);
 	}
 
-	if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
-	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
-	    ((mac[0] == 0x0) && (mac[1] == 0x0) && (mac[2] == 0x0) &&
-	     (mac[3] == 0x0) && (mac[4] == 0x0) && (mac[5] == 0x0))) {
-		mac[0] = 0x00;
-		mac[1] = 0xe0;
-		mac[2] = 0x4c;
-		mac[3] = 0x87;
-		mac[4] = 0x00;
-		mac[5] = 0x00;
-		/*  use default mac address */
-		memcpy(mac_addr, mac, ETH_ALEN);
-		DBG_88E("MAC Address from efuse error, assign default one !!!\n");
+	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
+		eth_random_addr(mac_addr);
+		DBG_88E("MAC Address from efuse error, assign random one !!!\n");
 	}
 
 	DBG_88E("%s MAC Address  = %pM\n", __func__, (mac_addr));
-- 
2.18.0

