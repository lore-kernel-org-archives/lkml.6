Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867CAC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C18121508
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789699;
	bh=+nFA/6FtLROIO9Gt4DF9MVL1xXI929Uh5/kd2f2ZD/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vl+dIDlGsaOK+fpUh4ICPEubJ7Vdgt+Ntv7nQT9JQ9nx3QUBvxNb5Ir3Sa5LLRv/Y
	 qXWegqEPS0oEia4laepFAaoxCT9ejNfo8N7JkUFoqCeHpbNSIFL7Q7zVLaNxL3mKWg
	 u+wVJV9n8oZTkgkncrk79wqv3eYP9DshJWpOqvxA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C18121508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbeLNMO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:14:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbeLNMOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:14:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358D0214F0;
        Fri, 14 Dec 2018 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789694;
        bh=+nFA/6FtLROIO9Gt4DF9MVL1xXI929Uh5/kd2f2ZD/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqfwDHo1wJ3RNAI8K00k6CHsVsaBmhI/56wPlIasz8aqjtoRyckY6E5oNc6ZZXPue
         vcopt7f84W6LY0UMxxNVNGH8wFgswU33kic9PhS36ATQ3vc1OvDLF8Om8u1CHCOdII
         9DLjQxMEF9L0r+Ius9jDILFcOK8BieBYj9xtZcAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 33/88] fscache, cachefiles: remove redundant variable cache
Date:   Fri, 14 Dec 2018 13:00:07 +0100
Message-Id: <20181214115704.888003896@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 5b68cf526887..c05ab2ec0fef 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -963,11 +963,8 @@ int cachefiles_write_page(struct fscache_storage *op, struct page *page)
 void cachefiles_uncache_page(struct fscache_object *_object, struct page *page)
 {
 	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
 
 	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
 
 	_enter("%p,{%lu}", object, page->index);
 
-- 
2.19.1



