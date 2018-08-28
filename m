Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748A8C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213E520869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213E520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeH1QxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:53:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51263 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1QxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:53:25 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fudcw-0005tM-RF; Tue, 28 Aug 2018 13:01:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: remove unused variable ret
Date:   Tue, 28 Aug 2018 14:01:46 +0100
Message-Id: <20180828130146.8995-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable ret is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/afs/server.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index 1d329e6981d5..cc8f7e9f76c5 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -153,7 +153,7 @@ static struct afs_server *afs_install_server(struct afs_net *net,
 	const struct afs_addr_list *alist;
 	struct afs_server *server;
 	struct rb_node **pp, *p;
-	int ret = -EEXIST, diff;
+	int diff;
 
 	_enter("%p", candidate);
 
@@ -198,7 +198,6 @@ static struct afs_server *afs_install_server(struct afs_net *net,
 		hlist_add_head_rcu(&server->addr6_link, &net->fs_addresses6);
 
 	write_sequnlock(&net->fs_addr_lock);
-	ret = 0;
 
 exists:
 	afs_get_server(server);
-- 
2.17.1

