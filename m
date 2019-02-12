Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75995C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A862190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INtNvp3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbfBLSsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:48:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43198 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732118AbfBLSsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:48:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so1645438pgk.10;
        Tue, 12 Feb 2019 10:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suU4k9iE7Md/KfJ4CfzvKVa4/9QAyJfSEidhnmW/+G4=;
        b=INtNvp3H9zdMtp3kcYDQMskua1THtfRgxAGGAIVRB7JNDn874CDV9KsMStpNWa2xEL
         RR9EQIAfASG2f5G41VZHK2HnxHV8kZ0pnnalBWPQlxagDRFqPxEfxHN9JlURxkFswNLn
         3FtoFMTfHNMM+prhDC/yYPtfAIxtM3JmFrWdOEIwn+rfAdCwiwVLbcdHD0kUbkkWjY0M
         vO/wyXBF3IWR8czOiJYKUC48AYvGvMixBgIr+6i6bwsnW5+FncVroEKebN/P8hZ2dDWS
         +2MAONo26YVbxJAdZgOKF/ruZbPc1WABeR6PKFTBZD5E+4y1hnsDg9BvaynjpStiIYJU
         AayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suU4k9iE7Md/KfJ4CfzvKVa4/9QAyJfSEidhnmW/+G4=;
        b=OJlpzCSG9WeN1oI5w7r95PLLkT+UX+SM5bYjoOZedJKpR0uNTa/wqN5c/Ad/efPXF1
         0Ke6gOKGRpyH7+ywBHGiD1Zil5eeYSB/1jP9ZJQ1vBSFTTEHHuN+qVu2or8oWoBjK3x2
         DNmr5RE/rEwmIXRRdG4cf+bWuzK+dqBBAo+gOxwHOVNRYy4JKJBQzbiOOjpDjxcw8Z4d
         kGZFce1yGlh2r2RsZwdS9uq2LCUxN084OOLBIdlspFmDXjLkD/7HTr8xBKB9Ny15+Hvr
         nQqdvWg08GdB7xNeBvjdxwaVq/FmycIwDdhFMbQohl5176DKYhCqB5uw55ZIXRCVHfN8
         ybhQ==
X-Gm-Message-State: AHQUAuYMxTehCauWn301UlxFmszhjzAoP1Kyv5rLM05AGlUC+8nj+coE
        jSTY5bj2t1gyzfgKHTSBmFU=
X-Google-Smtp-Source: AHgI3Iaah+QmrJRilV08qp62RKFGqu6y50w4zok0laivpUi6vKhq1pUGdWP5QL5l3WRpxqJK6ZewFA==
X-Received: by 2002:a63:fc4d:: with SMTP id r13mr4956696pgk.242.1549997297509;
        Tue, 12 Feb 2019 10:48:17 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:4d62])
        by smtp.gmail.com with ESMTPSA id f67sm25480102pfc.141.2019.02.12.10.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:48:16 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v7 1/7] cgroup: rename freezer.c into legacy_freezer.c
Date:   Tue, 12 Feb 2019 10:48:01 -0800
Message-Id: <20190212184807.20304-2-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212184807.20304-1-guro@fb.com>
References: <20190212184807.20304-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freezer.c will contain an implementation of cgroup v2 freezer,
so let's rename the v1 freezer to avoid naming conflicts.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 kernel/cgroup/Makefile                        | 2 +-
 kernel/cgroup/{freezer.c => legacy_freezer.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename kernel/cgroup/{freezer.c => legacy_freezer.c} (100%)

diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index bfcdae896122..8d5689ca94b9 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o
 
-obj-$(CONFIG_CGROUP_FREEZER) += freezer.o
+obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/legacy_freezer.c
similarity index 100%
rename from kernel/cgroup/freezer.c
rename to kernel/cgroup/legacy_freezer.c
-- 
2.20.1

