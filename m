Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DECFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F49206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F49206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbeGQJZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:25:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40189 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbeGQJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:25:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ffLjr-00013U-5I; Tue, 17 Jul 2018 08:53:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fscache, cachefiles: remove redundant pointer 'cache'
Date:   Tue, 17 Jul 2018 09:53:42 +0100
Message-Id: <20180717085342.17864-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'cache' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'cache' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cachefiles/rdwr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 5082c8a49686..548790c4a027 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -955,11 +955,8 @@ void cachefiles_uncache_page(struct fscache_object *_object, struct page *page)
 	__releases(&object->fscache.cookie->lock)
 {
 	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
 
 	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
 
 	_enter("%p,{%lu}", object, page->index);
 
-- 
2.17.1

