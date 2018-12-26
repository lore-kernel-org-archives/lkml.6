Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4805EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DE82171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="MTWWNnHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeLZSER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 13:04:17 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:38780 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeLZSER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 13:04:17 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id E3723AFC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 18:04:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gNBUkg7CfEZs for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 12:04:15 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id B478EADC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 12:04:15 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id c73so19139639itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 10:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pHDdXroo+ItPDxTlabWZU5oDTguS18rFy2uHl24kaBk=;
        b=MTWWNnHVzVJcy3d6X1krqUf0xkdTP07gw0MFCqqTK+ecXxQp7QgiNVwXRbaFEp6Gyu
         Yg48uUpSw246KkFw/h/UlFkbVXb4apSfQCTXfoTYWH5Is9GUi9/KHugK+Xz0uTvfrJP2
         kyo7PwRncswsXbNwGFhcfHjYka0jT+d7FKu6C3jFCU1bZb7IUP20tWjLSluePmmXrw6V
         P/eA8xcxPc4OM3aLuwJmB+ibeJpfwIrmVgZ8tumOJLff7L/3ktiGvAA0JkgdaiJnf7vY
         lAhg0v+fI2Ck3wXugz3edIqzMBmBtsoeHc/yJdEvOdqqcTDzYT6hEUn95p2ikAGQns9l
         mOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pHDdXroo+ItPDxTlabWZU5oDTguS18rFy2uHl24kaBk=;
        b=ooyetKIKRjj5nwrlEqY1Bsyvgf847Iq226dBoFqRKGhjhF+MtErptS0pUNHQ2IKH01
         Toi1aSYdGMeAjOoPZ7loYifqEU9534JUig3Zvd1eE7ol90R/woeEROnNuNih6XQrrrND
         ttXar6/ypPhhD0bDmH+5n+chDWKqx/tvWlRUux+VbJYN0tPCPGDTWu8cW1iCPha8pNtJ
         ItFXtiuY2Nlem38TyJZns5QBixpw7U7EYf8WilF2TCALnGRjzLWec/8zdbJUxJmwNCof
         ymxPTCUrLBCabExbT5YKGS/69O4lxCsYEpQthSyQrkOFbWRaAGHp1kxpPJ9DTLGJTOxR
         3YsA==
X-Gm-Message-State: AA+aEWap5pW9GsiadI76x6Nn1ItAWWIJPDiQ41xhOCRTa+9k/b4Ynx/h
        S+MbNhH+jvNZP/qanSK33WDHpQEEl/M4+IPNQbnmx5VLEf5jXpuxsUErRm411oqUUoZUECi8JZy
        GH560oBDBLyvOSDznOFfTaytN/eDu
X-Received: by 2002:a24:878c:: with SMTP id f134mr13397722ite.81.1545847455287;
        Wed, 26 Dec 2018 10:04:15 -0800 (PST)
X-Google-Smtp-Source: ALg8bN41iqDw7l1lE9tyD8JsHbO2UsdnBdxKlFzT5Nglj6PYAUTwJZ0MbNFa8Xbw8dMxrbCc0VmzvQ==
X-Received: by 2002:a24:878c:: with SMTP id f134mr13397707ite.81.1545847455022;
        Wed, 26 Dec 2018 10:04:15 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id v189sm12935071itb.42.2018.12.26.10.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 10:04:14 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: phy: check return value of bus write
Date:   Wed, 26 Dec 2018 12:04:06 -0600
Message-Id: <20181226180406.7881-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy_mii_ioctl() could fail when writing to the bus via
mdiobus_write(). The fix adds a check and returns an error in case
of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/phy/phy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 1d73ac3309ce..1fbdaa96b36e 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -397,6 +397,7 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 	struct mii_ioctl_data *mii_data = if_mii(ifr);
 	u16 val = mii_data->val_in;
 	bool change_autoneg = false;
+	int rc;
 
 	switch (cmd) {
 	case SIOCGMIIPHY:
@@ -443,8 +444,10 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 			}
 		}
 
-		mdiobus_write(phydev->mdio.bus, mii_data->phy_id,
-			      mii_data->reg_num, val);
+		rc = mdiobus_write(phydev->mdio.bus, mii_data->phy_id,
+				   mii_data->reg_num, val);
+		if (rc)
+			return rc;
 
 		if (mii_data->phy_id == phydev->mdio.addr &&
 		    mii_data->reg_num == MII_BMCR &&
-- 
2.17.1

