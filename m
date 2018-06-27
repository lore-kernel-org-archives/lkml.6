Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7444EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8D925D1C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy2i3HHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8D925D1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965531AbeF0RhS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:37:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56254 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932837AbeF0RhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:37:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so6769246wmv.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9cxHKShV56PWgIqeCTT7oiwH+AMPI4Oo5xRlCxbWT8I=;
        b=Uy2i3HHUol61TTeGncQ9pebJxahTb0+tnQ3LCqt9gdZbyLeQfn1D1C9lQFxzc0oBAN
         9highmqRrSn5bDd9U4yKvzsUhasgDcp+FAo56GMc04XFl8yXRxSLnNGDnPGByHzY6BzF
         n07aL2c3seoS2vazwPoq33Mu8mx4SnTKaK7POJoEfMvqtSqI9V0lgB3X/8DZhnt56T0W
         ATrEEh7xehyf3UQUQGNFNDv1pvSnMxs9ThTSaOgY7ZohuW0Pjmh8iaylRpu0FnsirxD5
         fstfapQ2Wt2asfeBTVsowvA9OusTMGLFBM1DIbxpI1rK3EFpqds2V5/NEma4ZzFDagzD
         DP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9cxHKShV56PWgIqeCTT7oiwH+AMPI4Oo5xRlCxbWT8I=;
        b=IeF4/QSd67FfK6USU13GZwTgJC7JvcdTxgLMYYS9ROWxQTif4CSYugLZP+lhu8nsxy
         M/AeE/EIUHVPoNLQebfmE3iQr1T6qtqwUKLrWazPHWKUV4y/y+WJoVtdoXC/3hY7eD7z
         RvXQ9yVEiF5NWVPJL5QZkognEMnDib2Gcy03AHMvcR/HaKv9L2xBjvG04ZQBXrXdlxg/
         JjhAcc/szgcnkP+GCIDk4SGXm41sOdjm4/0lLye7RevcZ3NGbTZ9Oz9zzcbhGkHvgtor
         BOreDiUdYysusYrzQqr0xmgDIJqU2UJvo9fPf8nbv7aJUdnbpZ/Q1/RKa/QrQNVehJb4
         Ui0g==
X-Gm-Message-State: APt69E2RRLDExJ9H93ryAZ1rsVyKOPE/eGWxfJh3pPpLWObASPyVIXT5
        2YnZqYnwZNMtww3PvjabVvU=
X-Google-Smtp-Source: AAOMgpeEjbWt+sL//ZC534KGLz8bfHOBYbJMX/mnuG8l3o0bRem+nPw2jAHFgNETCs2UFGIlz/hUuA==
X-Received: by 2002:a1c:7506:: with SMTP id o6-v6mr5704882wmc.60.1530121035820;
        Wed, 27 Jun 2018 10:37:15 -0700 (PDT)
Received: from arch.localdomain (x4db2cd79.dyn.telefonica.de. [77.178.205.121])
        by smtp.gmail.com with ESMTPSA id g4-v6sm4473220wrq.32.2018.06.27.10.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 10:37:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 1/4] staging: rtl8723bs: fix comparsion to NULL - coding style
Date:   Wed, 27 Jun 2018 19:36:46 +0200
Message-Id: <20180627173649.4105-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comparsion to NULL issues found by checkpatch.
Use !x instead of x == NULL.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 0822e440204e..e55895632921 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -747,7 +747,7 @@ u8 rtw_is_wps_ie(u8 *ie_ptr, uint *wps_ielen)
 	u8 match = false;
 	u8 eid, wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 
-	if (ie_ptr == NULL)
+	if (!ie_ptr)
 		return match;
 
 	eid = ie_ptr[0];
@@ -1163,7 +1163,7 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 	const unsigned char *addr;
 	int len;
 
-	if (mac_addr == NULL)
+	if (!mac_addr)
 		return;
 
 	if (rtw_initmac) {	/* 	Users specify the mac address */
-- 
2.18.0

