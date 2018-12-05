Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6614C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CCE20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeUBdh5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CCE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbeLEJlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:41:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbeLEJlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:49 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B8892084C;
        Wed,  5 Dec 2018 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002908;
        bh=Wm7im0A1HDlNmjT3CCf4t2+2Dk5MCR1Uli3DbwbAowg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeUBdh5qOxaS/f6waCB84HXcNwW3xACtIvFh0RuHvmPVWJImZ3S29nPIoQv53gtFw
         gqYtAY8xepex7sJkLJ50/3/bagIxZLI/MDhQBYZN4Us2pAODKT0YOSc/PLBkUF3d2h
         XGv4rOGRqnqF24OJtkgbwjbbt5DmXrLWcCONSqO8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 108/123] fscache, cachefiles: remove redundant variable 'cache'
Date:   Wed,  5 Dec 2018 04:35:40 -0500
Message-Id: <20181205093555.5386-108-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
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
index db233588a69a..8a577409d030 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -968,11 +968,8 @@ void cachefiles_uncache_page(struct fscache_object *_object, struct page *page)
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

