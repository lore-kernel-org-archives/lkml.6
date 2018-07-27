Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6E7C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F0B20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRKwQmiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F0B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbeG0J23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:28:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44471 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeG0J23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:28:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so2781810pgp.11;
        Fri, 27 Jul 2018 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qzVHO/6sRR1GOrx8CgUKWp1sL45+HfcyKN9jRLMtR+Y=;
        b=BRKwQmiIpymZ+OesLXnursMQJlKSI0gJC1SFJRjNiNiSpDvFOGLw/wAhbJTSazeXcS
         fCaYjRznAW00hZ/6yjvdoCCzNkHa6V1C9vN4uzoaYProX72rF3yIG+81pRxWeVeSmYF4
         PiDuwYPflwbvzAYQ4Q9x5lkPDR61iI/KAIGs9WMt6X/P8Asbpw0DN0gEOPkBXoC6wx27
         4fFsHLzyglOoDyhKd3njiau0bTzdNMwIE4dXdXM9Gp729PfizshmFXC+UDmJuZ8/CuCn
         2pzmGjXnvKhdNciGcfeRpCIl242v5j372tbS8M7aEzrbBitX6FusSZ8s9XB1H8F/BE3S
         +ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qzVHO/6sRR1GOrx8CgUKWp1sL45+HfcyKN9jRLMtR+Y=;
        b=qsbnXyl0I/XxfoPB74ednitLnFWtiJaltM5XSGcc/tEU/rH4urHQPa2ElmKcvHGBFH
         ryngjhS5Jix4nplp6GocCxY+hbOwH+fhj7bnQLr05e0ZWRpdkRELmNnY+0p9iHaWmTfO
         oJ8dHbNJgDR84wKO+U1hfMf8Gc4DvEMwXovOLe4CS0vjI+OaKSvu0U6SizWefS4RMtPX
         +RUOjPE+GJHSIvApZ5KDhvZ6qy+RYn/Hq8TwfXkNGMuThK9fp5qn2K6+liwKHibQ4J/h
         U86PXGDav8GRliPDnApGyWVpP69Fm4OVsVHOX2+Y9s4EsT0DboHIDWavQn8Djj+8mbJ/
         7wqQ==
X-Gm-Message-State: AOUpUlGQ4Co46ot32liX4j8kiX1cem+kF9Y6/oWANLmT341sWJ183uuQ
        02ZgnLFOmu/5dDbK2Ff2ks0=
X-Google-Smtp-Source: AAOMgpd2T4kwj3lkyyl5TGoXT7oyljRiAzOA6aQkeWvFaabIhFY72fLT5t4K4hPIqopSR4FWdBfiYg==
X-Received: by 2002:a63:e116:: with SMTP id z22-v6mr4904421pgh.89.1532678866556;
        Fri, 27 Jul 2018 01:07:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id l27-v6sm6302873pfi.180.2018.07.27.01.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:07:46 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jeffrey.t.kirsher@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: intel: igb: Replace mdelay() with msleep() in igb_integrated_phy_loopback()
Date:   Fri, 27 Jul 2018 16:07:38 +0800
Message-Id: <20180727080738.3301-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

igb_integrated_phy_loopback() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index e77ba0d5866d..4e64c9a6f1b6 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -1670,7 +1670,7 @@ static int igb_integrated_phy_loopback(struct igb_adapter *adapter)
 	if (hw->phy.type == e1000_phy_m88)
 		igb_phy_disable_receiver(adapter);
 
-	mdelay(500);
+	msleep(500);
 	return 0;
 }
 
-- 
2.17.0

