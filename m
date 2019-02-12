Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9895C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB03222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VY3IrDsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbfBLWZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:25:05 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43145 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbfBLWYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:24:36 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212222435euoutp02fdcd909be767d2374c6288ca64993349~CviInXxQe2689326893euoutp02d
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:24:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212222435euoutp02fdcd909be767d2374c6288ca64993349~CviInXxQe2689326893euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550010275;
        bh=cM4MfP71aUVFJaWpBz2QSD5VGLiKRykfFn1oLctogTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VY3IrDspo8b9YlJfaI4sHkfoALQQyCsKCyn98zRyZ3ahqSVaeUf+b3lG+IuPt+kWw
         f5uQbMQQ7Dene0KgCtw5x2+Yq+tI/Hk8pbnTn3FUKj7tXtXy+t03Z8agrCWLgDPJZZ
         mWBrS6e34HtCYnCKlWwjcWOWNaVxsptuoJ3GNY6k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212222434eucas1p1bbda4ca2a1e6367dbd296b7b51455916~CviH2XwOi1210112101eucas1p10;
        Tue, 12 Feb 2019 22:24:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4C.0F.04806.2A7436C5; Tue, 12
        Feb 2019 22:24:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190212222433eucas1p264602d67a916c644c7eb5012932fc17a~CviGyLBjj1609016090eucas1p2v;
        Tue, 12 Feb 2019 22:24:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212222433eusmtrp262a8241c83eac7a5a8cf1ccaeee1285a~CviGjUmy42980329803eusmtrp2N;
        Tue, 12 Feb 2019 22:24:33 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-83-5c6347a2f882
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2D.2C.04284.1A7436C5; Tue, 12
        Feb 2019 22:24:33 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222432eusmtip13bf63b9c5752e75a5ce987641c16c259~CviFqa3wH0525605256eusmtip16;
        Tue, 12 Feb 2019 22:24:32 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 3/7] Kconfig: drivers: devfreq: add default idle polling
Date:   Tue, 12 Feb 2019 23:23:54 +0100
Message-Id: <1550010238-24002-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7qL3JNjDGZul7fYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWlw4sYLL4vOExo8XtxhVsFvs6
        HjBZHH7TzmrxfnKxA7/HmnlrGD1mN1xk8WjZd4vdY8GmUo+Fn76yehx8t4fJ4/2+q2wefVtW
        MXp83iQXwBnFZZOSmpNZllqkb5fAlfFz9l62gr2cFfM/SzUwXmbvYuTkkBAwkdjx9AVbFyMX
        h5DACkaJ84c3MkE4Xxgluud8hcp8ZpT48KKbCaZl4czzzBCJ5YwS9ybvZIZr6dr2maWLkYOD
        TUBPYseqQpAGEQEriRftr9hBapgFjjFJfNo7hRkkISzgLfHidwMbiM0ioCqx9cMXMJtXwEti
        btsnRohtchI3z3WC1XMC1Z+ZtpIVIn6IXeLFhnII20Xi0opHUA8JS7w6vgXKlpH4v3M+1NXF
        Emc7VrFB2DUS7Sd3QNVYSxw+fpEV5GZmAU2J9bv0IcKOEjcP/gULSwjwSdx4KwgSZgYyJ22b
        zgwR5pXoaBOCqNaQ2NJzAWqRmMTyNdOghntItF+7BA3QeYwSR84uZJ7AKD8LYdkCRsZVjOKp
        pcW56anFxnmp5XrFibnFpXnpesn5uZsYgQnp9L/jX3cw7vuTdIhRgINRiYd3xdGkGCHWxLLi
        ytxDjBIczEoivJ42yTFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbB
        ZJk4OIGpwMfcmkOnY8miWRWH/xxQ2b3u/vq3izbuernCZgnrwolJqo9uzDCJtH3bu/DdR/ap
        2w4uXXP+x1//G81bmgWC9ix7ULKj9/5mTtPvt0RZdRMj4rr5Ez+KTBAsVp43Oe3D9+cuLkr/
        NS6oVruGPQpRWL/I99U+xjwGgZv7V1vUbFzieWlp4SVmn9tKLMUZiYZazEXFiQBNj/NSRAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7oL3ZNjDBpvsltsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xa0GGYvLu+awWXzuPcJosfbIXXaLSwcWMFl83vCY0eJ24wo2i30d
        D5gsDr9pZ7V4P7nYgd9jzbw1jB6zGy6yeLTsu8XusWBTqcfCT19ZPQ6+28Pk8X7fVTaPvi2r
        GD0+b5IL4IzSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy/g5ey9bwV7OivmfpRoYL7N3MXJySAiYSCyceZ65i5GLQ0hgKaPEo/YWqISYxKR926Fs
        YYk/17rYIIo+MUrcXXGdsYuRg4NNQE9ix6pCkBoRARuJ93PPsIDUMAtcY5K43XGfFSQhLOAt
        8eJ3AxuIzSKgKrH1wxcwm1fAS2Ju2ydGiAVyEjfPdTKD2JxA9WemrWQFmS8EVNN00GACI98C
        RoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgRGy7djPzTsYL20MPsQowMGoxMO74mhSjBBr
        YllxZe4hRgkOZiURXk+b5Bgh3pTEyqrUovz4otKc1OJDjKZAN01klhJNzgdGb15JvKGpobmF
        paG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk5gGDavZj/0tqFqcfeVTdrXU4QWzu9b
        +HXnhi82/bqsSXO/MVY7dPQon/2aKZtVfq+yaXJ7bmlu/cnq8yy9X0vl5xtYLg3X/NXwsGFR
        95x/lstOvuQI4Hhpfe6tl+U044xnMsZOoc48sxPTTkl/Tbi0M23b6q37d80p6t6m+3oDo9z7
        kElBEoe+CimxFGckGmoxFxUnAgDhlyGkpgIAAA==
X-CMS-MailID: 20190212222433eucas1p264602d67a916c644c7eb5012932fc17a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222433eucas1p264602d67a916c644c7eb5012932fc17a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222433eucas1p264602d67a916c644c7eb5012932fc17a
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222433eucas1p264602d67a916c644c7eb5012932fc17a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds default idle polling value for devfreq devices.
It is used in idle state, when the device is running at lowest frequency.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 6a172d3..f0fcc5e 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -29,6 +29,19 @@ menuconfig PM_DEVFREQ
 
 if PM_DEVFREQ
 
+config DEVFREQ_DEFAULT_POLLING_IDLE_MS
+	int "Default polling interval in idle state (ms)"
+	default 500
+	help
+	  The devfreq device is being polled by the devfreq framework.
+	  There are two states for the device operation: normal and idle.
+	  Each state has corresponding polling interval.
+	  When a device is not heavily loaded and runs at lowest frequency,
+	  it is in 'idle' state and longer polling interval is used.
+	  This setting controls the idle polling interval.
+	  It is designed to lower for power consumption.
+	  Set this to non-zero if the default value is to big for your system.
+
 comment "DEVFREQ Governors"
 
 config DEVFREQ_GOV_SIMPLE_ONDEMAND
-- 
2.7.4

