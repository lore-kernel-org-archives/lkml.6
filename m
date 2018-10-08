Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965D1C676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C49A20645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGHeHiZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C49A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJHUif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:38:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38192 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJHUif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:38:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so1431474pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UqfpPT8vEf7OKKVHwoY84WHB3qW2UG1fF7qQptqCzjs=;
        b=pGHeHiZNB7BbZirRVU0fq1MUDhHT6Qm/gle96nmPGr3bAyWNHtG3JCq+8kcYBaARGX
         zu7qUBhy7z6lmB/knfLonnR0pCNjS9Qty4HebKlNUVgOA6rbFVrlYrXMC7Uijls8LZ6Q
         b6kPY9fKFxzaZyD/5vZkv6EFwKYruUwGhKSX91xpUZcM6GDYA9/FLMsICQfkclMALAfR
         V8uf0reciN99x99G/fK0F3O7ws691cHmD3H2tLUUhk6VEFtdL36fUQp4LDneMGGMicUX
         3fDJvZISyhxp7zs/89rGoRhwYGpKPI6jYq6QVSiMnvLaGJDvose0I9uB6kj5I/SRVGZq
         5pWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UqfpPT8vEf7OKKVHwoY84WHB3qW2UG1fF7qQptqCzjs=;
        b=OyKhCcSRiFsQ6wYPbNKNAxazajXtVU/zxkOXSJLLw8gJQhs4EwbeHkCyVQ3YjlF6Hu
         67q3JR9s2jIV1yWO9mgHSpWAKh5yIZsU67K1lio62P4xLzilW2fHcRdDSltdvxR6uE7k
         nR1lWtIGL0KTxqPMwKamrxTFSfUo8jiwiuPlN+nmsrUM3gBg4nmRmvSnKBxOFxW8HzMq
         qkyiT/oOFhmGWkM/drB8EnBb/1Kd7DZN2Iz84eU0jScql1Zl0P6YDXSC4jyhaPrrWGAM
         rmm5PdJqG4waZxXg92hPBTsOoCUlGobBpylF188UBJuvU8pfdQV33e49BNmRn7Fl4qIX
         F7jw==
X-Gm-Message-State: ABuFfoj4R1oFOl7u2GRVS1NNOdcpgL94Rwxl+CJSlBlWm722DvtEIish
        7E/kBOliFe6SC+NYSv2QI7LTcKBddeKm6g==
X-Google-Smtp-Source: ACcGV62XBx+QfW8kr7WUlfh2GribhuTiaLMdvkE42dKIC01yQAzQjzydiPLOm3C1LO1gNuT4zjqklw==
X-Received: by 2002:a63:455e:: with SMTP id u30-v6mr1030108pgk.30.1539005211715;
        Mon, 08 Oct 2018 06:26:51 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id j14-v6sm17236057pgh.52.2018.10.08.06.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 06:26:51 -0700 (PDT)
From:   Song Muchun <smuchun@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Song Muchun <smuchun@gmail.com>
Subject: [PATCH] sched/fair: Fix update min_vruntime in dequeue_entity()
Date:   Mon,  8 Oct 2018 21:26:32 +0800
Message-Id: <20181008132632.83752-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment and the code around 2nd update_min_vruntime() are
not in agreement. From commit b60205c7c558 ("sched/fair: Fix
min_vruntime tracking"), I think that we want to update min_vruntime
when a task is sleeping/migrating. So, the check is inverted there.

Signed-off-by: Song Muchun <smuchun@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8f601edd958..c48ab0d1751e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4003,7 +4003,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * put back on, and if we advance min_vruntime, we'll be placed back
 	 * further than we started -- ie. we'll be penalized.
 	 */
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
+	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
 }
 
-- 
2.17.1

