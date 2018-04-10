Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbeDJNxo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:53:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48296 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753081AbeDJNxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:53:40 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH] drm/stm: ltdc: fix warning in ltdc_crtc_update_clut()
Date: Tue, 10 Apr 2018 15:53:12 +0200
Message-ID: <20180410135312.3553-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning
"warn: variable dereferenced before check 'crtc' (see line 390)"
by removing unnecessary checks as ltdc_crtc_update_clut() is
only called from ltdc_crtc_atomic_flush() where crtc and
crtc->state are not NULL.

Many thanks to Dan Carpenter for the bug report
https://lists.freedesktop.org/archives/dri-devel/2018-February/166918.html

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/stm/ltdc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 061d2b6e5157..e3121d9e4230 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -392,9 +392,6 @@ static void ltdc_crtc_update_clut(struct drm_crtc *crtc)
 	u32 val;
 	int i;
 
-	if (!crtc || !crtc->state)
-		return;
-
 	if (!crtc->state->color_mgmt_changed || !crtc->state->gamma_lut)
 		return;
 
-- 
2.15.1
