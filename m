Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4635CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E605A20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzwd3FLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E605A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeIADOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:14:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43926 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so12516523wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKZccMAg13mPyW6ruGjxhCIpiL9n5bC2WsGXa17EByE=;
        b=Vzwd3FLwI82bP6x/+/bKb+ivs6tls4UfM7mn9Sok/yZHZk/zUSJOE62/9btT6WFExB
         u+Gpiy1iB/CLfAcXMs2VBSbFuBqovok5d8vmXrqKIERpCOyYCAc6agL5/NG/9rlGAz5W
         J0E6SBKPus4gDJapq8Lu9qgrrrp9MQR9G6pv8+CtHahEBfi7pfvtLu0HHsdVk7W5pmCv
         S1OkBIQg/ozTwow0krweGG4p7bW0Vo2Tm+PftjFhPqKXzjZW6Q7naL/H/1rWU5wo9OG1
         hBwR5zbPVuZlfl3rclV4l0HjxLa++iHKr+8nSx3/1BYojB92djucbX43BuIUlf5ZuI7h
         4BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iKZccMAg13mPyW6ruGjxhCIpiL9n5bC2WsGXa17EByE=;
        b=uFKQk9cdKYyQPqN7CBpLVJJ/rc52eQAHj8J3nrDdn+3JY3S2uIQX9V0iRXxaSttW3S
         ynHnsA+0yaC1XvASY2iqlVFa2TnGYT/3VZSK6kNw9aLzJACsIlQYr0KD1jhicbLZ2Mu1
         4PkJhBEsI2RHvQfCeQA/2v9Jnh0GUS9Dn7rr8WjnYbllvRPYMfRnmUee3A/xIVefzmoC
         Gzug02x+Yp6+oTi56iIMQEb+9DHW7GYa0e3S7Y3sRjtPCxHVPBWikI0pTV9m9Xn7wOR+
         /y89cBsevIOsVQIgu9er5tLHO5zB5cjaN9vfuAq7vVUDlNlRBsp6D4MU7WBIXKBMczFk
         aRPA==
X-Gm-Message-State: APzg51DWGb+/ur4k/5DfVZ8C9PK8XPD3hL5sH/qrPHi69kLnF9M75df9
        +8QIoyXmi54JnZNNQkeYH9smhsU0J7I=
X-Google-Smtp-Source: ANB0Vdbhd33HN3XdA26EZxsXDVTlbc9+XUyOaEjRqlzlNfG8zCtLKIe/4oKYBV4FjvRWbFEGN+lcoA==
X-Received: by 2002:a5d:5685:: with SMTP id f5-v6mr13013000wrv.58.1535756580238;
        Fri, 31 Aug 2018 16:03:00 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:02:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/20] staging:rtl8192u: Remove unused functions - Style
Date:   Sat,  1 Sep 2018 00:02:33 +0100
Message-Id: <20180831230250.16810-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function declarations. This is a coding style change
which should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 10 ----------
 drivers/staging/rtl8192u/r8192U_core.c |  7 -------
 2 files changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 70bbd1fadcca..b3e6ce2acedb 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -1103,22 +1103,12 @@ void force_pci_posting(struct net_device *dev);
 
 void rtl8192_rtx_disable(struct net_device *dev);
 void rtl8192_rx_enable(struct net_device *dev);
-void rtl8192_tx_enable(struct net_device *dev);
 
-void rtl8192_disassociate(struct net_device *dev);
-void rtl8185_set_rf_pins_enable(struct net_device *dev, u32 a);
-
-void rtl8192_set_anaparam(struct net_device *dev, u32 a);
-void rtl8185_set_anaparam2(struct net_device *dev, u32 a);
 void rtl8192_update_msr(struct net_device *dev);
 int rtl8192_down(struct net_device *dev);
 int rtl8192_up(struct net_device *dev);
 void rtl8192_commit(struct net_device *dev);
 void rtl8192_set_chan(struct net_device *dev, short ch);
-void write_phy(struct net_device *dev, u8 adr, u8 data);
-void write_phy_cck(struct net_device *dev, u8 adr, u32 data);
-void write_phy_ofdm(struct net_device *dev, u8 adr, u32 data);
-void rtl8185_tx_antenna(struct net_device *dev, u8 ant);
 void rtl8192_set_rxconf(struct net_device *dev);
 void rtl819xusb_beacon_tx(struct net_device *dev, u16 tx_rate);
 
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 12783b88eb58..98bb40c50f40 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -830,13 +830,6 @@ void rtl8192_rx_enable(struct net_device *dev)
 	rtl8192_rx_initiate(dev);
 }
 
-
-void rtl8192_tx_enable(struct net_device *dev)
-{
-}
-
-
-
 void rtl8192_rtx_disable(struct net_device *dev)
 {
 	u8 cmd;
-- 
2.18.0

