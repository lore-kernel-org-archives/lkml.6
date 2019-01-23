Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1337C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB21221726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfAWBu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:50:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfAWBu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:50:58 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 71B579018AEC3AB4B036;
        Wed, 23 Jan 2019 09:50:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 09:50:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Tai Nguyen <ttnguyen@apm.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] perf: xgene: Remove set but not used variable 'config'
Date:   Wed, 23 Jan 2019 01:56:31 +0000
Message-ID: <1548208591-46158-1-git-send-email-yuehaibing@huawei.com>
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

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/perf/xgene_pmu.c: In function 'xgene_perf_stop':
drivers/perf/xgene_pmu.c:1055:6: warning:
 variable 'config' set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/perf/xgene_pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index d4ec048..27574e8 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1052,7 +1052,6 @@ static void xgene_perf_start(struct perf_event *event, int flags)
 static void xgene_perf_stop(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hw = &event->hw;
-	u64 config;
 
 	if (hw->state & PERF_HES_UPTODATE)
 		return;
@@ -1064,7 +1063,6 @@ static void xgene_perf_stop(struct perf_event *event, int flags)
 	if (hw->state & PERF_HES_UPTODATE)
 		return;
 
-	config = hw->config;
 	xgene_perf_read(event);
 	hw->state |= PERF_HES_UPTODATE;
 }



