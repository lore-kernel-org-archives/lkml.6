Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0788220874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j20WwDoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0788220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965311AbeFSIWC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:22:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44916 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756302AbeFSIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:20:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180619082000euoutp02494cc0fe59e3a3c8a5a19df40590ece1~5gexE8iss1395713957euoutp02S;
        Tue, 19 Jun 2018 08:20:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180619082000euoutp02494cc0fe59e3a3c8a5a19df40590ece1~5gexE8iss1395713957euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529396400;
        bh=apXlQ4KvBL8qm2fwxPcCszmmnldlFRci8SdE3pkcSE4=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=j20WwDoOFs2XMpDtmofxu0FORX1Bv9PJV7pKusPrHW9EPaiqw0yIguoTIXWqqAigf
         rSP1pg/nqzt6Da0Cu87Nu1ecEng+e7l34YqRQiroqt8AL7sIxPKf4+id5gilSxkG3s
         j49tFp0hNGeHi9/YAwnC/RdwwqgGIicvgo/B68mA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619081959eucas1p13fe0f80fe799f7325ff4b86c8ff1d617~5gewOHd-f0549605496eucas1p1V;
        Tue, 19 Jun 2018 08:19:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EA.AA.05700.EACB82B5; Tue, 19
        Jun 2018 09:19:59 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619081958eucas1p16911ee9962441735d929dc588e70ce70~5gevdvrDa0549605496eucas1p1U;
        Tue, 19 Jun 2018 08:19:58 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-1e-5b28bcae6975
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5A.56.04178.EACB82B5; Tue, 19
        Jun 2018 09:19:58 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAK00EJ59T2RV00@eusync4.samsung.com>;
        Tue, 19 Jun 2018 09:19:58 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v3 2/9] drm/exynos: move connector creation to attach
 callback
Date:   Tue, 19 Jun 2018 10:19:23 +0200
Message-id: <1529396370-18761-3-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG/c7d0eIwLb9MDEbiEDQF0Y+MNCg6EaRE9YdGtvLgdV521DIp
        h1Zu5i0lmpa6aFpOTZ1mpRV5qS1MpyldJDOwIq+BZqFppjv43+95n+d9Hz74GFyWS7oysYmp
        vDpRmSCnJETbq0Wbd+NTRYTvQBYaedBPooL+1xjK1s6QqFnfSKKqnrXZ8MJPCpWMFRPox+dB
        AhWNT+HIZmuiUV/2NI101400Mo+/I9FQ+20K6W3PMWSYGCFQQ88ojarfD2LoyrMeGulLJyi0
        2F5JhGzh6ivrATdUWIBxT8pHae6WtozkzCYdxT36/YXkxq5ZMK7FmMUVtpoAN292D5OES/ZE
        8Qmx6bx6197Tkpj5WR2e3APPa6rLKQ2odc4Djgxk/eELTRGRBySMjL0PoHU6FxfFPIDGhjJy
        IzXXtoCJRg2A3R1LtChWAVxtr1tzGIZivWB9buT63Jk1AdjyYQasC5y9QcKBqin7KSc2DH6z
        fbUzwXrAJWOVnaXsfqizWAmxzh1+7Nfh6+zIHoDlFX/s1ZAtpWFfUzu13gbXFi4X+ol5Jzhp
        aaVFdoM6bScmciasnbhHiLsaAH+NDuGiEQS7LYP2YpzdDEvabuLiTSnUXpWJEQ52WFco8ZV6
        ACf/5lPFYJsBOJiAC58mqKJ5wS+RP+cjKFVCWmK0z9kklRmsfY/ef5a5x2Dh7ZkuwDJAvkmq
        afaMkJHKdCFD1QUgg8udpQ+rFREyaZQy4wKvTopUpyXwQhfYzhByF+kpxaVwGRutTOXjeT6Z
        V2+4GOPoqgEHg6nA8eoFA7mslFa6dNS9PAzd4j4V9UPhGPP96Fa//OKQipoVH1pjwD07l1dy
        VKHDcZkjK8FTAbM1dySdb/KWUoJS0kyBvQZLueJkq3dl5phHpHafr5PjMr/TYWzibqgpwN9N
        DfW5A6HHvY7slhh3YIcuRnHRVv/4EwrnHDkhxCj9vHC1oPwPAj6ueRoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xa7rr9mhEG3R+kLC4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErozP7zqZC45IVDQsncXWwLhSpIuRk0NCwETi07avTF2MXBxCAksYJZ4+380I4TQy
        SSyYMZ29i5GDg01AS2JNezxIXERgFaPE1L932EEcZoHZrBKvHk1gBBklLOAnsfviTlYQm0VA
        VeLXkvlgNq+Ai0Tn8RMsEOvkJG6e62QGsTkFXCVmzf3OBGILAdW8WH2FaQIjzwJGhlWMIqml
        xbnpucWGesWJucWleel6yfm5mxiBob/t2M/NOxgvbQw+xCjAwajEw9uwUT1aiDWxrLgy9xCj
        BAezkgjv1qUa0UK8KYmVValF+fFFpTmpxYcYpTlYlMR5zxtURgkJpCeWpGanphakFsFkmTg4
        pRoY9TgTeZq0om5cefnL3WP/O83kp1uzd6/mMTgs8r4rV2yGukOWke9psRVcXdeC0hpZrj0X
        Kpd61lse38X+NvJUWtU0rtdLf6z7fnGiVEtJ7JaNL2d8L546bbpkhnqy1oPLGVMFd8ov0p3R
        5LFxo/mFH3q+SyOCuebsP5vKkFWlt+Xq4kX9Usl2SizFGYmGWsxFxYkAIolz83kCAAA=
