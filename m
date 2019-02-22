Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F6E207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjxHsCFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBVC2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:28:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46411 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBVC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:28:01 -0500
Received: by mail-oi1-f195.google.com with SMTP id j135so559740oib.13;
        Thu, 21 Feb 2019 18:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+IlDbVcA9kbchGRjzjxSkS7UtGRCYDfkxGLpULHzuhA=;
        b=GjxHsCFLZ891Fhrq/I9TZgH7ubK3dMUSz9CZS7WzdWSCvDc1ctvxiknO4E3dovRu30
         IGROhRnNghQbjNHD1XkdD8vTsIF3gHxolifEL7jFeReJ8pBFsSbsMcdw54vqV0QatHfy
         YybBU0FhCYCupwpzgqh9ANkuJZJa4Mn+eOvIkC0O1RizqGknai+KCjKfI3S4KIqsf6pF
         ltUM7GLaL23x6wxpINcj0w/jXPwSTbheINuZ2UnbEH5z7VAzldR8+pFYZSRywh//khW2
         9/ZUxg2GMSsrtJPiXoufgd/Sr+jrRFOuZFdeky6CZ7CcK7ma2VgZ3UfXlze8HzxEvpQ2
         S3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+IlDbVcA9kbchGRjzjxSkS7UtGRCYDfkxGLpULHzuhA=;
        b=pnqUXH9Xda53wUOhsLrqY6uXE3Jz8wJWBH5xznY/+J4J4dScWP+HhKFuOytBppnY2K
         esVjDQ4g0uZUhL50BpBdv8JpDGXut2gCxwGasr3EKvRvCAe3Mn4ydNhiWsGB9rviaUE/
         Uo41y/Q/QRUXLUqqkABXpkGHen1BlPAPNruHd7zvLY/RQL9wc9YIZwFaIyHlOa+k4ghl
         caDBIyyq+XEyCmxNA/BWTobraedHep1RvyUeXfhRjMJADXLPhaschF7Hy9jRjPKORMgc
         1BxIqYqtklM9OaKqto0WLX1bwvm7iHs1VGd1pf4lnd46k1+1YCSw22OQ/qhQBKouYIlf
         Xwgg==
X-Gm-Message-State: AHQUAuZ9KMfZ8pCmCYGiMJNu+cODyBX1F3IXLrpflNY5ybGVwMnXbf+Z
        8MiPPk/BrcjFEGZzkbmOuKYru/EQ
X-Google-Smtp-Source: AHgI3IaTfOStWgAdNhL+eABhRN1OW5QX38G32UA1KGcFMKCWd/DcHnqwgeOymyHQU8uYnbyUCUa2qQ==
X-Received: by 2002:aca:e690:: with SMTP id d138mr1096445oih.109.1550802480365;
        Thu, 21 Feb 2019 18:28:00 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id w200sm98521oif.13.2019.02.21.18.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 18:27:59 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     sfr@canb.auug.org.au, Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] rocker: Add missing break for PRE_BRIDGE_FLAGS
Date:   Thu, 21 Feb 2019 18:26:46 -0800
Message-Id: <20190222022647.20144-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A missing break keyword should have been added after adding support for
PRE_BRIDGE_FLAGS.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 93700458ff63 ("rocker: Check Handle PORT_PRE_BRIDGE_FLAGS")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 8200fbf91306..309a6bf9130c 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2083,6 +2083,7 @@ static int rocker_port_attr_set(struct net_device *dev,
 		err = rocker_world_port_attr_pre_bridge_flags_set(rocker_port,
 							      attr->u.brport_flags,
 							      trans);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = rocker_world_port_attr_bridge_flags_set(rocker_port,
 							      attr->u.brport_flags,
-- 
2.19.1

