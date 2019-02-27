Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C06C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6AD217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKo+tzDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfB0Tpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:45:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34167 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbfB0Tph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:45:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id u9so8507084pfn.1;
        Wed, 27 Feb 2019 11:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LyKdp20X8t4ovPHYE9CH/9hVrvQZYs4Dq33a5OBgkXM=;
        b=IKo+tzDYXiJOFmVxguVT0RQ6ERPwraLN3v6sMZ+GmJPw2HBfhSNKY5Y7wckZAEuUSA
         nWOBYCOmKK6VfkVg4iN9i3e6YVr3bHGOWgvI9qJwaSui1uhTcVquwNbz2XTL2SGi7NOr
         vNh1j20yyeoE1QL8XjWlgEEvPt3fmXZoxaNMA0hgvIkCfPqJZbDX+rrCJYajTpiBkaMN
         iLshKNTvrF6oaytkZtpvpB3wXwY4b6uUl8Bo1WRqTz5SRwB0HF7qxo2fI7ObnT05QuLw
         zzg0CEQXmWPPkDa3kyAwE1Ja1uxSteqFIOEKr/9QC3P+iNRq/CGVIBs152kSBleNNVr9
         /Nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LyKdp20X8t4ovPHYE9CH/9hVrvQZYs4Dq33a5OBgkXM=;
        b=mLNkT3rXge+VjCfXdA15K+OfK00zfi6nJbLW+2WLFyIxAK7WwwAX1gNgOKlYT99Rkj
         Tkuo4ZDFIMIs3vF1hed+NSUKYHWcTN2tD8JwMmMtvyr4BgoiqQT+JbcV/wiFSbpIcHhB
         VDrkTkMUYeNQCktRs/apoGpzGlKtfAJGnerIp68cV/mqt7Rw3RNiExqs6RuywYHEvUld
         0GeBDQd7EK7s5glnXf7RG2eETNG/edJNan/u2J8CY6QRpj+MjHBziW2ehlCdNYWxcuvj
         aexNdoHAbLR0yCbYMpYr+hIBDCcYbCajAUJ8e1SLTleV3/edWcoDRU9ml4XCRK1cXifh
         HW1g==
X-Gm-Message-State: AHQUAuYPqdtHRgPd0Qmj9AXbMaXyitBnSYSk7pPP1gDmyAlBVl4DsPw4
        8muqIS8TQht8AfTUq6N3Ry9dNuFN
X-Google-Smtp-Source: AHgI3IbG6+GrRIYhAOdfqGUavfRKLsxF6QitD2okZLlXdOGARmxhEKwZgpMWikXT+xv0NZYt6jFSow==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr657594pgc.366.1551296735881;
        Wed, 27 Feb 2019 11:45:35 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j6sm17044642pgq.33.2019.02.27.11.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 11:45:35 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 6/8] staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Wed, 27 Feb 2019 11:44:30 -0800
Message-Id: <20190227194432.725-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227194432.725-1-f.fainelli@gmail.com>
References: <20190227194432.725-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use a blocking notifier to perform those tasks.

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
swdev_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 018399ee8731..b0d2d9bf2532 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -929,6 +929,19 @@ static const struct switchdev_ops ethsw_port_switchdev_ops = {
 	.switchdev_port_attr_set	= swdev_port_attr_set,
 };
 
+static int
+ethsw_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = swdev_port_attr_set(netdev, port_attr_info->attr,
+				  port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 /* For the moment, only flood setting needs to be updated */
 static int port_bridge_join(struct net_device *netdev,
 			    struct net_device *upper_dev)
@@ -1047,6 +1060,12 @@ static int port_switchdev_event(struct notifier_block *unused,
 	struct ethsw_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 
+	if (!ethsw_port_dev_check(dev))
+		return NOTIFY_DONE;
+
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return ethsw_switchdev_port_attr_set_event(dev, ptr);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
@@ -1115,6 +1134,8 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ethsw_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

