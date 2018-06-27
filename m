Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22950C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C400D2546D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czjRAU3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C400D2546D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965662AbeF0SN6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:13:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45020 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965154AbeF0SN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:13:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id j3-v6so1338968pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v+4dp/BOvsFqHFx3yUzsYGxGxEU+qdmgbrrREHhz6Co=;
        b=czjRAU3BQLur05AcJMzW+DUB9nDAhrjJRuxtiJdpERQlzv7KZr6JnPqODYZsM7qeh2
         8vMi3bLBOxjxgtonJwi3bgojB4KpSqJsnJBbBI5mYv1xd3SxCD/fCIMbcxMdXzdZEiUY
         WSniOa8dARB2CrUM5666TIGl1ldIoKO3K+OUrZslzx2LwcKN9/yEVFNNTwVZguaUzf6n
         9d4GnC5M/j/EOTH3Ab/uvGmutNpLi7OYESCVQQOw9amMdBun4VcjZL436obKWoqh2eKH
         ZCft8kkXy+JqZZSRZoSqx9tpsGEopbeRAU5qT8VusESnQhRUCl5Ym1YLz7jtroEBTTbD
         Mngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v+4dp/BOvsFqHFx3yUzsYGxGxEU+qdmgbrrREHhz6Co=;
        b=Y+QUX6m6jdYy8W0OQREFMnBu2McpMfVe8Tz841jS2qOdrqYHEXDTPXZQUc0H+gFch/
         06R1Xx3zrXQJo98eS2TKCmGFwzWHQpNspHPZESuzRKeNFKCFmc+bSpE4zJcQvQCpJGoF
         6nxxcz8kgrFyccM3uieCxsQgL2B6t9O0frfUtIYbjHIIm6dslm0vVOb4h06xB9pDtnUN
         Sh94ylj7Z8mhsuUACn3FWgzSa8nYrOT/I+FgnjYTZKD/ZMXPWe1UnOwAiB9geD+FJg0r
         atA5piWDadiX+iCtE6BVxL5mnV+br37Kmh5rNG7h05My31Ls4l0cNiCgrNuhOgkwtOZV
         TryQ==
X-Gm-Message-State: APt69E0lkKesdMjfgGPrkhJdJhI0DQkGbMYiZ1MbaZp5JZHgGa/Ksg3y
        /EMgSEPYWtoukK2V2YvinF7GKg==
X-Google-Smtp-Source: ADUXVKJXUK8G1lHWBbxsZ9sS18sDBlotoR24L0kb1MSoSybzk9GwHFUcVxvXPHEmhAdUbl4r3aCq4w==
X-Received: by 2002:a65:4c02:: with SMTP id u2-v6mr6247278pgq.364.1530123236062;
        Wed, 27 Jun 2018 11:13:56 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id h8-v6sm6309728pgq.35.2018.06.27.11.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 11:13:54 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] kvm, mm: account shadow page tables to kmemcg
Date:   Wed, 27 Jun 2018 11:13:49 -0700
Message-Id: <20180627181349.149778-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of kvm's shadow page tables corresponds to the size of the
guest virtual machines on the system. Large VMs can spend a significant
amount of memory as shadow page tables which can not be left as system
memory overhead. So, account shadow page tables to the kmemcg.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 arch/x86/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d594690d8b95..c79a398300f5 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -890,7 +890,7 @@ static int mmu_topup_memory_cache_page(struct kvm_mmu_memory_cache *cache,
 	if (cache->nobjs >= min)
 		return 0;
 	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		page = (void *)__get_free_page(GFP_KERNEL);
+		page = (void *)__get_free_page(GFP_KERNEL|__GFP_ACCOUNT);
 		if (!page)
 			return -ENOMEM;
 		cache->objects[cache->nobjs++] = page;
-- 
2.18.0.rc2.346.g013aa6912e-goog

