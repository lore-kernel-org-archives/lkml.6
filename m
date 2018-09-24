Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867EAECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6E5208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5JO2+Hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6E5208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbeIXXhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:37:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40110 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeIXXhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:37:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id o2-v6so4310341wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQTZCtX91bdt4R3xckPOjwDP4xuTgfVCA7ernH1I0hs=;
        b=P5JO2+HvpNsrPJc7qV56xkr3AA3f/MdGPA3Zhls7WFQP5NxcwYcnQxVaoMrRobsMMk
         mIcoNDOoJxFLZfBApjRblFoNCbgXaO0Yl+SyKBeuQ6UnJ0XXcN8sBInu94vBCqmt0iIH
         REksAX9OsXP1TB88lQ0iFQNxJVLxPkkDHoGYVvpKnMh1BQGPCsjGwVQ4syQo6S+bysvt
         dIIXQMropyTsSteiw7D6Cet6gnmIiks10OckLZSnEC0IHCOAkelXKgwj/jbJsUt+s/m8
         gM2/hegaPDCjNZ+VrWUZNSL3nUCgjpFBmfJI9nkRhTFBvQzJ+14M7IDVicmiAJbyXRI/
         isuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQTZCtX91bdt4R3xckPOjwDP4xuTgfVCA7ernH1I0hs=;
        b=L3dUmZ4un/9ZWX90i+MMmdGHFqbromUpm+UOqnikwsjtTahqletsFHat8wNt4qCxx3
         FtI4IXhfbZjyunnZ+rp7j/ZgcXnPubnSelPwyBNBxDm9oo6ILKTd9hTLi7uWNgtqn9W7
         Dc4Nkr2LKdR3s8tj7gPnkkN4pAUL9DRjrvnXYiT4GjEticvtA7xOe4+E9tLbb76rBVIN
         PcWvKPmSKaa+lkelQ2ytGIKmm96W8jcZjg/fE7DM6WJlSSwsHE2M0rWN0vgNG8jRkFkr
         H/5IWgnm7Jah6Q+cBSXskZJV0RO3RkDTw1VtkgiJJIyeWudzMuHlAHtpfAawxrq25Vrc
         q4zA==
X-Gm-Message-State: APzg51BojvWkszNaP4WUvFKiqnC6vbTc9Z+Xg8H/snbJ1GeSU5OJVmjl
        J5hVgy+3RAD2kJWkj+0ApB0=
X-Google-Smtp-Source: ACcGV62416jg/flwGGsxFKnb1BD5u7w1FTFygbeSXZiTMgc8TVuyN9kGODIjsoaNdUlIYomL2+6jnA==
X-Received: by 2002:a1c:b984:: with SMTP id j126-v6mr8226824wmf.25.1537810431017;
        Mon, 24 Sep 2018 10:33:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e141-v6sm27392433wmd.32.2018.09.24.10.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:33:50 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] cachefiles: Explicitly cast enumerated type in put_object
Date:   Mon, 24 Sep 2018 10:33:44 -0700
Message-Id: <20180924173344.27952-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

fs/cachefiles/namei.c:247:50: warning: implicit conversion from
enumeration type 'enum cachefiles_obj_ref_trace' to different
enumeration type 'enum fscache_obj_ref_trace' [-Wenum-conversion]
        cache->cache.ops->put_object(&xobject->fscache,
cachefiles_obj_put_wait_retry);

Silence this warning by explicitly casting to fscache_obj_ref_trace,
which is also done in put_object.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 fs/cachefiles/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index af2b17b21b94..15e5988a83de 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -244,11 +244,13 @@ static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
 
 	ASSERT(!test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags));
 
-	cache->cache.ops->put_object(&xobject->fscache, cachefiles_obj_put_wait_retry);
+	cache->cache.ops->put_object(&xobject->fscache,
+		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_retry);
 	goto try_again;
 
 requeue:
-	cache->cache.ops->put_object(&xobject->fscache, cachefiles_obj_put_wait_timeo);
+	cache->cache.ops->put_object(&xobject->fscache,
+		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_timeo);
 	_leave(" = -ETIMEDOUT");
 	return -ETIMEDOUT;
 }
-- 
2.19.0

