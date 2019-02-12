Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02034C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6498222C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IBBtDrkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbfBLWYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:24:52 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43174 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732626AbfBLWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:24:40 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212222439euoutp02c11efb689922fdda3c79c37e33c8f9dc~CviMSrJHV0110801108euoutp02i
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:24:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212222439euoutp02c11efb689922fdda3c79c37e33c8f9dc~CviMSrJHV0110801108euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550010279;
        bh=ytt9HEqMSC9B+2sRfagi8v3hpwU3kimvGDt2IfVYwHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBBtDrkddYbndUdRDI/xDFU9zW0G6hqyquUnTqj3kwHxIVLNu8Dfo4kxdDlaNQ5ZE
         s0lne4eh3i68ej2sm5QE4bsLGmXNft8VCIOYPzy6XsSkIGoeaj4WlLKlNVN3Un/k8u
         HptlyDL/dQqB4SS8Z+TbGLsiDw/07ApxNCAfUa0k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212222438eucas1p183bb206d8fa2bc23619893fc1fb57c45~CviLNBi0Z2824728247eucas1p1V;
        Tue, 12 Feb 2019 22:24:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4D.0F.04806.6A7436C5; Tue, 12
        Feb 2019 22:24:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed~CviKHO6lT3241732417eucas1p1G;
        Tue, 12 Feb 2019 22:24:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212222437eusmtrp20828e27ab02dfdc3db19791cfd4abaaf~CviJ4ZLM02980329803eusmtrp2P;
        Tue, 12 Feb 2019 22:24:37 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-88-5c6347a62d50
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2F.2C.04284.4A7436C5; Tue, 12
        Feb 2019 22:24:36 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222436eusmtip1ccab2f13f0cf7851b39af0c8b00d7a1a~CviJPSXYI0525605256eusmtip18;
        Tue, 12 Feb 2019 22:24:36 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 6/7] trace: events: add devfreq trace event file
Date:   Tue, 12 Feb 2019 23:23:57 +0100
Message-Id: <1550010238-24002-7-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87rL3JNjDG4c4rTYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWlw4sYLL4vOExo8XtxhVsFvs6
        HjBZHH7TzmrxfnKxA7/HmnlrGD1mN1xk8WjZd4vdY8GmUo+Fn76yehx8t4fJ4/2+q2wefVtW
        MXp83iQXwBnFZZOSmpNZllqkb5fAlXH2yF3Ggn8CFa9W/WVsYJzP18XIySEhYCKx9FUjWxcj
        F4eQwApGiUczFrGDJIQEvjBK7DiWBJH4zChxZuYaZpiOVW9nskIkljNK3PiyGcoB6jix7DDQ
        LA4ONgE9iR2rCkEaRASsJF60v2IHqWEWOMYk8WnvFLBJwgLOEhdOrgSzWQRUJdp/nmIDsXkF
        vCS+9F9ggdgmJ3HzXCdYDaeAt8SZaStZIeLH2CXmrvaGsF0kOhquQMWFJV4d38IOYctI/N85
        nwnCLpY427GKDcKukWg/uQOqxlri8PGLrCA3MwtoSqzfpQ9iSgg4Snw+mg1h8knceCsIUswM
        ZE7aNp0ZIswr0dEmBDFDQ2JLzwWoPWISy9dMg5rtIbHh+Gdo4MxjlHh+8gjzBEb5WQi7FjAy
        rmIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMR6f/Hf+6g3Hfn6RDjAIcjEo8vCuOJsUI
        sSaWFVfmHmKU4GBWEuH1tEmOEeJNSaysSi3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1
        tSC1CCbLxMEp1cDoPuV/qIB1HJuaJmOd2RmtKcbHj7vN9mKY2zaxtM/T8LRqVaRMx0tnEzPj
        8luFvKutNSxbjvTqm54u4eTWnn/8BF/flILdqT4+R60kRP9lhR40suwTqXuwfW3xftGIGZZz
        0+Xi36afcp/QeyvkYt19ocWHF2luMNY48/kt73ODtlk3S66tOKXEUpyRaKjFXFScCABZ3tVt
        QwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7pL3ZNjDJaLWWycsZ7VYtqnyywW
        1788Z7VY1qBqcbbpDbvFrQYZi8u75rBZfO49wmix9shddotLBxYwWXze8JjR4nbjCjaLfR0P
        mCwOv2lntXg/udiB32PNvDWMHrMbLrJ4tOy7xe6xYFOpx8JPX1k9Dr7bw+Txft9VNo++LasY
        PT5vkgvgjNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3
        S9DLOHvkLmPBP4GKV6v+MjYwzufrYuTkkBAwkVj1diZrFyMXh5DAUkaJ3+e2MEEkxCQm7dvO
        DmELS/y51sUGUfSJUWLz8z/MXYwcHGwCehI7VhWC1IgI2Ei8n3uGBaSGWeAak8TtjvusIAlh
        AWeJCydXMoPYLAKqEu0/T7GB2LwCXhJf+i+wQCyQk7h5rhOshlPAW+LMtJWsIPOFgGqaDhpM
        YORbwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBCth37uXkH46WNwYcYBTgYlXh4VxxN
        ihFiTSwrrsw9xCjBwawkwutpkxwjxJuSWFmVWpQfX1Sak1p8iNEU6KaJzFKiyfnA6M0riTc0
        NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cAYxPN3W0UN3+XSAxKXHt75
        6FiT9e64jeHO/vnXJ8zg0Lx78E/q18qZ94Un/j1zIeClif2+dFNNdhHmXUXeTcX3rq/LPqui
        vDxdNWfpIbas5c2bTwcWqfwvV52//nfCzjuRWXpb5j0oTZesM39/vvqhsX7Vk3UPa+eaHc+z
        WfvFJ5E54qrsBWsRJZbijERDLeai4kQARDqPbKYCAAA=
X-CMS-MailID: 20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed@eucas1p1.samsung.com>
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
 include/trace/events/devfreq.h | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/trace/events/devfreq.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9919840..c042fda 100644
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
index 0000000..fec9304
--- /dev/null
+++ b/include/trace/events/devfreq.h
@@ -0,0 +1,39 @@
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
+		__string(dev_name, dev_name)
+		__field(unsigned long, freq)
+		__field(unsigned int, polling_ms)
+		__field(unsigned int, load)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__entry->freq = freq;
+		__entry->polling_ms = polling_ms;
+		__entry->load = (100 * busy_time) / total_time;
+	),
+
+	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%u",
+		__get_str(dev_name), __entry->freq, __entry->polling_ms,
+		__entry->load)
+);
+#endif /* _TRACE_DEVFREQ_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.7.4

