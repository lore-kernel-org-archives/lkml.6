Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6343C282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9365D20855
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmVg9qQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfBJXkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:40:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44280 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJXkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:40:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id g1so711091otj.11;
        Sun, 10 Feb 2019 15:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGQEeKs0wF3WsHP8KjXvQrPiN22+b85NexF3bnAlxpE=;
        b=cmVg9qQOPPaNBjQHy/gWSBVDgIr6lFg9d/mjiZtdp6lUBy6jpwkBg0DHfmw1mc2KO1
         Q6wLbsVnqZx2eCgy1Q7csK3SwkzZND2QSoqZT/Q7g4mPPwvGE006Pk3XI1pPZhJ7K88N
         OK38wHEkK/Uj1lHrsOhFQuU/ewfBdbOAo1gk+xWvApkMMR7FMxBbM22jTUBxuFkQSVg8
         ryKzoRAmM3j3VMRi/iCeksvJzch/l9syv2vpLc6F2XhdJ30DEWVAWJterJ0SqlSa81Xw
         sR6CxzpgBIW13jQN4wSHRqGihLRa7dQURIXmeDGRAHTRjrDvGp+pGdn2p7Y1nPh+/nW1
         GsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGQEeKs0wF3WsHP8KjXvQrPiN22+b85NexF3bnAlxpE=;
        b=VnPu563gQ1BoOKVRbxtTZ8v4KcdpMUESp8Cf3WrO/6QvHZSSwBIo4SbnFs/P2I1mmf
         mpoSrKaoLFjPZpSM+SgP2LMCmUDynmS8wW33veheivMmArWL6WZ+QKmI+KZ++Gy0j6ny
         cG5KzNCO2dg9adcAoBBDY0mOd2u28XQZ7tqq3dX7ksk0UQGjUlh5PBJSsRI0y4ThDEu6
         LEbcxjZz0Dl37UGrEaDr6LUmisQKQhRX0954zflQowynhWQbfp6ZurAuO7Qt7R8rhWmd
         WLSvRl1hrkIEmLIZIwV4Z6StOk/KuT71TOFl1ei56swgaGnQJVFuSX4aHjCGzJ0gcyEo
         4AiQ==
X-Gm-Message-State: AHQUAuYgQBrq2IMW5+rPcRFkHUp44G2Y3RCV7tEIDnQ0FyORLuurJmjU
        ik/bAaRnA9bgu+e4QRNJfV0RQ4Qu
X-Google-Smtp-Source: AHgI3Ib/yxaQK/tvQoQ2S9+y+57Zo40xkSN/XYIvbmSrejX8ER6BtYXNJhnNCPTcrpW6cnQmW9ve0A==
X-Received: by 2002:a9d:7417:: with SMTP id n23mr4468451otk.63.1549842016223;
        Sun, 10 Feb 2019 15:40:16 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v3sm4944269oib.57.2019.02.10.15.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 15:40:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 1/9] Documentation: networking: switchdev: Update port parent ID section
Date:   Sun, 10 Feb 2019 15:39:59 -0800
Message-Id: <20190210234007.16173-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the section about switchdev drivers having to implement a
switchdev_port_attr_get() function to return
SWITCHDEV_ATTR_ID_PORT_PARENT_ID since that is no longer valid after
commit bccb30254a4a ("net: Get rid of
SWITCHDEV_ATTR_ID_PORT_PARENT_ID").

Fixes: bccb30254a4a ("net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index f3244d87512a..2842f63ad47b 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -92,11 +92,11 @@ device.
 Switch ID
 ^^^^^^^^^
 
-The switchdev driver must implement the switchdev op switchdev_port_attr_get
-for SWITCHDEV_ATTR_ID_PORT_PARENT_ID for each port netdev, returning the same
-physical ID for each port of a switch.  The ID must be unique between switches
-on the same system.  The ID does not need to be unique between switches on
-different systems.
+The switchdev driver must implement the net_device operation
+ndo_get_port_parent_id for each port netdev,  returning the same physical ID
+for each port of a switch. The ID must be unique between switches on the same
+system. The ID does not need to be unique between switches on different
+systems.
 
 The switch ID is used to locate ports on a switch and to know if aggregated
 ports belong to the same switch.
-- 
2.19.1

