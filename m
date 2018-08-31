Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68812C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1469A20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egZfx5L3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1469A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIADMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40607 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id 207-v6so6634869wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K43H5rQ9agFtp3KyVHtvsJHREwvDnw84omXL97re9ko=;
        b=egZfx5L3Pami3Ew4TLK3aAS53FvlQKhCSpmg0Zi5JXeBkGMFpGEIL54QbB9zjegxxZ
         Qi8hr4As/gIyKBc1fB+UK9FGhJq+nklchxzI6GCGcg7Jz75bX+VQljEw/7Xu0THgcvaj
         ReJi7rddm8LB65AG9zfb5zAIiJsmlKFGlDZiZqYWXmRh1f/OYbC2rLSwqstojTOxvPnl
         XsrD+va9njBEpUn011X0Ao+XEyV8lAUY+9Wqn5Ol4W+W4JNR+XCDGai8Ggd+N8VOW3oe
         3c63Z+aSPBloFiTzw3Ci30YpjUWQFTq16t2tsKdxlL33uUYSYTtF7Zj/eV2rE35QjfX4
         iThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K43H5rQ9agFtp3KyVHtvsJHREwvDnw84omXL97re9ko=;
        b=gl3llqvKHU+UaCiKAUCJM4jicBwP+Zhvi4cBnto1SEQfQN1nn1dsJndzrflcHQRyT7
         sAYyfO3lVCxLeHt2m8Q+Ir8p0XcsK+m8RpH4uL/JczpojFmn7ForAPFQ5Cd3LL6/7mYc
         1GADUy+h1EhaP3XAeCFcRB9cUKujPw0nqmtq76bEOoVXLDf2VOkT5XxHOAfKTYQ9n9PR
         OrGpN1E0bsru48zqvVeamZvxIRPUr1sWywLKgfd33ScBRFsAE5efI2min6lJhT0jVW/s
         qN0j2HZZVv9Q6uf2Uf7LQ7HkwuFBKsXmqj3nlsvWhOZhBqwwqfr/GlWhpTUMwOJNT0Xy
         BgSQ==
X-Gm-Message-State: APzg51BvqAuuE37DOcKoMz33g65+QTNii1OenIkvxtUsby9Oez5oTKV6
        Wy1odGgPhjnTaLn1iZKgPXdaWwI5O2A=
X-Google-Smtp-Source: ANB0VdYrJReiW0Cf+Evy2rvHuYYBB2J5wnXYCjvLh91k/ecsRmH7BLNmF8wWKv4n2CfJSvF6x5AoHQ==
X-Received: by 2002:a1c:d785:: with SMTP id o127-v6mr5853784wmg.67.1535756577124;
        Fri, 31 Aug 2018 16:02:57 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:02:56 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/20] staging:rtl8192u: Remove write_cam() - Style
Date:   Sat,  1 Sep 2018 00:02:31 +0100
Message-Id: <20180831230250.16810-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the function write_cam() as it is unused.

Simple style change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 1 -
 drivers/staging/rtl8192u/r8192U_core.c | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 1b51601df1ee..77324a471de1 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -1092,7 +1092,6 @@ short rtl819xU_tx_cmd(struct net_device *dev, struct sk_buff *skb);
 short rtl8192_tx(struct net_device *dev, struct sk_buff *skb);
 
 u32 read_cam(struct net_device *dev, u8 addr);
-void write_cam(struct net_device *dev, u8 addr, u32 data);
 
 int read_nic_byte(struct net_device *dev, int x, u8 *data);
 int read_nic_byte_E(struct net_device *dev, int x, u8 *data);
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 6b22aaa40ff9..caa618a845df 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -237,13 +237,6 @@ static void CamResetAllEntry(struct net_device *dev)
 	write_nic_dword(dev, RWCAM, ulcommand);
 }
 
-
-void write_cam(struct net_device *dev, u8 addr, u32 data)
-{
-	write_nic_dword(dev, WCAMI, data);
-	write_nic_dword(dev, RWCAM, BIT(31) | BIT(16) | (addr & 0xff));
-}
-
 u32 read_cam(struct net_device *dev, u8 addr)
 {
 	u32 data;
-- 
2.18.0

