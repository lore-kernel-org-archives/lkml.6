Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA96C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA4C204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxstKwfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA4C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIMXrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:47:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37063 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeIMXrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:47:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id f1-v6so2989864plt.4;
        Thu, 13 Sep 2018 11:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oL2xG4bF8qgEbvy8dMAtzs2DoDvkKu0u4l0w+2sJW+A=;
        b=gxstKwfpU7PHsXm9/aY0mC8GAWLG86yP0KA2OrdBj6M9Uoy9vZ6lH9+fzm4JnIlshI
         VWr42+Zt6oUs7IlA1pPfVJxU85RTSNSbuFeiIBSkKejytuaD0DNaH9bOjU+FMo677c8f
         aay7Qjc9uC4SXtwW4czmgf+0WcW+e/0mO3mSWVel0kaeNXSs927k3/tpBJwLzjQ3vOUw
         e86F0iqzmNZ8hXda/2S+fjgz91EpCYrenPQtrxNdL72Ly5zxuaJ/qpUyN4JdLFpwJEyH
         29jmm9l0WLwYxm7CEg0j425znjnVwehONLJUjAltPZHyjjy9U78fDK1/VGhpZ/wZRUkR
         y/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oL2xG4bF8qgEbvy8dMAtzs2DoDvkKu0u4l0w+2sJW+A=;
        b=b10Wch1adv2QcYKiofnlX8fWClw1vfntGeMPMALKkO0GRdQFoVZO1wqZ48orFMolmM
         KZ7z5w3K/FGaVjnJDIcabdosJOHPZyG5n2xE+C4Z2wTQw+UJJ3asecQM0ZywH2jm9Sla
         8NGUE45QpcH6qj57hTu8/o75VHGT15u0dNmukWfsnDD178xyljdLQwO+uWyQBMbdB84R
         AIGezX1P3ro+4i9A5ICDwFml7fz92kYiFW0fZhKyM0j9gj18vIG9gr8Vr/2y9WOoQBHO
         WBArHTpxdSBiqTDFC5W+/JFMv6mrjQ/VQXgkuHlKtRxflyBiTZxDi/32eY7kjLKOVrkn
         l5oA==
X-Gm-Message-State: APzg51C90498A5ilmQjOk+PnTfXn0jeCx6g1kJYWpWdiAU+AnOgfp5OA
        2AqEWva6fPnXEqIbvrlWdpW2C6Aa
X-Google-Smtp-Source: ANB0VdYxLwjeP54DckkF/6UAoLTjQVWn39To+4DXykBK08HdBQs9shQ2mJNo6LeQSEOj9tTG7GkHsw==
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5-v6mr8308874plt.274.1536863796616;
        Thu, 13 Sep 2018 11:36:36 -0700 (PDT)
Received: from cox.net ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id a192-v6sm10366490pfa.124.2018.09.13.11.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:36:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: phy: et011c: Remove incorrect PHY_POLL flags
Date:   Thu, 13 Sep 2018 11:36:30 -0700
Message-Id: <20180913183630.32584-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY_POLL is defined as -1 which means that we would be setting all flags of the
PHY driver, this is also not a valid flag to tell PHYLIB about, just remove it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/et1011c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/phy/et1011c.c b/drivers/net/phy/et1011c.c
index ab541c9c56fb..565e49e7f76f 100644
--- a/drivers/net/phy/et1011c.c
+++ b/drivers/net/phy/et1011c.c
@@ -92,7 +92,6 @@ static struct phy_driver et1011c_driver[] = { {
 	.name		= "ET1011C",
 	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_POLL,
 	.config_aneg	= et1011c_config_aneg,
 	.read_status	= et1011c_read_status,
 } };
-- 
2.17.1

