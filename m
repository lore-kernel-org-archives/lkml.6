Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924CBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BF62087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeL1Cjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 21:39:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbeL1Cje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 21:39:34 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5612ABB0359A;
        Fri, 28 Dec 2018 10:39:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Fri, 28 Dec 2018 10:39:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        David Windsor <dave@nullcore.net>,
        "Roman Gushchin" <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Rik van Riel" <riel@surriel.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mm: Mark 'stack_vm_area' with __maybe_unused
Date:   Fri, 28 Dec 2018 02:46:30 +0000
Message-ID: <1545965190-2381-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning when
CONFIG_VMAP_STACK is not set:

kernel/fork.c: In function 'dup_task_struct':
kernel/fork.c:843:20: warning:
 variable 'stack_vm_area' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index e2a5156..b38c392 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -840,7 +840,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 {
 	struct task_struct *tsk;
 	unsigned long *stack;
-	struct vm_struct *stack_vm_area;
+	struct vm_struct *stack_vm_area __maybe_unused;
 	int err;
 
 	if (node == NUMA_NO_NODE)



