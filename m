Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932292AbeCKRDp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 13:03:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44318 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeCKRDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 13:03:43 -0400
From: Colin King <colin.king@canonical.com>
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][rds-next] rds: make functions rds_info_from_znotifier and rds_message_zcopy_from_user static
Date: Sun, 11 Mar 2018 18:03:40 +0100
Message-Id: <20180311170340.27696-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Functions rds_info_from_znotifier and rds_message_zcopy_from_user are
local to the source and do not need to be in global scope, so make them
static.

Cleans up sparse warnins:
net/rds/message.c:70:27: warning: symbol 'rds_info_from_znotifier' was
not declared. Should it be static?
net/rds/message.c:358:5: warning: symbol 'rds_message_zcopy_from_user'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/rds/message.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index 9c41bdd9e444..7448fa192543 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -67,7 +67,8 @@ static inline bool rds_zcookie_add(struct rds_msg_zcopy_info *info, u32 cookie)
 	return true;
 }
 
-struct rds_msg_zcopy_info *rds_info_from_znotifier(struct rds_znotifier *znotif)
+static struct rds_msg_zcopy_info *
+rds_info_from_znotifier(struct rds_znotifier *znotif)
 {
 	return container_of(znotif, struct rds_msg_zcopy_info, znotif);
 }
@@ -355,7 +356,8 @@ struct rds_message *rds_message_map_pages(unsigned long *page_addrs, unsigned in
 	return rm;
 }
 
-int rds_message_zcopy_from_user(struct rds_message *rm, struct iov_iter *from)
+static int rds_message_zcopy_from_user(struct rds_message *rm,
+				       struct iov_iter *from)
 {
 	struct scatterlist *sg;
 	int ret = 0;
-- 
2.15.1
