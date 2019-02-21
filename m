Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198D5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB38820855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF+5qWDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBUA6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:58:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44530 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBUA6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:58:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id y1so12817057pgk.11;
        Wed, 20 Feb 2019 16:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y8cTug1MK//k9Db5o5+0BQipNr3buFiSVSYrdmVTLt0=;
        b=eF+5qWDN7kVWTIqY7Wm2yb4JW+NNHnca8Tl6RbzAdWBMFFFnfkUsk8cGJo/Rm9qfJx
         tnnNQMBwkdH8OvkYK4hlfdGr0ylWAP3bWGG/lDIA3DDuLqNzGQ1wk+rf7AwK+hFHpOZL
         p0nVPP6X70eGnkWVPrtxjotKGgS49lMf2WfHACuK3trl2bpJ4W7m+Ee5gvlm2Y+WcpqT
         6TK7l6kwQXJr1igkG1rkaZEIa4LfoxPtSOC1iMspIIiQzUvRgqcWnpPgrtGh9KSZ8Lnb
         bzbGtCIcpO3VaRdEc7/JYrJsbXeH9GlkOaj+UXCem2ZP/Vcu4Gd0GRfPayZ3t+OjS8kS
         gxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y8cTug1MK//k9Db5o5+0BQipNr3buFiSVSYrdmVTLt0=;
        b=ab3GNRMEsR0K5G4peYsn9XvsbqEUcCAYTAXRbzXqKGkgacY6QGCzaUqdONlo7OB7mM
         lZqWIa6AaeJbfevSELH/xEDKDMFfucQS25FSHIGszTsoizSFGeo0ycE4Mk56V6aCDZuu
         Zt1hTM0wDQ5+N/TjyOFBM0VY+mR8jl/bx+Fw7kewXr2UVToV8HiQuMBkAcFHjaona0WB
         3dd5sthOTTqjtB3V8omj8qhlpv9ugScA8AsO73fv9XIWcnnMBORiv4WB/afb9Y+FskXD
         j88inxbziK4uTenilBSKnYq9GX5eyKs2t5x2PiW8cgYQsEM2mNtykJuWTu9bAQnS3UcN
         d3BA==
X-Gm-Message-State: AHQUAuY/snLcB1BjKobbE3LIyGI1C4/whTwf5IQUKqLYQ2ADPhWL9Eun
        WEGYhaDIweGDSvPuvPQqNSg9jcTz
X-Google-Smtp-Source: AHgI3IYdufQXgE/lu3hvws7c5MVO83/7fbUC/F6cEEV6Q9DnVbU//Pu23IYHdmS2BRUZ7aKLHBw/+g==
X-Received: by 2002:a62:2008:: with SMTP id g8mr36989316pfg.121.1550710718820;
        Wed, 20 Feb 2019 16:58:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z15sm17203255pgc.25.2019.02.20.16.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:58:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 1/8] net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
Date:   Wed, 20 Feb 2019 16:58:19 -0800
Message-Id: <20190221005826.26317-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing switchdev_port_attr_get(), introduce
PORT_PRE_BRIDGE_FLAGS which will be called through
switchdev_port_attr_set(), in the caller's context (possibly atomic) and
which must be checked by the switchdev driver in order to return whether
the operation is supported or not.

This is entirely analoguous to how the BRIDGE_FLAGS_SUPPORT works,
except it goes through a set() instead of get().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 5e87b54c5dc5..de72b0a3867f 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -46,6 +46,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
@@ -61,7 +62,7 @@ struct switchdev_attr {
 	void (*complete)(struct net_device *dev, int err, void *priv);
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
-		unsigned long brport_flags;		/* PORT_BRIDGE_FLAGS */
+		unsigned long brport_flags;		/* PORT_{PRE}_BRIDGE_FLAGS */
 		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
-- 
2.17.1

