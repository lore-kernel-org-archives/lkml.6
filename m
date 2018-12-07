Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D589C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6232083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHeNzApq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6232083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeLGUPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:15:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36303 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeLGUPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:15:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so2451938pfc.3;
        Fri, 07 Dec 2018 12:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mJ+hAWBjzYrtG9eKN+9slhswn7Xi2CuWuxj5q13heRo=;
        b=jHeNzApqttpKVz/ltNtKvxViPu0Gw62SHb5Tfbcxn1h3KauOhz+MIdEFlRkommBDtO
         UKaoPECJvDtrpn7BLmf27GGZvKQh7AZcvsB4T0c+kPxzhugZK1dQTfBYiZAsN6Q93USO
         TRSIaQ0MxMEl3dHIQK69uGxvTnWiprLJ2hsRuiIlAYpxpJ5JrCGm6ezTj8Sua7VQqpT4
         jHNuFsmdGNeSCldgIIMsdKddU5l2/VhtWE0sI6xmsXd7Nfx5B8dgpO+D/ttnTkbObkVQ
         5WbgZKxaoZg16Y5L/7/ak0gSnVzpTWg4s6klP0xja4XUqB6Zi1UHmA8sHhKzo0/3uMls
         kkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mJ+hAWBjzYrtG9eKN+9slhswn7Xi2CuWuxj5q13heRo=;
        b=oTJ+ZrlGXnaTodrClUwlvBNtyM8onRoO3oUyHcdWzcNtNj+U/GRTdpec0VlyFy5dbE
         ZHucDkIkmK7vRMlX5btOZVHHx/vLcrdWQjx5ZezA3lLujg3dQh0eZwswYUtBasc77+6I
         huhGSt4Nv2gcJWl97NiJ1v6JexFogaPl4ywZ4DYf1NGC3t82J4NYvc5Siwk6hvbseKDC
         hx4Kd7h5zgWuZcXlBHBcpoZWkSHyEkfQFBIB3UlP7l29T2Sr1dw/3l4LB1wDPF3yc+4t
         8kPX3WZ23b4wbaPpSZcZZfEEM+tgUMjp3FhuTBVFk4PjE1f5HWiHlBeyk9+YD3YZm5FF
         cu4w==
X-Gm-Message-State: AA+aEWbHoTH8dkFU8MhkC6WB/FPFpwyhJit8x9rdymbG+EkicjXksb37
        YImtw6b8+1c2twTyGgfUOn7jIPwcSSc=
X-Google-Smtp-Source: AFSGD/UcW/6HIKv/8bU8kGP2dljC/DYICdHpwxuTFWZsNyL2j6k5ofYJkZ+d25EDIVLKXMz3bsN+Ng==
X-Received: by 2002:a63:6782:: with SMTP id b124mr3203383pgc.151.1544213735947;
        Fri, 07 Dec 2018 12:15:35 -0800 (PST)
Received: from castle.thefacebook.com ([2620:10d:c090:200::6:d83b])
        by smtp.gmail.com with ESMTPSA id q75sm5870898pfa.38.2018.12.07.12.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 12:15:35 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v5 1/7] cgroup: rename freezer.c into legacy_freezer.c
Date:   Fri,  7 Dec 2018 12:15:25 -0800
Message-Id: <20181207201531.1665-2-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181207201531.1665-1-guro@fb.com>
References: <20181207201531.1665-1-guro@fb.com>
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

