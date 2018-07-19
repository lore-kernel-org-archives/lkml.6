Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B096CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6976C20862
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGi5d0Bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6976C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeGSKtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:49:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42693 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeGSKtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:49:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so3414637pgp.9;
        Thu, 19 Jul 2018 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RJhJrPg5vB3sWmzaN5lFkpQiPrD9UBbb70hv06tTUJ4=;
        b=LGi5d0BhcB4tPQcG26h5D5OhpGUIlojIG4lB+mcxmmVOvO9fCPITFBLoriP8vcRM7W
         SsWSt7yC/SnEFr/o6aB/TXMiOQmREPLLkqVa5BQFvTDvHSqGJWKSHaGIIoOkVWSwLQe1
         KrU0wVvvDtdKlLueIiTTlwC8f9qMVPrqUMQjeYLuW5iTo4fpjHZNHexVbV+EM0LVpTOq
         uIMpyC1AYUc5TB2AyPETwm+MSx45Xw6DmgVOf4eeZ0KblVQ0eJ01Cl3zaeH6bgLE6HIA
         JN//NmrgXYw978tqx4SOoLj6fblWI+Afadq0lwGc9HEvu2zDHC5F0Xe7PUecthW5qKvg
         GJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RJhJrPg5vB3sWmzaN5lFkpQiPrD9UBbb70hv06tTUJ4=;
        b=tZ8dL0VZfLfoRpl+prX/jMiA3X/TxJlw/thXiMSZ5TzGV57vww4TTV+gWl2Fhlc9Da
         PI05jVFZjcxbc0rdMRBVz3Xa/bnhtjfaRzADuJOWR9K0WEbhcGk97VBDErCLF5fk0Lfu
         jzFXS5hsFWG27YWtgvlKZS4dv+vP150s60EmrBJPtUmIXMRqmr/DsgrB715cVsaT2VpG
         5Cq6T6u10OAzzIzVrk2U029rq1A4HdJiR/mSdBKLYS2BTPQiCv4Y5pwuQ9F33SDdhFCb
         3e3QspPBe5oFY7RkeyhkYpfqAi3149ZE4ykwk3BIzZEhOV0WDfuo7yn+G8aGdsombYyf
         BceQ==
X-Gm-Message-State: AOUpUlFpoeMDzNo1adzU6kJWGeC9oHNlxAv/HtUKKEWoWGrWWaS0oYyN
        JsPro3Eduqzh5m0AEtHqpXE=
X-Google-Smtp-Source: AAOMgpf58Ur/K54N5Jqcv1LqCmzf7A84ZeXpRjad39H0B7floe29T/MppWrhK10Q4OePYHd223IhSA==
X-Received: by 2002:a65:62d8:: with SMTP id m24-v6mr9447904pgv.307.1531994827602;
        Thu, 19 Jul 2018 03:07:07 -0700 (PDT)
Received: from localhost ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r25-v6sm19077908pfj.42.2018.07.19.03.07.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 03:07:07 -0700 (PDT)
From:   Jing Xia <jing.xia.mail@gmail.com>
X-Google-Original-From: Jing Xia <jing.xia@unisoc.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     chunyan.zhang@unisoc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcg: fix use after free in mem_cgroup_iter()
Date:   Thu, 19 Jul 2018 18:06:47 +0800
Message-Id: <1531994807-25639-1-git-send-email-jing.xia@unisoc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that a kernel crash happened in mem_cgroup_iter(),
which can be triggered if the legacy cgroup-v1 non-hierarchical
mode is used.

Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b8f
......
Call trace:
  mem_cgroup_iter+0x2e0/0x6d4
  shrink_zone+0x8c/0x324
  balance_pgdat+0x450/0x640
  kswapd+0x130/0x4b8
  kthread+0xe8/0xfc
  ret_from_fork+0x10/0x20

  mem_cgroup_iter():
      ......
      if (css_tryget(css))    <-- crash here
	    break;
      ......

The crashing reason is that mem_cgroup_iter() uses the memcg object
whose pointer is stored in iter->position, which has been freed before
and filled with POISON_FREE(0x6b).

And the root cause of the use-after-free issue is that
invalidate_reclaim_iterators() fails to reset the value of
iter->position to NULL when the css of the memcg is released in non-
hierarchical mode.

Signed-off-by: Jing Xia <jing.xia.mail@gmail.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e6f0d5e..8c0280b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -850,7 +850,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	int nid;
 	int i;
 
-	while ((memcg = parent_mem_cgroup(memcg))) {
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
 		for_each_node(nid) {
 			mz = mem_cgroup_nodeinfo(memcg, nid);
 			for (i = 0; i <= DEF_PRIORITY; i++) {
-- 
1.9.1

