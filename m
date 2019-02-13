Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA647C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A104020842
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTyW9DBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392406AbfBMWHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:07:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39075 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbfBMWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:07:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so1816469pgp.6;
        Wed, 13 Feb 2019 14:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=whP2T31Mi9yk1nJwoFJ9GEi1TFBKA5bW2oJpYvjtFLM=;
        b=CTyW9DBGPDg9kgJF2ImT9OJfxJXgmtkjpQrzP9cY8KBy9RswNOIMfPUvAnRIH9AHO3
         UZA3YmOe2L0qaNA3lKDFiWivV/16BgnWGgU+kplCO3zRLH8s7neTJeAD/sSe9NX6N+Dl
         0EJevvdKre5PIL4S04rc7tfXDGmJ64KZB0Gq9a4mA1SPkX+dLrY67eq/0roqae9rl1hB
         vyttc7Xfm9G/ZlGEl9Nv/S20Y6MPsxf445dIS5aHLRfj3q6LHhZqDB4xrAgEq7PvQCKj
         7yGwwbK4HW4w6J21Jx04sl0dVpUdzGCsRPOlAgsce/cX+q4UeMUUceDpuFOjU20FLj/k
         JGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=whP2T31Mi9yk1nJwoFJ9GEi1TFBKA5bW2oJpYvjtFLM=;
        b=RJJ5b0TI7+b+pmchfm4wGLNpcT+EyLn7SsvgFxzqDlm+tjwI7gS/kF7sFoDLdN64hd
         S19IBTMXoD3UWP/hHR5smMZlv9v02LaO6OGrxC2m3Dq0IDgV3zYtzMEzCJqWbNB1QiDD
         Uf6yocjtBrvSWoAJOYQ3HI5niTarQI8D1tS7iovO8x3A/PDlpuNqXKgRTxymCAYCRzEV
         JbYIJMIFhHojk1IeOG7rmlUhkHY1AEPIWjD/ihtx5erEFRCThwyxowhJdga3fKknJy4z
         HrN9T62omEAHh1M5/c9nQM/PcrZB/C4J+rLLKPyb9VjZLEz5ybplYQeiMvbm5H82eHFZ
         KYKQ==
X-Gm-Message-State: AHQUAuYBXtP2XDMde8n6vjw6XFp4umsAbjiWG7l7DWn3CLgfV7oRE/Cd
        EUPtjF4tVT4AieLIRKwT0f4dXLap
X-Google-Smtp-Source: AHgI3IbMYhPy8O1Hl7g/4lzvjLOylhl07aqC4DTh7r4/4T3gNr4Gn2jdp5q70L6etllh8W2f07Iitw==
X-Received: by 2002:aa7:824f:: with SMTP id e15mr412033pfn.192.1550095635662;
        Wed, 13 Feb 2019 14:07:15 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o1sm383735pgn.63.2019.02.13.14.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:07:14 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 1/9] Documentation: networking: switchdev: Update port parent ID section
Date:   Wed, 13 Feb 2019 14:06:30 -0800
Message-Id: <20190213220638.1552-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
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
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index f3244d87512a..ea90243340a9 100644
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
+ndo_get_port_parent_id for each port netdev, returning the same physical ID for
+each port of a switch. The ID must be unique between switches on the same
+system. The ID does not need to be unique between switches on different
+systems.
 
 The switch ID is used to locate ports on a switch and to know if aggregated
 ports belong to the same switch.
-- 
2.17.1

