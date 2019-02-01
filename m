Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEB52146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFbBGgNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfBAWIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34477 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBAWID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id d9so57158pgl.1;
        Fri, 01 Feb 2019 14:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LbwCkocaVeKZW46o1m4njjA34ZciXtRR3TEQF+D/wBU=;
        b=RFbBGgNSMA6OPWPHXUTOpWh/ElFGHNdZwtHYgjM61k3NqlIo9dpC1aLxyPM4V8B5uy
         VKgkSPbqCZVF89TOX5KKfknEYZkSAusJsz3zry5+OGxQqOLnod2HicqtQJSdjMp62FxU
         uFRVjsCTiOQ5LfQPA6xFh/aP2edW0aF5wki3f7oeGe260yH+EBt4rtV7ujyfDNOzbMiW
         pqAFHKx5EYwfqLAqBvVq1wOSfLvxPoafCjWmGLE3n/G06h2Cq33InUW/QhNB/GVkBR7E
         gGLDbQSzk+/7tJ74M1qU3STSgHY/CmB+U2F3NKlbaApqiHWdIITWfMBlA8EPxXUKNFM2
         9iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LbwCkocaVeKZW46o1m4njjA34ZciXtRR3TEQF+D/wBU=;
        b=G08xC/FWwBqSKke0ZK6OC5KAP1IgFaNaKb2+bIH+Oq0p1+b4l7l7voPrlBRrjya8u6
         wF0JPUCNf/Z3vGvdD3kX9VCwjhSTY9HuDdjkj2Dyf1kc4pmPrjPEWxcYD9mn/D/amx3Z
         vPWHU9+tPgrEHTzhRKHsyXcGWSqElUOhh1QLdoJ+hX63OIlppcrY+rehU7+NHpOHK0ME
         VHuTFXe6jRea9JSLRiiggTQKiWmGTLVPBi0/z0IdZhMXewCLd4h84ZPc2uWIcsiO1MN3
         4CIYUNAYecSS39OtLonixdapzrcb9e3bRfMORxXgPwEiD8HmU+qPdYWmx2hLiQ4/FK0E
         mfBg==
X-Gm-Message-State: AJcUukccAzjxMkLEEwD3WqLXbhgt8zrQUH1/Pf81YE1OBoELNWjwttrZ
        b0unEB/8Ba8NTfTrKPCQ+jz8iRL4
X-Google-Smtp-Source: ALg8bN47oyaYouRemq/rIUKbK6tZSG2xrL3h7i78UEiZiMWmlflWy2C1l14xqAFJRhKqEasJI7PSsg==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr36401986pgc.216.1549058882394;
        Fri, 01 Feb 2019 14:08:02 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:01 -0800 (PST)
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
Subject: [RFC net-next 01/13] switchdev: Add SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
Date:   Fri,  1 Feb 2019 14:06:45 -0800
Message-Id: <20190201220657.30170-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing switchdev enabled drivers to veto specific
attribute settings from within the context of the caller, introduce a
new switchdev notifier type for port attributes.

Suggested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 63843ae5dc81..e62fb2693e00 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -145,6 +145,9 @@ enum switchdev_notifier_type {
 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_OFFLOADED,
+
+	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_GET, /* Blocking. */
 };
 
 struct switchdev_notifier_info {
@@ -167,6 +170,13 @@ struct switchdev_notifier_port_obj_info {
 	bool handled;
 };
 
+struct switchdev_notifier_port_attr_info {
+	struct switchdev_notifier_info info; /* must be first */
+	struct switchdev_attr *attr;
+	struct switchdev_trans *trans;
+	bool handled;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
-- 
2.17.1

