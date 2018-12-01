Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661C8C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277812081C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277812081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLATRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 14:17:51 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:10236 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeLATRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 14:17:51 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id C2AC8CA622C17CC4482A;
        Sat,  1 Dec 2018 16:05:50 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB1859GX039106;
        Sat, 1 Dec 2018 16:05:09 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120116055556-14106847 ;
          Sat, 1 Dec 2018 16:05:55 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        "Peter Zijlstra (Intel)" <peterz@infraded.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] cpu: Bool tests don't need comparisons
Date:   Sat, 1 Dec 2018 16:04:44 +0800
Message-Id: <20181201080444.9305-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-01 16:05:55,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-01 16:04:50
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB1859GX039106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to the file cpu.c
which fixes the following coccinelle warning:

WARNING: Comparison to bool

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@kernel.org>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Josh Poimboeuf <jpoimboe@redhat.com>
CC: "Peter Zijlstra (Intel)" <peterz@infraded.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Mukesh Ojha <mojha@codeaurora.org>
CC: linux-kernel@vger.kernel.org
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 91d5c38eb7e5..5bdd7e150a11 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1650,7 +1650,7 @@ int =5F=5Fcpuhp=5Fstate=5Fadd=5Finstance=5Fcpuslocked=
(enum cpuhp=5Fstate state,
 	lockdep=5Fassert=5Fcpus=5Fheld();
=20
 	sp =3D cpuhp=5Fget=5Fstep(state);
-	if (sp->multi=5Finstance =3D=3D false)
+	if (!sp->multi=5Finstance)
 		return -EINVAL;
=20
 	mutex=5Flock(&cpuhp=5Fstate=5Fmutex);
--=20
2.19.1

