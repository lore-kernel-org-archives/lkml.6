Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49794C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D91921900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QRmEbLhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438252AbfBNS6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:58:18 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59296 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395538AbfBNS6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:58:14 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190214185813euoutp01d153092f8f6f494b12ad9f39d7a114f0~DUAhSu5kg3056230562euoutp01A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:58:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190214185813euoutp01d153092f8f6f494b12ad9f39d7a114f0~DUAhSu5kg3056230562euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550170693;
        bh=1XGfectv7Qhst73Pj0qkueIcxP2sGHCSap0xJGIuUQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRmEbLhAdCkG1kGLsTDJV6bKgtdmZtSi4I1hk0gcjsXE34e0fUX5z9oyz1087ufea
         YLAWPUXeHP4EK56ljPk701u2JfO2k4t68vaYm9Wr9kxX5oXWjacFlpyk4ijaMNRHXL
         jPQV9I/xNE77qvcujUg23rNccrxBRXOlJHN6n34s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214185812eucas1p1de476846c8dff4cf20370c9003d61461~DUAgD6Q-A0095100951eucas1p12;
        Thu, 14 Feb 2019 18:58:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E8.0D.04441.34AB56C5; Thu, 14
        Feb 2019 18:58:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0~DUAfKf6ab2268922689eucas1p1a;
        Thu, 14 Feb 2019 18:58:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190214185810eusmtrp2de591659e4c021b358c0500c7033aefe~DUAe70Y2X1343513435eusmtrp2p;
        Thu, 14 Feb 2019 18:58:10 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-a1-5c65ba439946
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 11.39.04284.24AB56C5; Thu, 14
        Feb 2019 18:58:10 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190214185810eusmtip2f8953a34cc755688e361a12bc5e3763b~DUAeOUJ5v0560105601eusmtip2M;
        Thu, 14 Feb 2019 18:58:10 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 2/2] drivers: devfreq: add tracing for scheduling work
Date:   Thu, 14 Feb 2019 19:57:56 +0100
Message-Id: <1550170676-14173-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87rOu1JjDE53GFlsnLGe1eL6l+es
        Fmeb3rBb3GqQsbi8aw6bxefeI4wWa4/cZbe4dGABk8XnDY8ZLW43rmCz2NfxgMni8Jt2Vgce
        j9kNF1k8WvbdYvc4+G4Pk8f7fVfZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStjzey/bAVv
        OSrOzPnO1sC4ib2LkZNDQsBEYv6U/YxdjFwcQgIrGCXe9i5nhXC+MEq0fJ/CDOF8ZpTY3LGY
        BaZlX183VMtyRokVp9cwgiTAWh6cE+pi5OBgE9CT2LGqECQsImAl8aL9FTtIPbNAM5PEs7aF
        YIOEBdwk2s7NYQWpZxFQlbj5UA8kzCvgJfFl/3VWiF1yEjfPdTKD2JwC3hIbuyaxQcTnsUt0
        Pw6GsF0kLp57BVUvLPHq+Bao12Qk/u+czwRhF0uc7VgF1Vsj0X5yB1SNtcTh4xfBTmAW0JRY
        v0sfxJQQcJQ4/8cIwuSTuPFWEKSYGcictG06M0SYV6KjTQhihobElp4LUHvEJJavmQY120Pi
        z+H50NCcxyjR0XuDeQKj/CyEXQsYGVcxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEppXT
        /45/2sH49VLSIUYBDkYlHt4VGakxQqyJZcWVuYcYJTiYlUR4X28DCvGmJFZWpRblxxeV5qQW
        H2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCUamDMWst8g3tx2gUtJnU2+dvXlXkXuOmV
        u61axGk30dl0pvGs/ior56lzTCaFFPjOdbvN+vUUXyjHUck93z7XTvnCtZT19O7++RdMXHhj
        +PS4X9y3TZ7bmL9rKvvqsDWxf6z3n7M02r/Kic2AbYdC+aWMM5GPmKtFrJQS+VtnOEm80utQ
        vLGBwVaJpTgj0VCLuag4EQA8dZQMJwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xe7pOu1JjDLa+1rfYOGM9q8X1L89Z
        Lc42vWG3uNUgY3F51xw2i8+9Rxgt1h65y25x6cACJovPGx4zWtxuXMFmsa/jAZPF4TftrA48
        HrMbLrJ4tOy7xe5x8N0eJo/3+66yefRtWcXo8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gmtl/2QreclScmfOdrYFxE3sXIyeHhICJ
        xL6+bsYuRi4OIYGljBInHlxihEiISUzatx2qSFjiz7UuNoiiT4wS96Z2MHcxcnCwCehJ7FhV
        CFIjImAj8X7uGRaQGmaBfiaJpiUdrCAJYQE3ibZzc1hB6lkEVCVuPtQDCfMKeEl82X+dFWK+
        nMTNc53MIDangLfExq5JbCC2EFDN/TsPWCcw8i1gZFjFKJJaWpybnltsqFecmFtcmpeul5yf
        u4kRGOzbjv3cvIPx0sbgQ4wCHIxKPLwrMlJjhFgTy4orcw8xSnAwK4nwvt4GFOJNSaysSi3K
        jy8qzUktPsRoCnTTRGYp0eR8YCTmlcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1I
        LYLpY+LglGpg9Lt/bCmf6BSlh798IxNlvj5deW5bm6XBPmXuYM/TM7bF7pad+vSBesn6r12n
        5Z+ZfvjbIrt0/dt5Dv++HqoM+HrOjOvJff8ZHL02covfarkkLlzDofc7nLPVd1Fliv3mnfa+
        SntNA80XdE4Kdg7i2L4xPX/zzIK/iUsCJjou0N7t9ySe6260tBJLcUaioRZzUXEiADTKUJeM
        AgAA
X-CMS-MailID: 20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0
References: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add basic tracing of the devfreq workqueue and delayed work.
It aims to capture changes of the polling intervals and device state.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de7..c9714fd 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -29,6 +29,9 @@
 #include <linux/of.h>
 #include "governor.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/devfreq.h>
+
 static struct class *devfreq_class;
 
 /*
@@ -394,6 +397,11 @@ static void devfreq_monitor(struct work_struct *work)
 	queue_delayed_work(devfreq_wq, &devfreq->work,
 				msecs_to_jiffies(devfreq->profile->polling_ms));
 	mutex_unlock(&devfreq->lock);
+
+	trace_devfreq_monitor(dev_name(&devfreq->dev), devfreq->previous_freq,
+			      devfreq->profile->polling_ms,
+			      devfreq->last_status.busy_time,
+			      devfreq->last_status.total_time);
 }
 
 /**
-- 
2.7.4

