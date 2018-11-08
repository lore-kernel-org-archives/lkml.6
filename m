Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D7CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC8520827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEyOmvJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC8520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeKIFxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:53:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43583 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeKIFxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:53:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so28778845qkr.10;
        Thu, 08 Nov 2018 12:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mJ+hAWBjzYrtG9eKN+9slhswn7Xi2CuWuxj5q13heRo=;
        b=iEyOmvJWIkp2iDqOu4d/ZJzOXwaz59Zzuacsb1iK7faH53XGcY2v00rJrDUCgQBCxd
         DNcF2h91l5DDJiSK5rgn27lbAOcrokur/9wdGKDSTLM39qOzekCpTLArqcnOXyGSLUTt
         0a/3hvgnGdGS0592nMd321GuNGer7Td79eNruH0jOEURN2kmoZ8Gv1V5RC2qdr+vzMqE
         ARCJUR1yV+bgtlCCiyEimjmytvlqRZPm1DklSD4BRsexd3W4j0LVsG6hbDitBI5LhWBj
         ty6/H3fMMyx4xOGxQRRnhM+yGJ6vVWbZsHuvDbHlw7UA9UftAagFMopwcgXJsnGkJi90
         6BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mJ+hAWBjzYrtG9eKN+9slhswn7Xi2CuWuxj5q13heRo=;
        b=ZRqbSlAn9Ux31hYgkZBz+1Yphc8T7PiL9QuQW6JGARFBB+U+/ur57dUGOIQA3yA9W1
         jiJvfYhWaBZRaVJKoPZq8ZBHpV4t2JeDaVd0sxaudXU9XfbDaNqWvzifbHnc3R+7PQjX
         9XfiRfEniv9CGfLVa7Rsm/nR1byKZLtb+ZXJ1rzhScH+M8w0/XhJ4V9ouvqbWdPOI5GO
         +6uQ2MPpTMTs37OV7dBBO385CSkyCEE+VIdRW1JgYTboaollqnP191SlfRycmqx/g9mp
         GeaAB0yoohDWh+889RvjVn2Qe3BQKfGtqhAtkgmWSWkTC6TOqxq4ZJFafyFJy6QORHbt
         9i4A==
X-Gm-Message-State: AGRZ1gLVDJN+GoOaFOcfackUJxQuGAiUzVu9quug8CCvU0L09x6PoBip
        Kgee7El4kS1xO2lxUDUZTSq+7O9KmKE=
X-Google-Smtp-Source: AJdET5ewntIX4CQbBJ+VS5k7K+3j4DldoZOXSFmCI1UfG7cSK0/gAZv5355f3w2igVxqg6MMVyM71g==
X-Received: by 2002:ac8:4884:: with SMTP id i4mr5898830qtq.219.1541708168843;
        Thu, 08 Nov 2018 12:16:08 -0800 (PST)
Received: from castle.thefacebook.com ([2620:10d:c091:200::4:4cb1])
        by smtp.gmail.com with ESMTPSA id k38sm3399381qkh.72.2018.11.08.12.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 12:16:08 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] cgroup: rename freezer.c into legacy_freezer.c
Date:   Thu,  8 Nov 2018 15:15:56 -0500
Message-Id: <20181108201600.9129-2-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181108201600.9129-1-guro@fb.com>
References: <20181108201600.9129-1-guro@fb.com>
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

