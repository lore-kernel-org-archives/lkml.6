Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E49BC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E772184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LIxtvCHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfA2Rzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:55:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48946 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfA2Rza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:55:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190129175529euoutp026a5038234d77caf836da76bf0a35eac8~_Y1LKumuh2978229782euoutp02o
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 17:55:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190129175529euoutp026a5038234d77caf836da76bf0a35eac8~_Y1LKumuh2978229782euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548784529;
        bh=cwdR9PeB9U1fbRaysP0X7KBDHK6TquXGExqnRLFnqnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIxtvCHRAOn4hGnXHe8FuDDOmYFuIx6eQCGFqbx0PVKUUA6xEngaDYM9HVJpHR1qo
         dcwKeFUiRIh7o/Usx086wQHw0ZLdTARHurBjUBB8RvfCXIaJEvydBP/n8DqRePkFTH
         gcKNCv8FC5OsoCTyOgDQ83KBbBM3CUjZY9JbTj7o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190129175528eucas1p1a036179675a4722aaf310c13c1d31378~_Y1KkQXhi2162921629eucas1p1z;
        Tue, 29 Jan 2019 17:55:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5C.F7.04441.093905C5; Tue, 29
        Jan 2019 17:55:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190129175527eucas1p291cb41ad401d4513d65a81c0a2edff88~_Y1J0stAs2848028480eucas1p21;
        Tue, 29 Jan 2019 17:55:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190129175527eusmtrp23fb98231a66fc82a7837e642359fdf47~_Y1Jl1QDR0424104241eusmtrp2d;
        Tue, 29 Jan 2019 17:55:27 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-1e-5c5093902657
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 58.EE.04128.F83905C5; Tue, 29
        Jan 2019 17:55:27 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129175526eusmtip131024a1d26689c55865eab43ef3e27b5~_Y1I8rKrn2139121391eusmtip13;
        Tue, 29 Jan 2019 17:55:26 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/8] drivers: devfreq: events: add Exynos PPMU new events
Date:   Tue, 29 Jan 2019 18:55:13 +0100
Message-Id: <1548784514-26649-8-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87oTJgfEGFybz26xccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbe4
        3biCzeLwm3ZWBz6PTas62Tw2L6n3OPhuD5NH35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZRyY
        OIWl4DJnxdIvb9gaGNdzdDFyckgImEgcaJnJ0sXIxSEksIJRovP+PEYI5wujxIulK6Eynxkl
        Jlw5DeRwgLVMmpMJEV/OKPHyzQk2uI77S2+CFbEJ6EnsWFUIskJEoFrizvX9zCA1zAKTmSQW
        ne5mAkkIC/hIrHs1nQ3EZhFQlWhsPwxm8wp4SRw7/JAJ4j45iZvnOplBbE4Bb4mOx3cYIeKL
        2CVuPAmDsF0k9i8+zQ5hC0u8Or4FypaR+L9zPtScYomzHavYIOwaifaTO6BqrCUOH7/ICnIz
        s4CmxPpd+hBhR4klDy8zQvzLJ3HjrSBImBnInLRtOjNEmFeio00IolpDYkvPBahFYhLL10yD
        Gu4h8frrX7C4kMA8RonJx70mMMrPQti1gJFxFaN4amlxbnpqsWFearlecWJucWleul5yfu4m
        RmCCOf3v+KcdjF8vJR1iFOBgVOLhZQgOiBFiTSwrrsw9xCjBwawkwmv42z9GiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA6Onis39FTFTPBXdX5gfVE5c
        mq+SHG+z8mW1/bbV6m/erz44yzPggfCGF7lxXwJ3xZ6fcOTgBr3eU8kXlmqL7rPdeS66x6lQ
        1fOc0MeSOyvMr3dX7nD7JXKO12/Ru46WzY//cq5TdJltuWX1dd1NH10Yj1wLvLx53+x7fyeu
        mORYXWzLKRX6pLdBiaU4I9FQi7moOBEAAIGo9CwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t/xu7r9kwNiDLpvCFlsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S1u
        N65gszj8pp3Vgc9j06pONo/NS+o9Dr7bw+TRt2UVo8fnTXIBrFF6NkX5pSWpChn5xSW2StGG
        FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GQcmTmEpuMxZsfTLG7YGxvUcXYwc
        HBICJhKT5mR2MXJxCAksZZSYd28vcxcjJ1BcTGLSvu3sELawxJ9rXWwQRZ8YJWZe2cYG0swm
        oCexY1UhSI2IQL1E/5tLYDXMAvOZJPqnzGUFSQgL+EisezWdDcRmEVCVaGw/DGbzCnhJHDv8
        kAligZzEzXOdYIs5BbwlOh7fYQSxhYBqvr3+wTaBkW8BI8MqRpHU0uLc9NxiI73ixNzi0rx0
        veT83E2MwKDfduznlh2MXe+CDzEKcDAq8fAyBAfECLEmlhVX5h5ilOBgVhLhNfztHyPEm5JY
        WZValB9fVJqTWnyI0RToqInMUqLJ+cCIzCuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKa
        nZpakFoE08fEwSnVwGjCeCOw+HjxvGKNb9et9cXdNzZtn17AJKrm9Jx1yt20OpXwuMuLW+Xt
        XV/mTLrh8sLYN9uf2X+2ad2UoEjbqNIk0U1Wc+qFzBUU2f7s+8L78dGOy4vMQo1OqgRvSGNM
        viPU/Tixu/PfxEiHM0wSU3/Pm8M7IfZ8h8mPe85TvnHVNGTwvK+oUmIpzkg01GIuKk4EACma
        7fGQAgAA
X-CMS-MailID: 20190129175527eucas1p291cb41ad401d4513d65a81c0a2edff88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190129175527eucas1p291cb41ad401d4513d65a81c0a2edff88
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190129175527eucas1p291cb41ad401d4513d65a81c0a2edff88
References: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190129175527eucas1p291cb41ad401d4513d65a81c0a2edff88@eucas1p2.samsung.com>
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

