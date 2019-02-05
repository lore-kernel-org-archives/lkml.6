Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0D6C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4922183E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYBFggBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfBEX4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:56:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46713 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfBEXz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:55:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id o6so2239380pls.13;
        Tue, 05 Feb 2019 15:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FtkP+LHS9beMQbwAZ2URo6E44LQ0Jw0xcba93MNhkCA=;
        b=lYBFggBgD6/pL1x5YLKC0n9blvwalmvTGeRdY1RzKakvbJBpBxVj0quO9pzi4y8Nkp
         b2ACS1kqecDtlor0EbYHMjw5YkiMZH1NCKkYf6EY9k9e7ng9av7DSibJtwkMKdeW8kib
         4KFH9wnpkp6EuHUDbAM1h59NsPmZkr4/2Zdtxfl9gSMmBEeaaOOiYBtVWhmxyW3LJOgH
         Ivt3U5HigPrTSx5FL+JVHk3JXCq5vIeTCiw1vDHaa3qBygt8z8QXTnlGxWkk1fTzIO77
         KIHS9OxSqX4oGUD/fDKoyoF0D1OYnwW8D/+AXT7I3Ro1c60eTW1KCZsMkR6EKtEcL84u
         F2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FtkP+LHS9beMQbwAZ2URo6E44LQ0Jw0xcba93MNhkCA=;
        b=IUAmbvLl8B++pLwjBYHUQedqDA5Z4zGGvSIMHviBK8EPzp4nY2mLzasv2I8bMk8lb2
         uNbArCe3tHxt6TRDfylbXTNGC0QKpLtPK3y3Hc/bdB6GiJDyULcrYDaB+j3xy0TWvjX9
         dDrl5y7q6nnui4bQ8o2D22JaifGQi8kFolpY5FZH3v1WUeXMQexZH4pQVQnkjmSPOJAk
         9ojGZg2CMANh46gRpQ454p7RdmWPMpE6l3vMOXkpWZbeaRfOcbd3lGVfbISfZmLmgUf2
         2vuxX2oF++QcGE/A98vQMMUf5Ctn1PZDYgJCKy+2+usVuVlrmvmQW5f9WRvB2ofUch46
         s57Q==
X-Gm-Message-State: AHQUAuYp3p+Gq29PfO5aw1Jq5BW0yuRzv6AsWnxZpZuCOSF/6xFb7f8+
        fmG00QsK2xJL/Tn7c0MToWXBlHYz
X-Google-Smtp-Source: AHgI3IZ7g+QdeWkW1HOaE/vZJGBhRkJbogkLKGrTRzpP8xDUTWYn+vX/iPDOiFUwH9G16fkYbtnvnA==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12mr7476791plb.299.1549410956780;
        Tue, 05 Feb 2019 15:55:56 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v184sm6770197pfb.182.2019.02.05.15.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:55:55 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE)
Subject: [PATCH net-next v3 10/12] staging: fsl-dpaa2: ethsw: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 15:53:24 -0800
Message-Id: <20190205235326.14600-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205235326.14600-1-f.fainelli@gmail.com>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ethsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
of switchdev_ops eventually, ease that migration by implementing a
ndo_get_port_parent_id() function which returns what
switchdev_port_attr_get() would do.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index daabaceeea52..e559f4c25cf7 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -505,6 +505,17 @@ static netdev_tx_t port_dropframe(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static int swdev_get_port_parent_id(struct net_device *dev,
+				    struct netdev_phys_item_id *ppid)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
+
+	ppid->id_len = 1;
+	ppid->id[0] = port_priv->ethsw_data->dev_id;
+
+	return 0;
+}
+
 static const struct net_device_ops ethsw_port_ops = {
 	.ndo_open		= port_open,
 	.ndo_stop		= port_stop,
@@ -515,6 +526,7 @@ static const struct net_device_ops ethsw_port_ops = {
 	.ndo_get_offload_stats	= port_get_offload_stats,
 
 	.ndo_start_xmit		= port_dropframe,
+	.ndo_get_port_parent_id	= swdev_get_port_parent_id,
 };
 
 static void ethsw_links_state_update(struct ethsw_core *ethsw)
@@ -634,10 +646,6 @@ static int swdev_port_attr_get(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = 1;
-		attr->u.ppid.id[0] = port_priv->ethsw_data->dev_id;
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		attr->u.brport_flags =
 			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
-- 
2.17.1

