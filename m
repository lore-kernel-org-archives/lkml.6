Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C96C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05A520892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oREBpMVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05A520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbeLNM3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:29:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35198 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbeLNMKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:36 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181214121034euoutp02a12fe43e0182fb032b0454e1642b7f3d~wMc5xDuuw0904709047euoutp02G
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:10:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181214121034euoutp02a12fe43e0182fb032b0454e1642b7f3d~wMc5xDuuw0904709047euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544789434;
        bh=oWzjGiqLNxmljmmSxzuyHA7ENwD0Nk3aYeIIDQ8SbEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oREBpMVyW3v1GKTMVVpuzsqsTrmLH+kZlxKJ6uzaQSZ4kwlHOZWxOiPiNCF2ADut3
         wiGHwbo0X0wV8oFwRCRy1vm9kOOIu8XE2zxAz9XczraaEB39JqMNODmzsSk8bmG0l5
         vjjbV05TPDtgC/FkXenHt64EoMf8DhBH8+Qr9ZN0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181214121033eucas1p285a93be22fde9770583d2a2af6f307a9~wMc42asHR1566115661eucas1p2s;
        Fri, 14 Dec 2018 12:10:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 95.7D.04294.9BD931C5; Fri, 14
        Dec 2018 12:10:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6~wMc3_KReu1556815568eucas1p2h;
        Fri, 14 Dec 2018 12:10:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181214121032eusmtrp1fb5b974b3259c515c3b73cd7d2114a9a~wMc3uCJlG2638626386eusmtrp1T;
        Fri, 14 Dec 2018 12:10:32 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-19-5c139db971ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 00.91.04128.8BD931C5; Fri, 14
        Dec 2018 12:10:32 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181214121031eusmtip293d22b98bffcd885ff2210de090bdb53~wMc27XV0T0091800918eusmtip2i;
        Fri, 14 Dec 2018 12:10:31 +0000 (GMT)
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
Subject: [PATCH 1/6] include/drm: color_mgmt: Add enum labels
Date:   Fri, 14 Dec 2018 13:10:16 +0100
Message-Id: <1544789421-5265-2-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj22zk7O85mx6Pph4biysAiNSn5QpMUwUN/rH4UlaRLD27kjU3N
        W2ReKk3zBilas6A0rTTX1FyZJMs5yokXZC1MQxQvpeQ0ylRyO1r/nvd5n+d93vfjIzFay3cl
        ZYkprDxREi8mhHh772/Dwc77jpF+uXV7kanZwEclBj0PtVa38JHu9WOARlYWCVQxXoajmS+D
        OCqdnMfQwMALAerP/SZAqslRPhrW3CNQ9cBbHnquHROghz/acDQx2w3QWKUWoOrKWeI4zSif
        ZTGqpkKC6fg5wWeU+lPM+G0dj3n56Bqj05gEzB11E2DMKveTtueFQbFsvCyNlfsGRwul76uM
        WLKeSDf/KiBywCi/CNiSkDoM/4zrQBEQkjT1BMDm6kmcK5YBNBcs8iwqmjIDWJPnvO1YGMwR
        cHwDgIbysH+Ghto63NIgqCPw89gSYcFO1B64Xt5kjcAoDR8uTK5apzpSx+DUx3qrCKe84Ju+
        JetOIiocds73C7g0d/jJUIhZsC3FwHrNI+sgSJkE0PRVz+NEYbB1rZvgsCOc06m3zLvhh8pi
        nDPkAWhatlxtKcoAfPe0COdUgVBlnNucRG7u5w1bNL4cHQK7eg0CCw0pe2j87mChsU1Y0V6F
        cbQI3rpBc+p9cF6tJrZjZ8wrgMMM1HdvbD1pLYDvG41EGfCo+R/2AIAm4MKmKhLiWIV/InvF
        RyFJUKQmxvnEJCWowObf+rChW34FNGuXegBFAvEOkbSCjqT5kjRFRkIPgCQmdhKdKXCMpEWx
        koxMVp4UJU+NZxU9wI3ExS6iLJuJCzQVJ0lhL7NsMivf7vJIW9ccEHDaLSKm/9z0d/+hmZ1n
        p4T2BeW68ajpEYf8rmBZh2hYtksbnqYM8gxQdYRo3vn7yNIzm107HLwqzOoN55jGA9kR0bi2
        xMNu0C6wzRgq9TtRGqrM27PWG1s/JQ7ybF93un7Vm5Xcje+7GXd0dTmsQSTNvnwxrDitN2Po
        bFt+n40YV0glh/ZjcoXkL2NBTvBXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7o75grHGOzdqmpxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1lMuj+BxeLFvYssFv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN
        Ysb5fUwWa4/cZbdY+HEri8WDl/sZLe5OPsJoMWPySzYHIY95a6o9Nq3qZPPY/u0Bq8e8k4Ee
        97uPM3lsXlLvcXzXLXaPvi2rGD0+b5IL4IzSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQyzg6/QZzwUm2is8/WtkaGK+xdjFyckgImEi8u9jA3sXI
        xSEksJRRYunrzUwQCRmJeWf72CBsYYk/17rYIIo+ARW92cQOkmATMJW4ffcTWJGIgLLE34mr
        GEGKmAWOsUpMfL8KrEhYwFbi6ZllYEUsAqoSe058AlvNK+AusfP1WXaIDXISN891MoPYnAIe
        Est2LWEEsYWAal7N/MI4gZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMA42nbs55Yd
        jF3vgg8xCnAwKvHwHpgiFCPEmlhWXJl7iFGCg1lJhDesVThGiDclsbIqtSg/vqg0J7X4EKMp
        0FETmaVEk/OBMZ5XEm9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoFx
        XpOEfuM/U5YXsZW6reVMpy44+H2/uii8Om/Sm67q5PCehtwNDRKbvRbflet/miizca/yWh6+
        981LHEO+qq150ia9nN0vJH7eRseXca/X6rZM6rx0keeo/TZG98bdR47ty8jc1yj+1/q68wqV
        33N5bbv8Tp/OXjG7/PPTrtC/uV0yxY0dYSeUWIozEg21mIuKEwHnrVeluQIAAA==
X-CMS-MailID: 20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Range setting makes sense for YCbCr and RGB buffers. Current
drm_color_range enum labels suggest use with YCbCr buffers.
Create enum labels without colorspace specification.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 include/drm/drm_color_mgmt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 90ef9996d9a4..52f6d5221a0d 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -62,6 +62,8 @@ enum drm_color_range {
 	DRM_COLOR_YCBCR_LIMITED_RANGE,
 	DRM_COLOR_YCBCR_FULL_RANGE,
 	DRM_COLOR_RANGE_MAX,
+	DRM_COLOR_LIMITED_RANGE = DRM_COLOR_YCBCR_LIMITED_RANGE,
+	DRM_COLOR_FULL_RANGE = DRM_COLOR_YCBCR_FULL_RANGE,
 };
 
 int drm_plane_create_color_properties(struct drm_plane *plane,
-- 
2.7.4

