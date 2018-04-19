Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeDSN2W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:28:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34603 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750858AbeDSN2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:28:21 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH] drm/stm: ltdc: fix warnings in ltdc_plane_create()
Date: Thu, 19 Apr 2018 15:28:04 +0200
Message-ID: <20180419132804.8317-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make C=1" returns 2 warnings in ltdc_plane_create()
("Using plain integer as NULL pointer"). This patch
fixes them.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 616191fe98ae..d997a6014d6c 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -860,13 +860,13 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 
 	plane = devm_kzalloc(dev, sizeof(*plane), GFP_KERNEL);
 	if (!plane)
-		return 0;
+		return NULL;
 
 	ret = drm_universal_plane_init(ddev, plane, possible_crtcs,
 				       &ltdc_plane_funcs, formats, nb_fmt,
 				       NULL, type, NULL);
 	if (ret < 0)
-		return 0;
+		return NULL;
 
 	drm_plane_helper_add(plane, &ltdc_plane_helper_funcs);
 
-- 
2.15.1
