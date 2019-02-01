Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C556C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5956721726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G4oKySiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfBAQrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:47:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42681 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730954AbfBAQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:47:25 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190201164723euoutp0177e1bdc63133658cbf6e14d5013927ef~-S1lOB-rS1936319363euoutp01F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 16:47:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190201164723euoutp0177e1bdc63133658cbf6e14d5013927ef~-S1lOB-rS1936319363euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549039643;
        bh=xc/7rUEXW34l1G+b9ZoYdMgZh6gwNaSaXuTTk1vzFfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4oKySiBqf0q2YHVyHToN5PYtZjU6KSLRzP6o3BbU7+X/MzWjQ3kC3U5u25x6tjgZ
         r//hemtq2bbZ5Sj0lmQnKnTs+r7E5QFsU7a0OL6XRz1CXzYba7OLgR6Iz+seFs2KzW
         as536T65JJDyEh7uAx87givUgsyWGC0PRKx9Rozw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190201164723eucas1p1969a0e83a30ff436a75879f8933ece7f~-S1kjXmMY2555725557eucas1p13;
        Fri,  1 Feb 2019 16:47:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8E.E3.04441.A18745C5; Fri,  1
        Feb 2019 16:47:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190201164722eucas1p1b619d939e0f93ddb9ee1af7306e7cf67~-S1j3tw1-0638606386eucas1p1N;
        Fri,  1 Feb 2019 16:47:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190201164722eusmtrp227a12220d7bb071dd2b5b8137902ff53~-S1jo85XU0866308663eusmtrp2j;
        Fri,  1 Feb 2019 16:47:22 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-d8-5c54781a8b37
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 55.29.04284.A18745C5; Fri,  1
        Feb 2019 16:47:22 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190201164721eusmtip254cd81adf6ad8018652c0a45e574070f~-S1jBq4vp0105401054eusmtip2d;
        Fri,  1 Feb 2019 16:47:21 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 7/8] drivers: devfreq: events: add Exynos PPMU new events
Date:   Fri,  1 Feb 2019 17:46:51 +0100
Message-Id: <1549039612-28905-8-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87pSFSExBtPP6ltsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S1u
        N65gszj8pp3Vgc9j06pONo/NS+o9Dr7bw+TRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGbcW
        TWEveMdWsfb4GsYGxvesXYwcHBICJhIfG226GDk5hARWMErsXcbbxcgFZH9hlJjS28AG4Xxm
        lPh5upUJpAqk4fLq98wQieWMEp8PLWWGa5l+8TULyFg2AT2JHasKQRpEBKol7lzfD1bDLDCZ
        SWLR6W6wScICPhKzTj5iBrFZBFQlWo7NYASxeQW8JNY2PmKE2CYncfNcJ1gNp4C3RMfj7Ywg
        gyQEFrFL/GxoYoMocpG4PuMUVIOwxKvjW9ghbBmJ/zvnQ51dLHG2YxVUfY1E+8kdUDXWEoeP
        XwSHBbOApsT6XfoQYUeJx0s/QYOIT+LGW0GQMDOQOWnbdGaIMK9ER5sQRLWGxJaeC1CLxCSW
        r5nGDlHiIfHnUBUkdOYxSix6fJ1pAqP8LIRdCxgZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl
        5+duYgQmmNP/jn/awfj1UtIhRgEORiUe3g2/gmKEWBPLiitzDzFKcDArifA6ZYXECPGmJFZW
        pRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCUamBk/mP1wy0rp2al54pV
        VzZcfq1WXR3d0CV5gXvn7FM3vt7Znh247PGSKpmQyGtTL2/sark7oSVqJ5vqptlPeO4YPuT4
        9bCtOrgrfariFrOKLsao/f5+Ov+nfKvn5asKuexxZvvHdr3fqYzSC34d+FAXy7zybm3U3+Lz
        T5aVcIq7PTj0anOvYFuqEktxRqKhFnNRcSIAR/ESHywDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t/xe7pSFSExBn+WMltsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S1u
        N65gszj8pp3Vgc9j06pONo/NS+o9Dr7bw+TRt2UVo8fnTXIBrFF6NkX5pSWpChn5xSW2StGG
        FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GbcWTWEveMdWsfb4GsYGxvesXYyc
        HBICJhKXV79n7mLk4hASWMoo0dvdxgiREJOYtG87O4QtLPHnWhcbRNEnRolTG44wdTFycLAJ
        6EnsWFUIUiMiUC/R/+YSWA2zwHwmif4pc8E2CAv4SMw6+YgZxGYRUJVoOTYDbAGvgJfE2sZH
        UMvkJG6e6wSr4RTwluh4vB0sLgRUs+rfAeYJjHwLGBlWMYqklhbnpucWG+oVJ+YWl+al6yXn
        525iBIb9tmM/N+9gvLQx+BCjAAejEg/vhl9BMUKsiWXFlbmHGCU4mJVEeJ2yQmKEeFMSK6tS
        i/Lji0pzUosPMZoCHTWRWUo0OR8Yk3kl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NT
        C1KLYPqYODilGhg5O7QOM9ZltrafZix4sXlTQcNXUe8r/lmGbOXH6+aa3/gsNSWdL82txYrb
        JePxSqWHntbXL5/42fvlReqpQ0myjQcDrrJ5aT6/Kh2+OurP30d3GITMnl50suYUX3lbXKcy
        /90NbY0p3Q+dDZyXnbS62LU5ce69d23vX29wVv+VYm2apxtw5q8SS3FGoqEWc1FxIgDKuY5J
        kQIAAA==
X-CMS-MailID: 20190201164722eucas1p1b619d939e0f93ddb9ee1af7306e7cf67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201164722eucas1p1b619d939e0f93ddb9ee1af7306e7cf67
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201164722eucas1p1b619d939e0f93ddb9ee1af7306e7cf67
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190201164722eucas1p1b619d939e0f93ddb9ee1af7306e7cf67@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new performance events supported by Exynos5422 SoC counters.
The counters are built-in in Dynamic Memory Controller and provide
information regarding memory utilization.

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

