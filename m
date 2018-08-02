Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D15C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F4421501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iRX7+o0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F4421501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbeHBLqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:46:39 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49326 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeHBLqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:46:39 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180802095612epoutp01e6bfed08814d44be5e15c8f57b80f26e~HCLVOQ98l1088710887epoutp01d
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 09:56:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180802095612epoutp01e6bfed08814d44be5e15c8f57b80f26e~HCLVOQ98l1088710887epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533203772;
        bh=h+L17Wxzmpy2XSdArTUYdnBUXtpsAp4kL3LDzAai2Zw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=iRX7+o0AYV1gck9iO48IsYsfTKHzP/AysZobrDcIW4o+FkTa2o31jrW3H+vWGqfVr
         gFI+AgeJfvR5IiuzIpojJ/pRz92rSI8pqwCeIiRPT5AVym0AwBUiKfRIKzQg6HOcMg
         E9BktCE2dyqkYixoWn3oGSkNxmHjdLSSP+uuNcC0=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180802095609epcas1p3854642d5047c82b3bf08e01d5873e9b2~HCLSQV52W1757417574epcas1p3E;
        Thu,  2 Aug 2018 09:56:09 +0000 (GMT)
X-AuditID: b6c32a39-b9dff70000001030-c0-5b62d5392328
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.65.04144.935D26B5; Thu,  2 Aug 2018 18:56:09 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
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
In-Reply-To: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180802095608epcms1p33fb061543efc9ceb3ec12d5567ceffbc@epcms1p3>
Date:   Thu, 02 Aug 2018 18:56:08 +0900
X-CMS-MailID: 20180802095608epcms1p33fb061543efc9ceb3ec12d5567ceffbc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmnq7l1aRog2vztC1O73/HYvHykKbF
        9S/PWS3W/zzLZDH/yDlWi+l7N7FZnG16w25xedccNovPvUcYLZZev8hk0br3CLvFgYsT2Sw6
        jnxjduD1WDNvDaPH5b5eJo9NqzrZPO5c28Pm0bdlFaPH501yAWxRqTYZqYkpqUUKqXnJ+SmZ
        eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIcqKZQl5pQChQISi4uV9O1sivJL
        S1IVMvKLS2yVog0NjfQMDcz1jIyAtHGslZEpUElCasakD2eZC76IV3xbcp21gXGucBcjJ4eE
        gInE9OlHWUFsIYEdjBLHvzp1MXJw8AoISvzdAVYiLJAmsffnBnaIEiWJhpv7mCHi+hIdD7Yx
        gthsAroSWzfcZeli5OIQEZjHKPH91go2EIdZ4DyzxJL3jWwQy3glZrQ/ZYGwpSW2L98K1s0p
        4C6xvekCVFxU4ubqt+ww9vtj8xkhbBGJ1ntnmSFsQYkHP3dDxaUknrxdCFVfL3H98yImkMUS
        AhMYJX7f+A+V0Jd4dGU22BG8Ar4SFz7cAWtmEVCVuLl0CzPIxxICLhKT7giChJkF5CW2v50D
        FmYW0JRYv0sf5vyGjb/Z0dnMAnwS7772sMLEd8x7wgRhq0kc2r0Eql5G4vT0hVDne0hM/3mQ
        dQKj4ixEUM9CsngWwuIFjMyrGMVSC4pz01OLDQtM9YoTc4tL89L1kvNzNzGCU6uW5Q7GY+d8
        DjEKcDAq8fDeYEiKFmJNLCuuzD3EKMHBrCTC2+wBFOJNSaysSi3Kjy8qzUktPsRoCvT+RGYp
        0eR8YNrPK4k3NDUyNja2MDE0MzU0VBLnNfILjhYSSE8sSc1OTS1ILYLpY+LglGpgtD+8auJ2
        YZ+ZcrUnYp+qhDxbxf2q1/MUn5aoakpH8L+Th6SYGTcqGUiWGhgE5e8+Z9ykwvnp2bKbkbuv
        N9ks6JWPexpaUs6zJdJaVVyip/WukXDUE7/VVp13g1r1pCdUxL2T/CmzasUaZRdzC47sagad
        o98XTkvuu3jZM/H04lV7SsIT4sqVWIozEg21mIuKEwFwdoO2wwMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802005756epcas4p465a12f42a0e36f0af6fd276a3a56957f
References: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
        <CGME20180802005756epcas4p465a12f42a0e36f0af6fd276a3a56957f@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Many CPU architectures have caches that can scale independent of the CPUs.
>Frequency scaling of the caches is necessary to make sure the cache is not
>a performance bottleneck that leads to poor performance and power. The same
>idea applies for RAM/DDR.
>
>To achieve this, this patch adds a generic devfreq governor that takes the
>current frequency of each CPU frequency domain and then adjusts the
>frequency of the cache (or any devfreq device) based on the frequency of
>the CPUs. It listens to CPU frequency transition notifiers to keep itself
>up to date on the current CPU frequency.
>
>To decide the frequency of the device, the governor does one of the
>following:

This exactly has the same purpose with "passive" governor except for the
single part: passive governor depends on another devfreq driver, not
cpufreq driver.

If both governors have many features in common, can you merge them into one?
Passive governor also has "get_target_freq", which allows driver authors
to define the mapping.

Probably, you will need to add one more notifier call to get events from
cpufreq instead of devfreq.

>
>* Uses a CPU frequency to device frequency mapping table
>  - Either one mapping table used for all CPU freq policies (typically used
>    for system with homogeneous cores/clusters that have the same OPPs).
>  - One mapping table per CPU freq policy (typically used for ASMP systems
>    with heterogeneous CPUs with different OPPs)
>
>OR
>
>* Scales the device frequency in proportion to the CPU frequency. So, if
>  the CPUs are running at their max frequency, the device runs at its max
>  frequency.  If the CPUs are running at their min frequency, the device
>  runs at its min frequency. And interpolated for frequencies in between.

If you want to satisfy these two cases to the "modified" passive governors,
you may need to supply two "preloaded" get_target_freq functions for
struct devfreq_passive_data. If that's impossible, requiring a bit more
modifications, you may need to write alternative routines in
update_devfreq_passive().

Cheers,
MyungJoo

>
>Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>---
> .../bindings/devfreq/devfreq-cpufreq-map.txt       |  53 ++
> drivers/devfreq/Kconfig                            |   8 +
> drivers/devfreq/Makefile                           |   1 +
> drivers/devfreq/governor_cpufreq_map.c             | 583 +++++++++++++++++++++
> 4 files changed, 645 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
> create mode 100644 drivers/devfreq/governor_cpufreq_map.c
>
[]
>diff --git a/drivers/devfreq/governor_cpufreq_map.c b/drivers/devfreq/governor_cpufreq_map.c
>new file mode 100644
>index 0000000..084a3ff
>--- /dev/null
>+++ b/drivers/devfreq/governor_cpufreq_map.c
>@@ -0,0 +1,583 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights reserved.
>+ */

Is this boilerplate fine? ( using // )

