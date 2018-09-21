Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F56DECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C3B21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rwN+sLo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C3B21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbeIUSOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:14:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47675 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389835AbeIUSOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:14:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180921122614euoutp02640cf0ba8c47389d8884289a41ccdd42~WaembavZ22217422174euoutp02L
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:26:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180921122614euoutp02640cf0ba8c47389d8884289a41ccdd42~WaembavZ22217422174euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537532774;
        bh=LBpKXbnunUglxzbvvMAhAm9CB5cgys0I/Av0KmEUEkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwN+sLo+u1gKX07UZAPC/sG6mYSh6Ggd9MIpdpzXGC5+lPr7cVUew048qUMmABco1
         IZ5flcPIftU+wraWwFRcK5lLlXuJo+10S2c3owikrTHWvgKBVnZw8nZoPcKuAKEcQ2
         zWFTzr9bgBfaPgOetC0zwOyDr0Wg6yGKVRivjK0k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180921122614eucas1p294ac4ea64377f75dd8d2ee1eaf16b30f~WaelsrcR81399713997eucas1p2c;
        Fri, 21 Sep 2018 12:26:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 66.9F.04441.563E4AB5; Fri, 21
        Sep 2018 13:26:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180921122612eucas1p2f3e0b6cf2e15553bd4d7114722c2a217~WaeklfEj21399713997eucas1p2a;
        Fri, 21 Sep 2018 12:26:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180921122612eusmtrp19a799c50bbac74ea16730323753ae702~WaekTlLuu2872728727eusmtrp1F;
        Fri, 21 Sep 2018 12:26:12 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-ba-5ba4e365c61f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 34.69.04284.463E4AB5; Fri, 21
        Sep 2018 13:26:12 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180921122611eusmtip16207611fc884677872ac111ebe737ae2~WaejstnyO2133221332eusmtip1b;
        Fri, 21 Sep 2018 12:26:11 +0000 (GMT)
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 1/3] drm/exynos: drm_plane: Correct exynos_drm_plane_reset
Date:   Fri, 21 Sep 2018 14:24:36 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537532678-4276-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeyxVcRzf754nuZwum180bVdq3qS2s2WNpu0i05LVaOPECYvL7kFpbSyt
        5eK6+IMlWx6FGy7XzXNJN5HMK2UeE8vmdUl5lT9SjpP13+f3eX2/++5HIpIKzIaMkyezCjkT
        L8VN0eaenSFXdq4y3KNmx5WerB/E6NzBPhHdWKzF6N6OZ4D+tLWG0wUzapRe/DKC0nlzRoQe
        Gmog6IH7KwStmxvD6NH2JzhdPNQpouu6pwm6uHAJ97GQ6TRZuKxlexaTzWT3imRNlekylV4D
        ZBs6u0t4mKl3NBsfl8oq3M9FmsauatdAUofJnbV5FZIBVKQSmJCQOg1L5xYIJTAlJVQ1gMbM
        MpQXJNQmgMOv/QS8AeDzUXslIPcDfTOBAl0FYJfhpJDds2v0dTgv4NQZODW9vo+tKHv4O18D
        eBNCvUThq75xEV9kSQXAtyuxvAelHGBtT7lIWMgOTgxmITw2oWSw/tc8ymch1UzAoqqc/ayY
        SoUbCxeFffzg8MR5IWoJl3v1hICPwv7CnH/RTAAnN8cw4aEG8M0LJSq4zkLd+PJ+J0I5Qm27
        u0D7ws9LRajQbw7HVw/zNLIHC5qLEIEWw0cPJYL7BDTq9fjB2MWNLSBgGXzQlo0L5ykBsEyp
        JtTg2OP/w54CoAHWbAqXEMNynnL2thvHJHAp8hi3qMQEHdj7Ov27veutYOvjDQOgSCA1E3tU
        VIRLMCaVS0swAEgiUitxp7IyXCKOZtLusorECEVKPMsZgC2JSq3F5k43wyVUDJPM3mLZJFZx
        oIpIE5sMQDhYtvycPpXbFjr1Lp7L9w76OqKYlV8Pcla5XwspTC/xCPaq/pHv7XJlYJPxc7fz
        raAKQkNU08UXXC6PXj1eQ6RHqevydo90eLX6z2rNs60DSo1hiT67zofK79n7e5o1hmV1f8Pe
        6x3+fIipbooMbNAE1zh2WUTUzmzn2Y58tzVIUS6W8XRCFBzzF49+4lE2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Xd2Ux0uiDT5PVLS4te4cq0XvuZNM
        FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
        MeP8PiaLtUfuslvMmPySzYHfY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEXp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZbxd/56xYDdn
        xftnfcwNjH0cXYwcHBICJhIn73t3MXJyCAksZZS4/K8OxJYQkJGYd7aPDcIWlvhzrQvI5gKq
        +cQosWLmJnaQBJuAqcTtu5/AikQElCX+TlzFCFLELHCQRaJl4xlGkAXCAl4Sh99kgNSwCKhK
        rDm2iAnE5hVwl9hxppkVYoGcxM1zncwgNqeAh8S6H89YQFqFgGpOrTeZwMi3gJFhFaNIamlx
        bnpusaFecWJucWleul5yfu4mRmAcbDv2c/MOxksbgw8xCnAwKvHwGixeHC3EmlhWXJl7iFGC
        g1lJhHdf15JoId6UxMqq1KL8+KLSnNTiQ4ymQDdNZJYSTc4HxmheSbyhqaG5haWhubG5sZmF
        kjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQbG5o8Jca/8ZXM8U3980srj9hIu/ba4/xSDYOVB
        vayc+PmbNuw5Ou3N09W7jut9vH75jabVo4hX67Zd69PeMfVgt/9DC3MV9ur4NbGPvY7kSE+8
        23NU8G2qyskbotMSuQ7M6Xr7Ym3M8UB2j/bk4PQsic2Ll82tcJ6RnHtENUDkVYnlWoeppVt+
        KrEUZyQaajEXFScCAHAMzcSZAgAA
Message-Id: <20180921122612eucas1p2f3e0b6cf2e15553bd4d7114722c2a217~WaeklfEj21399713997eucas1p2a@eucas1p2.samsung.com>
X-CMS-MailID: 20180921122612eucas1p2f3e0b6cf2e15553bd4d7114722c2a217
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180921122612eucas1p2f3e0b6cf2e15553bd4d7114722c2a217
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180921122612eucas1p2f3e0b6cf2e15553bd4d7114722c2a217
References: <1537532678-4276-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180921122612eucas1p2f3e0b6cf2e15553bd4d7114722c2a217@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of helper functions in exynos_drm_plane_reset in order to set
all default values. Currently alpha isn't set during reset.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index dba29aec59b4..755ca0e9ead2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -131,16 +131,14 @@ static void exynos_drm_plane_reset(struct drm_plane *plane)
 
 	if (plane->state) {
 		exynos_state = to_exynos_plane_state(plane->state);
-		if (exynos_state->base.fb)
-			drm_framebuffer_put(exynos_state->base.fb);
+		__drm_atomic_helper_plane_destroy_state(plane->state);
 		kfree(exynos_state);
 		plane->state = NULL;
 	}
 
 	exynos_state = kzalloc(sizeof(*exynos_state), GFP_KERNEL);
 	if (exynos_state) {
-		plane->state = &exynos_state->base;
-		plane->state->plane = plane;
+		__drm_atomic_helper_plane_reset(plane, &exynos_state->base);
 		plane->state->zpos = exynos_plane->config->zpos;
 	}
 }
-- 
2.7.4

