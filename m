Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B5CC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D6C20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EurGI24u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D6C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeLEJ5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbeLEJ4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:56:33 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD91D21527;
        Wed,  5 Dec 2018 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003792;
        bh=ixkSGs3AesB+cKP9JzO54GkLwd16f35wRYQPDnBeeso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EurGI24uV8qsbJdELXP/4vLCJ0MfNcCfpjVLMFdLwdBmMas9mXHV7ai7BCanoi4dK
         9IhqkwdfXEmrsVRQKMOjZlsGWdOHXmPZwd95YKoN8zFvQqTdmkWqDNplfO3PdzanlJ
         jEfyAUzj8NQci34SI8BXra9oGVW4fmzwXuZ0kl1U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 20/26] fscache, cachefiles: remove redundant variable 'cache'
Date:   Wed,  5 Dec 2018 04:54:24 -0500
Message-Id: <20181205095430.8019-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095430.8019-1-sashal@kernel.org>
References: <20181205095430.8019-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 31ffa563833576bd49a8bf53120568312755e6e2 ]

Variable 'cache' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'cache' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/rdwr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index a899e69cd5fd..4b3a6b01bb48 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -962,11 +962,8 @@ int cachefiles_write_page(struct fscache_storage *op, struct page *page)
 void cachefiles_uncache_page(struct fscache_object *_object, struct page *page)
 {
 	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
 
 	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
 
 	_enter("%p,{%lu}", object, page->index);
 
-- 
2.17.1

