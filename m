Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6D5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6911620875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XIcjCmTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6911620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937508AbeFSIVt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:21:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44996 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937349AbeFSIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:20:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180619082002euoutp02faa4493710bd78d8f70d18112b14f7ff~5gezSB8P01480614806euoutp02h;
        Tue, 19 Jun 2018 08:20:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180619082002euoutp02faa4493710bd78d8f70d18112b14f7ff~5gezSB8P01480614806euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529396402;
        bh=6ybqatKyLKtsIgUKywEqO6Vqq+XVxGO87IkKvfPVMHg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=XIcjCmTb9WoMxUwiqPJeUj9p8qNTE6aYffBxQLc0nbUURsxf+rr/N4xQ9x4r9vyqd
         EMdK1yXdqNO5LGB9PKGBDCx5GoCLEnZz4LeowkEjJPDszVXo1UkTj74ab2kL5MAW0i
         aXEmB/dsgiQSAuMGPeSZjPlDpvJT3E1lZdWOLpsw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619082001eucas1p16027af53c991c6294356b6547a04a24d~5geyddbAf3063530635eucas1p1c;
        Tue, 19 Jun 2018 08:20:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.88.10409.1BCB82B5; Tue, 19
        Jun 2018 09:20:01 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619082000eucas1p1ed44d7aea857b12ce2c92c240be4dedd~5gexsDq2p0262702627eucas1p1t;
        Tue, 19 Jun 2018 08:20:00 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-d8-5b28bcb13911
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A1.66.04178.0BCB82B5; Tue, 19
        Jun 2018 09:20:00 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAK00EJ59T2RV00@eusync4.samsung.com>;
        Tue, 19 Jun 2018 09:20:00 +0100 (BST)
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
Subject: [PATCH v3 5/9] drm/panel: add support for BOE HV070WSA-100 panel to
 simple-panel
