Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA963C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F2925C31
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFxEgyRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F2925C31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934935AbeFYPNV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:13:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35386 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934842AbeFYPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:13:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id c13-v6so4120198wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TYpG9NpCaSglsGe53iw6pQH3ZoCrlOcilczhR5AKAVI=;
        b=NFxEgyRUQs9OJhzZjVDW7c/YIDYrKM8evibP7A8CVo/dFznotAVOztrZJYm5nRKeWe
         BWC5xb7YPiRAYDfoBY4mevOPu7MATg6ZrgQVdgXdGJAM/O8ymg25bMDW4sCyeZlwPjpm
         eagyrrOgj0Wxy766QYtEpLoTFMPbl+IraxxptN7lVz08xmmSbtfW2oFZMfin/cHwELMa
         mec8hEw2/IqkNzSlFjPHE5tD8LoYf6ucjY1vIe4VFBfTGUbFv4vWeXV3BHFcPz3EBmAh
         A267HT0H+glyIMdigHQU8eJTXCdh30CgmOsykj37ckiAy4/bgsgSnQ0lQF3AI7hR8jO1
         Tzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TYpG9NpCaSglsGe53iw6pQH3ZoCrlOcilczhR5AKAVI=;
        b=r7xzzI4EOWbpvZVl6sFNPXRkPafhK4GOzH1khebcKPFm6Z/BFTGFtRF/hqnvixHQgq
         Q/iI5XUArNI/dsgzV5QLMmSLV/NGuCOJgurZXxnXjBAvUqac6KHhQ++Y4N2GN9//WYdl
         0+XVtoUhYqODN5NKwzNhIh93tpIaL5pCDbvT9i9KDZHr9OV0ookVBCgYf9EdZfWb2nHL
         T9UKsOmyGhREzFkZHbxz9A5tCe/HWfYFdKS4eWBOWi4mqs5nuNTKkzPr4SDaiifXoiry
         Nf77jycI4nVy7dnR+wzGsjI/rZUHhyFr55EzFXSll41B5epVssK1m8aDSrUHU3XvYDzh
         74NA==
X-Gm-Message-State: APt69E2ymbaWG9iqwikD5RZ0skBsDAc80OrQR5RY7EoOo1zg60mYxuqc
        6cDpdmEOB3LQUTaO/CAYJH8=
X-Google-Smtp-Source: AAOMgpf5185zANXh8WVMrZCjX+VQcfNUbsTN+EtOqdpgoGEZHRZQ/XDtKmoulbl2koCB2rtiNBf4Cg==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr10986990wrd.61.1529939591164;
        Mon, 25 Jun 2018 08:13:11 -0700 (PDT)
Received: from arch.localdomain (x590e3931.dyn.telefonica.de. [89.14.57.49])
        by smtp.gmail.com with ESMTPSA id l78-v6sm15368283wmb.39.2018.06.25.08.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:13:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/4] staging: rtl8723bs: use mac_pton() in rtw_macaddr_cfg()
Date:   Mon, 25 Jun 2018 17:12:38 +0200
Message-Id: <20180625151238.23147-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625151238.23147-1-straube.linux@gmail.com>
References: <20180625151238.23147-1-straube.linux@gmail.com>
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
index 8af4a89e632f..62d19cfebb06 100644
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
+	} else{
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

