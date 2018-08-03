Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFCBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58B32172D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM8AIGcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58B32172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeHCHmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 03:42:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45084 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeHCHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 03:42:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so2619365pfo.12;
        Thu, 02 Aug 2018 22:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=fVXWaxwxreKXlqc1RlFh2JofIARKEY7E1agRdUX+U64=;
        b=cM8AIGcr923zdMpdIzff6uaGULx90HD6/pb1SzOlHNxmQn3SGmQgrKeg3Nlb4SdcOH
         cq/h+mPUPhUuKOv2G+0z5sEW6+V/MAalhyHs20OWjxCoeA5ptfJnK7IEg1RwzULhiUsw
         wVcWZUts+sDYXxQIkEzwX1NwC8rstIp4/7nfOB7OwGVhnOF8Iacuyx3n9YDEw7fwikdo
         a6W9Ioie7idm4r/niISTiosCax+bavEPBe4jK8TqhvOcvztd7ONwFBKwZ3zBgafUMXmZ
         UCWFU3UAsgx5SttmwJsyiVKdSBGSjwk39mCpgaz6LZ/K2RgIwBPFtxPcGP23CIqVd1vP
         wXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=fVXWaxwxreKXlqc1RlFh2JofIARKEY7E1agRdUX+U64=;
        b=Lj0I+8hCgMcoofllXmCzxbQVSrOe38pMynqZ3q0Q5RexoIAWrxpeGO3K1YHBg+UtoP
         ue2GM7MF8FPOueAvprsMTtgo6aq89HpM9zw51HJt55B1GpDtjt0KIBoGnBtpIBot1xTz
         UMFQ4UgsEMepj+yYzyxfBnDwSnNh3Et+JYSG27N7FwyAp7U/q7QlJoVjMbLrHbNGpEXl
         /3sceFStkhM3OQBG0QJQWN2tHS26ff+mSGNckK1RKTg001BlamAfkR8LzWhr4lSE8oWf
         vpsRLTylMamIgBfDKIUauu2p0265su8rwYqnFPuFYLu0YjH4mQ0afbB7HwS63/UhP7a5
         jdIQ==
X-Gm-Message-State: AOUpUlFY0Wf5Rcg40NxGK5FoIG0hGDx40sdyUbkZL+IiqfW/HMq188s9
        LXHiFU/DKwrmWWdS3VjSelY=
X-Google-Smtp-Source: AAOMgpff9xUqLAOcRmaS8c3fp6Evd7fn7eGWFKdzyKW8WHn3t7iUoYp4tVAK4BPLb3Ht30kiUl6aiA==
X-Received: by 2002:a63:1360:: with SMTP id 32-v6mr2305914pgt.159.1533275295349;
        Thu, 02 Aug 2018 22:48:15 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 16-v6sm5357284pfp.6.2018.08.02.22.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 22:48:14 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org
Subject: [PATCH v1] mm:memcg: skip memcg of current in mem_cgroup_soft_limit_reclaim
Date:   Fri,  3 Aug 2018 13:48:05 +0800
Message-Id: <1533275285-12387-1-git-send-email-zhaoyang.huang@spreadtrum.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for the soft_limit reclaim has more directivity than global reclaim, we
have current memcg be skipped to avoid potential page thrashing.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
---
 mm/memcontrol.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c0280b..9d09e95 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2537,12 +2537,21 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 			mz = mem_cgroup_largest_soft_limit_node(mctz);
 		if (!mz)
 			break;
-
+		/*
+		 * skip current memcg to avoid page thrashing, for the
+		 * mem_cgroup_soft_reclaim has more directivity than
+		 * global reclaim.
+		 */
+		if (get_mem_cgroup_from_mm(current->mm) == mz->memcg) {
+			reclaimed = 0;
+			goto next;
+		}
 		nr_scanned = 0;
 		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
 						    gfp_mask, &nr_scanned);
 		nr_reclaimed += reclaimed;
 		*total_scanned += nr_scanned;
+next:
 		spin_lock_irq(&mctz->lock);
 		__mem_cgroup_remove_exceeded(mz, mctz);
 
-- 
1.9.1

