Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF81B21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Sk45vIly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394888AbfBONGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:06:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49366 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfBONF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:05:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190215130556euoutp01a4cb8190393bf89af82ab3762bb1492a~Di2Oqkz0T1614616146euoutp01K
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:05:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190215130556euoutp01a4cb8190393bf89af82ab3762bb1492a~Di2Oqkz0T1614616146euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550235956;
        bh=LZqeMGz0F06tKp0oBaLAnd47vFr6i3FQ43wlPqLKA1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sk45vIly5rqkECECVvyRYt7qqsI3vstbIvqw95daULfOGX7dIrOVQwswCCvFx25bP
         r/Q6ns+pzoonl9qKKInjQLmXVjX/jqfKaY/tE2qjCv4CrwEyOKPxZpGzWIHVeZdHP9
         5rifenSTvlbiBpnPiB7Obfx1F/gT/VU7eZXAkvT4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190215130556eucas1p2d91ceba0ece8246c6f8573c32a437060~Di2OC7sE-3185531855eucas1p2F;
        Fri, 15 Feb 2019 13:05:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0A.37.04441.339B66C5; Fri, 15
        Feb 2019 13:05:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d~Di2NEN_3M1678616786eucas1p2v;
        Fri, 15 Feb 2019 13:05:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190215130554eusmtrp138c99b52c3faa5b9091bf2454f84b33f~Di2M1TqB02508925089eusmtrp1l;
        Fri, 15 Feb 2019 13:05:54 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-10-5c66b933570e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.22.04284.239B66C5; Fri, 15
        Feb 2019 13:05:54 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190215130554eusmtip23a565ecc7aa967d5bf9bd1910a6dcf95~Di2MPfL-01398613986eusmtip28;
        Fri, 15 Feb 2019 13:05:54 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 1/2] trace: events: add devfreq trace event file
Date:   Fri, 15 Feb 2019 14:05:12 +0100
Message-Id: <1550235913-5189-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550235913-5189-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87rGO9NiDC40WVhsnLGe1eL6l+es
        Fmeb3rBb3GqQsbi8aw6bxefeI4wWa4/cZbe4dGABk8XnDY8ZLW43rmCz2NfxgMni8Jt2Vgce
        j9kNF1k8WvbdYvc4+G4Pk8f7fVfZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj8VSugueC
        Fdd2XmRtYOzi72Lk5JAQMJFo2L2JvYuRi0NIYAWjxIPvp5ggnC+MEnd+rYByPjNK3Ji8lgmm
        5dHly2wQieWMEgf3dzHCtTQ+nsfSxcjBwSagJ7FjVSFIg4iAlcSL9ldgO5gFmpkknrUtBKsR
        FnCW+LkwE6SGRUBVYs7l+SwgNq+Ap0TX9snMEMvkJG6e6wSzOQW8JE5f+ckMMkdCYDq7xM/z
        m1ghilwk2pqnMkLYwhKvjm9hh7BlJE5P7mGBsIslznasYoOwayTaT+6AqrGWOHz8IivIPcwC
        mhLrd+lDhB0lzj29xwQSlhDgk7jxVhAkzAxkTto2nRkizCvR0SYEUa0hsaXnAjR4xCSWr5nG
        DlHiIXGmzRUSOHMZJV6fWMA8gVF+FsKuBYyMqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3
        MQITy+l/xz/tYPx6KekQowAHoxIP74qM1Bgh1sSy4srcQ4wSHMxKIryca9JihHhTEiurUovy
        44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTBuil325WHu79c7/kZ13rR9
        mtF0uTPyh9GBiM+Hbp6JMLjPrWO7YgvHd4bA/tOyXLaT1TRWhJ+fILNYrf0wa2yZjH72o9m5
        Ek+8Hj+YtmDb8VO7X+r+nMPUO/m9wIY/W7nO9bnbZ6491qm+TOvepFkuz4T2ZBw1NasSaHS+
        vNrY80tsRGzV8sZjSizFGYmGWsxFxYkAZUt+BCgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t/xe7pGO9NiDJoWmVhsnLGe1eL6l+es
        Fmeb3rBb3GqQsbi8aw6bxefeI4wWa4/cZbe4dGABk8XnDY8ZLW43rmCz2NfxgMni8Jt2Vgce
        j9kNF1k8WvbdYvc4+G4Pk8f7fVfZPPq2rGL0+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j8VSugueCFdd2XmRtYOzi72Lk5JAQMJF4
        dPkyG4gtJLCUUWLbZgOIuJjEpH3b2SFsYYk/17qAariAaj4xSqxvXgbkcHCwCehJ7FhVCFIj
        ImAj8X7uGRaQGmaBfiaJpiUdrCA1wgLOEj8XZoLUsAioSsy5PJ8FxOYV8JTo2j6ZGWK+nMTN
        c51gNqeAl8TpKz+ZQVqFgGpe9OROYORbwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzDM
        tx37uXkH46WNwYcYBTgYlXh4V2SkxgixJpYVV+YeYpTgYFYS4eVckxYjxJuSWFmVWpQfX1Sa
        k1p8iNEU6KaJzFKiyfnAGMwriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPH
        xMEp1cCosd33nKX6bzWf004HC7qevuO/d/Wy78v7SwUz99sLGiiIxBwIlO571JV0wLNFkHX+
        scpC11n7VHlOXNqyb9a6SP3pT09m+X4QVjVn9fg6TcSbS3yueHj3ce/g/W6m//ZutLaIDon9
        8SpxzmX1ycJzeZf5mjZv2hIeL5LS9NM0UfyYeFT7Sw4lluKMREMt5qLiRAB7jTe8iQIAAA==
X-CMS-MailID: 20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d
References: <1550235913-5189-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds a new file for with trace events for devfreq
framework. They are used for performance analysis of the framework.
It also contains updates in MAINTAINERS file adding new entry for
devfreq maintainers.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 MAINTAINERS                    |  1 +
 include/trace/events/devfreq.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 include/trace/events/devfreq.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 41ce5f4..9c44076 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4447,6 +4447,7 @@ S:	Maintained
 F:	drivers/devfreq/
 F:	include/linux/devfreq.h
 F:	Documentation/devicetree/bindings/devfreq/
+F:	include/trace/events/devfreq.h
 
 DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
 M:	Chanwoo Choi <cw00.choi@samsung.com>
diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
new file mode 100644
index 0000000..ce83dba
--- /dev/null
+++ b/include/trace/events/devfreq.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM devfreq
+
+#if !defined(_TRACE_DEVFREQ_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DEVFREQ_H
+
+#include <linux/devfreq.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(devfreq_monitor,
+	TP_PROTO(struct devfreq *devfreq),
+
+	TP_ARGS(devfreq),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, freq)
+		__field(unsigned long, busy_time)
+		__field(unsigned long, total_time)
+		__field(unsigned int, polling_ms)
+		__string(dev_name, dev_name(&devfreq->dev))
+	),
+
+	TP_fast_assign(
+		__entry->freq = devfreq->previous_freq;
+		__entry->busy_time = devfreq->last_status.busy_time;
+		__entry->total_time = devfreq->last_status.total_time;
+		__entry->polling_ms = devfreq->profile->polling_ms;
+		__assign_str(dev_name, dev_name(&devfreq->dev));
+	),
+
+	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%lu",
+		__get_str(dev_name), __entry->freq, __entry->polling_ms,
+		__entry->total_time == 0 ? 100 :
+			(100 * __entry->busy_time) / __entry->total_time)
+);
+#endif /* _TRACE_DEVFREQ_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.7.4

