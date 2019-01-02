Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CD6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2CD218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WI9X1XQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfABSHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:07:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35517 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfABSHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:07:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id w204so18327060qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 10:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8MMhR4sblhioJzUomNsJ/I2PWvUxrPx/Sn5DmGetoyA=;
        b=WI9X1XQz1cEWUVgamTBHZcl3PQGgqDRDzpXDrsx+G5yIjjab4UqzZJ1PufW3xKw29B
         nsllIBrjMpBqRDWhWn/z5dNKq+BTx4Ho9Ho3i0bneu9CuA6rJ7/GbXhSW5wvhgKVdRVG
         LVZoTWCBas8/Y9ck0JdKd4pEa1/tVVLzQsv0cmpXRcyzOEb26aK5tnw6lAe/vQbdwEsm
         +SKtD5vc/f7oBzpBz3aqAsfW50ITxNGhgE0H0rfbMS9kYitq+F4AuXZETpD31KrnuDdw
         skAi1YrJYMo1QZwNDQgew5NYc0saNIIKflc4XrbvweXrMYrT4ies0F1id4CYO7YA+UNX
         rMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8MMhR4sblhioJzUomNsJ/I2PWvUxrPx/Sn5DmGetoyA=;
        b=BWZHyhsGY0YAGREvozFfD8fWitIiMu0Dwn4Eu9W9EA0wcmCsIc0YKd4xCjQv6Iv3n1
         XIRmUnYEqNRV10CyEs06Qe59LWaIRYorYHBLQXVTfXLpKC0y6X58JhnouF941rwHOuho
         iTrWlTwhDm+AT8iwAkJC74b2mEzY3Xq24YW+GUd/Si3aSbp3/lV0cIkpiB0z1p6ve9MS
         3NZH53EWZCOu7y8g/9cy8hjZiTAVdcPqey8m5NWkxC/sQhR5JeNBxPOet/7XlBt73cIQ
         d4C3e3IG2ogzTOagq2FTfSzyETjjqeVr08YPqjB0o1GQjFRh81G/+bq+ulYgi/Oulzby
         4FOQ==
X-Gm-Message-State: AJcUukfbU0VH3u2H3+8vmquy1Okdc7BMTLB9FDAqHpk4hNLHJAA8zDZP
        So0r1/WRDNjqSDMrZS6XvU7DEA==
X-Google-Smtp-Source: ALg8bN55wjlWgpEnZeB50u7PpcQBjVNz4nbpZukoG+mAzwR0FtKM7suKPI+Wa/vrT/HimRArfkXlTw==
X-Received: by 2002:a37:ae87:: with SMTP id x129mr42158644qke.15.1546452425245;
        Wed, 02 Jan 2019 10:07:05 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u67sm23243069qki.22.2019.01.02.10.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 10:07:04 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] kmemleak: survive in a low-memory situation
Date:   Wed,  2 Jan 2019 13:06:19 -0500
Message-Id: <20190102180619.12392-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190102165931.GB6584@arrakis.emea.arm.com>
References: <20190102165931.GB6584@arrakis.emea.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak could quickly fail to allocate an object structure and then
disable itself in a low-memory situation. For example, running a mmap()
workload triggering swapping and OOM [1].

Kmemleak allocation could fail even though the trackig object is
succeeded. Hence, it could still try to start a direct reclaim if it is
not executed in an atomic context (spinlock, irq-handler etc), or a
high-priority allocation in an atomic context as a last-ditch effort.

[1]
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: remove the needless checking for NULL objects in slab_post_alloc_hook()
    pointed out by Catalin.

 mm/kmemleak.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index f9d9dc250428..9e1aa3b7df75 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -576,6 +576,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	struct rb_node **link, *rb_parent;
 
 	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
+#ifdef CONFIG_PREEMPT_COUNT
+	if (!object) {
+		/* last-ditch effort in a low-memory situation */
+		if (irqs_disabled() || is_idle_task(current) || in_atomic())
+			gfp = GFP_ATOMIC;
+		else
+			gfp = gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
+		object = kmem_cache_alloc(object_cache, gfp);
+	}
+#endif
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
 		kmemleak_disable();
-- 
2.17.2 (Apple Git-113)

