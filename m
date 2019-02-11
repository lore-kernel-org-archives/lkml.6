Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98871C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669FE217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvmCLGCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfBKVS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:18:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34494 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfBKVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:18:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id j18so172605pfe.1;
        Mon, 11 Feb 2019 13:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H4Y8A4xuqg0j64rJEM05W/f+R8PtN6hAxCFyq/qFXl0=;
        b=dvmCLGCnlWZxeH3BCjRHqaQc+cFdaTO6WoXfuP0Xtw8cxXtITrjGHPi/M+f6typUAQ
         DKOxlZGb9MS0dFdzMz/kxVBV1daoqKEU6mWD67Jd2mRCgx+7suuRHAQQH382cIQhupkr
         bTMhr+Zjw4JQRUvwng6K7gFY18SZwgkGwT4KK1TbvDanaa2alSt/4G/DkgegTOxLSVRt
         DuBrxkgO/P4ZCy8XwvUmzr1UQ+JeiyCADvEmflmNMgJ3P9YYE0v3FxDDt+teLeCUsELH
         /kZ7yQzPe/HRmHXP7AoH2HnGzOvdGoZMM4Yuf+i99cESRVCJBvRX93xGgdnp7CxrkGvi
         Jwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H4Y8A4xuqg0j64rJEM05W/f+R8PtN6hAxCFyq/qFXl0=;
        b=ubX9E9sM91XViXAn645BAqS5AjCTt9kvQuEnb/5u6Bp2X/BjJn34ThP3+Dk/4G8ivO
         LLRD2SYLLuy+aKL9qmKCaUqJzZiK5pIAkJFcVY1BKDNdSOaCaAogSK44KzyAfN+6uDCw
         RlQKa0BXG58eTysiHQvCvTf1+7i4/RnV9H5Mq/6hfRuyYIvEyu19Sh3KFVsP1qb5yYda
         0TDGAZV1UrEVVUL8iNC9wV/bkmX1k/7ii01lGdXcs7KMyLbJ+7FYz4+lXkfvgaegJcwQ
         puoekAJ5TVDl3t2QmliTtLL8U3FrlFMbx6Qqkw15Kssv3/qEyZbfSjaCqn82i5UxmLFG
         DJTQ==
X-Gm-Message-State: AHQUAubR6FT0FVcHrLwCdEBstK1x/SCeYloZx2wOyKmijKRkOD2I7eOz
        B0me8sghgs3m2neYy3Il7Pk+cBGi
X-Google-Smtp-Source: AHgI3IbXfnnL79dkeY8QLXD4qJr+ZGg/dq8kP2NdGXV7GtjbBsVwfclSFhj6KTF3b0iot6uxcHSDrw==
X-Received: by 2002:a63:fa58:: with SMTP id g24mr253565pgk.390.1549919904582;
        Mon, 11 Feb 2019 13:18:24 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 24sm15213029pfr.75.2019.02.11.13.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:18:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 3/3] staging: fsl-dpaa2: ethsw: Remove getting PORT_BRIDGE_FLAGS
Date:   Mon, 11 Feb 2019 13:17:49 -0800
Message-Id: <20190211211749.19847-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211211749.19847-1-f.fainelli@gmail.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no code that tries to get the attribute
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS, remove support for doing that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e559f4c25cf7..e5a14c7c777f 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -646,11 +646,6 @@ static int swdev_port_attr_get(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		attr->u.brport_flags =
-			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
-			(port_priv->flood ? BR_FLOOD : 0);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
 		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD;
 		break;
-- 
2.17.1

