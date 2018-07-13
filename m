Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1661ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5E52089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbbTv0pV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5E52089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeGMXY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:24:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37290 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbeGMXYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:24:18 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so12784020plc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 16:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=epRZbX2MzRqd+YuWxHaOlHsDt6hjooJyagwCrO6Tw7s=;
        b=rbbTv0pVdOMpkx6IDJePGKTtbXOpoY94OgqpCA9Sv8VNRdLlTS8Q4PH+wyvf4cJbQ0
         Ml//JNgvPGZeftKDb2vEQ4bU9J/peofq60rEXlFLnNqXtR6jIITD2OrGZhzOB64SR0lq
         fuPQLQPka3HJJxO2bmEM9Fi1utZJJAnBKNl4iVa6ooEgqJQ9ZIZZm0TKEXbOPzt9c0Mo
         5kLGWZnlyci31B8wEm+R/ZkI+EPUcXrUZu+gq2T+FoOCpLKLoP3JjOR/qmTmrM0SvAXn
         jY3Q8YXUkspZwvGtfmm0eezEzUdgwWOplAq3hvXUljbrvOXMUjRZavpJx+hBjnFK/o1N
         /gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=epRZbX2MzRqd+YuWxHaOlHsDt6hjooJyagwCrO6Tw7s=;
        b=C22clSuxmTH/cY9zDLAcYV7YCNNas7oCjGtW/VBYCw+zCL3n6pFC7kll1A6fi7wUdP
         vOCly39LwlY1ZCa0K8EZxenDaGZmj1YUndF+htWfInEDteqhZ/awxhqQ387juSTyQkYJ
         agtbCQhYjbatk0HnX6yXDKR6qJ/fdVrfRhLqyi1+kZc96YrRoVjlCWtcAN1VzFl6rbf5
         BxVtWeSVLYGLc6QUnp41lQxzsOrLRG+/lI9oPc3lgVuZIn29BToa3ClzXG6AYiYEsRx1
         ZmYd/e55CTNuQyWYDmOVNnWiz5lsjcckczE4pSVUbJ+NFhSZ4IVCfDIzxWHsVxAKNg5o
         aBDQ==
X-Gm-Message-State: AOUpUlEgWN8WXJq2Rhj59yo0xVnDASCkp9lBkFFwegU2JhhydQaLS2pp
        3BJqdTluzBchFI/f0LZLOPV2xA==
X-Google-Smtp-Source: AAOMgpdYvAytsViqbRSAPC2ly5AlcP1UNxwxhKWzPSJyPUJSur2sQ978iDeJPwfL7iU13kI6Bhl0Xg==
X-Received: by 2002:a17:902:8c88:: with SMTP id t8-v6mr8097123plo.117.1531523254926;
        Fri, 13 Jul 2018 16:07:34 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id w25-v6sm3397610pfg.136.2018.07.13.16.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 16:07:34 -0700 (PDT)
Date:   Fri, 13 Jul 2018 16:07:33 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch v3 -mm 5/6] mm, memcg: separate oom_group from selection
 criteria
In-Reply-To: <alpine.DEB.2.21.1807131604560.217600@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807131606410.217600@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com> <alpine.DEB.2.20.1803151351140.55261@chino.kir.corp.google.com> <alpine.DEB.2.20.1803161405410.209509@chino.kir.corp.google.com> <alpine.DEB.2.20.1803221451370.17056@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807131604560.217600@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the current implementation of the cgroup-aware oom killer,
memory.oom_group defines two behaviors:

 - consider the footprint of the "group" consisting of the mem cgroup
   itself and all descendants for comparison with other cgroups, and

 - when selected as the victim mem cgroup, kill all processes attached to
   it and its descendants that are eligible to be killed.

Now that the memory.oom_policy of "tree" considers the memory footprint of
the mem cgroup and all its descendants, separate the memory.oom_group
setting from the selection criteria.

Now, memory.oom_group only controls whether all processes attached to the
victim mem cgroup and its descendants are oom killed (when set to "1") or
the single largest memory consuming process attached to the victim mem
cgroup and its descendants is killed.

This is generally regarded as a property of the workload attached to the
subtree: it depends on whether the workload can continue running and be
useful if a single process is oom killed or whether it's better to kill
all attached processes.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 21 ++++-----------------
 mm/memcontrol.c                         |  8 ++++----
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1078,25 +1078,12 @@ PAGE_SIZE multiple when read back.
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
 
-	If set, OOM killer will consider the memory cgroup as an
-	indivisible memory consumers and compare it with other memory
-	consumers by it's memory footprint.
-	If such memory cgroup is selected as an OOM victim, all
-	processes belonging to it or it's descendants will be killed.
+	If such memory cgroup is selected as an OOM victim, all processes
+	attached to it and its descendants that are eligible for oom kill
+	(their /proc/pid/oom_score_adj is not oom disabled) will be killed.
 
 	This applies to system-wide OOM conditions and reaching
 	the hard memory limit of the cgroup and their ancestor.
-	If OOM condition happens in a descendant cgroup with it's own
-	memory limit, the memory cgroup can't be considered
-	as an OOM victim, and OOM killer will not kill all belonging
-	tasks.
-
-	Also, OOM killer respects the /proc/pid/oom_score_adj value -1000,
-	and will never kill the unkillable task, even if memory.oom_group
-	is set.
-
-	If cgroup-aware OOM killer is not enabled, ENOTSUPP error
-	is returned on attempt to access the file.
 
   memory.oom_policy
 
@@ -1379,7 +1366,7 @@ When selecting a cgroup as a victim, the OOM killer will kill the process
 with the largest memory footprint.  A user can control this behavior by
 enabling the per-cgroup memory.oom_group option.  If set, it causes the
 OOM killer to kill all processes attached to the cgroup, except processes
-with /proc/pid/oom_score_adj set to -1000 (oom disabled).
+with /proc/pid/oom_score_adj set to OOM_SCORE_ADJ_MIN.
 
 The root cgroup is treated as a leaf memory cgroup as well, so it is
 compared with other leaf memory cgroups.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2943,11 +2943,11 @@ static void select_victim_memcg(struct mem_cgroup *root, struct oom_control *oc)
 			continue;
 
 		/*
-		 * We don't consider non-leaf non-oom_group memory cgroups
-		 * without the oom policy of "tree" as OOM victims.
+		 * We don't consider non-leaf memory cgroups without the oom
+		 * policy of "tree" as OOM victims.
 		 */
-		if (memcg_has_children(iter) && !mem_cgroup_oom_group(iter) &&
-		    iter->oom_policy != MEMCG_OOM_POLICY_TREE)
+		if (iter->oom_policy != MEMCG_OOM_POLICY_TREE &&
+				memcg_has_children(iter))
 			continue;
 
 		/*
