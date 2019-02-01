Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503BDC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4492146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpiVXYoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfBAWKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:10:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41390 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfBAWIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so3874858pfi.8;
        Fri, 01 Feb 2019 14:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+1Zk2PiDZisJMq0/a8SJAvhMJmNAIi6Lssg2ko3q5F4=;
        b=BpiVXYoVfsUFnaMTdAP8HoVRfeWlLCkzeuE8KdONfzWzAUjGopUS7k7B2ZFf7c6bxW
         s7cmqNwWRpysApa4ITRHqtaPZYfMKEny9yxTne/IPfbZjSw4Xgu+hTlx8otTMT3Px7+x
         YrGL8Pqcpy0p7kg6fEghIxblZ0j90LurVnxMAZsS/kOFeDuoU/SX135NK12ThWvls80z
         uJ2v9QvJ2YWnbvfvell9Zo1f8kF4Mj1q7yxo3RPnFb6mu0Q4dep7rFn0rS9Mioit3gTl
         m5woJg9qRKue+j2dpos0engiTinnTuiaGH2HpG+LXqa7wc5Fzn5+QR8AivXkD1LcrwEw
         d4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+1Zk2PiDZisJMq0/a8SJAvhMJmNAIi6Lssg2ko3q5F4=;
        b=qs77w/hZEAhSOmK590oJQB3K96NMFY1F7jHhXevZJ2Cj7l0Qony+DKkyEFKc2C//2l
         v/FY3AomK89nIkV1vSNidgIukCbXSmCqumMoZwP3uoRUSXPS/Xtl9t+dMXjs/oPBbsFb
         PC67eum7tUy3junM7B04Dk2/lam+SDusggHmX828DawCBhFxi52mQPvaabGGtuQxRJKh
         vj3ja6OQ7TEzoVBDIxm+1tBFvoYUYQ0exRsTYbZFbXRPw5j+3mo1dN/qy5GUPKhu8vLQ
         vZSyRZ7mOyGQIBucnkd3+REvRx35FjgL95s0KUIEGSRUHXQFCfP2IbkBFp+T5mmLPzR/
         IW9A==
X-Gm-Message-State: AHQUAuakqQr9nHLD13FLI7s8mU2LdctHXIyF3PgRyvOIx8cCMx/8hASD
        aMuAaqufPR9bgfelAyGTzPj8UoLy
X-Google-Smtp-Source: AHgI3Ibygr1MEEPAJUeeIxuBOR2v+dVHjva/BA27w8cmejBypTL3IEo0KYsfailo9LatKwNbdyi9/A==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr1457569pgc.200.1549058884839;
        Fri, 01 Feb 2019 14:08:04 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:04 -0800 (PST)
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
Subject: [RFC net-next 02/13] rocker: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Fri,  1 Feb 2019 14:06:46 -0800
Message-Id: <20190201220657.30170-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
rocker_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 62a205eba9f7..f25f7b4345b8 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2827,6 +2827,27 @@ rocker_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+rocker_switchdev_port_attr_event(unsigned long event, struct net_device *netdev,
+				 struct switchdev_notifier_port_attr_info
+				 *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = rocker_port_attr_set(netdev, port_attr_info->attr,
+					   port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = rocker_port_attr_get(netdev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -2839,6 +2860,9 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return rocker_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+	case SWITCHDEV_PORT_ATTR_GET:
+		return rocker_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

