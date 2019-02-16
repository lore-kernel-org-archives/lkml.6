Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74CEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FA2222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxpCmzVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394631AbfBPE4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:56:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35236 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfBPE4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:56:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so20225696otm.2;
        Fri, 15 Feb 2019 20:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGQEeKs0wF3WsHP8KjXvQrPiN22+b85NexF3bnAlxpE=;
        b=XxpCmzVLVsxBd3x3MTABjyCfOsgnHW8mxlpLQxxw+cj4fNt3Zg6/qoRk9965QW5gXd
         xfkSRccVcJTxtkkc9jd26H0K89M8QetBORO90/EvlM6Esmk22DdiXlAMisy6Zh4PCnDP
         TvgqAYJHEyVRHzWSr/ztgEOZ8c/X40UGFDGMhsr3FLh9AOPlvyD0pQoD0MQpZkURP8qY
         XLR/8qhi0c0WDC4QgFIAA7RjOuIoS+nC8q/c/gthRkVvCO9dW+CZvGnWCClP0KHTiYX0
         cw5SlLoZimUy2wImNtE7WFkZuTCgNY6jiq1JHbN5IPMqOoWcSVA8Gj49oeOszCRyb8Uq
         u7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGQEeKs0wF3WsHP8KjXvQrPiN22+b85NexF3bnAlxpE=;
        b=m1Iyfmy5EMmlRBMniryNA5r3u2aJ5HuaLrgAJ6KIWFu61Lq2jf+uibt1Bnwqq8YiQt
         1/drSdsP/tGrZv1X0vIHp5s3seXrtpoWTzfHG6+KrHACq4KhBvB91jDwHALBNsIRv7Hm
         PSU6k82yLrB0UHKj875H/Gf2P/pfGSpT1iKeBAgF7zRGb/Lq1tJB7ydbdbZFLaSAdT/U
         SUbzlpnD6QmngYkmsk10gJ/MNTH/5kVYdtWByko5YrBsrESfvGfKQaJKLfhR3wj1lHys
         qNtR2jyFb2hFcLdafpLj7PVgukpd9GVIOtTtE9c1jJwFv38VQFFFXamwUG93j43HK74y
         eJBQ==
X-Gm-Message-State: AHQUAuYRY/fnGSTcb7wJIJ3ue+fNs0EIaMQIVOTLn0Q/NMNKGTNDAuYb
        17KKejGJXKNz20si5Ffxi9eObAmU
X-Google-Smtp-Source: AHgI3IaFg0JUDWysdNjBaFbOg8x1b9298AJeP9v/EAIIkmkYtfFHtc5l+4uKc2O1DSUHnip5FJOxXw==
X-Received: by 2002:aca:dec4:: with SMTP id v187mr8323834oig.92.1550292965170;
        Fri, 15 Feb 2019 20:56:05 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id j88sm3209480otj.47.2019.02.15.20.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 20:56:04 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 1/9] Documentation: networking: switchdev: Update port parent ID section
Date:   Fri, 15 Feb 2019 20:55:48 -0800
Message-Id: <20190216045556.3514-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190216045556.3514-1-f.fainelli@gmail.com>
References: <20190216045556.3514-1-f.fainelli@gmail.com>
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

