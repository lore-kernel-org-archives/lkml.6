Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A995C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 01:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE30720870
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 01:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6E5HK7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfAMB3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 20:29:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39478 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfAMB3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 20:29:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so7932344pgl.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 17:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qe7ypKblJkq/eW4paIX7q5kS22dE7KvzpId2BQAnWIk=;
        b=B6E5HK7v9tF6caPGq24VGq/s+eUPb4jMpD9zs/++pgxlMyxk/wSgT/1xM8IGMXvObB
         3OxTCOtQyDEHb+qwKvQgXtyNKnvV3TZ35nwgDJ8nWSy6vbyRiZGJ8wVTN5YnHxeojQJN
         5BHTlkL1dp6tBeRLG7yaaqRNCQhWc/s4+EAq+O/BD0t4PtfxS09RowZ6jx+UDSqmZUff
         1W4EdBaRm6KB+dgX0lWujUUhgOpwh+w609riQSu+HvdNZarZlhJUKUjQ8g3fIPMMwqAt
         zKJxqfGcuMorYSj81kQnOZpssd+XQjZ7zN7X61f22SdoZ3GoStxZGuW51f+PUO0HYNOB
         M8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qe7ypKblJkq/eW4paIX7q5kS22dE7KvzpId2BQAnWIk=;
        b=MLpuEW3uAgRSAAYoRsHsaUUaOUOw8//4wnkbG1XqY0tOfIriujdiplWflF1m+nALS7
         bisswhkgKBS0HkvvtX/RHa7KKqYE/wzcZhwzLOQnsieEFYaB8elGIg/p1vlKah1RC8Aw
         1EkEZ9XPVg3jpLNjqak5NGgKyzuZ+KyF08zSM2CAMjeHPYQj3qaPfrmU1PHwilCGblmr
         1u+ZvN8BR8rJxVmm4a7fuGCg0ZTF9xxNtc4YFkbB/FdKDjOsyaXzfAAob3h5L9ND6Gq0
         riQezMse4IXXkuwt87CoJKQMYrg0Z+s9h6x54ip8GA/cOyPpn7XIgVpBHhjs6BWi0Lha
         kJeQ==
X-Gm-Message-State: AJcUukc5xhBtijfbAdCXIgIoQZVYb2ve8kkV27luMCGeQml6uh6rv1Hb
        Yi6R78mqsEL04KH7sL7Hcx9zOx1d
X-Google-Smtp-Source: ALg8bN4GqDKSx30Me9zXeqBBPLc/9SkQ30dqrRFUfw5WiWc28VVixGX7N36F8UJvyOLX7u6poV3S2w==
X-Received: by 2002:a63:1d59:: with SMTP id d25mr18685308pgm.180.1547342954556;
        Sat, 12 Jan 2019 17:29:14 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c7sm165360529pfh.18.2019.01.12.17.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 17:29:13 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Rob Herring <robh@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/1] phy: fix build breakage: add PHY_MODE_SATA
Date:   Sat, 12 Jan 2019 17:29:09 -0800
Message-Id: <20190113012909.11986-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190113012909.11986-1-jhubbard@nvidia.com>
References: <20190113012909.11986-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Commit 49e54187ae0b ("ata: libahci_platform: comply to PHY framework") uses
the PHY_MODE_SATA, but that enum had not yet been added. This caused a
build failure for me, with today's linux.git.

Also, there is a potentially conflicting (mis-named) PHY_MODE_SATA, hiding
in the Marvell Berlin SATA PHY driver.

Fix the build by:

    1) Renaming Marvell's defined value to a more scoped name,
       in order to avoid any potential conflicts: PHY_BERLIN_MODE_SATA.

    2) Adding the missing enum, which was going to be added anyway as part
       of [1].

[1] https://lkml.kernel.org/r/20190108163124.6409-3-miquel.raynal@bootlin.com

Fixes: 49e54187ae0b ("ata: libahci_platform: comply to PHY framework")

Cc: Grzegorz Jaszczyk <jaz@semihalf.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/phy/marvell/phy-berlin-sata.c | 5 +++--
 include/linux/phy/phy.h               | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-berlin-sata.c b/drivers/phy/marvell/phy-berlin-sata.c
index a91fc67fc4e0..d70ba9bc42d9 100644
--- a/drivers/phy/marvell/phy-berlin-sata.c
+++ b/drivers/phy/marvell/phy-berlin-sata.c
@@ -32,7 +32,7 @@
 
 /* register 0x01 */
 #define REF_FREF_SEL_25		BIT(0)
-#define PHY_MODE_SATA		(0x0 << 5)
+#define PHY_BERLIN_MODE_SATA	(0x0 << 5)
 
 /* register 0x02 */
 #define USE_MAX_PLL_RATE	BIT(12)
@@ -102,7 +102,8 @@ static int phy_berlin_sata_power_on(struct phy *phy)
 
 	/* set PHY mode and ref freq to 25 MHz */
 	phy_berlin_sata_reg_setbits(ctrl_reg, priv->phy_base, 0x01,
-				    0x00ff, REF_FREF_SEL_25 | PHY_MODE_SATA);
+				    0x00ff,
+				    REF_FREF_SEL_25 | PHY_BERLIN_MODE_SATA);
 
 	/* set PHY up to 6 Gbps */
 	phy_berlin_sata_reg_setbits(ctrl_reg, priv->phy_base, 0x25,
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index e8e118d70fd7..3f350e2749fe 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -42,6 +42,7 @@ enum phy_mode {
 	PHY_MODE_PCIE,
 	PHY_MODE_ETHERNET,
 	PHY_MODE_MIPI_DPHY,
+	PHY_MODE_SATA
 };
 
 /**
-- 
2.20.1

