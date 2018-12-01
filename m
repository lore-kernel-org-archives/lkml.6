Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B0BC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809BD20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809BD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeLAUWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 15:22:06 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:56650 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeLAUWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 15:22:06 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 1EE54685BC0FEAD2B3B1;
        Sat,  1 Dec 2018 17:10:01 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB199tQ9069758;
        Sat, 1 Dec 2018 17:09:55 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120117104132-14115503 ;
          Sat, 1 Dec 2018 17:10:41 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] sched/fair: Fix assignment of boolean variables
Date:   Sat, 1 Dec 2018 17:09:36 +0800
Message-Id: <20181201090936.10175-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-01 17:10:41,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-01 17:09:35
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB199tQ9069758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings reported by coccinelle:
kernel//sched/fair.c:7958:3-12: WARNING: Assignment of bool to 0/1

This also makes the code more readable.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a2e8160968cb..f19aa66f9b15 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7955,7 +7955,7 @@ static inline void update=5Fsg=5Flb=5Fstats(struct lb=
=5Fenv *env,
 		if (env->sd->flags & SD=5FASYM=5FCPUCAPACITY &&
 		    sgs->group=5Fmisfit=5Ftask=5Fload < rq->misfit=5Ftask=5Fload) {
 			sgs->group=5Fmisfit=5Ftask=5Fload =3D rq->misfit=5Ftask=5Fload;
-			*overload =3D 1;
+			*overload =3D true;
 		}
 	}
=20
--=20
2.19.1

