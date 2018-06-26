Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5984BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C2621533
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrc5/ctc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C2621533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752977AbeFZIPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:15:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40951 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeFZIO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:14:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so746740wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d8UICC04ukq4QPdsvTBQtBxjQYdEIidT3Jm5ctQQFY4=;
        b=Vrc5/ctc7WrdcJCTTs3AKOCATePA2NufcX2hi7Qf/cidVQu+sUQdpfW+V7b1KmPVtn
         BiaevrtN+KWAcQm7FKDxF4sooDvNZ8GRMmAjgZ1FfaQ1yPnTQJ22/iY3200b0BNp5SnT
         prQ+nGrvQpF2EtIgkzFxuB0zJlbWsLKWnvrDtZzHC9BhKgUMob07+T0Ds+M0RiKRkmGT
         bn4yVe3kL0fYA16gXGfIj28YDpalMZHFDgOvXic3Xwz05HlWqSQkcnGPYKnP9kn+zO+Q
         y2jvYxufn1RSq8PDgbDJDV35molfViVEuUa2GISHWcAWqoqPvj1SIOUTAuA874qCdETL
         AepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d8UICC04ukq4QPdsvTBQtBxjQYdEIidT3Jm5ctQQFY4=;
        b=ZiPqo+E1B+3LP16HsLxTGpeNjeM4uXXS9oeWOp+Fjup4SVjHLbDN2SpeutkmJ2rTaX
         RI4lARCfUBv51VKFFN+ozvRPdg/uD8bxkOXen1m8Af3LnDZudtF2c93JPycpq7CrgPOf
         CwximdYNC1TU/hfGMjCHyJEzgAnIKMJTcHtCe2Rv2GlEJHRGLr69laYUlg2jFvbpUZkH
         vj3iAbH+88/+xZVAzGlxR2PNbABm18LxgfON1WxfX9MFR+ExyVylH0Lq+s5F0xQ1qOwj
         FIg7I0CEsnTaCxS5IsXuUjquTV4ZqxHiOfYWyC4hghHXsfY5RwJqKeRgLYdQorL4HO0B
         Npgw==
X-Gm-Message-State: APt69E2k/aaR6ehdvMFapniXD0lOzkA578Qx8YmwWNClrXbhZx7Sh5Ha
        wD/26oYmdP0gOUhQj3ggFAw=
X-Google-Smtp-Source: AAOMgpcKKCtn8ofxLVm6w7SaVEc1NZPwuIBBu+nKkvjzPL8GhaHdYxRAs0UTpYl9+RwQofckunO5LA==
X-Received: by 2002:a1c:c90:: with SMTP id 138-v6mr716688wmm.110.1530000897341;
        Tue, 26 Jun 2018 01:14:57 -0700 (PDT)
Received: from arch.localdomain (x590c812a.dyn.telefonica.de. [89.12.129.42])
        by smtp.gmail.com with ESMTPSA id 74-v6sm1946151wmt.31.2018.06.26.01.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:14:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 4/4] staging: rtl8723bs: use mac_pton() in rtw_macaddr_cfg()
Date:   Tue, 26 Jun 2018 10:14:09 +0200
Message-Id: <20180626081409.9518-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626081409.9518-1-straube.linux@gmail.com>
References: <20180626081409.9518-1-straube.linux@gmail.com>
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

