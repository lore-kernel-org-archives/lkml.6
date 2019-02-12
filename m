Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BFAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C826B222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auUGQKwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfBLVjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:39:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34845 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfBLVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:39:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so97466plo.2;
        Tue, 12 Feb 2019 13:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nNpP5TBgHvz9qVnnP4UT2eodY0643dbZRyGxK03F0CQ=;
        b=auUGQKwI752eq57z6JZbGReAyBcka0guCzdsBllfm9pb2xR+lSx4qAbIDCCo3QEYWR
         bKdEuZeGk1L/P1kaNFRa81+SKKcxFqCnkqaeQnD3oMdojpr0LmBFOqkZBrLT1K3jGe9i
         S0ZGT/sdzEPmmQdcpvPGVBhKDaUfTji8crK2fHM9/E685BzVksFQCV1+EkXagPpmlfU6
         Ff0hiJdDRqKBDOaeSycU5k4fhiFJjf940AL/xpuOeIcVijDT/Ja7BBYgDDKl3pLDvrCU
         uVK44XCFQs2J0dOsxaCp1aScMdZZj+duAWD+wmLJX0bd0DVhh188ORn9LE3IIO2DT3mu
         FLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nNpP5TBgHvz9qVnnP4UT2eodY0643dbZRyGxK03F0CQ=;
        b=WNpkWVKeJ/Eqxw9t+58pv3beaiFkmi6vkNSkexyySc2JQdqGN70+8UaJN+8wdF/T63
         v1ip4MxYKnqzBZCjeyM8Jcf7J9fkGVIS7TmsOYMcxvTgRuwDjsxVvAHBBgWPpHVMI7zs
         +zobUmfw33pTp1Rp9hgpRAnxnwkxF7DyZjuRJxqMHtZzwRYqiPQFH8hww8E3u1m2Yck3
         SEqWGaPus28O984kYYc61hzuPprvdBItLc8HxggOGpoJVfatAhVJa8k2ksyQBhHxQlOi
         D1prpzjKgId72gQahzfiVU/bJbv456z+qd21Pqb/sqhcDsw2M9Az018KBHP1hcWkw5BJ
         TWQw==
X-Gm-Message-State: AHQUAuYc4iYCrBuTAmOEGIZTlN2VTMFQ4saVmBqVIZRI3qJkg2xhq7aM
        KL9QZbLWEQCmHCsTIgCS13Gw4oa5
X-Google-Smtp-Source: AHgI3IZ7aDqcrtWHcOHSVaDWLxOHI/6esxA+H7HMXW2sJ8gvlXH3D7UNrdWqey/5i2Fdw2W6Ojaz/Q==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr6211151plb.182.1550007563862;
        Tue, 12 Feb 2019 13:39:23 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e81sm8074247pfb.65.2019.02.12.13.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:39:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] rocker: Remove port_attr_bridge_flags_get assignment
Date:   Tue, 12 Feb 2019 13:39:05 -0800
Message-Id: <20190212213905.26559-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 610d2b601bba ("rocker: Remove getting PORT_BRIDGE_FLAGS") we no
longer have a port_attr_bridge_flags_get member in the rocker_world_ops
structre, fix that.

Fixes: 610d2b601bba ("rocker: Remove getting PORT_BRIDGE_FLAGS")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 9c07f6040720..fa296a7c255d 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -2813,7 +2813,6 @@ struct rocker_world_ops rocker_ofdpa_ops = {
 	.port_stop = ofdpa_port_stop,
 	.port_attr_stp_state_set = ofdpa_port_attr_stp_state_set,
 	.port_attr_bridge_flags_set = ofdpa_port_attr_bridge_flags_set,
-	.port_attr_bridge_flags_get = ofdpa_port_attr_bridge_flags_get,
 	.port_attr_bridge_flags_support_get = ofdpa_port_attr_bridge_flags_support_get,
 	.port_attr_bridge_ageing_time_set = ofdpa_port_attr_bridge_ageing_time_set,
 	.port_obj_vlan_add = ofdpa_port_obj_vlan_add,
-- 
2.17.1

