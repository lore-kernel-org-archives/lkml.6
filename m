Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6F2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9801820869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbeLTQuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:50:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60111 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeLTQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:50:53 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ga1X8-0007Cs-M4; Thu, 20 Dec 2018 16:50:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] neighbour: remove stray semicolon
Date:   Thu, 20 Dec 2018 16:50:50 +0000
Message-Id: <20181220165050.17429-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the stray semicolon means that the final term in the addition
is being missed.  Fix this by removing it. Cleans up clang warning:

net/core/neighbour.c:2821:9: warning: expression result unused [-Wunused-value]

Fixes: 82cbb5c631a0 ("neighbour: register rtnl doit handler")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/core/neighbour.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 43687c9abe1d..1c4b7814ac32 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2817,7 +2817,7 @@ static int neigh_get_reply(struct net *net, struct neighbour *neigh,
 static inline size_t pneigh_nlmsg_size(void)
 {
 	return NLMSG_ALIGN(sizeof(struct ndmsg))
-	       + nla_total_size(MAX_ADDR_LEN); /* NDA_DST */
+	       + nla_total_size(MAX_ADDR_LEN) /* NDA_DST */
 	       + nla_total_size(1); /* NDA_PROTOCOL */
 }
 
-- 
2.19.1

