Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209FBC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE9923DEF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="lvUbPMbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE9923DEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936963AbeF2T3o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:29:44 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34276 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934465AbeF2TZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:25:48 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so2005574qth.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkdJSYLh9LN7Ss8j0Rn9mX3g9Rqhn9vecXPFB0z5w9o=;
        b=lvUbPMbc+sZ/5s4o0FACiGm2SVguhyOZvDPVCUu5DqDNjS4hp0cxAu4OsI4dVpAXIt
         fY37AGYKv7uKaxUx97B+1hXrDDahup3fJutWuVVH6y3stcdiBAYW9We7mUsrtpmsbW8L
         HvKYDOysSQrsavvzeTjJG+2wiVFaJQ7ArTCuBV9qxJ4F4hP5rYEOMLuldCei5w8A2hZK
         vxVLebXBPrRwStAq1HVI02th/m845ixb6kdu0NjCeDsK8Htbmz5RdgGRLcclvadwOCx7
         8ETyL6hfiXCd2PhcOoYvYh62U/o90IQjEPTDt4Ck92o2aI3iL+RHIlEYFM7InYimU1OI
         rI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gkdJSYLh9LN7Ss8j0Rn9mX3g9Rqhn9vecXPFB0z5w9o=;
        b=pCg+murop6fpsFTlXR8nF6rqpbre4UQqKu3KrCgBjTBHbfN4giUbLVVp1HCtyUHJ6h
         +hgZzruJ7Z6ec6hHkEKzGqK5+ZRw6N30CXx70T6c6Pe1ZT3wJzcD/dZdty/pVGuqOLVQ
         f8mkq3WJMmrFnGwl1GKzHjOHXxm6CXtA5lE2WlyVp/hShbsUTgZEPXWZwZXrZRWuWbQv
         s2GwEgSgwDlmDp7/zJN/KgVGHrDJ5SgKuEg9q3fvGNLUiRci43iLYqns9HfJPWLKkqyH
         kgK4OlNBR/YnDRuDNI7hGp5pMNsuDepckeLzvWH4kWyN7SHUU8uz1H46ltaIQFlmMqcp
         5yEg==
X-Gm-Message-State: APt69E2vT/+Q4SNFp8u3H9RDAwhm/bAOO2c8TIGK6aN+oYhpEpEAYxq4
        Nmgpsy+uDdkK3uG4evqxP+VPRg==
X-Google-Smtp-Source: AAOMgpeXS1VimVQQ8ne/1t0hLtrU8zIG9LCTGJnXcImtSUHkYd3LJN/R+aRpIe5P6lvLhFKSIYhdxA==
X-Received: by 2002:ac8:317b:: with SMTP id h56-v6mr15316109qtb.191.1530300347945;
        Fri, 29 Jun 2018 12:25:47 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d192-v6sm7178406qkb.46.2018.06.29.12.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:25:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 02/14] block: introduce bio_issue_as_root_blkg
Date:   Fri, 29 Jun 2018 15:25:30 -0400
Message-Id: <20180629192542.26649-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180629192542.26649-1-josef@toxicpanda.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

Instead of forcing all file systems to get the right context on their
bio's, simply check for REQ_META to see if we need to issue as the root
blkg.  We don't want to force all bio's to have the root blkg associated
with them if REQ_META is set, as some controllers (blk-iolatency) need
to know who the originating cgroup is so it can backcharge them for the
work they are doing.  This helper will make sure that the controllers do
the proper thing wrt the IO priority and backcharging.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/blk-cgroup.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6c666fd7de3c..69aa71dc0c04 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -238,6 +238,22 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 	return css_to_blkcg(task_css(current, io_cgrp_id));
 }
 
+/**
+ * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
+ * @return: true if this bio needs to be submitted with the root blkg context.
+ *
+ * In order to avoid priority inversions we sometimes need to issue a bio as if
+ * it were attached to the root blkg, and then backcharge to the actual owning
+ * blkg.  The idea is we do bio_blkcg() to look up the actual context for the
+ * bio and attach the appropriate blkg to the bio.  Then we call this helper and
+ * if it is true run with the root blkg for that queue and then do any
+ * backcharging to the originating cgroup once the io is complete.
+ */
+static inline bool bio_issue_as_root_blkg(struct bio *bio)
+{
+	return (bio->bi_opf & REQ_META);
+}
+
 /**
  * blkcg_parent - get the parent of a blkcg
  * @blkcg: blkcg of interest
-- 
2.14.3

