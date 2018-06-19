Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED188C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89F720875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gcVtjZNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89F720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937457AbeFSIUM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:20:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44900 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756208AbeFSIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:20:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180619081959euoutp02b69d248be46fddb0f4747a3e602c1c0a~5gewdnIJd1480614806euoutp02c;
        Tue, 19 Jun 2018 08:19:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180619081959euoutp02b69d248be46fddb0f4747a3e602c1c0a~5gewdnIJd1480614806euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529396399;
        bh=HVqTI3BdlAB5hwRcCEiGVCWF1C+YJV8AMlmBjxxx6gQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=gcVtjZNPPN04ouCx6eB77btdCv89AepurB5GRzb6NTAM7TsxGA92TtaBmSmtFczI2
         5btV476dtOt5ZPV4ZPrmFdN0Dm9/6W/cYLdWNbpBg54eBS2hI8sExZHrtckWWWQ+xv
         CBaoDyjr2ktdSQToQyx9J7M/w45ybF6/83hPukvs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180619081958eucas1p2ff6ed1961b4e04d26b8f346529b0f066~5gevkoTiF1187711877eucas1p2P;
        Tue, 19 Jun 2018 08:19:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7C.79.17380.EACB82B5; Tue, 19
        Jun 2018 09:19:58 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180619081957eucas1p2d2b9075a9b7a90837b40e4529ab31888~5geupfAZM2285022850eucas1p2D;
        Tue, 19 Jun 2018 08:19:57 +0000 (GMT)
X-AuditID: cbfec7f4-b4fc79c0000043e4-d1-5b28bcae84ca
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E2.E3.04183.DACB82B5; Tue, 19
        Jun 2018 09:19:57 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAK00EJ59T2RV00@eusync4.samsung.com>;
        Tue, 19 Jun 2018 09:19:57 +0100 (BST)
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
Subject: [PATCH v3 1/9] drm/exynos: rename "bridge_node" to
 "mic_bridge_node"
Date:   Tue, 19 Jun 2018 10:19:22 +0200
Message-id: <1529396370-18761-2-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSfSyUcRz3u+d57nncHE+H/KhpXatMI5XVb2PWFtuzVqv+a7R08gzDsXuc
        0JJZdJj3Xs5L+MORy+uRt6F5qdOMcwhZciXL67JRTaGch/8+38/b9/vbfhQmURFOVJg8hlXI
        ZRFSoQhvfrcx5Fbb4RLgoVm0Q1O1QwTKHHovQMmqFQI1qOsIVNq3w439/CFEeTM5OJr/bMRR
        9uwShgyGehINJi+TKC23nES62XECjbYXC5Ha0CVAZQtTOKrpmyaRZsIoQCmdfSRS5y8I0UZ7
        CX7RnqkuqQbMaFamgGkrnCaZIlUBwei0aUKm5ZeJYGYy9AKmsfwhk9WkBcyazvm6yF/kHcxG
        hMWyitM+d0ShX5K7iei3B+K0I1UgCZis04ElBWlP2N+lAulAREnolwCupecJ+WENQNObQsG+
        61PuNMkLFQD+bSrH+eEfgHMFmTsKRQlpV1j9ONDM29FaABsnV3Z7MfopAYdLlwhzlS19DeYZ
        u3cDOH0ctvXTZlpM+8JXz0oJfpsz/DiUhpmxJe0HC1/8Fph7IJ1NwoWibIw3+cJ54z62hYv6
        JpLHh+FofgbO4/uwaqES58NJAK5Pj+4FvGCv3ri7DaOtYV7zc8x8EKTFUJUq4S0M3PpTvPdK
        NYDLaRPCHOBYBiy0wIFVcpEhLHdWzt5z52SRnFIe4n43KlIHdv7HwLZ+vRW0bwb1AJoCUiux
        S93JAAkhi+XiI3sApDCpnfi1xiVAIg6WxSewiqhAhTKC5XrAIQqXOohvuyT6S+gQWQwbzrLR
        rGJfFVCWTkmgxllztPbb1bbwqgrbhPwAm1WvLfTVXhOd5Vwy1XKiZSDxWGpj60Fk2rpg8SDL
        a5g5hbl5yK04fa4y8NZIJV7v+che75PSEBFnrRu8XDUcNH7Ez6Be7TwvjvH28Qn/0CGyufG9
        d6au6Mq5SxOm0rGJyc05pcPMNqGrW72Z6fgkSopzobIzrpiCk/0HLeXkORsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xa7pr92hEG8w/rGJxa905VovecyeZ
        LJo63rJabJyxntVi/hGg2JWv79ksJt2fwGLx4t5FFov+x6+ZLc6f38BucbbpDbtF58Ql7Bab
        Hl9jtbi8aw6bxYzz+5gsFry8xWKx9shddoul1y8yWbTuPcJuMWPySzaLn7vmsTiIeqyZt4bR
        43JfL5PHzll32T1md8xk9di0qpPNY/u3B6we97uPM3lsXlLv0bdlFaPH501yAVxRXDYpqTmZ
        ZalF+nYJXBkPmw6yFhwVrFh1aSVjA+MDvi5GTg4JAROJOxPvsncxcnEICSxhlDjwbwmU08gk
        MfXsZ5YuRg4ONgEtiTXt8SBxEYFVjBJT/94BK2IWmM0q8erRBEaQUcICvhI3Hh4Ha2ARUJXY
        eUIAJMwr4CKxetp8VohtchI3z3Uyg9icAq4Ss+Z+ZwKxhYBqXqy+wjSBkWcBI8MqRpHU0uLc
        9NxiI73ixNzi0rx0veT83E2MwMDfduznlh2MXe+CDzEKcDAq8fA2bFSPFmJNLCuuzD3EKMHB
        rCTCu3WpRrQQb0piZVVqUX58UWlOavEhRmkOFiVx3vMGlVFCAumJJanZqakFqUUwWSYOTqkG
        xkl6viuqdNeptx6LUX8qHPzjnv5ts7THjtKqZ7+vurupd478mq9v7s95/ItLicF2Zf0iy8Yv
        Ja2mHk0ZM0JKRVN+mR87/a8rduFFtoYrDqWhgkKy/n77dIT//lt2hVn6zT+2WSfiVSztwlZY
        9zDcSTzDF1xcad1vZLUyKKI29+TWi+wmvyo7lViKMxINtZiLihMBSaNOp3gCAAA=
