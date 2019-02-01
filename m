Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD2DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9851218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SR8Eyyc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfBASiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:38:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60699 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfBASiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:38:17 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190201183815euoutp02088cf04f45a7bbef564b6cf0a8478e18~-UWX-eU7s2569825698euoutp02z
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 18:38:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190201183815euoutp02088cf04f45a7bbef564b6cf0a8478e18~-UWX-eU7s2569825698euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549046295;
        bh=GJW41DjudGz2vlwzTJPSKJ7u3dskLcWh/q0N5jgAyhQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SR8Eyyc0sYBOQ7NDMzEAuD/r4BsJyiO6plI3kwNo4oOyUuqB+UB2AcYwdZvaJTUF0
         AOwZDivMHW6bz0txTHsDzkNgS5mVV3R6zsBmhbSgy+yMAR7WQegbt2JF2i5onO7nlt
         oI/kJXVjI+xsiDukn4X+Zw+GBKKiuWgPXkTqrc8Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190201183814eucas1p25082a92c8f874e4a5b5186fc7829f717~-UWXOG6Tn2497424974eucas1p2z;
        Fri,  1 Feb 2019 18:38:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AE.42.04294.612945C5; Fri,  1
        Feb 2019 18:38:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190201183813eucas1p20183a08d4f75f853468a8129b048c208~-UWWbxHfV1776117761eucas1p2q;
        Fri,  1 Feb 2019 18:38:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190201183813eusmtrp16454222624010d36855d56e8b1c722a5~-UWWNC3gk0030900309eusmtrp1H;
        Fri,  1 Feb 2019 18:38:13 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-e8-5c549216a499
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BE.0D.04284.512945C5; Fri,  1
        Feb 2019 18:38:13 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190201183812eusmtip177a9a08674e895c440578f07b35e3f9c~-UWVaQJrp0541405414eusmtip1G;
        Fri,  1 Feb 2019 18:38:12 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH] drivers: devfreq: change devfreq workqueue mechanism
Date:   Fri,  1 Feb 2019 19:38:03 +0100
Message-Id: <1549046283-18242-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOV2xSSExBqcm8lhsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xa0GGYvLu+awWXzuPcJosfbIXXaL240r2CwOv2lntXg/udiBx2PN
        vDWMHgs2lXos/PSV1ePguz1MHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXxYUF9wX25iqOr
        exkbGN9JdjFyckgImEg8f36WqYuRi0NIYAWjxIvpL1kgnC+MEjdPf2OGcD4zSvSvXskG07L9
        53KoxHJGicnnLrDBtew8twfI4eBgE9CT2LGqEKRBRMBK4kX7K3aQGmaBbiaJhxt/MIEkhAVc
        JXr2/GAEsVkEVCU+/WhlB7F5Bbwk/ja2MUNsk5O4ea4TbJuEwH82iSuvL0Gd4SJx6/t8Fghb
        WOLV8S3sELaMxOnJPVDxYomzHaug6msk2k/ugKqxljh8/CIryKHMApoS63fpQ4QdJTrvLWIG
        CUsI8EnceCsIEmYGMidtmw4V5pXoaBOCqNaQ2NJzgQnCFpNYvmYa1HAPicbNj1hBbCGBWImm
        hxPYJjDKzULYtYCRcRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg8jj97/iXHYy7/iQd
        YhTgYFTi4RWoDokRYk0sK67MPcQowcGsJMLrlAUU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN
        8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwLglbMos7etifWGsqum51+zZg5bPTfkm7/87z7y3iGfp
        Yn2V27bSURaznu4/F1hw465It4eJFJO4BuvJlAUHJ7oVPNQNljXV0DXaONsu6/qnRQ61Zkv/
        L9L4mKSzVec/r7a0AMdvl1k9R4VPVuV7+7591hBdaTA/WTii+cDPKxHW1ecqixcrKrEUZyQa
        ajEXFScCAD06unUaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsVy+t/xu7qik0JiDC42sFtsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xa0GGYvLu+awWXzuPcJosfbIXXaL240r2CwOv2lntXg/udiBx2PN
        vDWMHgs2lXos/PSV1ePguz1MHn1bVjF6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxYUF9wX25iqOrexkbGN9JdjFyckgImEhs/7mc
        uYuRi0NIYCmjRMuMNywQCTGJSfu2s0PYwhJ/rnWxQRR9YpTY9PwrUxcjBwebgJ7EjlWFIDUi
        AjYS7+eeYQGpYRaYziTx5+ocNpCEsICrRM+eH4wgNouAqsSnH61gQ3kFvCT+NrYxQyyQk7h5
        rpN5AiPPAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFhu+3Yz807GC9tDD7EKMDBqMTD
        K1AdEiPEmlhWXJl7iFGCg1lJhNcpCyjEm5JYWZValB9fVJqTWnyI0RRo+URmKdHkfGBM5ZXE
        G5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYHTK2tf08c77IPuVXeVy
        W9hf65760Om7TMErZOYpE891q59w3o2YvWKqW+vz1/NuC35hujclX8b24C+796nemjPMTWQm
        LH/zdvLrz0bzWfbHzFpd1WVQsXlrvgZLhXvlxINsUWEXGc74mt84/M4z+mmExf0pK8VdnPTi
        dhpOuLHkj+eko+yvmKcosRRnJBpqMRcVJwIAdMBLc3ECAAA=
