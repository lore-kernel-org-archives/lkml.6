Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4115A217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q32VfzdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfBRSYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:24:39 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33942 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392084AbfBRSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:21:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190218182131euoutp0100c3649bea0cf1cbfd0b896f4c3bd960~EiFngztST3074130741euoutp01s
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:21:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190218182131euoutp0100c3649bea0cf1cbfd0b896f4c3bd960~EiFngztST3074130741euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550514091;
        bh=wUN2vzB5U0AoORJfr99gPFk8Dy3g4fg9Lyo7amxIwqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q32VfzdLcoFrnvbUGQbp2Myqq513e6XiUmRn2nfEa5/v6zfIt6KxpoNX0rDJhq1ox
         QJB4TJa1oHSguNPiiVgF9Xa86l5PLE8/FSIK6flsaq/xONVtzEgtVg6b9My49KSa6f
         ejVIm3AUf4ri1Zg1ZONpvuULTm0Pl8cGzIpolqMg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190218182130eucas1p1e1f66aa71942a7e054b840ae0278313c~EiFm7SsNr3138431384eucas1p1C;
        Mon, 18 Feb 2019 18:21:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 14.1D.04806.AA7FA6C5; Mon, 18
        Feb 2019 18:21:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190218182129eucas1p1804530445570fc73af89ed46b9a448b9~EiFmFz1-K2715727157eucas1p1-;
        Mon, 18 Feb 2019 18:21:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190218182129eusmtrp13b49ca9d7477825ac9bc67cb6c2f8c1e~EiFl3HuOq2427024270eusmtrp1w;
        Mon, 18 Feb 2019 18:21:29 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-70-5c6af7aa328c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3C.F8.04128.9A7FA6C5; Mon, 18
        Feb 2019 18:21:29 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190218182128eusmtip1624d6919a0c1e7bd9e29f4484a62036e~EiFlPs7Qb1372313723eusmtip1V;
        Mon, 18 Feb 2019 18:21:28 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 2/2] drivers: devfreq: add tracing for scheduling work
Date:   Mon, 18 Feb 2019 19:21:09 +0100
Message-Id: <1550514069-9237-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTcRjG++9s55wNF6cp+sfEaBDeSIskD1pSIDHtS9+CFGzpyUs6bUct
        tctKcTp0mVaay1oRqSfDS2rzfsVlomTiNSWHulSswK3ES9ZOZ9K3h+f5vRdeXhyRPBS44nGK
        FEqpkCdIURG/qX9j+DCzHh9x5E+PM1lXWiMgJ6xfBeTQ3VWMnFa5kaMtT1DSUtAHyDd9sxj5
        qUvPIy2184D8fKcSJTty53hk76pacMpBplON8GXZHdOYrPt7G0/2o2MMlWkbGCCz1LufQy+I
        TkRTCXFplNIv+KIotmp0AEvWYtfvvT6pApsCDRDikPCH4ysliAaIcAlRCWDts188NpAQVgDn
        W4K4wAKgtbmBt1vRYtKjHFQBYPvbMxxkKyhuK8Q0AMdRwhcamKss40QEwiX1CsYyCJHFg+ac
        53w2cCRC4fpO3r9GfOIQnG/tBKwW23yDoc4+zB1ODechrBYSYXCrqhmwjSBRgsGCGY0dCoGN
        71pRTjvCFWMDxmk3OFicz+c0DYdyGTtzA6oHDHYmCPYaRwTs0gjhBWta/Dj7NNTpllDWhsRe
        OPltH2sjNlnUxF6LtcUwN0fC0Z6wIf+jfRlnWFH9yN5cBicGFwB3nnIA9dtVSCE4UPZ/mB4A
        BrhQqXRiDEUfU1DXfGl5Ip2qiPGNSkqsB7ZnGdwx/jSAju1LPYDAgdRBrK+Ij5AI5Gl0emIP
        gDgidRL3T9oscbQ8PYNSJkUqUxMougfsx/lSF3HmnrlwCREjT6GuUFQypdxNebjQVQU8vrRu
        F50/21X6mFiMYMprw5hg1eUyf4nRa6Z+5lVqcUBU3majedKU6dk0W+3dWXRzJNCn2prx1JQp
        tIybFrO1ZtHv0M4FRl3+YOygPjgyxOJucVime297mj+89/gZLrx/fDkLmWK21ry617pe3trg
        tfsUotKANJ22tWDkxbyUT8fKj3ojSlr+F/X3JkYoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xu7orv2fFGNx/LG2xccZ6VovrX56z
        WpxtesNucatBxuLyrjlsFp97jzBarD1yl93i0oEFTBafNzxmtLjduILNYl/HAyaLw2/aWR14
        PGY3XGTxaNl3i93j4Ls9TB7v911l8+jbsorR4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MlZdPshf0sVf0r7ZtYPzF2sXIySEhYCKx
        6+ECti5GLg4hgaWMEs1N/6ASYhKT9m1nh7CFJf5c64Iq+sQo0bj5P1MXIwcHm4CexI5VhSA1
        IgI2Eu/nnmEBqWEW6GeSaFrSATZIWMBT4vu/TjYQm0VAVeLx7v2MIDYvUHzHjo1MEAvkJG6e
        62QGsTkFvCR+r9wJViMEVHP+8S6WCYx8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgQG
        +7ZjP7fsYOx6F3yIUYCDUYmHd8HyrBgh1sSy4srcQ4wSHMxKIrzHbgCFeFMSK6tSi/Lji0pz
        UosPMZoCHTWRWUo0OR8YiXkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqY
        ODilGhgX/JGU4N9pEvU+mSv6zcJVXHyaGodOh76boqYxo5nr1snO/pPJmzMEVl5KVdv68sDb
        d13/lFne1Ohz/1oprLJox8nOL6nKCk3H927XnncvPXf7oxXXkvlYODdP36n38m/XZ3f3Gre+
        7IAraT8ZlW4vu3RigfJyg/anMdcyjObrcevdtubx37dNiaU4I9FQi7moOBEAIliwPIwCAAA=
X-CMS-MailID: 20190218182129eucas1p1804530445570fc73af89ed46b9a448b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190218182129eucas1p1804530445570fc73af89ed46b9a448b9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190218182129eucas1p1804530445570fc73af89ed46b9a448b9
References: <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190218182129eucas1p1804530445570fc73af89ed46b9a448b9@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add basic tracing of the devfreq workqueue and delayed work.
It aims to capture changes of the polling intervals and device state.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de7..660365a 100644
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
@@ -394,6 +397,8 @@ static void devfreq_monitor(struct work_struct *work)
 	queue_delayed_work(devfreq_wq, &devfreq->work,
 				msecs_to_jiffies(devfreq->profile->polling_ms));
 	mutex_unlock(&devfreq->lock);
+
+	trace_devfreq_monitor(devfreq);
 }
 
 /**
-- 
2.7.4

