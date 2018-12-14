Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCB4C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889EF20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OdiNpZfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889EF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeLNM27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:28:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35233 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbeLNMKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:39 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181214121037euoutp0232fb679b2aca0c686e88a6e395f661e6~wMc8GEvCn0903709037euoutp02O
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:10:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181214121037euoutp0232fb679b2aca0c686e88a6e395f661e6~wMc8GEvCn0903709037euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544789437;
        bh=8bnkjwGTVLZ37CKTxSpN56zRX02HgRga5uA9mp1FyLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OdiNpZfSR3yA74NV1didImFsv6yuf95EfwPwyJUbNyjscRsjESZLBvVDUlSjaSdOO
         SDZ+QDTuiV+jLBUFpfyC/ijMmDwxFoeb4hg5v/oIbKxOfUcZtT9xSoEocZjsM6WqL0
         QRev8YMuhHpGyw229eYYaZTGwThn8odno/9adASM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181214121036eucas1p2f97ace3bea4f416a36f5f81a65ca4501~wMc69wxkB1566115661eucas1p2w;
        Fri, 14 Dec 2018 12:10:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id ED.9B.04441.BBD931C5; Fri, 14
        Dec 2018 12:10:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181214121035eucas1p11c9465bd3d5398c7d9c947c2e1844854~wMc6Nt3481060310603eucas1p1v;
        Fri, 14 Dec 2018 12:10:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181214121035eusmtrp2c5247febf3a785ee094755a577de9564~wMc596Hlb1165911659eusmtrp2r;
        Fri, 14 Dec 2018 12:10:35 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-6d-5c139dbb483b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9C.CC.04284.BBD931C5; Fri, 14
        Dec 2018 12:10:35 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181214121034eusmtip268a6ef2ac764e6d85719c2abd8b2bb16~wMc5NRC0P0092500925eusmtip2-;
        Fri, 14 Dec 2018 12:10:34 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 3/6] drm/exynos: drm_drv: Extend exynos_drm_plane_config
Date:   Fri, 14 Dec 2018 13:10:18 +0100
Message-Id: <1544789421-5265-4-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHe3cuO44Wp6Phi4nRpCIpb1i8ZUlC1PkU9aUiR7X0oJJT29Q0
        ySTRdJF5CZu11MxSZqlN0zlLc4jDLJeXRC1vmeC1vCYpaptH69vz/J/f//0/PLwUxjQSDlRw
        aASnCJWFSEgRXtn4x7y/5omt1H0p7xDqKWkh0L2WJgF6rS4lkKnmOUAd879IlNGfhqORvlYc
        3R8ax5DZXCZEn25PCJFuqJNA7QYNidTmWgF61dArRE+n3+BoYLQOoN7MBoDUmaPkMYbNeRnL
        6rQpJFv1e4Bgc5rOsP13TQK2vOAWazL0CNnUCi1gZ3VOp20uiI4EcCHBUZzCzeeyKKhcb8bC
        TcLourcaLB6UkypgQ0HaC5q+6QgVEFEMXQTgZGk9yTdzAE6V/RDyzSyAemMttmFpjf8s4AeF
        AFY/MBP/LLkFo8BKkfQB+LV3Zi3EjnaGy+laYIUw2kDAn0OLAuvAlmZhW8KzNQind8GSiSXc
        WovpkzC3dlHIxznB7paUtWgbC//CULD2EKR7hHA1ewznoeOwRKtZ388Wjpkq1s2OcLU6V8Ab
        EgDsmesk+CYNwPpi1brbG+q6xiwUZdlvLyw1uPGyL1RXLxBWGdJbYNfkVquMWcqMyocYL4th
        chLD07vheEUFuRE7MjsP+JqFlcbq9Qs9BrAtK5lMAzse/Q/LA0AL7LlIpTyQU3qEctddlTK5
        MjI00NU/TK4Dlt/VvGKa0YP5titGQFNAslkclMFIGUIWpYyRGwGkMImd+GyirZQRB8hibnCK
        sEuKyBBOaQTbKVxiL47dNODH0IGyCO4qx4Vzio2pgLJxiAd7arty7bN6kY+7nzOpuDn9odS7
        9VThRfUMuOZ78Eu7dKjYK31Y3vBu6s4CmRAcY1C5xJlP6JnBc93JR7fhIg3rJfBWue+MquI6
        qKy+OK/sQE3RSH60/0f3us4pz+U5leegg7mZXNoHndMPD+u/J55fqWpfmZ3KT0p93+2YuUmC
        K4NkHi6YQin7C1S3WDZZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7q75wrHGFyfwWJxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1lMuj+BxeLFvYssFv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN
        Ysb5fUwWa4/cZbdY+HEri8WDl/sZLe5OPsJoMWPySzYHIY95a6o9Nq3qZPPY/u0Bq8e8k4Ee
        97uPM3lsXlLvcXzXLXaPvi2rGD0+b5IL4IzSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQy9i84zxzwXH2iv175jA3MG5m62Lk5JAQMJG42HCBqYuR
        i0NIYCmjxLvZJ6ESMhLzzvZB2cISf651sUEUfWKUmLn2GDNIgk3AVOL23U9gRSICyhJ/J65i
        BCliFjjGKjHx/Sp2kISwgIfEpebFYEUsAqoS6978ZgGxeQXcJebv+8UOsUFO4ua5TrChnED1
        y3YtYQSxhYBqXs38wjiBkW8BI8MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwDjaduzn5h2M
        lzYGH2IU4GBU4uE9MEUoRog1say4MvcQowQHs5IIb1ircIwQb0piZVVqUX58UWlOavEhRlOg
        oyYyS4km5wNjPK8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA6OL
        e6g4U8d51Qfm+iF2Zd+nX1h5d+GjTbY7xWLXBt4+qL5w/+dXCfXaLJl/BRqrzptly6230Pna
        0XWVax3vp4qyd2VWZ7auFbC/cP7vE8/7EiwvQp5zp4Tq5bZPzdTheqVbaWW0aYd0ufH3CUte
        b5YJvLhoWtE6Tc+d8hZtzf/1Dh/8/raCN1CJpTgj0VCLuag4EQDG0Q5XuQIAAA==
X-CMS-MailID: 20181214121035eucas1p11c9465bd3d5398c7d9c947c2e1844854
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181214121035eucas1p11c9465bd3d5398c7d9c947c2e1844854
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214121035eucas1p11c9465bd3d5398c7d9c947c2e1844854
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181214121035eucas1p11c9465bd3d5398c7d9c947c2e1844854@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new range capability and add range value to
exynos_drm_plane_config.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index 5e61e707f955..1bc334d846c5 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -94,6 +94,7 @@ struct exynos_drm_plane {
 #define EXYNOS_DRM_PLANE_CAP_TILE	(1 << 3)
 #define EXYNOS_DRM_PLANE_CAP_PIX_BLEND	(1 << 4)
 #define EXYNOS_DRM_PLANE_CAP_WIN_BLEND	(1 << 5)
+#define EXYNOS_DRM_PLANE_CAP_RANGE	(1 << 6)
 
 /*
  * Exynos DRM plane configuration structure.
@@ -111,6 +112,7 @@ struct exynos_drm_plane_config {
 	const uint32_t *pixel_formats;
 	unsigned int num_pixel_formats;
 	unsigned int capabilities;
+	enum drm_color_range range;
 };
 
 /*
-- 
2.7.4