X-CMS-MailID: 20190201183813eucas1p20183a08d4f75f853468a8129b048c208
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201183813eucas1p20183a08d4f75f853468a8129b048c208
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201183813eucas1p20183a08d4f75f853468a8129b048c208
References: <CGME20190201183813eucas1p20183a08d4f75f853468a8129b048c208@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes devfreq's custom workqueue and uses system one.
It switches from queue_delayed_work() to schedule_delayed_work().
It also changes deferred work to delayed work, which is now not missed
when timer is put on CPU that entered idle state.
The devfreq framework governor was not called, thus changing the frequency
of the device did not happen.
Benchmarks for stressing Dynamic Memory Controller show x2
performance boost with this patch when 'simpleondemand_governor' is
responsible for monitoring the device load and frequency changes.
With this patch, the scheduled delayed work is done no mater CPUs' idle.
It also does not wake up the system when it enters suspend (this
functionality stays the same).
All of the drivers in devfreq which rely on periodic, guaranteed wakeup
intervals should benefit from it.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de7..c200b3c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -31,13 +31,6 @@
 
 static struct class *devfreq_class;
 
-/*
- * devfreq core provides delayed work based load monitoring helper
- * functions. Governors can use these or can implement their own
- * monitoring mechanism.
- */
-static struct workqueue_struct *devfreq_wq;
-
 /* The list of all device-devfreq governors */
 static LIST_HEAD(devfreq_governor_list);
 /* The list of all device-devfreq */
@@ -391,8 +384,8 @@ static void devfreq_monitor(struct work_struct *work)
 	if (err)
 		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
 
-	queue_delayed_work(devfreq_wq, &devfreq->work,
-				msecs_to_jiffies(devfreq->profile->polling_ms));
+	schedule_delayed_work(&devfreq->work,
+			      msecs_to_jiffies(devfreq->profile->polling_ms));
 	mutex_unlock(&devfreq->lock);
 }
 
@@ -407,9 +400,9 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
-	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
 	if (devfreq->profile->polling_ms)
-		queue_delayed_work(devfreq_wq, &devfreq->work,
+		schedule_delayed_work(&devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 }
 EXPORT_SYMBOL(devfreq_monitor_start);
@@ -473,7 +466,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 
 	if (!delayed_work_pending(&devfreq->work) &&
 			devfreq->profile->polling_ms)
-		queue_delayed_work(devfreq_wq, &devfreq->work,
+		schedule_delayed_work(&devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
 	devfreq->last_stat_updated = jiffies;
@@ -516,7 +509,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 
 	/* if current delay is zero, start polling with new delay */
 	if (!cur_delay) {
-		queue_delayed_work(devfreq_wq, &devfreq->work,
+		schedule_delayed_work(&devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 		goto out;
 	}
@@ -527,7 +520,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 		cancel_delayed_work_sync(&devfreq->work);
 		mutex_lock(&devfreq->lock);
 		if (!devfreq->stop_polling)
-			queue_delayed_work(devfreq_wq, &devfreq->work,
+			schedule_delayed_work(&devfreq->work,
 			      msecs_to_jiffies(devfreq->profile->polling_ms));
 	}
 out:
@@ -1430,12 +1423,6 @@ static int __init devfreq_init(void)
 		return PTR_ERR(devfreq_class);
 	}
 
-	devfreq_wq = create_freezable_workqueue("devfreq_wq");
-	if (!devfreq_wq) {
-		class_destroy(devfreq_class);
-		pr_err("%s: couldn't create workqueue\n", __FILE__);
-		return -ENOMEM;
-	}
 	devfreq_class->dev_groups = devfreq_groups;
 
 	return 0;
-- 
2.7.4

