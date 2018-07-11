Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED36BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956D320BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956D320BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbeGKMF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:05:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34943 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeGKMF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:05:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id v3-v6so2282832wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p+DsmytoCm1k5u6GKbImO3pLjQkmS1zMYiXb5ppcJos=;
        b=M9mRlzOmv+UCYu7rrxiCGFHfq7W7nN871GDoYV16foqp/YM8SZogIOQdDyoJ6fgds1
         sB1oMhSJjstb4YjVwt0reBWtIKjA6+7uKjyc45LVYUyvRlMUCSRWlrmuEIxm/O8KNyDw
         wSYsP/AIBd8V7j/7Jf8/8D2u1q2xY8X4pREKr1SvolX+XjSLiLtD0uif06JXJ9Scd1F6
         XfZ5HPjdGWMZD71iHWQInus6m2Zb7J0xdgFh3dIIEdhxsrO8FWboSnMSd9mfzYUr/RY0
         X5cpH/thZbWpuznyyMe28lAAKeEmBuyU3SQswM7eaolelOpiVad+bSKYKrAcq4nrCW0G
         n2JQ==
X-Gm-Message-State: APt69E1Yz4BfbAUEC2hzIXnVyjJZiHYAjNz9ZR/mWUX7Cq+3vBgJvf2M
        Qa+KVbd/mHYaQkIFJj1L70o=
X-Google-Smtp-Source: AAOMgpfk5UJeLjFCZWC64ocX3SI6NT6jLNlUoXNj0GRrUKWGLAAkMRuvKNwSLMmfCkRnEk9iFpK2lg==
X-Received: by 2002:a1c:b94c:: with SMTP id j73-v6mr18623025wmf.104.1531310487918;
        Wed, 11 Jul 2018 05:01:27 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-144-122.eurotel.cz. [37.188.144.122])
        by smtp.gmail.com with ESMTPSA id j11-v6sm20749703wrr.37.2018.07.11.05.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:01:27 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, oom: document oom_lock
Date:   Wed, 11 Jul 2018 14:01:21 +0200
Message-Id: <20180711120121.25635-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Add a short documentation about what is the oom_lock scope.

Requested-by: David Rientjes <rientjes@google.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index ed9d473c571e..32e6f7becb40 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -53,6 +53,14 @@ int sysctl_panic_on_oom;
 int sysctl_oom_kill_allocating_task;
 int sysctl_oom_dump_tasks = 1;
 
+/*
+ * Serializes oom killer invocations (out_of_memory()) from all contexts to
+ * prevent from over eager oom killing (e.g. when the oom killer is invoked
+ * from different domains).
+ *
+ * oom_killer_disable() relies on this lock to stabilize oom_killer_disabled
+ * and mark_oom_victim
+ */
 DEFINE_MUTEX(oom_lock);
 
 #ifdef CONFIG_NUMA
-- 
2.18.0

