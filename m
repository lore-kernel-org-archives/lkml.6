Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E92AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5466224A85
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5466224A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937026AbeF3MEv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 08:04:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59773 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936201AbeF3MEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 08:04:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZEcR-00045Q-VZ; Sat, 30 Jun 2018 12:04:48 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: make helper function to_mnt_ns static
Date:   Sat, 30 Jun 2018 13:04:47 +0100
Message-Id: <20180630120447.17861-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function to_mnt_ns is local to the source and does not need to be
in global scope, so make it static.

Cleans up sparse warning:
symbol 'to_mnt_ns' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 4e630dcb75c9..e7d2119656a4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1641,7 +1641,7 @@ static bool is_mnt_ns_file(struct dentry *dentry)
 	       dentry->d_fsdata == &mntns_operations;
 }
 
-struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
+static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
 }
-- 
2.17.1

