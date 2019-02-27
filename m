Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA6CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AE9218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O0uZ2ru3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfB0GNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:13:55 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18146 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfB0GNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:13:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c762a9d0000>; Tue, 26 Feb 2019 22:13:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Feb 2019 22:13:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Feb 2019 22:13:54 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 06:13:54 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 06:13:53 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 06:13:53 +0000
Received: from KetanPC.nvidia.com (Not Verified[10.24.230.224]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c762a9d0000>; Tue, 26 Feb 2019 22:13:53 -0800
From:   Ketan Patil <ketanp@nvidia.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <snikam@nvidia.com>,
        <bnihalani@nvidia.com>, <byan@nvidia.com>,
        <sgurrappadi@nvidia.com>, <treding@nvidia.com>, <talho@nvidia.com>,
        Ketan Patil <ketanp@nvidia.com>
Subject: [PATCH] sched/cputime: Remove unnecessary assignment statement
Date:   Wed, 27 Feb 2019 11:43:22 +0530
Message-ID: <1551248002-27303-1-git-send-email-ketanp@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551248030; bh=U7JoUTFtFbXNm2+yNUCW/elCKIwLCYopIaSqouFWelk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=O0uZ2ru3HKLAoFsMsTyywDm2Ivlwfmp5bsCLORboa5Lf+qXu0DC+iZTT4l9u80vEV
         mlTrBP3testqV597Kkm3jci28IHNDDwJJangSTn+96fkqmh17c9juxM9lCePAJrGOp
         Co0XlKBk2kkYM+Km0owsK4dCdu8zb0HHasDTCHYK2GaXfGztlKc4dZ7h3KEfhMULrn
         5dXWFqPbeMB6NpfNYyJiX/3wM/sbk4NAfCS/DEd3YacxZXYEHmp1x8QipZpITwdOF5
         8JYsqL/oIQQf0dX5vPbbJrDXcrsrEl7b233wZmXJ9P4Jit1KhhamPol54MpI38S7oP
         32XWx64SQBuTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code assigns the value from rtime to utime variable,
and then jumps to the update label. And the value of utime is then
updated, so the earlier value of utime is not used. Hence remove
that unnecessary assignment statement.

This fixes one of the coverity defects.

Based on work by Ishan Mittal <imittal@nvidia.com>

Signed-off-by: Ketan Patil <ketanp@nvidia.com>
---
 kernel/sched/cputime.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index ba4a143..ad64771 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -616,10 +616,8 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	 * Once a task gets some ticks, the monotonicy code at 'update:'
 	 * will ensure things converge to the observed ratio.
 	 */
-	if (stime == 0) {
-		utime = rtime;
+	if (stime == 0)
 		goto update;
-	}
 
 	if (utime == 0) {
 		stime = rtime;
-- 
2.7.4

