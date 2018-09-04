Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63501C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC992077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC992077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeIDR35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:29:57 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46890 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726355AbeIDR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:29:57 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Sep 2018 16:08:53 +0300
Received: from dev-l-vrt-135-006.mtl.labs.mlnx (dev-l-vrt-135-006.mtl.labs.mlnx [10.134.135.6])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w84D4mna022823;
        Tue, 4 Sep 2018 16:04:48 +0300
Received: from dev-l-vrt-135-006.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-135-006.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w84D4mk3018688;
        Tue, 4 Sep 2018 16:04:48 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-135-006.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w84D4kRY018686;
        Tue, 4 Sep 2018 16:04:46 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net] devlink: Fix devlink_param_driverinit_value_set() stub return code
Date:   Tue,  4 Sep 2018 16:04:25 +0300
Message-Id: <1536066265-18641-1-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stub function returned -EOPNOTSUPP while CONFIG_NET_DEVLINK is off.
It caused false warning during driver load. Driver needs to update
devlink on a parameter value if devlink module is there, if not it
doesn't need any error code.

Fixes: ec01aeb1803e ("devlink: Add support for get/set driverinit value")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
---
 include/net/devlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index b9b89d6..b467357 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -781,7 +781,7 @@ static inline bool devlink_dpipe_table_counter_enabled(struct devlink *devlink,
 devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 				   union devlink_param_value init_val)
 {
-	return -EOPNOTSUPP;
+	return 0;
 }
 
 static inline void
-- 
1.8.3.1

