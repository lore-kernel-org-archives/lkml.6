Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931EC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5779120835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026560;
	bh=gX3ERyKWviMMRJBRCJ5AxRiMRtkW9aiusuFWpDPvdHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1qNM3UUppYIbHf8admduTng/J3BXA4NJHSowYdRVKJJzJvkHPIJNUR4/Eb+vb2Q64
	 01YloB1DB8/PUn/QKVhN0OvNpKvOA/HLYjsUhWXrPDP07orWdz1E5pC+CEOguR4DeY
	 ZpwUEPuc8Aimkgeoobz8/nqULGuVE3ByEhvC2pHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390046AbfBMCz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:55:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388290AbfBMChZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A013206B6;
        Wed, 13 Feb 2019 02:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025444;
        bh=gX3ERyKWviMMRJBRCJ5AxRiMRtkW9aiusuFWpDPvdHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xqg/+wEyGidobTBKKWPNxvpUyIJrlRGxP6ZKn+vDFERamcOH7alzqJmim1tRQSYIo
         om7nMUfIhFXfC58tTwlFNwQPnst/rk9y6QP3qU7mMZSqylz47fqJhFkzB+F9SIDgB6
         TcCe0asxIl3HpFP4DmA4gwlnP2CFV+Co1QQRhOrk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 20/83] xen/pvcalls: remove set but not used variable 'intf'
Date:   Tue, 12 Feb 2019 21:35:58 -0500
Message-Id: <20190213023701.20286-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 1f8ce09b36c41a026a37a24b20efa32000892a64 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/xen/pvcalls-back.c: In function 'pvcalls_sk_state_change':
drivers/xen/pvcalls-back.c:286:28: warning:
 variable 'intf' set but not used [-Wunused-but-set-variable]

It not used since e6587cdbd732 ("pvcalls-back: set -ENOTCONN in
pvcalls_conn_back_read")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-back.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index e8b3ff8e7868..d4ea33581ac2 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -283,12 +283,10 @@ static int pvcalls_back_socket(struct xenbus_device *dev,
 static void pvcalls_sk_state_change(struct sock *sock)
 {
 	struct sock_mapping *map = sock->sk_user_data;
-	struct pvcalls_data_intf *intf;
 
 	if (map == NULL)
 		return;
 
-	intf = map->ring;
 	atomic_inc(&map->read);
 	notify_remote_via_irq(map->irq);
 }
-- 
2.19.1

