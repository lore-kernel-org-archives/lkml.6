Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC6C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E64320874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVfJJ2Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfBJRxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38876 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfBJRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:18 -0500
Received: by mail-ot1-f67.google.com with SMTP id m1so2175901otf.5;
        Sun, 10 Feb 2019 09:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7L0xTa6HUjap5hvS5D6PfDYA/2qTJS8vMeAX54+U6P8=;
        b=AVfJJ2Z3BJxohhvaJosGHfmuHpolN4+mn5xeHpQxDwgH3+SrEUl98/yXAbSXa6HrrI
         4JvrRQVv7UzDD9bz2MhL4WnF+YaOqQNAFun0jH3RrPQinnlWTyhDy86oazrKG/TLUpwN
         PwvUIgLrxVT4L4harlpMJVk2jgKcAEkmM/k+JkSvW1ESuJ6L/Bu3/L3JczIwvKGnEQhH
         ZXBhOpqk4zcQBJ6zfETqsl/Jt3lo8zzqiss7oc01+1xpY8Hzs9Y1U6ehGcw4SeVkgoKi
         5TEuayykwBgMfDShRSR+BIdrNZV53/w5T++btSZtuRGJVQYGaxm3Qdm7MAQtLtBHY+tD
         Mp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7L0xTa6HUjap5hvS5D6PfDYA/2qTJS8vMeAX54+U6P8=;
        b=PymcQOU53JKKcxslbKbEZm/k0k4fHA7JkfEUdjehENhTqxG8iIb2nfTV3KSfZrAgZ6
         Yms0/APDoubN/hKteBGdE9stVpoCgjxJfxAJS0WnP1Ju8te518FwjQX5EzeZfJYScX2K
         GSuPf3lWWMWAOhev0OctKfBhC5GuSvK+NbDsMttO60RUzBfBNmSd+xfYCNCSxcWawXCb
         uNZtRm87cMWKPWd7yeJRqOj5FQJdZTD7ZT5fUeGYgIyBxxkYabBVdR4BhY6od0OeL89j
         XAXLaPpRu3CpgXO7L6d33djTY/CnzGKf0OP3GE0mXrRpRkIKHsA0AVKynXio6ErwnHb1
         7lQA==
X-Gm-Message-State: AHQUAuaPz7g1KFpVHCL/kdOybC5gCuHeuHautLU25EPKjs/veSN3NSmJ
        8xVkyrjSoZYRzBcEFiUjwnO4AQdT
X-Google-Smtp-Source: AHgI3Ib1A5lZZQ8e8yQ+YV5QbtehTyUkPyZ4hYHVIq/F2Eqg2s2apEjnRBiflVQripA0Mk+K9yQHAw==
X-Received: by 2002:a9d:644b:: with SMTP id m11mr12312054otl.90.1549821196362;
        Sun, 10 Feb 2019 09:53:16 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 01/16] Documentation: networking: switchdev: Update port parent ID section
Date:   Sun, 10 Feb 2019 09:50:50 -0800
Message-Id: <20190210175105.31629-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
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
2.19.1

