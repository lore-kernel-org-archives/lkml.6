Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C049C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC9720874
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="k0E20J5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeLZRuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:50:39 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:52320 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeLZRui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:50:38 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 0CC309A9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 17:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zNpwTun29peW for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 11:50:36 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id CD13293F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 11:50:36 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id 128so20357876itw.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OXkyZtVZ84paU131QdjLkvaDVS75Ha7ZnWK1vHWVPpk=;
        b=k0E20J5JCsl7JXWU+dV6cv/GIfYPduE7+WL3GJEmJ5ic4afEavvBe3QDkBNqUPlx9y
         UjzAvb+l1EzryfxYPdOu83Ld8vId7oBX+6G8O5m8BBvcsxwCqTrGeXJ51tsLpH0oWmH9
         Q5s9+19tl4MBSLDR9F7A8HMsczlRxPRzyZXWIMttVMJLMunDWU+VSqIIgwlGXm2WG6e3
         j1OO5be4knujgidrJZ9UxpM8PT8u23jh+1UiHqQrFRgKGya0zzIfTsXWQjK3NhuQXByu
         9guQzA6477fLzPzawWUJ5gYj06/o4MbQQ9nvEoznJYCTQvvwkWqQ8I4lfDG0RlDWx6DB
         KhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OXkyZtVZ84paU131QdjLkvaDVS75Ha7ZnWK1vHWVPpk=;
        b=URPrzH8hlyj4wulo+mC0FccSyNvpt2uiDyNxNdC+iL4hvzsQbAZkxNpObjbUaP8Wrj
         8e039UarzZcJevI8PcG0wevf8qSHfIiOWLbYHBk+V47nCDpf+UC/2X5Ne/SxV1VgcGss
         Bq40uR7BvA3C8YgAMsqkRP214We5H2p6D7c3TDZLd1XewfbNEpNBEVQQtg2rHm3RN0bt
         PXfvkJXT1kQLqUBojVj9+CUGtjD4ywP/3BE8+N/lgd4ce3ZcvxqMDOgYGMAIAeHFs/hV
         ntOzuziHafc2FPDGkiCR/w18Cv6kJng6z7pHfk8Xc2MR7y9S9qzfZ2ypoDf6Ai3vcpRL
         yQrQ==
X-Gm-Message-State: AJcUuke8X5Ffo80ibgMz2Wl5R8IPCdkV4rZCNNQxWPG2JdbZ9Pxa78pQ
        qQxPPFO2Mca3Na+OpCDlFO4z/WqID1z0GgONc2p+T2BsJiAj7O8XJYgTpHmC3Z1syOFnB/mlPU3
        UjkTEhq0KF8P+rG+vQxbWnDbRjIB3
X-Received: by 2002:a24:648f:: with SMTP id t137mr12958102itc.95.1545846635999;
        Wed, 26 Dec 2018 09:50:35 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4pQKyNrbEnAVNXI7Ifx9Zhw2Pet8J4sxr8BIqeVuG3TW/L//KmCgUe6UXjjzwG/uP5bG7mYg==
X-Received: by 2002:a24:648f:: with SMTP id t137mr12958093itc.95.1545846635696;
        Wed, 26 Dec 2018 09:50:35 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id c2sm16235754ioh.29.2018.12.26.09.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 09:50:34 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: dsa: bcm_sf2: Propagate error value from mdio_write
Date:   Wed, 26 Dec 2018 11:50:01 -0600
Message-Id: <20181226175001.76546-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both bcm_sf2_sw_indir_rw and mdiobus_write_nested could fail, so let's
return their error codes upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/dsa/bcm_sf2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 2eb68769562c..73fbc16a1f86 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -305,9 +305,8 @@ static int bcm_sf2_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
 	if (addr == BRCM_PSEUDO_PHY_ADDR && priv->indir_phy_mask & BIT(addr))
 		bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
 	else
-		mdiobus_write_nested(priv->master_mii_bus, addr, regnum, val);
-
-	return 0;
+		return mdiobus_write_nested(priv->master_mii_bus,
+				addr, regnum, val);
 }
 
 static irqreturn_t bcm_sf2_switch_0_isr(int irq, void *dev_id)
-- 
2.17.2 (Apple Git-113)

