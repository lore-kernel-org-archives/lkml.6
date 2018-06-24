Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2C5C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77CE24DFF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8RkWGie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77CE24DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755134AbeFXPdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:33:49 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41121 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754958AbeFXPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:33:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id y20-v6so9996889qto.8;
        Sun, 24 Jun 2018 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/U7L7gIAMgtnKQQawaeDuUVHIW9fT7Cfx88aBkBM2Y8=;
        b=B8RkWGielEYB7nh8QsqpE4idXpuPSee4E7wsO7eU1gdTmmYBa37LemCOjsG6phTM5M
         6Km3hGOvj7f7qzXHy017Hyz5tmaoOOB7EDthx5x9aG6NP4Gmsv+ZL1d8A9Te4J3YG4yz
         M97cJG4CLvAw8/m8YZGrXUN6LRzjnG7iA7voxS4Fn1ynVSF83NQVqW6q5vHf5CRFzUKx
         5/o9m6lBhrus0CXR2Bfuzzh4TPZ3ZeVuiX4YfStwXK6LwtpyrqpeXIOe2n0h4/7p0xeR
         eIJ6ucax/13nJmVr2MrLdNZlTeGVIKQapVet4cNzPxmvnXYN/iLknwu34P77aQssr9u9
         EDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/U7L7gIAMgtnKQQawaeDuUVHIW9fT7Cfx88aBkBM2Y8=;
        b=Lt5UppVCux1QMENbG0PZAj7gvtTyfb9QhQYfRxjhezGyE/eJYgcr/kRMuP6s/qytO1
         OCXdL2OomkxMdvtvYQZsUbpJ/1T1g2sR1Gjei6c3OzBRWFrRcSddlhlLXmv9PhR/KCWh
         4od6R8ke8Y5KDAGKCRREPIctAereB+VoHZB/HaOHm0FKdRQ3h3ylFDoGwkoMu7wJMY6U
         TXvC8GU2wVt8QQldLE7XOtc1lW77/1sILbSiUys2QVJdPKBqapYZiZLOuihvXUQQwpFf
         1Iz2CRIdLnn8yVAtsbBOZWBjt/EMgkpBAVFRxWLSAj1ae9xr5uuutbQPQHqv1iOP5Dhu
         VG1g==
X-Gm-Message-State: APt69E2WKsNw0Hm/ZZrXglPQtlcbLw/o9Vy5usQhEhrW4NtQ21M612k9
        qexZstO7O0iCF4mb2KmcK8EkgKL0
X-Google-Smtp-Source: ADUXVKJFm9CEtPQf2WRY7afJmhtC7UpUYG43ofebcEoLFQWxVMv5iqGwxoh6Jg6CleoATJGhBx1EFQ==
X-Received: by 2002:ac8:25f2:: with SMTP id f47-v6mr8220742qtf.12.1529854424359;
        Sun, 24 Jun 2018 08:33:44 -0700 (PDT)
Received: from cox.net ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id m128-v6sm9155700qkd.33.2018.06.24.08.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:33:43 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     petrm@mellanox.com, jiri@mellanox.com, ilias.apalodimas@linaro.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFT] net: dsa: Allow configuring CPU port VLANs
Date:   Sun, 24 Jun 2018 08:33:39 -0700
Message-Id: <20180624153339.13572-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now there was no way to specifically target the VLAN attributes and
membership of the CPU port of a DSA switch. This forced drivers to either
always have the CPU port be "VLAN tagged" (b53) in every VLAN that gets added
to the front-panel/user facing ports, or when the switch supports it, use an
"unmodified" semantic (mv88e6xxx).

This is less than ideal because there are cases where we might not even want to
have the CPU port be part of the same VLAN than its user facing ports, e.g: to
isolate a group of noisy stations. There are also cases where we want to
control exactly how the CPU port receives VLAN traffic such that proper
separation/identification can occur.

Make this possible by flagging events targeting an orig_dev which is a bridge
master and using that as a hint to mean that we want to configure the
CPU/management port. This is compatible with multiple bridges over the same
switch in that, an user still has the responsibility to create separate
broadcast domains with separate VLAN databases/IDs per bridge.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Andrew, Vivien,

Could you test this on mv88e6xxx to make sure there is no regression? Thanks

 net/dsa/port.c   | 4 ++--
 net/dsa/switch.c | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index ed0595459df1..37385e491117 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -253,7 +253,7 @@ int dsa_port_vlan_add(struct dsa_port *dp,
 	};
 
 	if (netif_is_bridge_master(vlan->obj.orig_dev))
-		return -EOPNOTSUPP;
+		info.port = dp->cpu_dp->index;
 
 	if (br_vlan_enabled(dp->bridge_dev))
 		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_ADD, &info);
@@ -271,7 +271,7 @@ int dsa_port_vlan_del(struct dsa_port *dp,
 	};
 
 	if (netif_is_bridge_master(vlan->obj.orig_dev))
-		return -EOPNOTSUPP;
+		info.port = dp->cpu_dp->index;
 
 	if (br_vlan_enabled(dp->bridge_dev))
 		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index b93511726069..d69bcc8f9ba2 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -211,8 +211,11 @@ static int dsa_switch_vlan_add(struct dsa_switch *ds,
 	bitmap_zero(members, ds->num_ports);
 	if (ds->index == info->sw_index)
 		set_bit(info->port, members);
+	/* CPU port is configured via dsa_port_vlan_add() with events
+	 * targeting the bridge device
+	 */
 	for (port = 0; port < ds->num_ports; port++)
-		if (dsa_is_cpu_port(ds, port) || dsa_is_dsa_port(ds, port))
+		if (dsa_is_dsa_port(ds, port))
 			set_bit(port, members);
 
 	if (switchdev_trans_ph_prepare(trans))
-- 
2.14.1

