Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DC1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7512087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jxoj6rZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfAaIuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:50:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50894 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfAaIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:50:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190131085012euoutp025c25b8a63c441da5dfb06673c80f58f9~_4rpuJXoq1148011480euoutp02Z
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:50:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190131085012euoutp025c25b8a63c441da5dfb06673c80f58f9~_4rpuJXoq1148011480euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548924612;
        bh=cwdR9PeB9U1fbRaysP0X7KBDHK6TquXGExqnRLFnqnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxoj6rZID3jf6syTNLUXLFE85TivizoDB3xJ9a+9nH0WG56Y/OuOSlldYzFtrtFm7
         +nI97+Skr7+NRD0Y+5tQbXWILtTClpc/xd1cOIH0K8IRHnk0nhFbvcMg2g38KPX2h9
         u9jCXSnHNvg7RkMuXZD9/LRVrgNVW86Qsy56mZRg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190131085011eucas1p2e11a07fb6bbd9e6930feca08c6467f60~_4rpMaSZj0245502455eucas1p2I;
        Thu, 31 Jan 2019 08:50:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E9.1E.04806.3C6B25C5; Thu, 31
        Jan 2019 08:50:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190131085010eucas1p2b2bdc90be27dfd73f13d41ed0d725bb2~_4roWgiwr2509225092eucas1p2q;
        Thu, 31 Jan 2019 08:50:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190131085010eusmtrp2632965bdc6036b14cee1ae06c625e338~_4roDrVaI2341223412eusmtrp2j;
        Thu, 31 Jan 2019 08:50:10 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-6e-5c52b6c3e60e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.7B.04128.2C6B25C5; Thu, 31
        Jan 2019 08:50:10 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190131085009eusmtip1de17dacb18bc4399c64a183fc19ecf0a~_4rnLSLiF1303413034eusmtip1H;
        Thu, 31 Jan 2019 08:50:09 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 7/8] drivers: devfreq: events: add Exynos PPMU new events
Date:   Thu, 31 Jan 2019 09:49:53 +0100
Message-Id: <1548924594-19084-8-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7qHtwXFGOxcIG6xccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbe4
        3biCzeLwm3ZWBz6PTas62Tw2L6n3OPhuD5NH35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZRyY
        OIWl4DJnxdIvb9gaGNdzdDFyckgImEhcbu9j7GLk4hASWMEo8ejfBzYI5wujxJbT65khnM+M
        Em1P5rLBtNzpXsACkVjOKLH6/A9GuJZpV54wdTFycLAJ6EnsWFUI0iAiUC1x5/p+sEnMApOZ
        JBad7mYCSQgL+Eh0rzrAAmKzCKhK3Ln1EyzOK+Al8XfnZnaIbXISN891MoPYnALeEku6/oIN
        khBYxC6xcOVtFogiF4kDz/uhzhOWeHV8C1SzjMT/nfOZIOxiibMdq6BqaiTaT+6AqrGWOHz8
        IivI0cwCmhLrd+lDhB0l5l8+wwYSlhDgk7jxVhAkzAxkTto2nRkizCvR0SYEUa0hsaXnAtQi
        MYnla6ZBDfeQOLD0Ktj1QgLzgIHYVz+BUX4Wwq4FjIyrGMVTS4tz01OLjfNSy/WKE3OLS/PS
        9ZLzczcxApPM6X/Hv+5g3Pcn6RCjAAejEg/vg7WBMUKsiWXFlbmHGCU4mJVEeA1/+8cI8aYk
        VlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYJx5YHrXpUzzxyu3
        JelfKbmx/qXqzn03Z60qPvgpLafu/xJP/ea1i6d9OO6+OSThSG1kbMa9q6odX9VM9tlybQo8
        EbWhQdFmTcG1RAXu51baFVNmf9ztsOVabxqT/4rPP65HeH+fM/WQWpvG/ZjOlZvt1a4084gf
        VSxXX/pj90yXn+Kzddcu37RSiaU4I9FQi7moOBEACmvLYC4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t/xu7qHtgXFGDR9ZLXYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslvc
        blzBZnH4TTurA5/HplWdbB6bl9R7HHy3h8mjb8sqRo/Pm+QCWKP0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mg5MnMJScJmzYumXN2wNjOs5uhg5
        OSQETCTudC9g6WLk4hASWMooMa3xPCtEQkxi0r7t7BC2sMSfa11sEEWfGCVO35wG5HBwsAno
        SexYVQhSIyJQL9H/5hJYDbPAfCaJ/ilzwQYJC/hIdK86wAJiswioSty59ZMJxOYV8JL4u3Mz
        1AI5iZvnOplBbE4Bb4klXX/BbCGgmh//PjJOYORbwMiwilEktbQ4Nz232EivODG3uDQvXS85
        P3cTIzDstx37uWUHY9e74EOMAhyMSjy8D9YGxgixJpYVV+YeYpTgYFYS4TX87R8jxJuSWFmV
        WpQfX1Sak1p8iNEU6KiJzFKiyfnAmMwriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2a
        WpBaBNPHxMEp1cCoHbf9yDvfS3/tj254LjGvUFx/I3/nJeuET7bH9iVFlMT7TuIJOfQvNmiy
        2/olvWvLv4icEMpi8BLduE999x1dU+fIaGbp5c+79lbHlazeYb79VuezT6bnrwkk3T7g+u/J
        l9W2Th7WKpv+HrAI0dsnfjGfKZ7x+57dZhI6+QwT1Jnkcg5lpFopsRRnJBpqMRcVJwIApfer
        V5ECAAA=
X-CMS-MailID: 20190131085010eucas1p2b2bdc90be27dfd73f13d41ed0d725bb2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131085010eucas1p2b2bdc90be27dfd73f13d41ed0d725bb2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085010eucas1p2b2bdc90be27dfd73f13d41ed0d725bb2
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085010eucas1p2b2bdc90be27dfd73f13d41ed0d725bb2@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new performance events supported by Exynos5422 SoC counters.
The counters are built-in in Dynamic Memory Controller and provide
information regarding memory utilization.

CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-pm@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-samsung-soc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c61de0b..67d6674 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -89,6 +89,12 @@ static struct __exynos_ppmu_events {
 	PPMU_EVENT(d1-cpu),
 	PPMU_EVENT(d1-general),
 	PPMU_EVENT(d1-rt),
+
+	/* For Exynos5422 SoC */
+	PPMU_EVENT(dmc0_0),
+	PPMU_EVENT(dmc0_1),
+	PPMU_EVENT(dmc1_0),
+	PPMU_EVENT(dmc1_1),
 };
 
 static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
-- 
2.7.4

