Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476FFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1371621741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="kwFxqb4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeLZTIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:08:36 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:41154 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeLZTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:08:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 8A69DB18
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 19:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iZsIbp6kgY66 for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 13:08:01 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 594C91C3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:08:01 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id b8so4692181ion.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 11:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ochM5m1KMB+5vlcxy5xlYUPq9FxXr2ho76d6PIZxYqg=;
        b=kwFxqb4I69HA5AqDxFsKEWBcg/NoeYcc/A8lJg2r9zy4NMy2L1FkP8j4BJvQe4Ffo3
         e1l1vGEQwY1cpj1q2n7IRgxUhd2YpjW/yd6SQF4Joub9j2mACHS6z2exi8C/0K2IvF0P
         D1ePRXAzam0egWKLvO/SmgIgImmc6Pe6K/5tPCyBvh+gAzJtcZsZ2rbAJj526M/Bnl+3
         hv6x6fOlG5RWSYgfkdgyqjPI9aVSOykfSa7n7p09NHL/OUA30PUKmPV9a0UobSSsfbEr
         GWEVaKl8Cu9wVsHpvMGDTE7wfpwPR05VfcuEpmwSe8zV6/Suyu1I3LoxdaP+sR7haCLw
         tGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ochM5m1KMB+5vlcxy5xlYUPq9FxXr2ho76d6PIZxYqg=;
        b=skNzMrkVTT+X+WafNobNnTB22o7jGLgDz5klbKm/eoaruF96SSdmGAPFX0ed5ZDtwV
         y+848aZIL7V/0DJjfAJGPSoPfcWAYFgRI8WD/n02YEWNDHQM19qgZYtpEG8WD1MeqN9B
         fHtYNfm9yCvUZ08gnnQJ4vhnPTqwN/kaaHm5gVIu88BSemKFrYCBOtuqLlJJt72vGW5f
         fZJBEDwtXrSB6nCFKOdcVWCbp1938wZPjtx+xmZ7E/sL245Zx64UWZ+ldI7MEBGwH9wZ
         oLIATVtTkUzQkmw7QMLZhE9+X3ywqvX2GSUQRc08ZLGHn/ghuneylp74KxqWPjuCYugp
         LNQg==
X-Gm-Message-State: AJcUukemg6EWGzuuQMql1cNrUYTuIwg+7VkxQGq0hHvnLlq81IzInm3T
        /efw7gCfPkGUTsiRPTyX/hJO6kH2jdXB7GXXCE0R31hCGkPfx/NI3BV8Q890x82cnnG9T6tipa1
        /jJXql6FTxyEb/bzzfy5M227jV5/e
X-Received: by 2002:a6b:ee16:: with SMTP id i22mr13755737ioh.124.1545851280952;
        Wed, 26 Dec 2018 11:08:00 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6x56qoVTWhe77xBx3wll/eAhWeS3daRnVJV8e5+qAo6OrgbkXSMBwYVy+Hm8urOfxf0wuufg==
X-Received: by 2002:a6b:ee16:: with SMTP id i22mr13755727ioh.124.1545851280735;
        Wed, 26 Dec 2018 11:08:00 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id r21sm13145399ita.27.2018.12.26.11.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 11:08:00 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joe Perches <joe@perches.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: compaction.c: Propagate return value upstream
Date:   Wed, 26 Dec 2018 13:07:49 -0600
Message-Id: <20181226190750.9820-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sysctl_extfrag_handler(), proc_dointvec_minmax() can return an
error. The fix propagates the error upstream in case of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 mm/compaction.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 7c607479de4a..5703b4051796 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1879,9 +1879,8 @@ int sysctl_compaction_handler(struct ctl_table *table, int write,
 int sysctl_extfrag_handler(struct ctl_table *table, int write,
 			void __user *buffer, size_t *length, loff_t *ppos)
 {
+	return
 	proc_dointvec_minmax(table, write, buffer, length, ppos);
-
-	return 0;
 }
 
 #if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
-- 
2.17.1

