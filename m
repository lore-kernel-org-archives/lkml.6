Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F57C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C3A2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lasF7ugy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C3A2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeJZAze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:55:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43607 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJZAzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:55:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181025162203euoutp02b517c0044bf41c2d4372d2ae0ad7dd2b~g5oM5A9sm1517515175euoutp02_
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:22:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181025162203euoutp02b517c0044bf41c2d4372d2ae0ad7dd2b~g5oM5A9sm1517515175euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540484523;
        bh=9iNx3jbPbDAgfcltw+XZmb8c2kLZwCvMaGnRR5Swdvo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lasF7ugy9K3bQzHISqLpRA+DKuRSD16b28hqMO5MbI6hbZ+vSo2MZrQa0EYic3t4H
         1gv+XVB+n2HnsJgDdmm+0PgfRk6UrE3fEObubSdIwLZX+k6rauXdiZ+/jhTEEehk0g
         gDZ9S0Iry1X4RbQHGbBObEOErtB8TFL9uIRUucKE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181025162202eucas1p2fe1ea6018812a51e2490c36b03bd22c2~g5oL0enhQ2146821468eucas1p2X;
        Thu, 25 Oct 2018 16:22:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 69.46.04441.AADE1DB5; Thu, 25
        Oct 2018 17:22:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181025162201eucas1p1033325147e317799e7c174345c9ab333~g5oKoWGPR1757217572eucas1p1Y;
        Thu, 25 Oct 2018 16:22:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181025162201eusmtrp2676d21d779e22e9403135ac86c4c075a~g5oKYRafO0843108431eusmtrp24;
        Thu, 25 Oct 2018 16:22:01 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-9d-5bd1edaaa07f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A1.C8.04284.9ADE1DB5; Thu, 25
        Oct 2018 17:22:01 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181025162200eusmtip1fa99b49863375ae032eaae634fcb5c12~g5oJoqYur0691606916eusmtip15;
        Thu, 25 Oct 2018 16:22:00 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Lowry Li <lowry.li@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH v4 0/2] drm/exynos: decon: Add properties
