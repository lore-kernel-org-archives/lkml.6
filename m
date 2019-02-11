Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2248BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D085321B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r1J4U7J+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbfBKPal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:30:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38839 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbfBKPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:30:37 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190211153036euoutp019c596e95a7b544569cc75ec681b717d0~CWPZFyAXB0731007310euoutp01w
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:30:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190211153036euoutp019c596e95a7b544569cc75ec681b717d0~CWPZFyAXB0731007310euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549899036;
        bh=1WHPhvc6LGCRwAvqQQU9cdvfjKoLYpm+pmVpGPdBqbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1J4U7J+l/mHXUVddRrHEVgccGhhNW/Wpljjj4ls15/5ubS4FOnw5OqwE65ujSXhC
         Iejq0eFuSyc+wcdrW5MIfx8QrIpZJH/eqLmBO9tmsqlGiXPkMmUHdvw9AF4jQ15G8m
         2wea7fCfFy3PtYayyomrtCNpSJHxI4ugjFbjIRg8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190211153036eucas1p25ad551750b5a27cd554998aa6f33416c~CWPYoYcWR2447924479eucas1p29;
        Mon, 11 Feb 2019 15:30:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A5.3B.04294.B15916C5; Mon, 11
        Feb 2019 15:30:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60~CWPX5sCz61377713777eucas1p1n;
        Mon, 11 Feb 2019 15:30:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190211153034eusmtrp1125db13f3ff96929e4ecdb09a65c2bc5~CWPXeqD5y0170801708eusmtrp18;
        Mon, 11 Feb 2019 15:30:34 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-b5-5c61951bd73c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0E.C1.04128.A15916C5; Mon, 11
        Feb 2019 15:30:34 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190211153034eusmtip1a14f560a5b688af82f1b3a670fbaec52~CWPW70QeI2415524155eusmtip1Y;
        Mon, 11 Feb 2019 15:30:34 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 1/2] drivers: devfreq: change devfreq workqueue mechanism
Date:   Mon, 11 Feb 2019 16:30:04 +0100
Message-Id: <1549899005-7760-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzvd889d4+bs8dRvmHMja1Mp4z1LE2vf1zWpj8togfPjuWtexBp
        63pz2Il5TxHVnC4vJZPslnXIGmdJXltGZSEvw1WYkbuH+u/z/Xw/L98/vgQmKccdiZj4JEYZ
        T8dKBSJ+87vV3gNORXTowTGTF/WitAGnipf6+dSQ6QdOVas8KOPNWSE1qnKm+lsfCKjlnA5E
        1XV8EVLLz78h6vONGgHVPqvGqYUC9rhYXltRi+T3VX18eWVjsrxq6Rcufzuv58nvNumQfLnR
        5ZzwvOhoFBMbk8IovQMuiqKH6zR44sre1JWyDb4KzezORlYEkL6guqflZSMRISFrEEy8mhVw
        gwnBytog4oZlBJm37uA7lon1LCG30CJ4ZmoT/rP8earfCiMIASmDFt1ls8GePAJT6hmLBiMf
        8qAnu96SZEeeBd3rj5gZ80kPqKgs55mxmDwDg5tP+FybC4z0Zlk0VmQgjNYPWO4DsloIv7U5
        ljIgT4M+L5DT28FMV5OQw87QXaDZzmHBmKkTcPgaqN+3bGv8ob2rDzfHYOR+aGj15ugTMD+i
        x7l0GxieszXT2BbMby7BOFoMmRkSTr0PmjQfeBzeA9ra4u1wORg7cy3HS8hyBJNDfnnItex/
        VyVCOuTAJLNxCob1iWeuyFg6jk2OV8giE+Ia0dbTdG90mVpQ63qEAZEEklqLUxPoUAlOp7Bp
        cQYEBCa1F0cUblHiKDrtKqNMCFcmxzKsATkRfKmDOH3XeIiEVNBJzCWGSWSUO1seYeWoQv6n
        8t9U/4wZwx/1eFy3jmIKTBqqu8S3r/6w0uuluyTS1kcxzSbOBRRNFRXXr0WshJWU5lQPVpJf
        F41tnVUJ34OCMSovVXuyL7jwtp9Rkr7YP6Cm7EPGM6bdbHLn3TfVMudYQ7kCHl8I4tWOu+b6
        aRttPq16HpsMi1kIcAvXSPlsNH3IE1Oy9F9Hjm+hMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e/4XV2pqYkxBrsW6ltsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xa0GGYvLu+awWXzuPcJosfbIXXaLzxseM1rcblzBZnH4TTurxfvJ
        xQ68HmvmrWH0mN1wkcVjwaZSj4WfvrJ6HHy3h8mjb8sqRo/Pm+QC2KP0bIryS0tSFTLyi0ts
        laINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mm6s7WEt+CFZ8WPWP5YGxlei
        XYycHBICJhIP/3SydzFycQgJLGWUODSljwUiISYxad92dghbWOLPtS42iKJPjBL9H5uYuxg5
        ONgE9CR2rCoEqRERsJF4P/cMC0gNs8BqJomfx3vZQBLCAj4Sq3ZeYgaxWQRUJeYtmMsEYvMK
        eEpc+78EapmcxM1znWA1nAJeErfWXQXrFQKqafjzgX0CI98CRoZVjCKppcW56bnFRnrFibnF
        pXnpesn5uZsYgcG/7djPLTsYu94FH2IU4GBU4uFVyE2MEWJNLCuuzD3EKMHBrCTCmzQFKMSb
        klhZlVqUH19UmpNafIjRFOioicxSosn5wMjMK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5Y
        kpqdmlqQWgTTx8TBKdXAODWcaY6sufKaY6vPFD/Utb6n/CDskPOd5ec4vx7yyK3/eKAg1zcj
        Wmt6CYvwzzmvPZR2v8gpKEybKs4zIeb6msLAkJ/Rsr1yMgbVhY+zZy+NOGDdc5fj8J4fKkH7
        Nh3VTavbrFGwhFcmTFm1ZsKRiVsPND6Unh/82fHGDEHRBxY2v6aZPu7lVWIpzkg01GIuKk4E
        AB6EGECUAgAA
X-CMS-MailID: 20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60
References: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for creating another workqueue in the system,
the existing one should meet the requirements.
This patch removes devfreq's custom workqueue and uses system one.
It switches from queue_delayed_work() to schedule_delayed_work().
It also does not wake up the system when it enters suspend (this
functionality stays the same).

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de7..882e717 100644
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
 
@@ -409,7 +402,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 {
 	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
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

