Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE31C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3671125D1C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffX6y53Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3671125D1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965801AbeF0Rh1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:37:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35117 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965445AbeF0RhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:37:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id z137-v6so6397377wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iso5m+Cn76weigqPX5CSZ1I7GWctee9e5DkxLDyH9VA=;
        b=ffX6y53Z5YAAk83unBsmkkXuFamRHnqW7Bgt7aVaKiSCRMhfYF7g5g1cTh9QpwgB8M
         hDUSI0lfUNywoZtn8INUiatoQPAtHPiG8CTqxvQVcCUkwGnY2hfkhOrWHRGYfyA+guKA
         aIPbsO82SMRrLRi9p+tXAlzwBWgGRCW5P0wTGPT2Xq26VrXxW8n/K6g4JmBCNR3vNkWv
         N4EEqif7WuMccfdckrpCISR0skeW5JbD2wGqJVbRgzzDOjvFCuxOVA+uMwb00dnqNV7s
         EscX5CojKmK8HKlA9KqytD8sT5U3zqfKc5QVPkco8fWjN/dj8WE/+obxp0p9mso1t25Z
         yzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iso5m+Cn76weigqPX5CSZ1I7GWctee9e5DkxLDyH9VA=;
        b=of4eb6Yz/etxgOTThgLUoxSGuUARlzlt9ERy8M9Q7DKGf5TBAUklRblFly3o9JFw2E
         OXZ5ayrSDyIpLl7ulrZ9KKJO671uaYwbAOenHjQfTTO5eqi7F81LYq49U4P47uCeWEmU
         VrBPIcNRMBccNgR24WEzYSj65uYcMcXhI5bQ6kTL3ogI28lnN67nqkrJPZcigdmZvfm1
         X4YX90ATQq5+jf/u0EfWKn0bShUys2k0gtvZxPbLtj1DwcuOtAzb2Xv1FS4uVXADUEAk
         dQApqRTvoiNYYALfSDonGQWXg6QwPKRSemWroia3/Rrar3Avo6nqm9fTgrtKgdyVv8Cz
         UEwQ==
X-Gm-Message-State: APt69E2MCIR1YhGAw0XGzuSBlvdAM2b0RRZ9K6M84OCupWOoQasH1Z3C
        Nq3np2Zrb6kbX4dt7d8JGuo=
X-Google-Smtp-Source: AAOMgpdIzpljtMtw+joNidlaYX9gE04vc511oDOWDlZLwgIc2Vg4nphgf4cxdjroXXxsuBSzBNEn0A==
X-Received: by 2002:a1c:5d0e:: with SMTP id r14-v6mr5544014wmb.152.1530121041637;
        Wed, 27 Jun 2018 10:37:21 -0700 (PDT)
Received: from arch.localdomain (x4db2cd79.dyn.telefonica.de. [77.178.205.121])
        by smtp.gmail.com with ESMTPSA id g4-v6sm4473220wrq.32.2018.06.27.10.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 10:37:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 4/4] staging: rtl8723bs: use mac_pton() in rtw_macaddr_cfg()
Date:   Wed, 27 Jun 2018 19:36:49 +0200
Message-Id: <20180627173649.4105-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627173649.4105-1-straube.linux@gmail.com>
References: <20180627173649.4105-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the mac_pton() helper to convert the mac address string.

The functions key_char2num() and key_2char2num() are not used
anywhere else and can be removed.

This also has the benefit of validating the input since mac_pton()
returns false if the string is not valid.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 30 +++----------------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  3 --
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 8af4a89e632f..8e0025e1ff14 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1137,25 +1137,6 @@ ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
 
 }
 
-static u8 key_char2num(u8 ch);
-static u8 key_char2num(u8 ch)
-{
-		if ((ch >= '0') && (ch <= '9'))
-			return ch - '0';
-		else if ((ch >= 'a') && (ch <= 'f'))
-			return ch - 'a' + 10;
-		else if ((ch >= 'A') && (ch <= 'F'))
-			return ch - 'A' + 10;
-		else
-			return 0xff;
-}
-
-u8 key_2char2num(u8 hch, u8 lch);
-u8 key_2char2num(u8 hch, u8 lch)
-{
-		return ((key_char2num(hch) << 4) | key_char2num(lch));
-}
-
 void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 {
 	u8 mac[ETH_ALEN];
@@ -1166,14 +1147,11 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 	if (!mac_addr)
 		return;
 
-	if (rtw_initmac) {	/* 	Users specify the mac address */
-		int jj, kk;
-
-		for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3) {
-			mac[jj] = key_2char2num(rtw_initmac[kk], rtw_initmac[kk + 1]);
-		}
+	if (rtw_initmac && mac_pton(rtw_initmac, mac)) {
+		/* Users specify the mac address */
 		ether_addr_copy(mac_addr, mac);
-	} else{	/* 	Use the mac address stored in the Efuse */
+	} else {
+		/* Use the mac address stored in the Efuse */
 		ether_addr_copy(mac, mac_addr);
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 39502156f652..4eb51f45b387 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -32,9 +32,6 @@
 #define WEXT_CSCAN_HOME_DWELL_SECTION	'H'
 #define WEXT_CSCAN_TYPE_SECTION		'T'
 
-
-extern u8 key_2char2num(u8 hch, u8 lch);
-
 static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
 	6000000, 9000000, 12000000, 18000000, 24000000, 36000000, 48000000, 54000000};
 
-- 
2.18.0