X-CMS-MailID: 20180619081957eucas1p2d2b9075a9b7a90837b40e4529ab31888
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619081957eucas1p2d2b9075a9b7a90837b40e4529ab31888
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619081957eucas1p2d2b9075a9b7a90837b40e4529ab31888@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding support for peripheral out bridges, the "bridge" name
becomes imprecise as it refers to a different device than the
"out_bridge".

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index eae44fd..9599e6b 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -279,7 +279,7 @@ struct exynos_dsi {
 	struct list_head transfer_list;
 
 	const struct exynos_dsi_driver_data *driver_data;
-	struct device_node *bridge_node;
+	struct device_node *mic_bridge_node;
 };
 
 #define host_to_dsi(host) container_of(host, struct exynos_dsi, dsi_host)
@@ -1631,7 +1631,7 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
 	if (ret < 0)
 		return ret;
 
-	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
+	dsi->mic_bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
 
 	return 0;
 }
@@ -1642,7 +1642,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 	struct drm_encoder *encoder = dev_get_drvdata(dev);
 	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
 	struct drm_device *drm_dev = data;
-	struct drm_bridge *bridge;
+	struct drm_bridge *mic_bridge;
 	int ret;
 
 	drm_encoder_init(drm_dev, encoder, &exynos_dsi_encoder_funcs,
@@ -1661,10 +1661,10 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
-	if (dsi->bridge_node) {
-		bridge = of_drm_find_bridge(dsi->bridge_node);
-		if (bridge)
-			drm_bridge_attach(encoder, bridge, NULL);
+	if (dsi->mic_bridge_node) {
+		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
+		if (mic_bridge)
+			drm_bridge_attach(encoder, mic_bridge, NULL);
 	}
 
 	return mipi_dsi_host_register(&dsi->dsi_host);
@@ -1783,7 +1783,7 @@ static int exynos_dsi_remove(struct platform_device *pdev)
 {
 	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
 
-	of_node_put(dsi->bridge_node);
+	of_node_put(dsi->mic_bridge_node);
 
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.7.4

