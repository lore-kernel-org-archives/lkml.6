Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF88C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A802146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD257aAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBAWIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38108 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBAWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so3887762plb.5;
        Fri, 01 Feb 2019 14:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FKCIMCyyfN1QkkeHgOqs2oTy49pc5Z+rv4NjsW0Dv0o=;
        b=DD257aAjioCFNHxiYzBeOgHIb9oZEXYgIWX6U9NMdBDijp+PBdL5YOlQ+NqHlCZxHK
         YSRNs0O7nmbfucgo8K/9Kj4N9eEWUJcLBEqU8yqKNvkNoXnCHtpEgEtmWQgt9Hi3z9Fh
         qVQFWnnlNJSKNAWd1aZ8CPazEOQyinBg5Y6N+ffxExKOhXMOoCmWME8S0NJN/Ew3Jb7S
         gedunAfF8p3aDtfTSAhryRvV02ZXdBVOR5YNVmCIkb+EkGR7MfHGKp8mcNUGZ72Wt+WQ
         mOTHJDgEel8XOXVbZWIghpDLRH19K2+MXkgIYwPdfwuWz88LMv0wUETDnX3WyMXum3+o
         e94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FKCIMCyyfN1QkkeHgOqs2oTy49pc5Z+rv4NjsW0Dv0o=;
        b=be2PZNuL29/E7kQZygajX2nlnFTpIXE0yvbpBwqAWAxXDyxv4q5RIbPk8HQMj7n2LV
         TnrqcFzExKYezK6/CvmD1U6xZ86tq//GdH1XS6n0UzhjjEyJ5vGjmDZuDTXZSBGJbYcP
         S7A5QusRwxgJRgI63g7EXC1curjpFIhckiM4vVsEmW3fwQmDcKiX4iRCKyQ9fqJ9MO9o
         fWNxxtqDdYr/lDLCOvys30mI0iAcOiVhYhqu8Xq3HsNRFNiNz5IvaOV3UxIu77l4w3GZ
         Z06hIxFKb4ObASRzR/lnPVV1mE32xZr3qS/mazTEh3NRmfcG9QPEybPcXoNq8X5EWvRl
         +JzA==
X-Gm-Message-State: AJcUukcD5kpF2HlkcD/W5gcupf9VnyQe0FRjsfrpwH3xmLUQ5tWY3Mzd
        4UkJdFqpcLNlX6iCunrvPehagYV2
X-Google-Smtp-Source: ALg8bN5f9VF8ObGdMSocNNty0nu+ftWtyuORRxXb5O+3ntXPqb+HQqBBv4pV4RuPkoWwjBoyRzmC7A==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr42186693pll.51.1549058887257;
        Fri, 01 Feb 2019 14:08:07 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:06 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "Francois H. Theron" <francois.theron@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        John Hurley <john.hurley@netronome.com>,
        Edwin Peer <edwin.peer@netronome.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Subject: [RFC net-next 03/13] net: dsa: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Fri,  1 Feb 2019 14:06:47 -0800
Message-Id: <20190201220657.30170-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
dsa_slave_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 91de3a663226..bc7d5092a1c7 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1549,6 +1549,27 @@ dsa_slave_switchdev_port_obj_event(unsigned long event,
 	return notifier_from_errno(err);
 }
 
+static int
+dsa_slave_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
+					      port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = dsa_slave_port_attr_get(netdev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 					      unsigned long event, void *ptr)
 {
@@ -1561,6 +1582,9 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET: /* fallthrough */
+	case SWITCHDEV_PORT_ATTR_GET:
+		return dsa_slave_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

