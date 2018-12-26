Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCB4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5793218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nZT4hEmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeLZSWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 13:22:37 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:53008 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeLZSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 13:22:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 913B3C17
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 18:22:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NvOgM_fo4mEA for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 12:22:35 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 5B87E95B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 12:22:35 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id q207so17685589iod.18
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 10:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DQ0rWibMm/cd/dFLHvxTM+AqaDAMA+FVrvqKAFKGGQY=;
        b=nZT4hEmTP73erko1pv0hlIhmrrmARaDdmGc4DbnqhCusBuz6OeQSLgbWMQ/DobYmjH
         gmLZnWheVZEOnUwwGISHUB2lo6g514MZHyKN1DfIti7Wip7YlQo0SjF4ha13s0HicId0
         JK70I/QGdzYYuO9YendaV/ad3Vzl4jqHoxb2P/egDeV94ot4jIIrwlxodHFTPBhtPtYi
         C9vxcoKKIId6/ajRzc167q8wVVPkc01vYyt+0+KJiWy0FaV/JWGZpWE0g2t3hRhwd9X5
         VLyOKigvzA6IE4T+sV2nz/NICma7GRq+4aVCsJiOx3+JGaisjmy6pnqy/bJCI4vU2ydf
         qGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DQ0rWibMm/cd/dFLHvxTM+AqaDAMA+FVrvqKAFKGGQY=;
        b=jNqfROzsmA93uOz2+l86xHxINqZSLw92dar1Sb7ND5GEX1A1gDX7E2aXqNzKJU7Sfb
         TfC6/Xt4VwL7KxodnzksinU+cE/dlOy8+q8ndfesv4lxnfo5M08xig/Elyh/wTSznm7B
         RsPWxTjeyRik4aI7rc4qhHPg478zlnwEiAJPc/juuF4+8r1dnxvNrsv8ZuUxiCoPctmZ
         lmsK2o6T8wYnmhURSbEsL83l+imSBmfmHQ3EccXy4Pq0NLS2tnyF663mm3VLcWMHD43y
         p4Sxg4uHyOmMRfL1sVnuJmKjy1Vl2qKsjoMLGTLwaIKgUkUB4NTiUOB77Uj2Vk6Hpc6X
         LWaA==
X-Gm-Message-State: AA+aEWZ0ASA74R0WZ+lSj2C7cZwqBuQUbhufjPYnZjiI3fCJKcYUcbzh
        EJrGPiOlc1TX2zB25C2dx3tVya+sZod8+UcQjr8NAD6vYFqfSY4EMcciJW5fnx/dKYkF4v9jzhk
        6QOWQNAoCsQlAvBO2UMReWqmelePB
X-Received: by 2002:a24:b518:: with SMTP id v24mr14677177ite.159.1545848554517;
        Wed, 26 Dec 2018 10:22:34 -0800 (PST)
X-Google-Smtp-Source: AFSGD/Uwpc0YwXLiVQ/ppaeDFNOtO1GQWtg1i4+rS/2H42opUiyI6R+L/hWGNUS04ubWQMHQ7jp7Cg==
X-Received: by 2002:a24:b518:: with SMTP id v24mr14677159ite.159.1545848554193;
        Wed, 26 Dec 2018 10:22:34 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id n16sm16422636iom.58.2018.12.26.10.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 10:22:33 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: bcm_sf2: Propagate error value from mdio_write
Date:   Wed, 26 Dec 2018 12:21:31 -0600
Message-Id: <20181226182132.76798-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both bcm_sf2_sw_indir_rw and mdiobus_write_nested could fail, so let's
return their error codes upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/dsa/bcm_sf2.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 2eb68769562c..236815700fba 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -303,11 +303,10 @@ static int bcm_sf2_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
 	 * send them to our master MDIO bus controller
 	 */
 	if (addr == BRCM_PSEUDO_PHY_ADDR && priv->indir_phy_mask & BIT(addr))
-		bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
+		return bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
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

