Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9DAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC70222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ceC/mab+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfBLWYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:24:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43184 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbfBLWYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:24:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212222441euoutp02e8677baf1a82a33bc1b01e6d49266159~CviNyqnIf2689326893euoutp02j
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:24:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212222441euoutp02e8677baf1a82a33bc1b01e6d49266159~CviNyqnIf2689326893euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550010281;
        bh=SYN7egH52Y2feMOkqm4NJLPSYateJfp0Xa3NLviJfqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceC/mab+j5aE8/49/Lr1devRw5/RDB6EvYSD7KYzxqZ0YD2aPb6LhBLkVA3zrIdl4
         NcdBwOlpL8i6tlqd/c7l5MKbknLeTz0rJO3cshIvy+HNge63zkvOCjentD07X0INVX
         JTRrWFLqPUcHiwPLcju+AMYgVwK1yoV3Kfx9ARZg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212222439eucas1p17fa7beda7a1195f4f96fb9215cb7159e~CviMVzYzp3241332413eucas1p1Z;
        Tue, 12 Feb 2019 22:24:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.45.04294.7A7436C5; Tue, 12
        Feb 2019 22:24:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190212222438eucas1p27e020c2b36f2e5a2188e4df6fb18488b~CviLUxpJ22094320943eucas1p2S;
        Tue, 12 Feb 2019 22:24:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212222438eusmtrp2c400061bde808e2ae5621a5a911600e1~CviLGAOD32980329803eusmtrp2Q;
        Tue, 12 Feb 2019 22:24:38 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-05-5c6347a7be9b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 20.3C.04284.6A7436C5; Tue, 12
        Feb 2019 22:24:38 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222437eusmtip1978d34682a89c707ecead0da0b7c14b1~CviKV2dqg2067220672eusmtip1E;
        Tue, 12 Feb 2019 22:24:37 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 7/7] drivers: devfreq: add tracing for scheduling work
Date:   Tue, 12 Feb 2019 23:23:58 +0100
Message-Id: <1550010238-24002-8-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7rL3ZNjDM4vEbPYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWlw4sYLL4vOExo8XtxhVsFvs6
        HjBZHH7TzmrxfnKxA7/HmnlrGD1mN1xk8WjZd4vdY8GmUo+Fn76yehx8t4fJ4/2+q2wefVtW
        MXp83iQXwBnFZZOSmpNZllqkb5fAlfFz0UnmgpncFdfWfWVpYFzK2cXIySEhYCKx6lwXUxcj
        F4eQwApGiceXbzNCOF8YJWZca4LKfGaU+NrSxAjTcv36N1aIxHJGiV3rvoIlwFr2TKjtYuTg
        YBPQk9ixqhAkLCJgJfGi/RU7SD2zwDEmiU97pzCDJIQFPCVO/VwCZrMIqErMe3UDzOYV8JLo
        2dTEDLFMTuLmuU4wm1PAW+LMtJWsEPFD7BK93bUQtovEx1tLoeqFJV4d38IOYctI/N85nwnC
        LpY427GKDcKukWg/uQOqxlri8PGLrCA3MwtoSqzfpQ8RdpS4/fEBO0hYQoBP4sZbQZAwM5A5
        adt0Zogwr0RHmxBEtYbElp4LUIvEJJavmQY13EPidccydkhIzWOUWPxkHeMERvlZCMsWMDKu
        YhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECExIp/8d/7KDcdefpEOMAhyMSjy8K44mxQix
        JpYVV+YeYpTgYFYS4fW0SY4R4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1
        ILUIJsvEwSnVwNiffCE3N4ydw6998d9TptdOrcpm0jyXXdE37fCVBzxK/VW1UoXzHk7LCY86
        GfMl0lE6/6nvbv/5JUfTQyyVsuWbm9imtEfxV3xa0CJ0jkelrGiXpt6DvqM+mvHPV9nMnvrI
        p0vuz/QrvOYtdVOD6lcFyOg0qXx61vF+eYy/etGhfY/uTilVU2Ipzkg01GIuKk4EAMy2B15E
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7rL3JNjDF5+4rXYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWlw4sYLL4vOExo8XtxhVsFvs6
        HjBZHH7TzmrxfnKxA7/HmnlrGD1mN1xk8WjZd4vdY8GmUo+Fn76yehx8t4fJ4/2+q2wefVtW
        MXp83iQXwBmlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl/Fz0UnmgpncFdfWfWVpYFzK2cXIySEhYCJx/fo31i5GLg4hgaWMEudXNzFDJMQkJu3b
        zg5hC0v8udbFBmILCXxilFi8x66LkYODTUBPYseqQpCwiICNxPu5Z1hA5jALXGOSuN1xnxUk
        ISzgKXHq5xKwmSwCqhLzXt0As3kFvCR6NsHskpO4ea4TzOYU8JY4M20lK8h8IaCapoMGExj5
        FjAyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMkG3Hfm7ewXhpY/AhRgEORiUe3hVHk2KE
        WBPLiitzDzFKcDArifB62iTHCPGmJFZWpRblxxeV5qQWH2I0BbppIrOUaHI+MHrzSuINTQ3N
        LSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwWr1s78jcX1bcvlf4fO7z9rh5
        c9O2LJ4auLe7QTWZSVoo7c6J5/umX3DakRd5TlWm/e2c9v9B86RkJPNbI/WrWixmaBfITExv
        Ds4SKdrCa3DrwqHqW9LLupVFXpY0TvSaYRq9/JtKe7ZcyOKKvoPSmTsu1SQbvt7W9+Dr9bSj
        0Xcrd7T2/PBTYinOSDTUYi4qTgQAmWmr/KYCAAA=
X-CMS-MailID: 20190212222438eucas1p27e020c2b36f2e5a2188e4df6fb18488b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222438eucas1p27e020c2b36f2e5a2188e4df6fb18488b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222438eucas1p27e020c2b36f2e5a2188e4df6fb18488b
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222438eucas1p27e020c2b36f2e5a2188e4df6fb18488b@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add basic tracing of the devfreq workqueue and delayed work.
It aims to capture changes of the polling intervals and device state.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 29e99ce..c1d0d8c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -29,6 +29,9 @@
 #include <linux/of.h>
 #include "governor.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/devfreq.h>
+
 /* The ~30% load threshold used for load calculation (due to fixed point
  * arithmetic) */
 #define LOAD_THRESHOLD_IN_DEVICE_USAGE (300)
@@ -418,6 +421,7 @@ static void devfreq_monitor(struct work_struct *work)
 	struct devfreq *devfreq = container_of(work,
 					struct devfreq, work.work);
 	unsigned int polling_ms;
+	const char *df_name = dev_name(&devfreq->dev);
 
 	mutex_lock(&devfreq->lock);
 	polling_ms = devfreq_get_polling_delay(devfreq);
@@ -429,6 +433,10 @@ static void devfreq_monitor(struct work_struct *work)
 	schedule_delayed_work(&devfreq->work,
 			      msecs_to_jiffies(polling_ms));
 	mutex_unlock(&devfreq->lock);
+
+	trace_devfreq_monitor(df_name, devfreq->previous_freq, polling_ms,
+			      devfreq->last_status.busy_time,
+			      devfreq->last_status.total_time);
 }
 
 /**
-- 
2.7.4

