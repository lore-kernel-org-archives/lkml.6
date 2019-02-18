Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7203CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2E92184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KkA3AKPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfBRG2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:28:42 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:22802 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRG2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:28:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1I6SF1Z003818;
        Mon, 18 Feb 2019 15:28:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1I6SF1Z003818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550471296;
        bh=GQ7y1jv3TPMmSnBg82zb/DrP9e/mLTCQYVUXjI9OyZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=KkA3AKPZ51exYb2sT/Xer+WNznFqHg5jSHzJaOkrzi89Me3a+WapQkd+0VVxGWMt+
         D315WrZ1URvw8GckMPFT/LVqSOtTEbjl2WxpUWYYccQJ2CFgPhy66HzBa/ElDa50WA
         4trva+OK9SxyQhykCu7cZeWylxqkYkF6nh4lbP4/tw3fy55Ohr9Y9IOdqBA1PJWilT
         Iq11cpMPGyY0K8pKCK+RkBHqNKMiawtr+V9sLTWKj1v6Qu5gxbokMjtUFZ8k3T44NM
         5BVO3DVnhjMXE241ukLo7JclWtX90L+iIz/z2MXhP6j6iP/+8acZ+Kua/9X0Im/aWO
         0jGEtrIS3U9iQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpuset: remove unused task_has_mempolicy()
Date:   Mon, 18 Feb 2019 15:28:11 +0900
Message-Id: <1550471291-4327-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a remnant of commit 5f155f27cb7f ("mm, cpuset: always use
seqlock when changing task's nodemask").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 kernel/cgroup/cpuset.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 479743d..72afd55 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -203,19 +203,6 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
 	return css_cs(cs->css.parent);
 }
 
-#ifdef CONFIG_NUMA
-static inline bool task_has_mempolicy(struct task_struct *task)
-{
-	return task->mempolicy;
-}
-#else
-static inline bool task_has_mempolicy(struct task_struct *task)
-{
-	return false;
-}
-#endif
-
-
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_ONLINE,
-- 
2.7.4