Date:   Thu, 25 Oct 2018 18:21:51 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+XYuO61WZ2eCX1YSi4KK7gZfJLEs4kQF1R9JzahjO6ikS7a0
        9I/UStFFako4KqyZmc3bnMt0ZZfhXBZtrYvVhmUXyMqsnIsS0zbPrP9+7/M+D+/Dx0dhjJ2I
        olI0h3mthktVkBK8teu3e4npq0e1/PbJmcjb6CLQaVe3CDUbmgjkvHkFoGeBbyRq77OJUdmb
        Uhz1v/bgqOT9Fwy53WYxenR8QIws73sI9NR2gUQG920RKmm7R6CGzl4xMv64jqPe8k6ADOWf
        SKWcra+sB6zFVESyN372EWxl9w72zSmniG2pzmHbyzpErNPmFbPFVhNg/Zbo7ZI9klg1n5qS
        yWuXrdsvSb58p06U3kUevalvI3OBkdCDKRSkY2Cd/y6pBxKKoWsBfBLw4sIwDOCwxyESBj+A
        D/LKRZOR+8ZaEGKGvgrgi8H4f4mP3Z6JBUmvhr7eITLEEfQ8+OeMCYRMGP2UgO4qIx5ayOk1
        8FaeYaIITs+Ht14Uh0tFw1euIkxglxjmj8eFWEpnQqd5FBf0jVCf6xALLIefndYwz4bj7Rcn
        akP6BIDe4R5CGEoBvFenD6fXQsvLz0EXFay0EDbZlgnyemgbvYuFZEhPhy+/ykIyFsSy1oqw
        LIWFBYzgXgC/WK3k5Nl+fwAIzMLWuvLwA+2FNdVmrBREn/t/6xIAJhDJZ+jSknjdCg1/ZKmO
        S9NlaJKWHjiUZgHBn/VwzDnUBgJPEu2ApoBimvS++bGKIbhMXVaaHUAKU0RIO3weFSNVc1nZ
        vPbQPm1GKq+zg1kUroiU1lQ2qxg6iTvMH+T5dF47uRVRU6JyQZKZHavEbC3Zu0bnNB2sPtv/
        PHHTtYHhuecvuk74NsiO5ahjerc2zFKqA7G8bPo7R1FhtYL/U58Qs1hlKMh+m2BbFTvSFzgX
        x6lW5u+e+t2/XW7M2qyJzati8mX8DIWyw9EYPyNipEXbU+X7RQ9GmZbXMMqdOduOjGxRHK8Y
        +KDAdcncikWYVsf9BaUdKSZVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7or316MNlh4mtXi1rpzrBa9504y
        WWycsZ7V4vjupYwWV76+Z7PY+WAXu8Wk+xNYLF7cu8hi0f/4NbPF+fMb2C3ONr1ht9j0+Bqr
        xeVdc9gsZpzfx2TRv+Mgq8XaI3fZLRZ+3MpicXfyEUaLGZNfsjkIe6yZt4bRY9OqTjaP7d8e
        sHrMOxnocb/7OJPH5iX1Hjsn7WXyOL7rFrtH35ZVjB6fN8kFcEXp2RTll5akKmTkF5fYKkUb
        WhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZSzev5qp4Bhbxe6uHWwNjAtZuxg5
        OSQETCROLFzB2MXIxSEksJRRYt3dy2wQCRmJeWf7oGxhiT/Xutggij4xSmx885kJJMEmYCpx
        ++4nsCIRAWWJvxNXgU1iFnjIKvF+YSdYQljAUmJP4wywdSwCqhJ7rveB2bwCHhJTpt2E2iAn
        cfNcJ/MERp4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNl27Gfm3cwXtoYfIhRgINR
        iYf3xIYL0UKsiWXFlbmHGCU4mJVEePfevhgtxJuSWFmVWpQfX1Sak1p8iNEUaPlEZinR5Hxg
        JOeVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDMZbyzn/nGaTu1
        9ud/NM4L6eSpv5ry8njOfK8qlqtRzp82vXxvZ/BOWKw1Ma2OS3d3J+dOu5iQrA7vmSFd/+x4
        5/+ccshJrc9e7veh7DnXWtaGFjZuTd05P+FjzV1eOeZj+r1BBXqfBBLjrQ/Eid2/8cRjkWrQ
        /wKJpk1F/z+1HtohpZXy4pISS3FGoqEWc1FxIgBVnKVMrAIAAA==
Message-Id: <20181025162201eucas1p1033325147e317799e7c174345c9ab333~g5oKoWGPR1757217572eucas1p1Y@eucas1p1.samsung.com>
X-CMS-MailID: 20181025162201eucas1p1033325147e317799e7c174345c9ab333
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181025162201eucas1p1033325147e317799e7c174345c9ab333
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181025162201eucas1p1033325147e317799e7c174345c9ab333
References: <CGME20181025162201eucas1p1033325147e317799e7c174345c9ab333@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds two new configurable properties
to exynos5433_drm_decon.

Patch 1 add window alpha property.
Patch 2 add pixel blend mode property.

Regards,
Chris

Changes in v4:
- set blend equation for DRM_MODE_BLEND_PIXEL_NONE explicitly,

Changes in v3: 
- fix compilation error,

Changes in v2: 
- add premultiplied pixel blend mode (i.e. make it functional),
- correct minor issues from v1, 
- refactor code in order to adapt to above changes.

Christoph Manszewski (2):
  drm/exynos: decon: Make plane alpha configurable
  drm/exynos: decon: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 82 ++++++++++++++++++++++++++-
 drivers/gpu/drm/exynos/regs-decon5433.h       | 22 +++++++
 2 files changed, 102 insertions(+), 2 deletions(-)

-- 
2.7.4

