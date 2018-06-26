Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95A2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DAD2668D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHpinkG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DAD2668D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbeFZIPb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:15:31 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37505 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752913AbeFZIO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:14:56 -0400
Received: by mail-wr0-f196.google.com with SMTP id k6-v6so16231363wrp.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vMbC7me8qNkOxK4Ddp6UZnSI0/+rni3gGHPFEZKB0WE=;
        b=gHpinkG90b6XpzjsaO4BXJJjmknFduteHBwa5gzKR4nBs3vYTHZb9u4gJ9sETqw5sZ
         MigDLw77SXiuIU4IziWLy613X5sgLzZf6tkgQKBtFrQBVXC8p3sGPAaXADX1J7aVn0/A
         fW8YtI+tEY5kQk0/1qBKp/XQcvwK4YhVcyjJB+x4gNQzMFcZNOIvaBleFOOXyBuLo3fN
         F7htb/6ZpX3AVGi/yp56fWrJQSz/eA1B6hlGf5cMckWX9wFF4kX3kp/pKUv/1Y8atfUw
         yzCFo1/kuezyEyV40i+5JHQ0ctD1xup6VuMUXVXR7UOr1ZhR21vauG32FhJN29GJFiIG
         kpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vMbC7me8qNkOxK4Ddp6UZnSI0/+rni3gGHPFEZKB0WE=;
        b=BwmdUS4Cb5LhtkvKRVSyVMRSFcPZhMxT2cPBTzZyF3BTvEmD5Rz/vwJMh0SZTpcfPq
         lUl9QJu3y4syu3JyuwqVQUuHbOsk+t+kzqVQP24oJuW5hfTXmJV7Hp8zivVtK+kzWOA6
         SE0OgqoABBt4XgF2psg9V8p2I8QVbLxBjPbr9YjLZ4QCwAHNpY4+0rHKFKhZ55s86oXx
         +bxZ6Y4JvV5h1MAnVmTLPgEqF+YdQV3aigNB4ToGSY/3e7u4RXQrZGtViOQrV9vYic4l
         orMj3iuYeoCMk3q0Fg2QtNw9sqJzyzKVNqebCgWWuh2/OTQ34DWYN9qg52BpcAVbT9c7
         mtxg==
X-Gm-Message-State: APt69E2FHG0kFN6hE3IGmqBsGcEUJiYUKf2lhxPslWlqSn03QXppanb+
        6X8artfCpJrb3qovJx0SK/g=
X-Google-Smtp-Source: AAOMgpeZP1GtALzh59GrH2TxyQTIlqSRHqOlzUkPRLQlsellgjkZD/HhJ5V3DCsz/yOO/o1+gtk/Iw==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr537069wrd.61.1530000895174;
        Tue, 26 Jun 2018 01:14:55 -0700 (PDT)
Received: from arch.localdomain (x590c812a.dyn.telefonica.de. [89.12.129.42])
        by smtp.gmail.com with ESMTPSA id 74-v6sm1946151wmt.31.2018.06.26.01.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:14:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in rtw_macaddr_cfg()
Date:   Tue, 26 Jun 2018 10:14:08 +0200
Message-Id: <20180626081409.9518-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626081409.9518-1-straube.linux@gmail.com>
References: <20180626081409.9518-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ether_addr_copy() instead of memcpy() to copy the mac address.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 7aa00d1391f7..8af4a89e632f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1172,15 +1172,15 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 		for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3) {
 			mac[jj] = key_2char2num(rtw_initmac[kk], rtw_initmac[kk + 1]);
 		}
-		memcpy(mac_addr, mac, ETH_ALEN);
+		ether_addr_copy(mac_addr, mac);
 	} else{	/* 	Use the mac address stored in the Efuse */
-		memcpy(mac, mac_addr, ETH_ALEN);
+		ether_addr_copy(mac, mac_addr);
 	}
 
 	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
 		if ((addr = of_get_property(np, "local-mac-address", &len)) &&
 		    len == ETH_ALEN) {
-			memcpy(mac_addr, addr, ETH_ALEN);
+			ether_addr_copy(mac_addr, addr);
 		} else {
 			eth_random_addr(mac_addr);
 			DBG_871X("MAC Address from efuse error, assign random one !!!\n");
-- 
2.18.0

