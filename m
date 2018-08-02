Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D1DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE2A214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="owrfSfiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE2A214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeHBMEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:04:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:44552 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeHBMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:04:15 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180802101343epoutp02cb26a23424557b71947ec31f72c35e7d~HCaoCcWUC0935909359epoutp021
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 10:13:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180802101343epoutp02cb26a23424557b71947ec31f72c35e7d~HCaoCcWUC0935909359epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533204823;
        bh=FfaW/AUWPhHenAVlUSko12Wj562B02gdBEIRLrANvpc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=owrfSfiSq2kIlpqmezaW6Gdlxekc33FrDlEmdOrgDVFMA7bhmwNVtzZASadJB6P13
         ubuofnFCncqHkDThDKYkmfMU95EwnabtygHNxq34gfvwi28PtJSKXMhENPBaU+un1w
         E7X7O8vGLbFG0Econe77TMgezHZrRVstL4WUjygw=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180802101341epcas1p27ab50bdc01561421f2d43fdc8c0fc838~HCalpcbpu1466614666epcas1p2T;
        Thu,  2 Aug 2018 10:13:41 +0000 (GMT)
X-AuditID: b6c32a39-bb5ff70000001030-32-5b62d9550b31
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.D7.04144.559D26B5; Thu,  2 Aug 2018 19:13:41 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for
 interconnect bandwidth voting
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Saravana Kannan <skannan@codeaurora.org>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "daidavid1@codeaurora.org" <daidavid1@codeaurora.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180802101341epcms1p53ee79776dbcbeaf6f1e7910b20095220@epcms1p5>
Date:   Thu, 02 Aug 2018 19:13:41 +0900
X-CMS-MailID: 20180802101341epcms1p53ee79776dbcbeaf6f1e7910b20095220
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmnm7ozaRog8ZuYYvT+9+xWLw8pGlx
        /ctzVov1P88yWcw/co7VYvreTWwWZ5vesFtc3jWHzeJz7xFGi6XXLzJZtO49wm5x4OJENouO
        I9+YHXg91sxbw+hxua+XyWPTqk42jzvX9rB59G1ZxejxeZNcAFtUqk1GamJKapFCal5yfkpm
        XrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0KFKCmWJOaVAoYDE4mIlfTubovzS
        klSFjPziElulaENDIz1DA3M9IyMgbRxrZWQKVJKQmrHi9E3mgo28Feem9jM2MHZwdzFyckgI
        mEj8OXWAqYuRi0NIYAejRHvDWrYuRg4OXgFBib87hEFqhAUSJFpnzmEHsYUElCQabu5jhojr
        S3Q82MYIYrMJ6Eps3XCXBWSOiMA8Ronvt1awgTjMAueZJZa8b2SD2MYrMaP9KQuELS2xfflW
        sG5OAXeJE/O62SHiohI3V7+Fs98fm88IYYtItN47ywxhC0o8+LkbKi4l8eTtQqj6eonrnxeB
        fSMhMIFR4veN/1AJfYlHV2aDHcEr4CuxYO9fJhCbRUBV4tfUZ1BDXSQ+vPgGdhyzgLzE9rdz
        mEEhwSygKbF+lz7M/Q0bf7Ojs5kF+CTefe1hhYnvmPeECcJWkzi0ewlUvYzE6ekLoVZ5SDz7
        vZJ5AqPiLERYz0KyeBbC4gWMzKsYxVILinPTU4sNC0z1ihNzi0vz0vWS83M3MYLTq5blDsZj
        53wOMQpwMCrx8N5gSIoWYk0sK67MPcQowcGsJMLb7AEU4k1JrKxKLcqPLyrNSS0+xGgK9P9E
        ZinR5Hxg6s8riTc0NTI2NrYwMTQzNTRUEuc18guOFhJITyxJzU5NLUgtgulj4uCUamAMPaRt
        W2eiWnJLaWfIlHVn5s/Wnfr3QOVdsQcndjGd+sxkOKs/m+NTTFfIg+jT/6d5Xt3/ijuCdVPW
        8d4ui0ARtYWveSY0Pw3bsninREWUufK+Ww8ilgXusg7SLLvFNJ8hru/ttJUHlwdwL+07Xf9v
        389gYSHtzOJbNUJLPrvzuoX/nHBJ9vsnJZbijERDLeai4kQAjzo9GsUDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802005759epcas4p4a68d50e61c8425124a993de1917021a2
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
        <CGME20180802005759epcas4p4a68d50e61c8425124a993de1917021a2@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This driver registers itself as a devfreq device that allows devfreq
>governors to make bandwidth votes for an interconnect path. This allows
>applying various policies for different interconnect paths using devfreq
>governors.
>

First of all, the name, "devfreq_icbw", is not appropriate for a
devfreq device driver. It confuses; it looks like a part of the
framework itself.

>diff --git a/drivers/devfreq/devfreq_icbw.c b/drivers/devfreq/devfreq_icbw.c
>new file mode 100644
>index 0000000..231fb21
>--- /dev/null
>+++ b/drivers/devfreq/devfreq_icbw.c
>@@ -0,0 +1,116 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright (c) 2013-2014, 2018, The Linux Foundation. All rights reserved.
>+ */
>+
>+#define pr_fmt(fmt) "icbw: " fmt
>+
>+#include <linux/kernel.h>
>+#include <linux/module.h>
>+#include <linux/init.h>
>+#include <linux/err.h>
>+#include <linux/errno.h>
>+#include <linux/mutex.h>
>+#include <linux/devfreq.h>
>+#include <linux/platform_device.h>
>+#include <linux/of.h>
>+#include <linux/interconnect.h>

Where can I find this file?

>+
>+struct dev_data {
>+	struct icc_path *path;
>+	u32 cur_ab;
>+	u32 cur_pb;
>+	unsigned long gov_ab;
>+	struct devfreq *df;
>+	struct devfreq_dev_profile dp;
>+};
>+
>+static int icbw_target(struct device *dev, unsigned long *freq, u32 flags)
>+{
>+	struct dev_data *d = dev_get_drvdata(dev);
>+	int ret;
>+	u32 new_pb = *freq, new_ab = d->gov_ab;
>+
>+	if (d->cur_pb == new_pb && d->cur_ab == new_ab)
>+		return 0;
>+
>+	dev_dbg(dev, "BW KBps: AB: %u PB: %u\n", new_ab, new_pb);
>+
>+	ret = icc_set(d->path, new_ab, new_pb);

I'm not sure if icc_set is available.


Cheers,
MyungJoo

