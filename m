Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCFCC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B5425C61
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtDdXzfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B5425C61
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966382AbeF0WRA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:17:00 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38475 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965728AbeF0WQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:16:58 -0400
Received: by mail-pl0-f67.google.com with SMTP id d10-v6so1699124plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vt/asKPxANT7pXBKJwL4AGXXdhdY3QWBTWUSJGPy7c4=;
        b=DtDdXzfPTlUBJ8OvQXUC7BO1t4tQ+S0FtqRrh8UXgFhw6/kLRciRAxyVk74eN2lYHh
         0GGJsLiQf3CWvDo1Q7zSF0Oaj/bQlrT+UHAvrBooE1nfXwnVefb0XhEKBNgjMrY5UQtH
         x3v9xSdw+06n0bEbSAUObP95jBlNpLYs4fe/XjIhgkNJv39KpCTwlvoPPyb9chCsyU8C
         9vu0ywfiAFXh/ENzkXYMLzc8MhulxjbwLuRJ39P+quovrNqGCtaeSHbMyS4FLKKK05zl
         7vBx8ZZRe5CRYH+SNb+Iij4mMOw128QIvMXvRGolu+/CbO8r53svM+VXNkqJ+e4ErodO
         Jo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vt/asKPxANT7pXBKJwL4AGXXdhdY3QWBTWUSJGPy7c4=;
        b=BLcTX3kUWjiVVzNejhHQLLm0w+cCOgl4hkS5qdLpj23WLZ6heoXZb8uumzMbVSRORH
         8S5fE0TnZ4k1AKRS+kAr7PW+TCHzJETqEpZrA+9w+yxUHHu9aJCx2TIPKK7DTtHWDr0E
         slQKA84/sXKOtNfRHdGPI9JIF+vma58Xe+FDCwoBl8gBNlQWj7ZLufhZgxicpiCkaBLb
         jzWfjD2auoheT1Tk0mst5OmYxe6lc8j3gFFx/fAuPOWAsmUJARZ2xhCWcraN4FqBMUF9
         klGIVeA0uIGTHaNQtIuX6vrB2FMmxYdX+A3UDBhkzriGUSfbnwErCJ32JMzr+yL/WxMN
         wCWw==
X-Gm-Message-State: APt69E3M3XGOE1W6W0yTeYDh9+bxbAxwy9Pk+P3WcXGrcb2mOQ0U5/RQ
        Pz8ilyf93HQhS2rVSQ+JPs2goQ==
X-Google-Smtp-Source: ADUXVKLweQw8Cm9krohFrz3NIyiTHd6LZoHL/KB/eznP7EAHY4EJdLG5DH6wPUO6PV6Y594Z1HEChg==
X-Received: by 2002:a17:902:7782:: with SMTP id o2-v6mr7890665pll.93.1530137817932;
        Wed, 27 Jun 2018 15:16:57 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id r86-v6sm9641967pfi.165.2018.06.27.15.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 15:16:56 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>
Subject: [PATCH v2] net, mm: account sock objects to kmemcg
Date:   Wed, 27 Jun 2018 15:16:42 -0700
Message-Id: <20180627221642.247448-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the kernel accounts the memory for network traffic through
mem_cgroup_[un]charge_skmem() interface. However the memory accounted
only includes the truesize of sk_buff which does not include the size of
sock objects. In our production environment, with opt-out kmem
accounting, the sock kmem caches (TCP[v6], UDP[v6], RAW[v6], UNIX) are
among the top most charged kmem caches and consume a significant amount
of memory which can not be left as system overhead. So, this patch
converts the kmem caches of all sock objects to SLAB_ACCOUNT.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
---
Changelog since v1:
- Instead of specific sock kmem_caches, convert all sock kmem_caches to
  use SLAB_ACCOUNT.

 net/core/sock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index bcc41829a16d..9e8f65585b81 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3243,7 +3243,8 @@ static int req_prot_init(const struct proto *prot)
 
 	rsk_prot->slab = kmem_cache_create(rsk_prot->slab_name,
 					   rsk_prot->obj_size, 0,
-					   prot->slab_flags, NULL);
+					   SLAB_ACCOUNT | prot->slab_flags,
+					   NULL);
 
 	if (!rsk_prot->slab) {
 		pr_crit("%s: Can't create request sock SLAB cache!\n",
@@ -3258,7 +3259,8 @@ int proto_register(struct proto *prot, int alloc_slab)
 	if (alloc_slab) {
 		prot->slab = kmem_cache_create_usercopy(prot->name,
 					prot->obj_size, 0,
-					SLAB_HWCACHE_ALIGN | prot->slab_flags,
+					SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT |
+					prot->slab_flags,
 					prot->useroffset, prot->usersize,
 					NULL);
 
@@ -3281,6 +3283,7 @@ int proto_register(struct proto *prot, int alloc_slab)
 				kmem_cache_create(prot->twsk_prot->twsk_slab_name,
 						  prot->twsk_prot->twsk_obj_size,
 						  0,
+						  SLAB_ACCOUNT |
 						  prot->slab_flags,
 						  NULL);
 			if (prot->twsk_prot->twsk_slab == NULL)
-- 
2.18.0.rc2.346.g013aa6912e-goog

