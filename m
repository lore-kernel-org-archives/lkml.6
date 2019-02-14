Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935D9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FF821B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dHumlW9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438227AbfBNS6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:58:17 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34932 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389187AbfBNS6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:58:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190214185811euoutp0223190cf22c45efd0d597f164d7a01557~DUAfxMygR2496724967euoutp02g
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:58:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190214185811euoutp0223190cf22c45efd0d597f164d7a01557~DUAfxMygR2496724967euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550170691;
        bh=Y7/qZ97VhxjVPdA+gdtH/9yafH9YPYnkq+6rqLhlND0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHumlW9jcKGomU82s22GKEoB8pf0OXCO0b1M8lBNVgN9NNZjtCSw7jyeLiBRCRmWB
         AZBMHtMeEAAuh6Z/IvdyPOLD/ExTE62g6qwMXd64xCSL0wpEN2ANVnyql3ytl7QXWQ
         dTcpQwgGW/198FmSI7P/ZrZAOc9oq60zED1BAxz4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214185810eucas1p124ec6052e0a48c73b3172ac1db6db391~DUAe1yIDP0094600946eucas1p1G;
        Thu, 14 Feb 2019 18:58:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 89.13.04294.24AB56C5; Thu, 14
        Feb 2019 18:58:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190214185809eucas1p219acc085fd241f3f685e52cb5534f905~DUAd3wI530153101531eucas1p2S;
        Thu, 14 Feb 2019 18:58:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190214185809eusmtrp1f183bb048c087ce19773be04609e50b4~DUAdpBZiz1152911529eusmtrp1f;
        Thu, 14 Feb 2019 18:58:09 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-bd-5c65ba42c0b5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.C0.04128.14AB56C5; Thu, 14
        Feb 2019 18:58:09 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190214185808eusmtip2bbbcf6ba06c11b146aec4fae67ce2525~DUAdDZRX00484004840eusmtip2v;
        Thu, 14 Feb 2019 18:58:08 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 1/2] trace: events: add devfreq trace event file
Date:   Thu, 14 Feb 2019 19:57:55 +0100
Message-Id: <1550170676-14173-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87pOu1JjDHb8l7fYOGM9q8X1L89Z
        Lc42vWG3uNUgY3F51xw2i8+9Rxgt1h65y25x6cACJovPGx4zWtxuXMFmsa/jAZPF4TftrA48
        HrMbLrJ4tOy7xe5x8N0eJo/3+66yefRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGnI0XmAr6
        hCrmnXnF1sA4k7+LkZNDQsBE4vzWw2xdjFwcQgIrGCX2/v7KCJIQEvjCKHHhgRtE4jOjxOsP
        f1hgOla9f8MCkVjOKLF94QJGCAeo4/CVm0AOBwebgJ7EjlWFIA0iAlYSL9pfsYPUMAs0M0k8
        a1vIAlIjLOAg8WiWOkgNi4CqxIxtXWwgNq+Al8SM3f+glslJ3DzXyQxicwp4S2zsmgR2qoTA
        dHaJc5/6oIpcJE6/XswGYQtLvDq+hR3ClpE4PbkHqqZY4mzHKqiaGon2kzugaqwlDh+/yApy
        D7OApsT6XfoQYUeJndfnsIGEJQT4JG68FQQJMwOZk7ZNZ4YI80p0tAlBVGtIbOm5wARhi0ks
        XzMNariHxJKWueyQ0JnHKDH97R6WCYzysxCWLWBkXMUonlpanJueWmyUl1quV5yYW1yal66X
        nJ+7iRGYWk7/O/5lB+OuP0mHGAU4GJV4eFdkpMYIsSaWFVfmHmKU4GBWEuF9vQ0oxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnLea4UG0kEB6YklqdmpqQWoRTJaJg1OqgTGx4uqDB60qCXHvdSXW
        xv+dWJPN9+/WvK/xmQ8m3cxs1bCeN4NNWSJq/4MzeW9WMJvfyE7VYpluVGww3aF9U4RTz5nz
        0RlS55c+jnQJ3eF84eieu5NP9zCahf5fKBGgESO8ruBnTMiN+xMv3E6rlOVRSC5dtjicc7Jw
        XY5w9IwWsw2ZU067aSuxFGckGmoxFxUnAgCE11f+KQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xe7qOu1JjDM4cl7bYOGM9q8X1L89Z
        Lc42vWG3uNUgY3F51xw2i8+9Rxgt1h65y25x6cACJovPGx4zWtxuXMFmsa/jAZPF4TftrA48
        HrMbLrJ4tOy7xe5x8N0eJo/3+66yefRtWcXo8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GnI0XmAr6hCrmnXnF1sA4k7+LkZNDQsBE
        YtX7NyxdjFwcQgJLGSU+TO5jh0iISUzatx3KFpb4c62LDaLoE6NE18rTzF2MHBxsAnoSO1YV
        gtSICNhIvJ97BmwQs0A/k0TTkg5WkBphAQeJR7PUQWpYBFQlZmwDmcPJwSvgJTFj9z8WiPly
        EjfPdTKD2JwC3hIbuyaB1QgB1dy/84B1AiPfAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmb
        GIHBvu3Yzy07GLveBR9iFOBgVOLhXZGRGiPEmlhWXJl7iFGCg1lJhPf1NqAQb0piZVVqUX58
        UWlOavEhRlOgoyYyS4km5wMjMa8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoR
        TB8TB6dUA+M03q02B5bkvar4nZJQtvnGpgqBgt3+Wkt9jBYtKGRvSA5wOM2sqNSt0hD06tLE
        qMUFqbleade8JV2qG0Udax7eum72RPZbZjV7W9I3/lRDiR47yedsrz0qbhdb/1/7UklIf/mc
        qLBa91RbtuTfSl2ruiZWbzA9UP1vxd082WXqm1dFFy26rcRSnJFoqMVcVJwIABzoyvCMAgAA
X-CMS-MailID: 20190214185809eucas1p219acc085fd241f3f685e52cb5534f905
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190214185809eucas1p219acc085fd241f3f685e52cb5534f905
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190214185809eucas1p219acc085fd241f3f685e52cb5534f905
References: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190214185809eucas1p219acc085fd241f3f685e52cb5534f905@eucas1p2.samsung.com>
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
 include/trace/events/devfreq.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
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
index 0000000..d6990dc
--- /dev/null
+++ b/include/trace/events/devfreq.h
@@ -0,0 +1,42 @@
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
+	TP_PROTO(const char *dev_name, unsigned long freq,
+		 unsigned int polling_ms, unsigned long busy_time,
+		 unsigned long total_time),
+
+	TP_ARGS(dev_name, freq, polling_ms, busy_time, total_time),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, freq)
+		__field(unsigned long, busy_time)
+		__field(unsigned long, total_time)
+		__field(unsigned int, polling_ms)
+		__string(dev_name, dev_name)
+	),
+
+	TP_fast_assign(
+		__entry->freq = freq;
+		__entry->busy_time = busy_time;
+		__entry->total_time = total_time;
+		__entry->polling_ms = polling_ms;
+		__assign_str(dev_name, dev_name);
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

