Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656B3C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5D1223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFp/WRu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5D1223F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeHJPRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:17:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34885 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbeHJPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:17:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so7112348ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V6hmd09XYpCGXiuhvOsp9DvV/Bv2s+eIOM1qddmcKlA=;
        b=FFp/WRu+t+oYQsOuluFJ1lNh743K69Nyj2sGogRbZEY//48Lk92pasBpLUbkujQcp2
         YXGV36K9+aPkTb1//CchS6jdiJ4skHp5VfbyphKKW6V0H2wsCg2AYRZWgQ/fOSXpwFPK
         2hsMwDwiE+kGZyhO58WEKVq9DKTNYzEN4d7Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V6hmd09XYpCGXiuhvOsp9DvV/Bv2s+eIOM1qddmcKlA=;
        b=nK6S6H+7RsC0SqabjFsYNuPhCwtC6OYyKhJB3DskO+iNrfupidcn8XyGcTkwemuisA
         TPjdwmAHRDYx408ohRezDAFSD9Rb8myL8IiI1pJyMWuaOJgbRBxGba9djtb5+WqYcn4h
         HRuuzLon6/V/gzYcQ0uRfHmOpB3Hv9CCQ0yj8h9MLgqWcFNZ/AEk4RYqWJGSjlGC0lcw
         iyYfRWUFzca8ysaXvEmOWrxcPX/F81x5CciHEXXI84hIgh+wFZi4no4u6LodLSPIwkvF
         YMIV6kDZEL8mUakfzLRnFHzsugbW7qEQCmvoH/mKiAWqRAnc9z8IL3YwJj0sxbf8+CFU
         dgtg==
X-Gm-Message-State: AOUpUlGN4grKWUdJo/nIyOD6c77T41S7VLdsy9HzJlkiKXjViHluN4Zn
        yCLb28XvrD0XRllRfuinQzWybA==
X-Google-Smtp-Source: AA+uWPxfkmV+5juHXoN/gDE5EDOqgduRjgKS86Z4/XlBN6wOXwUx4474A8zQ3UL7M1R0ns8aUhaYnQ==
X-Received: by 2002:a2e:8617:: with SMTP id a23-v6mr4985207lji.43.1533905241225;
        Fri, 10 Aug 2018 05:47:21 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 84-v6sm1626382lje.48.2018.08.10.05.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 05:47:20 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 1/2] net: ethernet: ti: cpsw: clear all entries when delete vid
Date:   Fri, 10 Aug 2018 15:47:08 +0300
Message-Id: <20180810124709.25089-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
References: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases if some of the entries were not found in forwarding table
while killing vlan, the rest not needed entries still left in the
table. No need to stop, as entry was deleted anyway. So fix this by
returning error only after all was cleaned. To implement this, return
-ENOENT in cpsw_ale_del_mcast() as it's supposed to be.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c     | 14 ++++----------
 drivers/net/ethernet/ti/cpsw_ale.c |  2 +-
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 358edab9e72e..9edac671f276 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2125,16 +2125,10 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
 
 	dev_info(priv->dev, "removing vlanid %d from vlan filter\n", vid);
 	ret = cpsw_ale_del_vlan(cpsw->ale, vid, 0);
-	if (ret != 0)
-		return ret;
-
-	ret = cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
-				 HOST_PORT_NUM, ALE_VLAN, vid);
-	if (ret != 0)
-		return ret;
-
-	ret = cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
-				 0, ALE_VLAN, vid);
+	ret |= cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
+				  HOST_PORT_NUM, ALE_VLAN, vid);
+	ret |= cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
+				  0, ALE_VLAN, vid);
 	pm_runtime_put(cpsw->dev);
 	return ret;
 }
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 93dc05c194d3..5766225a4ce1 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -394,7 +394,7 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
 
 	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
 	if (idx < 0)
-		return -EINVAL;
+		return -ENOENT;
 
 	cpsw_ale_read(ale, idx, ale_entry);
 
-- 
2.17.1

