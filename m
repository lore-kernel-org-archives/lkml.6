Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeCWDoY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:44:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40951 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751890AbeCWDoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:44:22 -0400
X-UUID: 0b54a1ac820d4c9d8b1c652e693b4735-20180323
From: Ryder Lee <ryder.lee@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Rick Chang <rick.chang@mediatek.com>, Bin Liu <bin.liu@mediatek.com>
Subject: [PATCH] [media] vcodec: fix error return value from mtk_jpeg_clk_init()
Date: Fri, 23 Mar 2018 11:44:13 +0800
Message-ID: <f9295ecafa4c845ef5d9414fca47b2dc0fc6640d.1521776018.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.003
X-TM-AS-Result: No-2.867500-8.000000-10
X-TMASE-MatchedRID: iyOaUzKo3m/MxeM2fhfB7kyQ5fRSh265H8fXhwPLN7GjxYyRBa/qJQJj
        6WxgWJYb5MIx11wv+CPGVuWouVipcjQJ8LiNAx5aJT7qgeqiOg9523AyrCX8wnfLsXBEMK4+Z/I
        B5jAhZAVBBpB9i3UBwlkf0TYN3mgxzMo/u4o0CcFuB+4uIp4zDvDsnHBTQS9kyoRE4tv/7I7j/Q
        m+fSvAAma0vgPD7M1v1PYfTfPNTUk=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.867500-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.003
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error return value should be fixed as it may return EPROBE_DEFER.

Cc: Rick Chang <rick.chang@mediatek.com>
Cc: Bin Liu <bin.liu@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index 226f908..af17aaa 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -1081,11 +1081,11 @@ static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
 
 	jpeg->clk_jdec = devm_clk_get(jpeg->dev, "jpgdec");
 	if (IS_ERR(jpeg->clk_jdec))
-		return -EINVAL;
+		return PTR_ERR(jpeg->clk_jdec);
 
 	jpeg->clk_jdec_smi = devm_clk_get(jpeg->dev, "jpgdec-smi");
 	if (IS_ERR(jpeg->clk_jdec_smi))
-		return -EINVAL;
+		return PTR_ERR(jpeg->clk_jdec_smi);
 
 	return 0;
 }
-- 
1.9.1