X-CMS-MailID: 20180619081958eucas1p16911ee9962441735d929dc588e70ce70
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619081958eucas1p16911ee9962441735d929dc588e70ce70
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619081958eucas1p16911ee9962441735d929dc588e70ce70@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation assumes that the only possible peripheral
device for DSIM is a panel. Using an output bridge child device
should also be possible.

If an output bridge is available, don't create a new connector.
Instead, call drm_bridge_attach() and set encoder's bridge to NULL
in order to avoid an out bridge from being visible by the framework, as
the DSI bus needs control on enabling its child output bridge.

Such sequence is required by Toshiba TC358764 bridge, which is a DSI
peripheral bridge device.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 38 ++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 9599e6b..c0408c0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -255,6 +255,7 @@ struct exynos_dsi {
 	struct mipi_dsi_host dsi_host;
 	struct drm_connector connector;
 	struct drm_panel *panel;
+	struct drm_bridge *out_bridge;
 	struct device *dev;
 
 	void __iomem *reg_base;
@@ -1499,7 +1500,30 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
 				  struct mipi_dsi_device *device)
 {
 	struct exynos_dsi *dsi = host_to_dsi(host);
-	struct drm_device *drm = dsi->connector.dev;
+	struct drm_encoder *encoder = &dsi->encoder;
+	struct drm_device *drm = encoder->dev;
+	struct drm_bridge *out_bridge;
+
+	out_bridge  = of_drm_find_bridge(device->dev.of_node);
+	if (out_bridge) {
+		drm_bridge_attach(encoder, out_bridge, NULL);
+		dsi->out_bridge = out_bridge;
+		encoder->bridge = NULL;
+	} else {
+		int ret = exynos_dsi_create_connector(encoder);
+
+		if (ret) {
+			DRM_ERROR("failed to create connector ret = %d\n", ret);
+			drm_encoder_cleanup(encoder);
+			return ret;
+		}
+
+		dsi->panel = of_drm_find_panel(device->dev.of_node);
+		if (dsi->panel) {
+			drm_panel_attach(dsi->panel, &dsi->connector);
+			dsi->connector.status = connector_status_connected;
+		}
+	}
 
 	/*
 	 * This is a temporary solution and should be made by more generic way.
@@ -1518,11 +1542,6 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->lanes = device->lanes;
 	dsi->format = device->format;
 	dsi->mode_flags = device->mode_flags;
-	dsi->panel = of_drm_find_panel(device->dev.of_node);
-	if (dsi->panel) {
-		drm_panel_attach(dsi->panel, &dsi->connector);
-		dsi->connector.status = connector_status_connected;
-	}
 	exynos_drm_crtc_get_by_type(drm, EXYNOS_DISPLAY_TYPE_LCD)->i80_mode =
 			!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
 
@@ -1654,13 +1673,6 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 	if (ret < 0)
 		return ret;
 
-	ret = exynos_dsi_create_connector(encoder);
-	if (ret) {
-		DRM_ERROR("failed to create connector ret = %d\n", ret);
-		drm_encoder_cleanup(encoder);
-		return ret;
-	}
-
 	if (dsi->mic_bridge_node) {
 		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
 		if (mic_bridge)
-- 
2.7.4

