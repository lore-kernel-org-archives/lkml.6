Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35F0C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 11:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C922077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 11:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck0Ug6aK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C922077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeJNTHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 15:07:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40893 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeJNTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 15:07:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id 1-v6so7929447plv.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wbu8HvKWHmFly3GzATHm2Qtfp/ZYak2nWq8b8q7iqt8=;
        b=Ck0Ug6aKbYOV7OPBM1zZpzzahskRp0Z9KdaYlzRYsVU+3AsB06bXR4LmQMuM+42DJe
         LqUMqlYjGRttJc5g2xDS6MJ1t2KFOFVnmovKOlcemCoWzdEgL/rQ+xPSR4D0Pvh1mLHy
         1H34vRUDEtsyo65k/omwjvg23s+oZAFZeERA/20SSJ6lF8RlZVt1ez6LdXBac/j/bOo7
         m88ZHpWTe9O8tx4jW47uwd40+Q3OP4yiryv0tzFn29vLa0Db/CSKBKQcBZQliT8hMN3D
         J726M1nEnuxv5yb0aqlJbSB90M9J8wruOA4OhovvCzuPvc51YxUVAooS/VAHMW7tj82T
         wadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wbu8HvKWHmFly3GzATHm2Qtfp/ZYak2nWq8b8q7iqt8=;
        b=sogdN9OPdevA7trBQ1qoB23jftP0sZqAEt931JTZmGb746090hwa511pAO1nMWukAU
         bXobHUYAqWhLiZfrtYUxbO+mNA2ZUxTDVOXeECJrNprK40Q1U1H7aVDvXkEakgqfRIwW
         Ud409XzpMNMsiLH1C4W0SlSGM3Bdbi+C64sGfrxx1Z/gLBj7EilwKwjOvfd5WZ4b2qSC
         PlA4geoSyuFb6JL35UTg0uSvitFdoHQP7TWsbJO7Up4YwBrFkoFQTrtnLH/jVMdzn/L7
         /kkM6ImnzsXy/5iMdsmc47+sUnf+y4obteAL5QDgJUqHQ3mEVgfZH8UQxi0tdomzq8KJ
         VTDw==
X-Gm-Message-State: ABuFfohlIfLe9grddzsVBbwqL8UwMi2BvMrnV6+zIf/VPI26DoV0n3Qz
        k6JGvqGTf0Fkc+mYjZR5UFA=
X-Google-Smtp-Source: ACcGV627bFC+3D1Wohnz2HcPvnElNz8g0NgWLO3xoADQSAPu4HYw6Xkyi+HMZi5/l5tSFplfQTQ1OA==
X-Received: by 2002:a17:902:7045:: with SMTP id h5-v6mr1772080plt.211.1539516390433;
        Sun, 14 Oct 2018 04:26:30 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id m7-v6sm7672378pgq.59.2018.10.14.04.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 04:26:29 -0700 (PDT)
From:   Song Muchun <smuchun@gmail.com>
To:     mingo@redhat.com, mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix update min_vruntime in dequeue_entity()
Date:   Sun, 14 Oct 2018 19:26:12 +0800
Message-Id: <20181014112612.2614-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment and the code around 2nd update_min_vruntime() are
not in agreement. From commit b60205c7c558 ("sched/fair: Fix
min_vruntime tracking"), I think that we want to update min_vruntime
when a task is sleeping/migrating. So, the check is inverted there.

Fixes: b60205c7c558 ("sched/fair: Fix min_vruntime tracking")
Signed-off-by: Song Muchun <smuchun@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 585d5726338b..ee271bb661cc 100644
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

