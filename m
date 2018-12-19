Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B46CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646C021841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeLSNfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:35:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50789 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729314AbeLSNfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:35:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so6134558wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LFXc3WxdrSHXgyCpCrn9p3wMV9bnOsJ/xNARp8pyj/o=;
        b=q82es3RQBiu8TpQypdZgiPR3kSrLyX1nGvTXIqmalTjAF52pPXXckDEzRt9LKQaFD1
         w2PYZfCIYu5ZmoVV5ZqmUDSX8PVsv80utQ0TMrCDgcRNShOaSpRBl22jtTzD7YinPoLF
         CQWNOwQCbX6SXjd/0eJF9XLOeHf5QiMHh/d6vGbH94fSmQxy22hc3zx35DB18ROzFfz8
         g4MbXOxsciVA+rqsL5cMvUeL7n0OD87secCaoWRjCF7mlEAuzZKroC9tpE1NOvsqG/id
         MV5ghcCEo6At26EpgluojRcgeroxuqgyLDBjldVZ6jSc/Lwq5j7dwzUEJVsDx9N2REGL
         V1hQ==
X-Gm-Message-State: AA+aEWZYHZc3OvBQ1QWFch5YBG8ZKTd6vkK7SKpYy08oa7YBuJsFRuuH
        3Rm4aLFVmDX1kEJRfbbrL5lCEg==
X-Google-Smtp-Source: AFSGD/VS8cyx4wmFF78HJFnegKkB6llgiLTYiopUtIhT16J6DfB8hdKBiAINLkAFphE1RyClEmqVUA==
X-Received: by 2002:a1c:8791:: with SMTP id j139mr7098836wmd.86.1545226508429;
        Wed, 19 Dec 2018 05:35:08 -0800 (PST)
Received: from localhost.localdomain.home ([151.15.249.65])
        by smtp.gmail.com with ESMTPSA id o16sm6251542wrn.11.2018.12.19.05.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:35:07 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     lizefan@huawei.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 2/2] sched/topology: Update init_sched_domains() comment
Date:   Wed, 19 Dec 2018 14:34:45 +0100
Message-Id: <20181219133445.31982-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181219133445.31982-1-juri.lelli@redhat.com>
References: <20181219133445.31982-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Holding hotplug lock is not a requirement anymore for callers of sched_
init_domains after commit 6acce3ef8452 ("sched: Remove get_online_cpus()
usage").

Update the relative comment preceding init_sched_domains().

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8d7f15ba5916..10e61b62f138 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1850,9 +1850,8 @@ void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms)
 }
 
 /*
- * Set up scheduler domains and groups. Callers must hold the hotplug lock.
- * For now this just excludes isolated CPUs, but could be used to
- * exclude other special cases in the future.
+ * Set up scheduler domains and groups.  For now this just excludes isolated
+ * CPUs, but could be used to exclude other special cases in the future.
  */
 int sched_init_domains(const struct cpumask *cpu_map)
 {
-- 
2.17.2

