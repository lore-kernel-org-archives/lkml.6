Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7509C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B46B222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="etql8x53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbfBLWYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:24:38 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37923 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732064AbfBLWYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:24:35 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190212222434euoutp01ecaa667d44691c0333d740afdfb48ca8~CviHWCYBo0553905539euoutp01U
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:24:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190212222434euoutp01ecaa667d44691c0333d740afdfb48ca8~CviHWCYBo0553905539euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550010274;
        bh=KqkqYXxukBnSIJA+sFmQXEE/iDEhqD/Nl1ve7BwR/As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etql8x53pr1sJYe3eDSuDr5bobd9B3mb87niiH/Q8oVXXROFYIDRU9RAS25buhrbW
         wYRTe1RMSjGjEA+ojVfV4IaMmXFfL/f1VQFA8zXuaVCghiTTODQvpIYAyPPp6UErHj
         7Cz7coIWGceampNl2eWz11isndApEOuezedDi7iU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212222433eucas1p28631700a0adcfd382213974273cf7e4e~CviGlnEa72786327863eucas1p2T;
        Tue, 12 Feb 2019 22:24:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 25.03.04441.1A7436C5; Tue, 12
        Feb 2019 22:24:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222431eucas1p1697607e6536a90283cf7dad37fa74dbb~CviFEYTL92824728247eucas1p1T;
        Tue, 12 Feb 2019 22:24:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190212222431eusmtrp13c30a6b4cee6eb27d53bc41626cb80fa~CviE1lDyx2311323113eusmtrp1g;
        Tue, 12 Feb 2019 22:24:31 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-df-5c6347a1be68
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.93.04128.F97436C5; Tue, 12
        Feb 2019 22:24:31 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222430eusmtip16cce7fd7db472b1b5806427db2260e87~CviEKjnVt0525605256eusmtip15;
        Tue, 12 Feb 2019 22:24:30 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 2/7] drivers: devfreq: change devfreq workqueue mechanism
Date:   Tue, 12 Feb 2019 23:23:53 +0100
Message-Id: <1550010238-24002-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7oL3ZNjDLpm81psnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xa0GGYvLu+awWXzuPcJosfbIXXaLSwcWMFl83vCY0eJ24wo2i30d
        D5gsDr9pZ7V4P7nYgd9jzbw1jB6zGy6yeLTsu8XusWBTqcfCT19ZPQ6+28Pk8X7fVTaPvi2r
        GD0+b5IL4IzisklJzcksSy3St0vgyvhz8w17wVfJikmTlrA1MD4X7WLk5JAQMJE4dOQ0Uxcj
        F4eQwApGiTs9vxkhnC+MEoeOPWcDqRIS+Mwocf1VLkzHpa0gcZCi5YwSp7pvscN1LO0/ztLF
        yMHBJqAnsWNVIUiDiICVxIv2V2A1zALHmCQ+7Z3CDJIQFvCR+NqzGMxmEVCVWHz1MDuIzSvg
        JXFpw2lWiG1yEjfPdYLVcAp4S5yZtpIVZJCEwCF2iZdPPzBBFLlIXJ64mgXCFpZ4dXwLO4Qt
        I3F6cg9UvFjibMcqNgi7RqL95A6oGmuJw8cvsoIczSygKbF+lz5E2FFix40jTCBhCQE+iRtv
        BUHCzEDmpG3TmSHCvBIdbUIQ1RoSW3ouQB0jJrF8zTSo4R4S65+fZ4EEzzxGiVkn37FMYJSf
        hbBsASPjKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMCUdPrf8U87GL9eSjrEKMDBqMTD
        u+JoUowQa2JZcWXuIUYJDmYlEV5Pm+QYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTS
        E0tSs1NTC1KLYLJMHJxSDYzsxbt5LPfFTy0rXLSOUV6h++V98wpt8a/yamFOSf9E/ut7nVNm
        8FVxkZlzeO563Sgl2+PNhRdYMjYFc5p7TOzukQ5zkeF3Tl60JvmKyJff1w928K5v8VfvPpQn
        sVbq5t4Cq11qrEscllyd6zhx7SrrY0tkgx8dE/QvDmlXc9ec+ekGs9tjdSWW4oxEQy3mouJE
        AD+3q3dFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7rz3ZNjDO5dlLfYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWlw4sYLL4vOExo8XtxhVsFvs6
        HjBZHH7TzmrxfnKxA7/HmnlrGD1mN1xk8WjZd4vdY8GmUo+Fn76yehx8t4fJ4/2+q2wefVtW
        MXp83iQXwBmlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl/Hn5hv2gq+SFZMmLWFrYHwu2sXIySEhYCJxaetzti5GLg4hgaWMEq8ermGHSIhJTNq3
        HcoWlvhzrQuq6BOjxLZ/K1m6GDk42AT0JHasKgSpERGwkXg/9wwLSA2zwDUmidsd91lBEsIC
        PhJfexYzg9gsAqoSi68eBhvKK+AlcWnDaVaIBXISN891gtVwCnhLnJm2khVkvhBQTdNBgwmM
        fAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExsi2Yz+37GDsehd8iFGAg1GJh3fF0aQY
        IdbEsuLK3EOMEhzMSiK8njbJMUK8KYmVValF+fFFpTmpxYcYTYFumsgsJZqcD4zfvJJ4Q1ND
        cwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjKbzt1TKP+ec+udvpPN5/U02
        8i0MtzMT13zczqpesOV7Q1SmmlF76eeK7y+U1eIF5UJuJbEImmyX5n0eZ6zZy3jMg/NlfLiY
        whzJDR1Z7xM2M0081965WDhPZPrvv/N5kz1kJu284F8VljJvg+Wdg3dsJuryrgraWDDjvoPF
        /sntq9ZOvjVbSomlOCPRUIu5qDgRAJhc+IinAgAA
X-CMS-MailID: 20190212222431eucas1p1697607e6536a90283cf7dad37fa74dbb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222431eucas1p1697607e6536a90283cf7dad37fa74dbb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222431eucas1p1697607e6536a90283cf7dad37fa74dbb
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222431eucas1p1697607e6536a90283cf7dad37fa74dbb@eucas1p1.samsung.com>
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
index 0c9bff8..c200b3c 100644
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
 	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
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

