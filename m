Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1782C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D6125D27
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZk8sLKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D6125D27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965757AbeF0RhV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:37:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37924 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965445AbeF0RhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:37:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so6329150wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VHZFiW3iqABkjfjpGLKXzDuybhiL5tPkeHdrj+bQUKc=;
        b=NZk8sLKczTFtq6gb5txuue4ppXceZLdCckCV6Y1yo1scN9Fu+Bp5w+ehPDGUJfXsko
         j/HlSYu4jFLzsCb6mWPsG+WpRY3vNr/NQi4Fm0VTU6YqPG3giyhg3tI7urcS3tnijgAR
         GuNHsxEMYmTrqPsFGRO998CCctwGTCNvHQ7Y9rcoPY4TI8tbtlfCaCs+E/Rk+cHQJ1bR
         UF9/Y/JIFiVi6IlbourXiySri3y/vgHGvVhV59s58Twe02eMENqTuPMrUfp7AvSqHO+y
         xE3q5Fg86iVCq0An7x6HZNhVC6lxJnx82qGGR2W6/DVJv4N3NElCbmZQ7HUgxdg/fX5I
         ipOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VHZFiW3iqABkjfjpGLKXzDuybhiL5tPkeHdrj+bQUKc=;
        b=VgvM3kaWgDZl2JLNjoZ2wD3Vx7qSpCDtvv5wd6Zxzj2fED6KpwymdFWHmeHXjsc4Sj
         ySC3kBGxt5u0QRIFPQrnEjwtc1YVYTV7nNrx4jl8YKmDIdVB88fABMiR5fN0U5QDNTDv
         If6qbVREH+2IErW8c6jXVh95SfBfF08IKH3g0KxH18dG4N7xmqDWMg63Q+aJ42LITPUZ
         we+glhL4Nr9kU3Oj0UINOq+581moo/qHWS+Zm83mr/PDw7COhOC5Bl12WaGjFRpaE6hW
         YroS6RHyN5lqjQiccBptgP/VxG2djcQylswvdNSFGONMZOxWE2TJFhFxlg0JH0ZrjAMt
         mYpg==
X-Gm-Message-State: APt69E2LNDjsu5W8kQTeuYDlwig4b8FGtOfwyiX7t/M9ilqRt4reNihn
        2lWge+RbaNbdKGNzi/IMiF0=
X-Google-Smtp-Source: AAOMgpdPvAl5o9KSiEPK69Bd+E8j0BA1vCAnBmxcpzWRRUkzXVB55D6fXBhdgBMlAy4JkhOpR03gcQ==
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr5907016wma.21.1530121037763;
        Wed, 27 Jun 2018 10:37:17 -0700 (PDT)
Received: from arch.localdomain (x4db2cd79.dyn.telefonica.de. [77.178.205.121])
        by smtp.gmail.com with ESMTPSA id g4-v6sm4473220wrq.32.2018.06.27.10.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 10:37:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 2/4] staging: rtl8723bs: refactor rtw_macaddr_cfg()
Date:   Wed, 27 Jun 2018 19:36:47 +0200
Message-Id: <20180627173649.4105-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627173649.4105-1-straube.linux@gmail.com>
References: <20180627173649.4105-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using is_broadcast_ether_addr() and is_zero_ether_addr() instead of
testing each byte of the mac[] array for 0xff and 0x00 shortens the
code and improves readability.

If np == NULL, of_get_property() returns NULL, hence the "np" check
is not needed.

Instead of a fixed default mac address use a random one to reduce the
likelihood of mac address collision.

Thanks to Joe Perches and Dan Carpenter.

Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e55895632921..7aa00d1391f7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1177,24 +1177,13 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 		memcpy(mac, mac_addr, ETH_ALEN);
 	}
 
-	if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
-	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
-	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
-	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
-		if (np &&
-		    (addr = of_get_property(np, "local-mac-address", &len)) &&
+	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
+		if ((addr = of_get_property(np, "local-mac-address", &len)) &&
 		    len == ETH_ALEN) {
 			memcpy(mac_addr, addr, ETH_ALEN);
 		} else {
-			mac[0] = 0x00;
-			mac[1] = 0xe0;
-			mac[2] = 0x4c;
-			mac[3] = 0x87;
-			mac[4] = 0x00;
-			mac[5] = 0x00;
-			/*  use default mac addresss */
-			memcpy(mac_addr, mac, ETH_ALEN);
-			DBG_871X("MAC Address from efuse error, assign default one !!!\n");
+			eth_random_addr(mac_addr);
+			DBG_871X("MAC Address from efuse error, assign random one !!!\n");
 		}
 	}
 
-- 
2.18.0