Date:   Tue, 19 Jun 2018 10:19:26 +0200
Message-id: <1529396370-18761-6-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTYRTHfe7L7nU4uUzDRys/LKIhZEmFDyRpoXEjCD/kh1ymM28quSmb
        L1lUImWbpU2lMjM1UPP9ZTrfKMv5MjRzLqWWYRpiqZv1Qc0ErZxXv/3OOf///3Dg0LhYS3rR
        8cpkTqWUJ0gEQqJtYM18sPmVVHb4pwmiiYYREuWMDGIoU7NIoubCRhKV9m32xld+CVD+lI5A
        c18tBHo4Y8OR2dxEofeZdgpp88oppJ/5SKKxrmIBKjR3Y6hsfoJA9X2TFKr4ZMHQ3dd9FCos
        mBegta4SImgXW1dSB9ix3ByM7SyapNhnmqckq6/RCtj239MkO3XfhLEt5bfZ3NYawC7pvUOF
        4cKAGC4hPpVTHToRJYzrtWjxpB6Xa3PVA1QGuCPMBs40ZI7CoY5xPBsIaTFTBWCObgPwxRKA
        uulhwY5q3dq9raoEMCuvDeOLfwAOLdg2LTQtYHxg3b1IR9+dqQGwxbq4FYUzj0g4WmojHVFu
        jAxmDZYRDiaY/XC1uItysIgJhmU95dvrvOHnES3uYGcmBBY9X93aBpkCClYazCQvCobt62+2
        DW5wwdRK8bwHajU9GM83YPX8S4I3ZwC4PDmG84PjsNdk2QrCGVeY3/YEd5wAGRHUZIl5CQu/
        bVgJ/sxCAPutnbgOeJYBpxrgwaWoFbGc+oiSS/NVyxXqFGWs7+VEhR5sPsi7v6aVDtC9Hm0E
        DA0kLiJp4wGZmJSnqtMVRgBpXOIuMlRIZWJRjDz9OqdKjFSlJHBqI9hNExIP0SXprXAxEytP
        5q5yXBKn2plitLNXBjDrag1iu1eaxb4UZLF6s/6nJgyBVWER/Siq0ie/tutFiL/TqF7qdLZ0
        2HNZqiga+PIgLGXuymkByT62iWa6z9QaO1UvsJPHQs/90Ly1eWQqpwI+XPCDxrT1DPvNqei9
        57/Xl7TOEhFUY9RsQ+504p8SmWtxb3tP8L61wIsFTRJCHSf388FVavl/L98WcxwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xa7ob9mhEG+w7YGpxa905VovecyeZ
        LJo63rJabJyxntVi/hGg2JWv79ksJt2fwGLx4t5FFov+x6+ZLc6f38BucbbpDbtF58Ql7Bab
        Hl9jtbi8aw6bxYzz+5gsFry8xWKx9shddoul1y8yWbTuPcJuMWPySzaLn7vmsTiIeqyZt4bR
        43JfL5PHzll32T1md8xk9di0qpPNY/u3B6we97uPM3lsXlLv0bdlFaPH501yAVxRXDYpqTmZ
        ZalF+nYJXBmHL3YyFxzkqXix8hh7A2MLVxcjJ4eEgInEnxv7mLsYuTiEBJYwSny72MsG4TQy
        Sbx+/B3I4eBgE9CSWNMeDxIXEVjFKDH17x12EIdZYDarxKtHExhBRgkLREu0nVzAAmKzCKhK
        fJ+zix3E5hVwkVhwcAkbxDo5iZvnOplBbE4BV4lZc78zgdhCQDUvVl9hmsDIs4CRYRWjSGpp
        cW56brGhXnFibnFpXrpecn7uJkZg6G879nPzDsZLG4MPMQpwMCrx8DZsVI8WYk0sK67MPcQo
        wcGsJMK7dalGtBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5O
        qQbGuV39NpfWs6uFyXWqyrySWKu6SanKM3TvyqtuX2ZdiZFu0IhgVnv37tnj39/+c1naSBtX
        zhZLvpv9SdfnVDzDfzON/naTI5ZfTs3xe1/vG/RnuZbk83ufi3/9uxWtanVFXWDv80O657b5
        Xfy1d6aAxeNFPZu0/s4QMfr3091rW/eT6OMcb+JKlFiKMxINtZiLihMBFNbtyHkCAAA=
X-CMS-MailID: 20180619082000eucas1p1ed44d7aea857b12ce2c92c240be4dedd
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619082000eucas1p1ed44d7aea857b12ce2c92c240be4dedd
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619082000eucas1p1ed44d7aea857b12ce2c92c240be4dedd@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds support for BOE HV070WSA-100 WSVGA 7.01 inch panel
in panel-simple driver. The panel is used in Exynos5250-arndale boards.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab4..d5da58d 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -745,6 +745,28 @@ static const struct panel_desc avic_tm070ddh03 = {
 	},
 };
 
+static const struct drm_display_mode boe_hv070wsa_mode = {
+	.clock = 40800,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 90,
+	.hsync_end = 1024 + 90 + 90,
+	.htotal = 1024 + 90 + 90 + 90,
+	.vdisplay = 600,
+	.vsync_start = 600 + 3,
+	.vsync_end = 600 + 3 + 4,
+	.vtotal = 600 + 3 + 4 + 3,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc boe_hv070wsa = {
+	.modes = &boe_hv070wsa_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 154,
+		.height = 90,
+	},
+};
+
 static const struct drm_display_mode boe_nv101wxmn51_modes[] = {
 	{
 		.clock = 71900,
@@ -2113,6 +2135,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "avic,tm070ddh03",
 		.data = &avic_tm070ddh03,
 	}, {
+		.compatible = "boe,hv070wsa-100",
+		.data = &boe_hv070wsa
+	}, {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
 	}, {
-- 
2.7.4

