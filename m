Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A90C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8B921741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OQFvDCxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeLZRhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:37:45 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:36382 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeLZRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:37:44 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4C6AA9D3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 17:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m_P3qe8hwM4C for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 11:37:42 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 1ADB56A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 11:37:42 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id u2so19696497iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 09:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yxt2Y/xGhxUz9dJIXAwgpXma5zpJOQ6jsJWBEi9cV/s=;
        b=OQFvDCxOhylfCdGZIC1Ivz53I5R5Sg/z58U949NMThkexWe/ydLTJf3VmcAefytV2B
         mnBSFA0Rg93qORqjmdqswTinhq88HRIENj6rAzayEJcsj/zhvPDGU4KbEabBZkVEDfKl
         lYCW2mqVz/RXCqUDKhBPb10ET4OFcOL5HNNWEeE04ysDyV9Pnp7BQExji21xcUh8Tol2
         zyUGv4HoZWYUMynRkHrAXN9TiYEx+YffJb76dBS+7OgZ0L9gPfvm3WYzE3twDc/0i7vB
         wgwF8KjhkAIoSe5r/8HSZacsT7cv1QJ/3hH3Ceg3S6Awbic19caLblS28FlLbanA4vBz
         p31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yxt2Y/xGhxUz9dJIXAwgpXma5zpJOQ6jsJWBEi9cV/s=;
        b=cZVOY6EX0pTvfPXJuFKobVLc0mWtBG3yquChvCsivcNwF9e2+sqM2H5f3P28JZjo+n
         5iyYu6LDo7xxvOFNWOXSaaXbKojX2P9wmLKl0jyMStb21Dmq4Pl9afTW+I+iAGW6OJnC
         TwBqkEM3R7w+IJELpbGpSI3YUj7F7mcWS9RKIM4LUPjBILJd3Bc17IUuMnLIpKcA71dW
         GOVY+C0GdzmyhpO+ulAdMjAKSbGR4UkjwX5ASPtnDG0M4WNQfMm4eQbvjs7xqaBijzFr
         empqV6yfHebNDB4A/iSE+C5XRKwnTipkrMKWrEuALqsgygohJYlE0AjyPJnrURy909md
         Xn/A==
X-Gm-Message-State: AJcUukdk7ltDFp65yy6O8sfYD2mhN9r5yhCZYtQluUqmo8ZqsCaDlRTM
        gEfgeq/huwJOOoalJ7KDviqelhqYOykQUTwszzQqfUmk0kLfxXNELyu6TKYZKnqLKG8oaMLLWLe
        Ud+DL+Wosvz/MKXj235kxpfEEhXaa
X-Received: by 2002:a5d:9652:: with SMTP id d18mr3921131ios.257.1545845861724;
        Wed, 26 Dec 2018 09:37:41 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4e56M/UjQ8az4I6y5/An2cMORU0RpSR/Wpz/yw5KLfDXD34AUkCIXYPw4WOQbrwyfDZKQs3w==
X-Received: by 2002:a5d:9652:: with SMTP id d18mr3921111ios.257.1545845861495;
        Wed, 26 Dec 2018 09:37:41 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id e68sm14585031ite.7.2018.12.26.09.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 09:37:40 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net:phy: Add a return value check on bus write
Date:   Wed, 26 Dec 2018 11:37:17 -0600
Message-Id: <20181226173717.7113-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xgmiitorgmii_read_status() could fail when writing to the bus via
mdiobus_write(). The fix adds a check and returns an error in case
of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 74a8782313cf..926879d43373 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -58,7 +58,9 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 	else
 		val |= BMCR_SPEED10;
 
-	mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);
+	err = mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.17.1

