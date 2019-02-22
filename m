Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA94E20651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooggOJlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfBWAAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:00:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45210 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBWAAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:00:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id r14so1762556pls.12;
        Fri, 22 Feb 2019 16:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PQg9HVQIYqiPsBwNT6JyGAohQPDs6z9iGbY5s51mdrw=;
        b=ooggOJlx9eNugsNcErrVth1sEPtj3KdzUNJ0KHhgfgVYuleCK3JfCCy/g3VGEIOCLr
         JtapHDTkiAprmlSwVuIG0BzIMFN4SM10PKqy3AwI6EJiRIpVTJ/xDWF1QTIlXIUyI9bI
         vsdEPXS4wKM5/Py0Ery9JMlGvyMUCXwYWnIn/hnMwvK+8tY8VkEzjZ0HAhrqYB9ptPVQ
         GuPQnq48CC3VIGGrT67RdPcBwPv9kbpWQEt54BcCUEVwUlX0mQrCg+GGyQFs5eTKFGyf
         VkFk4QdtERNr0QUsC1wzN6JUKP1Qo3fXjq+o7B82PtO6vbXuK3k9Y8EziOWkXB883F7+
         nt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PQg9HVQIYqiPsBwNT6JyGAohQPDs6z9iGbY5s51mdrw=;
        b=YcA4pAPKOSlvms6ieK3ttR17vRvVLosMlkf1dEGnHiEJGPyvqhA0ejw/2jJR4YUIzK
         kCGKsIq8PCrVzRSTHy2hhI/ffY2SNkC5rOl+1aXFzR/JF2FiSa+d/lQ9XdZV8a5sCM59
         Zzsy04+VSTtXOZWA+Uji6LbNKeOUJACOpkUqCv0nDCPcftRxCl/5UNLw0nKMe7Vl2+g2
         hcnQaRm4zq46p4wbVg6DTFJCe9825nKvz4sLPXEb/p1XMnALM6V6MROzRzMmgTEwPgvI
         JDOfI8a6oPtJWLK71PmE2sPefnTV+3CvqkQhKkX41TIlY18pHlx+b0LJf190kJgQAcr3
         sr5w==
X-Gm-Message-State: AHQUAuZS14p6csYsKO3+tF9EicvfEsq3lnsvV+WflScAwzPjl9hKRGJ6
        Y2yLFaqJ+9xCyGqLhtx8cNbIx2ag
X-Google-Smtp-Source: AHgI3IZfWAmcz3kPdqGonBmyDcGqNzBDUfqLwAcI+8GGSl6cgxe6ctbTC0xx7UgVWjBWVK9bjPNuQw==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr6839313plp.8.1550880040921;
        Fri, 22 Feb 2019 16:00:40 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z12sm3327872pgv.0.2019.02.22.16.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:00:40 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 4/8] mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Fri, 22 Feb 2019 15:59:22 -0800
Message-Id: <20190222235927.10295-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use a notifier to perform those tasks.

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and utilize the switchdev_handle_port_attr_set()
to handle stacking of devices.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 766f5b5f1cf5..c1aedfea3a31 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3123,6 +3123,13 @@ static int mlxsw_sp_switchdev_event(struct notifier_block *unused,
 	struct net_device *br_dev;
 	int err;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET) {
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     mlxsw_sp_port_dev_check,
+						     mlxsw_sp_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
 	/* Tunnel devices are not our uppers, so check their master instead */
 	br_dev = netdev_master_upper_dev_get_rcu(dev);
 	if (!br_dev)
@@ -3446,6 +3453,11 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     mlxsw_sp_port_dev_check,
+						     mlxsw_sp_port_attr_set);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

