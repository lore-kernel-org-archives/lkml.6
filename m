Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C439FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883972089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwvIc2Y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883972089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeKQKxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:53:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45315 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:53:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so11282164pgc.12;
        Fri, 16 Nov 2018 16:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mJ+hAWBjzYrtG9eKN+9slhswn7Xi2CuWuxj5q13heRo=;
        b=qwvIc2Y+PXxx8kZ4H59GjS4idYhJKXQCk2kP/Ehq6DgTL266DiskYKZ/w61t1i4TpV
         uohREcBifiWOad4Y2v+iGBDv+Fk0rxiXc2xLDsbuCZMsSGnlLWo7Cih2Yzch8NuGSRYv
         KywrxnKSkq1+4gTdaa2by22YOgUT17SQbKUgNjwftZ7w2KxYzSKMnmBxYGroSWAtyRJ+
         hlc3XBC5GRws2Dz7pcIij5R71k9Z91gftthEHmD/ZOaBv881WQw/JLfNfdbXmKGLmFbf
         MiYqX5KyOzIktaYjqgHX6Zl05fkFZIhYzS8c3S0rtaznB2mf2eLFSyuMEjudPmffgxZ8
         XhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mJ+hAWBjzYrtG9eKN+9slhswn7Xi2CuWuxj5q13heRo=;
        b=D/jnfsZ07CLvz6rfg/neZJFIydIifRsmaOGMPb1pnYCB/AUqqRrbybjSCyXKnd6g6+
         3WT4tra4tWcGVXEMEI0lxje1zlu1HzXjWYQhcbWoWcZj/p905UWsS/iBmzxuUQh7qWJ4
         hJd3NHcsD5ZDblBqSlx470rSJT7u6YgeZcL2uUStnmtSj7JHwyhAbSstZZwus+2BnJH3
         eNxiYj2rbGyhS9iz/3DvggWuR6YbZSBQ6WQX7lrtoQ2wLJEGw5XbK4Q3igyYRagzpUxq
         CKJazm8ottMV4l5rPcCGv87FUA/mAecrBsdk0IKv0jroi/qMo7E+8BO64JnUWSh+PIdW
         oNZw==
X-Gm-Message-State: AGRZ1gL8cDmRh3vkgJDk+5w/kmDnhCuRZqYDSErmf8SssrUdQ+yxzxB9
        A5aWvi+LgdwUX7iWKKURfymtyatvETQ=
X-Google-Smtp-Source: AJdET5frL0OWuhy2lod4Xb9VZTrSdbFiMYpotKZikrL2AZdHwVZf1xnBlCZPeXXC8VEcIUkjP0SLlQ==
X-Received: by 2002:a63:f844:: with SMTP id v4mr11827015pgj.82.1542415116009;
        Fri, 16 Nov 2018 16:38:36 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::4:2b73])
        by smtp.gmail.com with ESMTPSA id f6sm1981177pfg.188.2018.11.16.16.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 16:38:35 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 1/7] cgroup: rename freezer.c into legacy_freezer.c
Date:   Fri, 16 Nov 2018 16:38:24 -0800
Message-Id: <20181117003830.15344-2-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181117003830.15344-1-guro@fb.com>
References: <20181117003830.15344-1-guro@fb.com>
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
2.17.2

