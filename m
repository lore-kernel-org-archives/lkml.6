Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C27D213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plza3K4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C27D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeGLKpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:45:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41540 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeGLKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:45:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so5300582edr.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1Ma1QLQ7vLtVTUMMWo64aZkb2u6N6Fuml+JcUiek1pY=;
        b=Plza3K4QTFsv16fcgAM02Jnd8xffNVSIB8r4IBQmJMv66TRqnb+FCmn2+AAW7pLb6B
         916EZp+YKwzx2HpS8K6uWjsyIUMoRxqXnIOS8sdFTRO5EBUa445j2wwpwFS+VVKU9CxI
         8nbOme411lJR961yiTU9OD+9k3CnXzeqg+JIanD2EzGIr3MedJGgv8HwKVZjeCMRP4q+
         FLLJrDVJRNEVkzlAgrCiov/wGNUtL7nAyEFWhrCauthm8sl9CkC8//9kSSp2HCPfcX7M
         ig7bHaSct3NyAI2UP3wpBCyPg8Lb93BDVHNkdIGgYl3SNnipr+yraS7EG/zKfzFw4T3U
         Iseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Ma1QLQ7vLtVTUMMWo64aZkb2u6N6Fuml+JcUiek1pY=;
        b=HYThAmEUsf3yLbkUJXzMm1s8Sc9UmiBNN1cWFlJp2yFmPq3ZS0I3Lh0E8ux5fZjPjv
         AY9zW69lgbuX2PgIs+uoM9kQHldCwOEwogLz2pu3M+IXMckSwWMiUANnco6FQpItOGRl
         OAbRaAvTzlH42XCAjPZoBXSLAXptqLnCYKj5m3+sko/gN7QwoDM8QqimuHGb/fYbvzTr
         kzoKbGB0WNltyVE46yrQYYD4d0aXvLpSuf2Xn6Srj9nZBQuCcvRZ7A8nDmNVDNXf64/L
         H1kIDO9mlPUXnsFZMfW8/At4FGELByxoG2XH2dvamVypIUPfoeM0yVfO6OAjq09CbfCi
         BdFQ==
X-Gm-Message-State: AOUpUlGTkaQ+26y2WPAojRi1EWdSWDQaHtcvxbP4v73uwDrkAONoYNnx
        9JjGbPAyxVIVKGZ6rl9CgZ0=
X-Google-Smtp-Source: AAOMgpeEDxvzdbtw0hiDnFTR8GPrAB2YB3dj/3Ue8hBecC9uLGzi/wF6BP8DTs0nf8R9jr2fqt6tXQ==
X-Received: by 2002:a50:9493:: with SMTP id s19-v6mr1969273eda.285.1531391784581;
        Thu, 12 Jul 2018 03:36:24 -0700 (PDT)
Received: from arch.localdomain (x4d0a32b7.dyn.telefonica.de. [77.10.50.183])
        by smtp.gmail.com with ESMTPSA id r11-v6sm3661567edh.32.2018.07.12.03.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 03:36:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: rtl8723bs: remove unused code
Date:   Thu, 12 Jul 2018 12:36:06 +0200
Message-Id: <20180712103610.19532-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove commented rtw_is_cckrates_included() and
rtw_is_cckratesonly_included() from os_dep/ioctl_linux.c.
Both are defined in core/rtw_ieee80211.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 32 -------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index ceb2b10fa0b2..63b79a7eaccf 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -79,38 +79,6 @@ void rtw_indicate_wx_disassoc_event(struct adapter *padapter)
 	eth_zero_addr(wrqu.ap_addr.sa_data);
 }
 
-/*
-uint	rtw_is_cckrates_included(u8 *rate)
-{
-		u32 i = 0;
-
-		while (rate[i]!= 0)
-		{
-			if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
-			(((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
-			return true;
-			i++;
-		}
-
-		return false;
-}
-
-uint	rtw_is_cckratesonly_included(u8 *rate)
-{
-	u32 i = 0;
-
-	while (rate[i]!= 0)
-	{
-			if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-				(((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
-			return false;
-			i++;
-	}
-
-	return true;
-}
-*/
-
 static char *translate_scan(struct adapter *padapter,
 				struct iw_request_info* info, struct wlan_network *pnetwork,
 				char *start, char *stop)
-- 
2.18.0

